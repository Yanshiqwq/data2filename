@echo off
echo.
echo 	%~nx0 v1.2.2 By ��ʱqwq 
echo.
echo BiliBili:	https://space.bilibili.com/431304449
echo Github:		https://github.com/Yanshiqwq/data2filename

if "%~1" == "" (
	echo �÷�:		%~nx0 �����ܵ��ļ�
	pause
	goto :EOF
)
if exist "%~1"\ (
	echo [ERROR] ֻ�ܼ����ļ�.
	pause
	goto :EOF
)

echo �ļ�����:	%~nx1

set /a GB=%~z1/1024/1024/1024
set /a MB=%~z1/1024/1024%%1024
set /a KB=%~z1/1024%%1024
echo �ļ���С:	%GB%GB %MB%MB %KB%KB

echo ��������:	Լ6�ļ�/KB
set /a FILESCOUNT=%~z1/1024*1934/340
echo �����ļ�:	%FILESCOUNT%��

echo �����ٶ�:	256MB/s
set /a COMPLETETIME=%~z1/1024/256
set /a COMPLETEMINSEC=%COMPLETETIME%%%1000
set /a COMPLETESEC=%COMPLETETIME%/1000
echo ����ʱ��:	%COMPLETESEC%�� %COMPLETEMINSEC%����

echo ת���ٶ�:	993KB/s
set /a COMPLETETIME=%~z1/1024/993
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
echo ת��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

echo �����ٶ�:	512KB/s
set /a COMPLETETIME=%~z1/1024/512
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
echo ����ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

echo �ֽ��ٶ�:	170KB/s
set /a COMPLETETIME=%~z1/1024/170
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
echo �ֽ�ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

set FILESIZE=0
set /a FILESIZE=%~z1/1024
set /a COMPLETETIME=%FILESIZE%/1024/256+%FILESIZE%/1024/128+%FILESIZE%/512+%FILESIZE%/170
set /a COMPLETESEC=%COMPLETETIME%%%60
set /a COMPLETEMIN=%COMPLETETIME%/60%%60
set /a COMPLETEHOUR=%COMPLETETIME%/3600%%60
echo Լ��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

set RAND=%RANDOM%
set OUTFILE=%~nx1_encode
set OUTFILE=%OUTFILE: =_%
if exist "%~dp1%OUTFILE%" rd /s /q "%~dp1%OUTFILE%" >nul
mkdir "%~dp1%OUTFILE%" >nul

echo [INFO] ���ڱ����ļ�...
base64 -w235 "%~1" > "%~dp1file%RAND%.tmp"

echo [INFO] ����ת���ļ�...
sed -i "s/\//-/g" "%~dp1file%RAND%.tmp"

echo [INFO] ���ڼ����ļ���ϣֵ...
for /f "delims=" %%i in ('certutil -hashfile %1 MD5 ^| findstr /V ��ϣ ^| findstr /V ���') do (cd. > "%~dp1%OUTFILE%\hash_%%i.encode") 

echo [INFO] ���ڼ����ļ�...
set COUNT=0
for /f "delims=" %%i in ('type "%~dp1file%RAND%.tmp"') do (
	setlocal enabledelayedexpansion
	set /a "COMPLETESEC=(%FILESCOUNT%-!COUNT!)/1024%%60"
	set /a "COMPLETEMIN=(%FILESCOUNT%-!COUNT!)/1024/60%%60"
	set /a "COMPLETEHOUR=(%FILESCOUNT%-!COUNT!)/1024/3600%%60"
	cd. > "%~dp1%OUTFILE%\data%RAND%_!COUNT!_%%i"
	set /a PER=!COUNT!%%596
	if "!PER!" == "0" echo [INFO] ���ڷֽ��ļ�...	[!COUNT!/%FILESCOUNT%]	[ETA !COMPLETEHOUR!ʱ!COMPLETEMIN!��!COMPLETESEC!��]
	endlocal
	set /a COUNT+=1
)

del /f /q "%~dp1file%RAND%.tmp" >nul
set /a COUNT=%COUNT%-1
cd. > "%~dp1%OUTFILE%\index_%RAND%_%COUNT%.encode"
set FILEEXT=%~x1
cd. > "%~dp1%OUTFILE%\filename_%~n1_%FILEEXT:~1%.encode"
echo [INFO] �ֽ����!
goto :EOF