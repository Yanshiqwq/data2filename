@echo off
echo.
echo         %~nx0 v1.1 By ��ʱqwq https://space.bilibili.com/431304449
echo.
echo �����ٶ�:	Լ40KB/s
echo ��������:	Լ21�ļ�/KB
if "%~1" == "" echo �÷�: %~nx0 �����ܵ��ļ� & goto :EOF
echo �ļ�����:	%~nx1
set /a GB=%~z1/1024/1024/1024
set /a MB=%~z1/1024/1024%%1024
set /a KB=%~z1/1024%%1024
echo �ļ���С:	%GB%GB %MB%MB %KB%KB
set /a FILESIZE=%~z1/1024
set /a COMPLETESEC=%FILESIZE%/40%%60
set /a COMPLETEMIN=%FILESIZE%/40/60%%60
set /a COMPLETEHOUR=%FILESIZE%/40/3600%%60
echo Լ��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��
set RAND=%RANDOM%
base32 "%~1" > "%~dp1file%RAND%.tmp"
set OUTFILE=%~nx1_encode
set OUTFILE=%OUTFILE: =_%
mkdir "%~dp1%OUTFILE%" >nul

echo [INFO] ���ڼ����ļ���ϣֵ...
for /f "delims=" %%i in ('certutil -hashfile %1 MD5 ^| findstr /V ��ϣ ^| findstr /V ���') do (cd. > "%~dp1%OUTFILE%\hash_%%i.encode") 

echo [INFO] ���ڷֽ��ļ�...
set COUNT=0
for /f "delims=" %%i in ('type "%~dp1file%RAND%.tmp"') do (
	setlocal enabledelayedexpansion
	set FILEDATA=%%i
	set FILEDATA=!FILEDATA:/=-!
	cd. > "%~dp1%OUTFILE%\data%RAND%_!COUNT!_!FILEDATA!"
	endlocal
	set /a COUNT+=1
)

del /f /q "%~dp1file%RAND%.tmp" >nul
set /a COUNT=%COUNT%-1
cd. > "%~dp1%OUTFILE%\index_%RAND%_%COUNT%.encode"
set FILEEXT=%~x1
cd. > "%~dp1%OUTFILE%\filename_%~n1_%FILEEXT:~1%.encode"
echo [INFO] �ֽ����!