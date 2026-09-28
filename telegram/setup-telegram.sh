#!/usr/bin/env bash
# 티파니 텔레그램 연결 설치 스크립트 (macOS / Linux)
# 사용법: 이 저장소 폴더에서  bash telegram/setup-telegram.sh
set -euo pipefail
step(){ printf '\n==> %s\n' "$1"; }
ok(){ printf '    OK  %s\n' "$1"; }

step "1/5 Claude Code 확인"
command -v claude >/dev/null || { echo "claude 명령이 없어요. https://code.claude.com/docs/en/quickstart"; exit 1; }
ok "Claude Code $(claude --version 2>/dev/null || true)"

step "2/5 Bun 확인"
if ! command -v bun >/dev/null; then
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi
ok "Bun $(bun --version)"

step "3/5 공식 플러그인 마켓 추가"
claude plugin marketplace add anthropics/claude-plugins-official --scope user

step "4/5 텔레그램 플러그인 설치"
claude plugin install telegram@claude-plugins-official --scope user

step "5/5 봇 토큰 저장 (@BotFather 에게 /newbot 으로 받은 토큰)"
read -r -p "    봇 토큰: " token
[[ "$token" =~ ^[0-9]+:[A-Za-z0-9_-]+$ ]] || { echo "토큰 모양이 이상해요. 다시 실행해주세요."; exit 1; }
mkdir -p "$HOME/.claude/channels/telegram"
printf 'TELEGRAM_BOT_TOKEN=%s\n' "$token" > "$HOME/.claude/channels/telegram/.env"
chmod 600 "$HOME/.claude/channels/telegram/.env"
ok "토큰 저장: ~/.claude/channels/telegram/.env"

cat <<'MSG'

설치 끝! 이제 이렇게 하세요.
  1) 이 저장소 폴더에서:  claude --channels plugin:telegram@claude-plugins-official
  2) 텔레그램에서 내 봇에게 아무 메시지나 보내면 6자리 페어링 코드가 옵니다
  3) Claude Code 창에 입력:  /telegram:access pair <코드>
  4) 이어서:                 /telegram:access policy allowlist
  5) 텔레그램에서 티파니에게 말 걸기. Claude Code가 켜져 있는 동안만 답합니다.
MSG
