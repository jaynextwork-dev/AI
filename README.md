# AI 업무 팀 (리드 티파니 + 워커 에이전트)

이 저장소는 Claude Code에서 "리드 한 명 + 워커 여러 명" 구조로 일하기 위한 설정이다.

## 구조

```
사용자 ──── 티파니(리드, 메인 세션)
              ├─ 어려운 일: 직접 처리
              ├─ research-worker (Sonnet): 조사, 초안
              └─ quick-worker (Haiku): 단순 반복 작업 (여러 개 동시 실행)
```

- 티파니가 일을 난이도별로 쪼개서 워커에게 보내고, 결과를 검수한다.
- 부족하면 워커에게 보완 지시를 다시 보낸다.
- 사용자에게는 정리된 진행 보고만 올라간다.

## 파일

| 파일 | 역할 |
|---|---|
| `CLAUDE.md` | 리드가 지킬 위임·검수·보고·비용 규칙 |
| `.claude/agents/quick-worker.md` | 단순 작업 워커 정의 (Haiku) |
| `.claude/agents/research-worker.md` | 조사·초안 워커 정의 (Sonnet) |

## 사용법

이 저장소를 연 Claude Code 세션에서 평소처럼 말하면 된다. 예:

```
어울림축제 제안서 준비할 거야. 발주처 조사, 최근 3년 유사 축제 사례, 과업지시서 요구사항 표 정리까지 팀으로 나눠서 해줘.
```

티파니가 알아서 아래처럼 나눈다.
- 발주처 조사, 유사 사례 수집 → `research-worker`
- 과업지시서 요구사항 표 정리 → `quick-worker`
- 콘셉트 도출, 최종 편집 → 티파니 직접

특정 워커를 지목하고 싶으면 `@"quick-worker (agent)"`처럼 부를 수 있다.

## 워커 추가하기

`.claude/agents/이름.md` 파일을 만들면 된다. 맨 위 frontmatter에서 `model`(haiku/sonnet/opus), `tools`, `maxTurns`를 정한다. 새 세션을 열면 자동으로 읽힌다.

## 비용

워커 하나가 독립된 Claude 호출이라 워커 수만큼 사용량이 늘어난다. 단순 작업은 Haiku로 두는 것이 비용의 핵심이다. `CLAUDE.md`의 비용 가드 규칙에 따라 큰 작업은 시작 전에 컨펌을 받는다.

## 참고 (공식 문서)

- 서브에이전트: https://code.claude.com/docs/en/sub-agents
- 에이전트 팀(워커끼리 직접 대화가 필요할 때, 실험 기능): https://code.claude.com/docs/en/agent-teams
