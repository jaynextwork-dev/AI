#!/usr/bin/env bash
# 대화(컨텍스트)가 길어지면 선배에게 알리고, 티파니에게 /clear 권유를 지시한다.
# UserPromptSubmit 훅. 외부 도구 없이 grep/sed만 쓴다 (Git Bash, 리눅스, 맥 공통).
WARN=150000     # 이 이상이면 알림
STRONG=300000   # 이 이상이면 강하게 권유

input=$(cat)
t=$(printf '%s' "$input" | sed -n 's/.*"transcript_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | sed 's/\\\\/\//g')
[ -f "$t" ] || exit 0

# 메인 대화의 마지막 응답 한 줄에서 토큰 수를 읽는다
line=$(grep '"type":"assistant"' "$t" | grep -v '"isSidechain":true' | tail -n 1)
[ -n "$line" ] || exit 0
num() { n=$(printf '%s' "$line" | grep -o "\"$1\":[0-9]*" | head -n 1 | grep -o '[0-9]*$'); echo "${n:-0}"; }
used=$(( $(num input_tokens) + $(num cache_read_input_tokens) + $(num cache_creation_input_tokens) ))

[ "$used" -ge "$WARN" ] || exit 0
k=$(( used / 1000 ))
if [ "$used" -ge "$STRONG" ]; then
  msg="⚠️ 이 대화가 ${k}k 토큰이야. 메시지 하나마다 이만큼 다시 읽어서 사용량이 크게 나가. 지금 /rename 으로 이름 붙이고 /clear 해줘."
else
  msg="💡 이 대화가 ${k}k 토큰을 넘었어. 다른 일로 넘어갈 거면 /clear 하는 게 아껴."
fi
printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"[context-guard] 현재 대화 %sk 토큰. 답변 끝에 한 줄로 /clear(필요하면 먼저 /rename)를 권해라."}}\n' "$msg" "$k"
