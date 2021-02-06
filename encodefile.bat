@echo off
echo.
echo 	%~nx0 v1.2.2 By ��ʱqwq 
echo.
echo BiliBili:	https://space.bilibili.com/431304449
echo Github:		https://github.com/Yanshiqwq/data2filename
echo �����ٶ�:	Լ170KB/s
echo ��������:	Լ6�ļ�/KB
if "%~1" == "" (
	echo �÷�:		%~nx0 �����ܵ��ļ�
	pause
	goto :EOF
)
echo �ļ�����:	%~nx1
set /a GB=%~z1/1024/1024/1024
set /a MB=%~z1/1024/1024%%1024
set /a KB=%~z1/1024%%1024
echo �ļ���С:	%GB%GB %MB%MB %KB%KB
set /a FILESCOUNT=%~z1/1024*1934/340
echo �����ļ�:	%FILESCOUNT%��
set /a FILESIZE=%~z1/1024
set /a COMPLETEMINSEC=%FILESIZE%/256%%1000
set /a COMPLETESEC=%FILESIZE%/256/1000
echo ����ʱ��:	%COMPLETESEC%�� %COMPLETEMINSEC%����
set /a FILESIZE=%~z1/1024/1024
set /a COMPLETESEC=%FILESIZE%%%60
set /a COMPLETEMIN=%FILESIZE%/60%%60
set /a COMPLETEHOUR=%FILESIZE%/3600%%60
echo ת��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��
set /a FILESIZE=%~z1/1024
set /a COMPLETESEC=%FILESIZE%/170%%60
set /a COMPLETEMIN=%FILESIZE%/170/60%%60
set /a COMPLETEHOUR=%FILESIZE%/170/3600%%60
echo Լ��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��
set RAND=%RANDOM%
set OUTFILE=%~nx1_encode
set OUTFILE=%OUTFILE: =_%
if exist "%~dp1%OUTFILE%" rd /s /q "%~dp1%OUTFILE%" >nul
mkdir "%~dp1%OUTFILE%" >nul

echo [INFO] ���ڱ����ļ�...
base64 -w235 "%~1" > "%~dp1fileraw%RAND%.tmp"

echo [INFO] ����ת���ļ�...
sed -e "s/\//-/g" "%~dp1fileraw%RAND%.tmp" > "%~dp1file%RAND%.tmp"
del /f /q "%~dp1fileraw%RAND%.tmp"

echo [INFO] ���ڼ����ļ���ϣֵ...
for /f "delims=" %%i in ('certutil -hashfile %1 MD5 ^| findstr /V ��ϣ ^| findstr /V ���') do (cd. > "%~dp1%OUTFILE%\hash_%%i.encode") 

echo [INFO] ���ڷֽ��ļ�...
set COUNT=0
for /f "delims=" %%i in ('type "%~dp1file%RAND%.tmp"') do (
	setlocal enabledelayedexpansion
	cd. > "%~dp1%OUTFILE%\data%RAND%_!COUNT!_%%i"
	set /a PER=!COUNT!%%595 >nul
	if "!PER!" == "0" echo [INFO] �����!COUNT!/%FILESCOUNT% 
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