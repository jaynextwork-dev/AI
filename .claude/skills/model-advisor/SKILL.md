---
name: model-advisor
description: 새 작업을 시작할 때, 또는 선배가 "어떤 모델 써?", "이거 Sonnet으로 돼?", "사용량 아끼려면?"이라고 물을 때 작업에 맞는 모델과 생각 강도(effort)를 한 줄로 추천한다. 대화 중 일의 종류가 바뀌었을 때(예: 콘셉트 회의 → 표 정리)도 사용한다.
---

# 모델·생각 강도 추천

목표: 작업에 필요한 만큼만 쓴다. 추천은 **한 줄**로 끝낸다. 선택지를 여러 개 늘어놓지 않는다.

## 추천표

| 작업 종류 | 모델 | 생각 강도 | 예시 |
|---|---|---|---|
| 단순·반복 | Haiku (quick-worker에게 위임) | low | 목록 정리, 표 변환, 형식 통일, 파일 찾기 |
| 보통 (대부분의 일) | Sonnet | medium | 조사, 초안, 메일·보도자료, 예산표, 일정 정리 |
| 어려운 판단 | Opus | high | 제안서 콘셉트 도출, 발주처 숨은 욕구 분석, 최종본 편집 |

- `xhigh`, `max`는 쓰지 않는다. 선배가 직접 요청할 때만 쓴다.
- 애매하면 Sonnet + medium.

## 말하는 법

현재 모델이 추천과 같으면 아무 말도 하지 않는다. 다를 때만 답변 맨 앞에 한 줄:

> 💡 이 일은 Sonnet이면 충분해. `/model sonnet` 하고 `/effort medium` 하면 아껴.

어려운 일인데 낮은 모델이면:

> 💡 이건 콘셉트 판단이라 Opus가 나아. `/model opus` 하고 `/effort high` 추천해.

## 근거

- Sonnet이 대부분의 작업을 잘 처리하고 Opus보다 싸다. Opus는 복잡한 판단에 쓴다. 단순 서브에이전트는 Haiku. 생각한 양(thinking)은 출력 토큰으로 과금되고 `/effort`로 낮출 수 있다.
- 출처: https://code.claude.com/docs/en/costs ("Choose the right model", "Adjust extended thinking")
