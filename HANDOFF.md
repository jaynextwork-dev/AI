# 인수인계: 클라우드 티파니 → 로컬 티파니

이 문서를 읽는 너는 선배(사용자) 컴퓨터에서 실행 중인 티파니다.
클라우드 세션(session_01KVVJQgzYQNuCGVpEvSxSXN)의 티파니가 여기까지 해뒀고, 나머지를 네가 이어서 한다.
선배는 개발자가 아니다. 이벤트 프로듀서다. 명령어를 선배에게 시키지 말고 네가 직접 실행한다.
선배에게 부탁할 것은 딱 두 가지뿐이다: 앱 접근 허용 클릭, 그리고 네가 못 하는 게 있을 때 화면 캡처.

## 선배가 원하는 것

1. 폰의 텔레그램에서 티파니에게 말을 걸고 답을 받는 것 (Claude Code Channels 기능)
2. 그 뒤로는 이 저장소의 리드+직원 구조(CLAUDE.md, README.md)로 일하는 것

## 이미 끝난 것 (저장소 브랜치 `claude/multi-agent-collaboration-chat-fnbmil`)

- `CLAUDE.md`: 티파니가 지킬 위임·검수·보고·비용 규칙
- `.claude/agents/`: 직원 6명 (research-worker, proposal-strategist, pr-manager, budget-tracker, reality-checker, quick-worker)
- `telegram/setup-telegram.ps1`(윈도우), `telegram/setup-telegram.sh`(맥): Bun 설치, 플러그인 마켓 추가, 텔레그램 플러그인 설치, 토큰 저장
- `start-telegram.cmd`: 텔레그램 채널 모드로 Claude Code 실행
- `telegram/README.md`: 사용법·한계·출처
- `.gitignore`: `*.env` 차단 (토큰이 저장소에 못 올라감)

## 네가 할 일 (순서대로, 멈추지 말고)

1. **저장소 확인**: 현재 폴더가 이 저장소가 아니면 `git clone https://github.com/jaynextwork-dev/AI.git` 하고 그 폴더로 이동한 뒤 브랜치 `claude/multi-agent-collaboration-chat-fnbmil`를 체크아웃한다.
2. **설치 스크립트의 앞부분을 직접 실행**한다. 토큰 입력 단계 전까지:
   - `claude --version` 확인
   - Bun 없으면 `powershell -c "irm bun.sh/install.ps1 | iex"` (맥: `curl -fsSL https://bun.sh/install | bash`), 새 PATH 반영
   - `claude plugin marketplace add anthropics/claude-plugins-official --scope user`
   - `claude plugin install telegram@claude-plugins-official --scope user`
3. **텔레그램 봇 만들기**. 데스크톱 컨트롤(computer use) 도구가 있으면 텔레그램 PC앱을 열어 @BotFather에게 `/newbot` → 이름 "티파니" → 아이디 `tiffany_thenext_bot`(이미 있으면 뒤에 숫자 붙임)으로 만들고 토큰을 화면에서 읽는다. 도구가 없으면 선배에게 "텔레그램에서 @BotFather에게 /newbot 보내고, 이름은 티파니, 아이디는 tiffany_thenext_bot 으로 만든 뒤 나온 토큰을 여기 붙여줘"라고 한 번만 부탁한다.
4. **토큰 저장**: `~/.claude/channels/telegram/.env`에 `TELEGRAM_BOT_TOKEN=<토큰>` 한 줄. 윈도우는 `$env:USERPROFILE\.claude\channels\telegram\.env`. 토큰을 대화에 다시 출력하거나 저장소에 넣지 않는다.
5. **채널 모드로 실행**: 현재 세션은 채널 없이 켜진 상태이므로, 선배에게 "이 창을 닫고 저장소 폴더의 start-telegram.cmd를 더블클릭해줘"라고 안내한다. 맥이면 `claude --channels plugin:telegram@claude-plugins-official`.
   - 그 새 창의 티파니는 이 HANDOFF의 6번부터 이어서 한다.
6. **페어링**: 선배가 텔레그램에서 봇에게 아무 메시지를 보내면 6자리 코드가 온다. 선배가 코드를 말해주면 `/telegram:access pair <코드>` 실행, 이어서 `/telegram:access policy allowlist` 실행.
7. **테스트**: 선배에게 텔레그램에서 "티파니 있어?"라고 보내보라고 하고, 답이 가는지 확인한다.
8. 끝나면 이 HANDOFF.md의 맨 아래 "진행 상태"를 갱신하고 커밋·푸시한다.

## 규칙

- 선배에게는 CLAUDE.md의 보고 형식으로만 보고한다. 명령어를 보여주지 말고 결과만 말한다.
- 막히면 추측하지 말고 "지금 여기서 막혔고, 이 화면을 캡처해줘"라고 정확히 말한다.
- 텔레그램 봇 토큰은 비밀번호다. 대화·저장소·캡처 어디에도 남기지 않는다.
- 참고 문서: https://code.claude.com/docs/en/channels , https://github.com/anthropics/claude-plugins-official/tree/main/external_plugins/telegram

## 진행 상태

- [ ] 1 저장소 확인
- [ ] 2 Bun·플러그인 설치
- [ ] 3 봇 생성
- [ ] 4 토큰 저장
- [ ] 5 채널 모드 실행
- [ ] 6 페어링·잠금
- [ ] 7 테스트 성공
