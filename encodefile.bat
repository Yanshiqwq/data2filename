@echo off
set /a START_TIMESTAMP=%time:~0,2%*360000+%time:~3,2%*6000+%time:~6,2%*100+%time:~9,2%
echo.
echo	 	%~nx0 v1.2.3-color By ��ʱqwq 
echo.
print -e \\033[1;36m[PID #0]\\033[0m BiliBili:	https://space.bilibili.com/431304449"
print -e \\033[1;36m[PID #0]\\033[0m Github:	https://github.com/Yanshiqwq/data2filename"

if "%~1" == "" (
	print -e \\033[1;36m[PID #0]\\033[0m �÷�:			%~nx0 �����ܵ��ļ�
	goto :END
)
if exist "%~1\" (
	print -e \\033[1;36m[PID #0]\\033[0m ����: ֻ�ܼ����ļ�.
	goto :END
)

print -e \\033[1;36m[PID #0]\\033[0m �ļ�����:	%~nx1

set /a GB=%~z1/1024/1024/1024
set /a MB=%~z1/1024/1024%%1024
set /a KB=%~z1/1024%%1024
print -e \\033[1;36m[PID #0]\\033[0m �ļ���С:	%GB%GB %MB%MB %KB%KB

REM ��������:	Լ6�ļ�/KB
set /a FILESCOUNT=%~z1/1024*1934/340
print -e \\033[1;36m[PID #0]\\033[0m �����ļ�:	%FILESCOUNT%��

REM �����ٶ�:	256MB/s
set /a COMPLETETIME=%~z1/1024/256
set /a COMPLETEMINSEC=%COMPLETETIME%%%1000
set /a COMPLETESEC=%COMPLETETIME%/1000
print -e \\033[1;36m[PID #0]\\033[0m ����ʱ��:	%COMPLETESEC%�� %COMPLETEMINSEC%����

REM ת���ٶ�:	993KB/s
set /a COMPLETETIME=%~z1/1024/993
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
print -e \\033[1;36m[PID #0]\\033[0m ת��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

REM �����ٶ�:	512KB/s
set /a COMPLETETIME=%~z1/1024/512
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
print -e \\033[1;36m[PID #0]\\033[0m ����ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

REM �ֽ��ٶ�:	170KB/s
set /a COMPLETETIME=%~z1/1024/170*13/4
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
print -e \\033[1;36m[PID #0]\\033[0m �ֽ�ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

print -e \\033[1;36m[PID #0]\\033[0m �������ò���...
set RAND=%RANDOM%
set OUTFILE=%~nx1_encode
set OUTFILE=%OUTFILE: =_%
if not exist "%~dp1%OUTFILE%" mkdir "%~dp1%OUTFILE%" >nul

print -e \\033[1;36m[PID #0]\\033[0m ���ڱ����ļ�...
base64 -w235 "%~1" > "%~dp1file%RAND%.tmp"

print -e \\033[1;36m[PID #0]\\033[0m ����ת���ļ�...
sed -i "s/\//-/g" "%~dp1file%RAND%.tmp"

print -e \\033[1;36m[PID #0]\\033[0m ���ڴ���У���ļ�...
for /f "delims=" %%i in ('certutil -hashfile %1 MD5 ^| findstr /V ��ϣ ^| findstr /V ���') do (cd. > "%~dp1%OUTFILE%\hash_%%i.encode") 

print -e \\033[1;36m[PID #0]\\033[0m ���ڼ����ļ�...
set COUNT=0

for /f "delims=" %%i in ('type "%~dp1file%RAND%.tmp"') do (
	setlocal enabledelayedexpansion
	set /a "COMPLETESEC=(%FILESCOUNT%-!COUNT!)*13/4/1024%%60"
	set /a "COMPLETEMIN=(%FILESCOUNT%-!COUNT!)*13/4/1024/60%%60"
	set /a "COMPLETEHOUR=(%FILESCOUNT%-!COUNT!)*13/4/1024/3600%%60"
	cd. > "%~dp1%OUTFILE%\data%RAND%_!COUNT!_%%i"
	set /a PER=!COUNT!%%71
	if "!PER!" == "0" print -en \\033[1;36m[PID #!COUNT!]\\033[0m ���ڷֽ��ļ�...	\\033[1;32m[!COUNT!/%FILESCOUNT%]	\\033[1;33m[ETA !COMPLETEHOUR!ʱ!COMPLETEMIN!��!COMPLETESEC!��] \\033[0m \r
	endlocal
	set /a COUNT+=1
)
print -e \\033[1;36m[PID #%COUNT%]\\033[0m ���ڷֽ��ļ�...	\\033[1;32m[%COUNT%/%COUNT%]	\\033[1;33m[ETA 0ʱ0��0��] \\033[0m
print -e \\033[1;36m[PID #0]\\033[0m ����ɾ����ʱ�ļ�...
del /f /q "%~dp1file%RAND%.tmp" >nul

print -e \\033[1;36m[PID #0]\\033[0m ���ڴ��������ļ�...
set /a COUNT=%COUNT%-1
cd. > "%~dp1%OUTFILE%\index_%RAND%_%COUNT%.encode"

print -e \\033[1;36m[PID #0]\\033[0m ���ڴ����ļ���...
set FILEEXT=%~x1
cd. > "%~dp1%OUTFILE%\filename_%~n1_%FILEEXT:~1%.encode"

print -e \\033[1;36m[PID #0]\\033[0m �ֽ����!
goto :END

:END
set /a END_TIMESTAMP=%time:~0,2%*360000+%time:~3,2%*6000+%time:~6,2%*100+%time:~9,2%
set /a COST=(%END_TIMESTAMP%-%START_TIMESTAMP%)*10+%RANDOM%%%10
print -en \\033[1;32m[PID #0]\\033[0m [Process completed (%COST%ms) - press Enter]
set /p =