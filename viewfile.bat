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
pause