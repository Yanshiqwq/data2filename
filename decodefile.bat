@echo off
echo.
echo 	%~nx0 v1.2.2 By ��ʱqwq 
echo.
echo ^<BiliBili^>	https://space.bilibili.com/431304449
echo ^<Github^>	https://github.com/Yanshiqwq/data2filename
echo ��ԭ�ٶ�:	Լ331KB/s
if "%~1" == "" (
	echo �÷�:		%~nx0 �����ܵ��ļ�
	pause
	goto :EOF
)
if not exist "%~1"/ (
	echo [ERROR] ֻ�ܽ����ļ���.
)
set RAND=%RANDOM%
for /f %%i in ('where /r "%~1" index_*') do (set INDEXFILE=%%~ni)
for /f %%i in ('where /r "%~1" filename_*') do (set NAMEFILE=%%~ni)
for /f %%i in ('where /r "%~1" hash_*') do (set HASHFILE=%%~ni)
for /f "delims=_ tokens=2,3" %%i in ('echo %INDEXFILE%') do (set FILERAND=%%i)
for /f "delims=_ tokens=3" %%i in ('echo %INDEXFILE%') do (set FILECOUNT=%%i)
for /f "delims=_ tokens=2" %%i  in ('echo %NAMEFILE%') do (set FILENAME=%%i)
for /f "delims=._ tokens=3" %%i  in ('echo %NAMEFILE%') do (set FILEEXT=%%i)
for /f "delims=" %%i in ('dir /b /a-d "%~1" ^| find /v /c ""') do (set FILECOUNT=%%i)
if "%FILEEXT%" NEQ "~1" (
	set FILENAME=%FILENAME%.%FILEEXT%
)
echo �ļ�����:	%FILENAME%
set FILEHASH=%HASHFILE:~5%
set /a FILESIZE=%FILECOUNT%*340/1934*1024
set /a GB=%FILESIZE%/1024/1024/1024
set /a MB=%FILESIZE%/1024/1024%%1024
set /a KB=%FILESIZE%/1024%%1024
echo �ļ���С:	%GB%GB %MB%MB %KB%KB
set /a FILESIZE_=%FILESIZE%/1024/1024
set /a COMPLETESEC=%FILESIZE_%%%60
set /a COMPLETEMIN=%FILESIZE_%/60%%60
set /a COMPLETEHOUR=%FILESIZE_%/3600
echo ����ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��
set /a FILESIZE_=%FILESIZE%/1024
set /a COMPLETESEC=%FILESIZE_%/331%%60
set /a COMPLETEMIN=%FILESIZE_%/331/60%%60
set /a COMPLETEHOUR=%FILESIZE_%/331/3600
echo Լ��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

echo [INFO] ���ںϲ��ļ�...
set COUNT=0
for /f "delims=_ tokens=3" %%i in ('dir /b /od /on /oe "%~1\*."') do (
	setlocal enabledelayedexpansion
	set FILEDATA=%%i
	echo !FILEDATA! >> %~dp1fileraw%RAND%.tmp
	set /a PER=!COUNT!%%596
	if "!PER!" == "0" echo [INFO] �����!COUNT!/%FILESCOUNT%
	endlocal
	set /a COUNT+=1
)
endlocal

echo [INFO] ���ڽ����ļ�...
sed -e "s/-/\//g;s/ //g" "%~dp1fileraw%RAND%.tmp" > "%~dp1file%RAND%.tmp"
base64 -di %~dp1file%RAND%.tmp > %~dp1%FILENAME%
del /f /q %~dp1fileraw%RAND%.tmp >nul
del /f /q %~dp1file%RAND%.tmp >nul

echo [INFO] ����У���ļ���ϣֵ...

for /f %%i in ('certutil -hashfile "%~dp1%FILENAME%" MD5 ^| findstr /V ��ϣ ^| findstr /V ���') do (set HASH=%%i)
echo [INFO] ��ϣֵ:		%HASH%
echo [INFO] ԭ��ϣֵ:	%FILEHASH%
if "%HASH%" == "%FILEHASH%" (
	echo [INFO] У�����!
	goto :EOF
)
echo [WARN] У��ʧ��!�����ļ������ļ��Ƿ�����.