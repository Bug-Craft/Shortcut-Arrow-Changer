@echo off

if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
echo.
echo   ���������ļ���ǰ��δ�Թ���Աģʽ���С�
echo.
echo   �������ⰴ���Դ� UAC ��Ȩ��ʾ��
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
    echo   ��ǰ��ݷ�ʽ�ļ�ͷ�����صġ�
    echo.
    echo   �������ⰴ������ʾ��
    pause > nul
    goto show
) else (
    echo.
    echo   ��ǰ��ݷ�ʽ�ļ�ͷ�ǿɼ��ġ�
    echo.
    echo   �������ⰴ�������ء�
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

