# 티파니 텔레그램 연결 설치 스크립트 (Windows PowerShell)
# 사용법: PowerShell을 열고 이 저장소 폴더에서 아래를 실행
#   powershell -ExecutionPolicy Bypass -File .\telegram\setup-telegram.ps1
# 하는 일: Bun 설치 확인 → 플러그인 마켓 추가 → 텔레그램 플러그인 설치 → 봇 토큰 저장 → 실행 파일 안내

$ErrorActionPreference = "Stop"
function Step($msg) { Write-Host ""; Write-Host "==> $msg" -ForegroundColor Cyan }
function Ok($msg)   { Write-Host "    OK  $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "    !!  $msg" -ForegroundColor Yellow }

Step "1/5 Claude Code 확인"
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Warn "claude 명령을 찾을 수 없어요. Claude Code를 먼저 설치하고 PowerShell을 다시 열어주세요."
  Warn "설치 안내: https://code.claude.com/docs/en/quickstart"
  exit 1
}
Ok ("Claude Code " + (claude --version 2>$null))

Step "2/5 Bun 확인 (텔레그램 플러그인 실행에 필요)"
if (-not (Get-Command bun -ErrorAction SilentlyContinue)) {
  Write-Host "    Bun이 없어서 설치합니다 (공식 설치 명령)."
  powershell -c "irm bun.sh/install.ps1 | iex"
  $env:Path = "$env:USERPROFILE\.bun\bin;" + $env:Path
}
if (Get-Command bun -ErrorAction SilentlyContinue) { Ok ("Bun " + (bun --version)) }
else { Warn "Bun 설치 후 PATH 반영이 안 됐어요. PowerShell을 닫고 다시 열어 이 스크립트를 한 번 더 실행해주세요."; exit 1 }

Step "3/5 공식 플러그인 마켓 추가"
claude plugin marketplace add anthropics/claude-plugins-official --scope user
Ok "마켓 추가(또는 이미 있음)"

Step "4/5 텔레그램 플러그인 설치 (user 범위: 모든 프로젝트에서 사용)"
claude plugin install telegram@claude-plugins-official --scope user
Ok "텔레그램 플러그인 설치"

Step "5/5 봇 토큰 저장"
Write-Host "    텔레그램에서 @BotFather 에게 /newbot 을 보내 받은 토큰을 붙여넣으세요."
Write-Host "    (모양: 123456789:AAH...  / 이 토큰은 내 PC에만 저장되고 저장소에는 올라가지 않습니다)"
$token = Read-Host "    봇 토큰"
if ([string]::IsNullOrWhiteSpace($token) -or $token -notmatch '^\d+:[A-Za-z0-9_-]+$') {
  Warn "토큰 모양이 이상해요. BotFather 메시지에서 토큰만 정확히 복사해 다시 실행해주세요."; exit 1
}
$dir = Join-Path $env:USERPROFILE ".claude\channels\telegram"
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$envPath = Join-Path $dir ".env"
[IO.File]::WriteAllText($envPath, "TELEGRAM_BOT_TOKEN=$token`n", (New-Object System.Text.UTF8Encoding($false)))
Ok "토큰 저장: $envPath"

Write-Host ""
Write-Host "설치 끝! 이제 이렇게 하세요." -ForegroundColor Cyan
Write-Host "  1) 이 저장소 폴더의  start-telegram.cmd  를 더블클릭 (또는 PowerShell에서 .\start-telegram.cmd)"
Write-Host "  2) 텔레그램에서 내 봇에게 아무 메시지나 보내면 6자리 페어링 코드가 옵니다"
Write-Host "  3) 열린 Claude Code 창에 입력:  /telegram:access pair <코드>"
Write-Host "  4) 이어서 입력:               /telegram:access policy allowlist   (나만 쓰게 잠금)"
Write-Host "  5) 텔레그램에서 티파니에게 말 걸기. PC의 Claude Code 창이 켜져 있는 동안만 답합니다."
