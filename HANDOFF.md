# 인수인계: 텔레그램 연결 정리 (로컬 티파니가 할 일)

선배가 텔레그램 티파니를 안 쓰기로 했다(2026-10-07). 저장소 쪽 파일(`telegram/`, `start-telegram.cmd`)은 클라우드 티파니가 이미 지웠다.
선배 컴퓨터에 남은 것만 네가 정리한다. 선배는 개발자가 아니니 명령어는 네가 직접 실행하고 결과만 보고한다.

## 할 일 (순서대로)

1. 텔레그램 플러그인 제거: `claude plugin uninstall telegram@claude-plugins-official --scope user`
2. 봇 토큰 파일 삭제: 윈도우 `%USERPROFILE%\.claude\channels\telegram\` 폴더, 맥 `~/.claude/channels/telegram/` 폴더. 토큰 내용은 출력하지 않는다.
3. 바탕화면이나 다른 곳에 `start-telegram.cmd` 바로가기가 있으면 지운다.
4. 텔레그램 봇 `@tiffany_thenext_bot` 삭제: 데스크톱 컨트롤 도구가 있으면 텔레그램 PC앱에서 @BotFather에게 `/deletebot` → 봇 선택 → 확인 문구 입력. 도구가 없으면 선배에게 "텔레그램에서 @BotFather에게 /deletebot 보내고 tiffany_thenext_bot 고른 다음 안내대로 확인해줘"라고 한 번만 부탁한다. 지우기 전에 선배에게 한 번 확인받는다(되돌릴 수 없음).
5. Bun은 다른 플러그인이 쓸 수 있으니 지우지 않는다.
6. 끝나면 아래 진행 상태를 갱신하고 커밋·푸시한다.

## 진행 상태

- [ ] 1 플러그인 제거
- [ ] 2 토큰 파일 삭제
- [ ] 3 바로가기 정리
- [ ] 4 봇 삭제

# 인수인계 2: 사용량 알림 훅 확인 (로컬 티파니가 할 일)

이 저장소에 `UserPromptSubmit` 훅(`.claude/hooks/context-guard.sh`, bash 스크립트)을 넣었다. 클라우드(리눅스)에서는 테스트를 통과했다. 선배 윈도우 PC에서도 도는지 확인한다.

1. Git Bash가 있는지 확인한다(`bash --version`). 있으면 훅이 그대로 돈다.
2. 없으면 같은 동작을 PowerShell 스크립트(`context-guard.ps1`)로 옮기고, `.claude/settings.json`의 command를 그 스크립트로 바꾼다. 동작: stdin JSON의 `transcript_path`를 읽고, 메인 대화의 마지막 assistant 줄에서 `input_tokens + cache_read_input_tokens + cache_creation_input_tokens`를 더해 15만 이상이면 알림, 30만 이상이면 강한 경고를 낸다.
3. 큰 대화 하나에서 메시지를 보내 알림이 뜨는지 본다. 결과를 아래에 적고 커밋·푸시한다.

- [ ] 윈도우에서 훅 동작 확인
