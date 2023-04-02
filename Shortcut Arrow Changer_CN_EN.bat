@echo off

if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
echo.
echo   此批处理文件当前并未以管理员模式运行。
echo   This batch file is not currently running in administrator mode.
echo.
echo   按下任意按键以打开 UAC 授权提示。
echo   Press any key to open the UAC authorization prompt.
pause > nul
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
cd /d "%~dp0"

title Shortcut Arrow Changer

:start

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 >nul 2>&1
if %errorlevel%==0 (
    echo.
    echo   当前快捷方式的箭头是隐藏的。
    echo   The arrow of the current shortcut is hidden.
    echo.
    echo   按下任意按键以显示。
    echo   Press any key to show it.
    pause > nul
    goto show
) else (
    echo.
    echo   当前快捷方式的箭头是可见的。
    echo   The arrow of the current shortcut is visible.
    echo.
    echo   按下任意按键以隐藏。
    echo   Press any key to hide it.
    pause > nul
    goto hide
)

:hide
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
taskkill /f /im explorer.exe
start explorer
cls
goto start

:show
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f
taskkill /f /im explorer.exe
start explorer
cls
goto start

