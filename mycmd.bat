@echo off
:startme
echo.
echo %cd%^>
set /p command=%cd%^>
call %command%

goto startme