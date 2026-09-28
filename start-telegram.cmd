@echo off
rem 티파니를 텔레그램에 연결한 상태로 Claude Code 실행 (이 창을 닫으면 텔레그램 응답도 멈춥니다)
cd /d "%~dp0"
claude --channels plugin:telegram@claude-plugins-official
