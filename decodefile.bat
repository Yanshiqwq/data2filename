@echo off
echo.
echo %~nx0 v1.1 By ��ʱqwq https://space.bilibili.com/431304449
echo.
set RAND=%RANDOM%
for /f %%i in ('where /r "%~1" index_*') do (set INDEXFILE=%%~ni)
for /f %%i in ('where /r "%~1" filename_*') do (set NAMEFILE=%%~ni)
for /f "delims=_ tokens=2" %%i  in ('echo %NAMEFILE%') do (set FILENAME=%%i)
for /f "delims=._ tokens=3" %%i  in ('echo %NAMEFILE%') do (set FILEEXT=%%i)
if "%FILEEXT%" NEQ "~1" (
	set FILENAME=%FILENAME%.%FILEEXT%
)
for /f "delims=_ tokens=2,3" %%i in ('echo %INDEXFILE%') do (set FILERAND=%%i)
for /f "delims=_ tokens=3" %%i in ('echo %INDEXFILE%') do (set FILECOUNT=%%i)
echo ��ԭ�ٶ�:	Լ79KB/s
if "%~1" == "" (
	echo �÷�: %~nx0 �����ܵ��ļ�
	goto :EOF
)
echo �ļ�����:	%FILENAME%
set /a GB=%~z1/1024/1024/1024
set /a MB=%~z1/1024/1024%%1024
set /a KB=%~z1/1024%%1024
echo �ļ���С:	%GB%GB %MB%MB %KB%KB
set /a FILESIZE=%~z1/1024
set /a COMPLETESEC=%FILESIZE%/79%%60
set /a COMPLETEMIN=%FILESIZE%/79/60%%60
set /a COMPLETEHOUR=%FILESIZE%/79/3600%%60
echo Լ��ʱ��:	%COMPLETEHOUR%ʱ %COMPLETEMIN%�� %COMPLETESEC%��

echo [INFO] ���ںϲ��ļ�...
setlocal enabledelayedexpansion
for /f "delims=_ tokens=3" %%i in ('dir /b /od /on /oe "%~1\*."') do (
	set FILEDATA=%%i
	set FILEDATA=!FILEDATA:-=/!
	echo !FILEDATA! >> %~dp1file%RAND%.tmp
)
endlocal

echo [INFO] �ϲ����!���ڽ����ļ�...
base32 -di %~dp1file%RAND%.tmp > %~dp1%FILENAME%
del /f /q %~dp1file%RAND%.tmp >nul

echo [INFO] �������!����У���ļ���ϣֵ...
for /f %%i in ('where /r "%~1" hash_*') do (set HASHFILE=%%~ni)
set FILEHASH=%HASHFILE:~5%
certutil -hashfile %~dp1%FILENAME% MD5 | findstr /V ��ϣ | findstr /V ��� > %~dp1hash%RAND%.tmp
for /f %%i in ('type %~dp1hash%RAND%.tmp') do (set HASH=%%i)
del /f /q %~dp1hash%RAND%.tmp >nul
if "%HASH%" == "%FILEHASH%" (
	echo [INFO] У�����!
	goto :EOF
)
echo [WARN] У��ʧ��!�����ļ������ļ��Ƿ�����.