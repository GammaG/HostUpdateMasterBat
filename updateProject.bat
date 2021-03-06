:: This script will first create a backup of the original or current hosts
:: file and save it in a file titled "hosts.bak"
::
::
:: THIS BAT FILE MUST BE LAUNCHED WITH ADMINISTRATOR PRIVILEGES
@ECHO OFF
TITLE Update Hosts

:: Check if we are administrator. If not, exit immediately.
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %ERRORLEVEL% NEQ 0 (
    ECHO This script must be run with administrator privileges!
    ECHO Please launch command prompt as administrator. Exiting...
    EXIT /B 1
)

if not exist "%WINDIR%\System32\drivers\etc\makeHosts.py" (
 ::clone the project::
 git -C "%TEMP%" clone --depth 1 https://github.com/StevenBlack/hosts.git
 ::backup the old host::
 echo backup old hosts file
 copy "%WINDIR%\System32\drivers\etc\hosts" "%WINDIR%\System32\drivers\etc\hosts.bak" 
 ::delete the pulled hosts file
 del "%TEMP%\hosts\hosts"
 
 if exist "%WINDIR%\System32\drivers\etc\myhosts" ( 
	::delete the pulled myhosts file
	del "%TEMP%\hosts\myhosts"
 )
 
 echo moving project to system32/drivers/etc
 ::copy all content from the pulled folder::
 xcopy /s /h /Y "%TEMP%\hosts" "%WINDIR%\System32\drivers\etc" 
 ::delete the pull folder::
 echo delete pull folder
 
 set OLDDIR=%CD%
 cd %WINDIR%\System32\drivers\etc
 ::install required python libs::
 echo install python dependencies
 python -m pip install --upgrade pip
 pip3 install --user -r requirements.txt
 cd %OLDDIR%
 echo done
 rd /s /q "%TEMP%\hosts"
 ) else (
::update project::
echo update project
git -C "%WINDIR%\System32\drivers\etc" pull origin master
)
::update host file::
echo update host
set OLDDIR=%CD%
cd %WINDIR%\System32\drivers\etc
python updateHostsFile.py -a
ipconfig /flushdns
cd %OLDDIR%
echo done
pause
