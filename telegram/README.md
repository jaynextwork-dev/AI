# 티파니 텔레그램 연결 안내

폰의 텔레그램에서 티파니에게 말을 걸고, 답을 같은 채팅방에서 받는다.
일은 내 PC에서 켜둔 Claude Code가 한다. 그래서 **PC의 Claude Code 창이 켜져 있는 동안만** 답한다.

내가 할 일은 두 가지다. 나머지는 스크립트가 한다.

## 1. 텔레그램 봇 만들기 (2분)

1. 텔레그램에서 **@BotFather** 검색해서 대화 시작
2. `/newbot` 보내기
3. 봇 이름 입력 (예: 티파니) → 아이디 입력 (`bot`으로 끝나야 함, 예: `tiffany_thenext_bot`)
4. BotFather가 주는 **토큰**(모양: `123456789:AAH...`) 복사. 이건 비밀번호다. 아무 데도 올리지 않는다.

## 2. 설치 스크립트 실행 (3분)

**Windows**: PowerShell을 열고 이 저장소 폴더로 이동한 뒤

```
powershell -ExecutionPolicy Bypass -File .\telegram\setup-telegram.ps1
```

**Mac**: 터미널에서

```
bash telegram/setup-telegram.sh
```

스크립트가 Bun 설치, 플러그인 설치를 하고 마지막에 토큰을 물어본다. 붙여넣으면 내 PC의 `~/.claude/channels/telegram/.env`에만 저장된다.

## 3. 켜기와 페어링 (첫 1회)

1. 저장소 폴더의 `start-telegram.cmd` 더블클릭 (Mac은 `claude --channels plugin:telegram@claude-plugins-official`)
2. 텔레그램에서 내 봇에게 아무 메시지나 보낸다 → 봇이 **6자리 페어링 코드**를 준다
3. Claude Code 창에 입력: `/telegram:access pair <코드>`
4. 이어서 입력: `/telegram:access policy allowlist` (나만 쓰게 잠금)

이후에는 `start-telegram.cmd`만 켜면 된다.

## 쓰는 법

텔레그램에서 평소처럼 말한다. "이번 주 나라장터 축제 공고 정리해줘", "정산서 합계 다시 확인해줘".
티파니가 PC에서 직원들에게 나눠 시키고, 결과를 텔레그램으로 보고한다.
사진을 보내면 PC의 `~/.claude/channels/telegram/inbox/`에 저장되고 티파니가 읽는다.

## 알아둘 것

- **답이 없으면** PC에서 `start-telegram.cmd` 창이 켜져 있는지 본다. 꺼져 있으면 봇은 답하지 못한다.
- **권한 물음**: 티파니가 파일 수정 등 허락이 필요한 일을 만나면 PC 창에서 물어본다. 폰에서 답이 멈추면 PC 창을 본다.
- **비용**: 추가 요금 없음. 평소 Claude 사용량대로 소모.
- **요금제**: Pro/Max 개인 계정은 바로 됨. Team/Enterprise는 관리자가 claude.ai → Admin settings → Claude Code → Channels에서 켜야 함.
- **아직 연구 프리뷰**라 명령어가 바뀔 수 있다. 바뀌면 공식 문서 기준으로 고친다.
- **한계**: 그룹 채팅은 기본 설정에서 안 됨(1:1만). 직원(워커)마다 따로 말풍선이 뜨는 건 안 되고, 티파니 한 명이 모아서 답한다.

## 출처

- Claude Code Channels 공식 문서: https://code.claude.com/docs/en/channels
- 텔레그램 플러그인 원본: https://github.com/anthropics/claude-plugins-official/tree/main/external_plugins/telegram
- 플러그인 CLI 명령 참조: https://code.claude.com/docs/en/plugins/cli-reference
- Bun 설치 명령: https://github.com/oven-sh/bun#install
