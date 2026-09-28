@echo off
rem 티파니를 텔레그램에 연결한 상태로 Claude Code 실행 (이 창을 닫으면 텔레그램 응답도 멈춥니다)
cd /d "%~dp0"
rem Bun 경로를 직접 추가 (설치 직후 PATH가 반영되지 않은 창에서도 플러그인이 뜨도록)
set "PATH=%USERPROFILE%\.bun\bin;%PATH%"
claude --channels plugin:telegram@claude-plugins-official
