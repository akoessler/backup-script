@echo off

setlocal

set SCRIPT_PATH=%~dp0
set BEGIN_TIME=%DATE% %TIME%


:: Parameter
set SRC_PATH=%1
set DST_PATH=%2
set JOB_NAME=%3
set FILE_FILTER=%4
set ADDITIONAL_PARAMETER=%5 %6 %7 %8 %9

if [%FILE_FILTER%]==[] set FILE_FILTER=*.*
if NOT [%SRC_PATH:~-1%] EQU [\] SET SRC_PATH=%SRC_PATH%\
if NOT [%DST_PATH:~-1%] EQU [\] SET DST_PATH=%DST_PATH%\


:: Variables

set PARAMETER=/mir /ZB /R:1 /W:1 /COPY:DAT /DCOPY:DAT /UNICODE /ETA /XJ /V /NP %ADDITIONAL_PARAMETER%

set LOGFOLDER=.backuplog

set LOGNAME=%JOB_NAME%-log.txt
set LOGBAKNAME=%LOGNAME%.bak

set INFO_FILE_NAME=%JOB_NAME%-info.txt
set INFO_FILE_NAMEBAK=%INFO_FILE_NAME%.bak

set SRC_LOG_PATH=%SRC_PATH%%LOGFOLDER%\
mkdir %SRC_LOG_PATH%
set SRC_LOG_FILE=%SRC_LOG_PATH%%LOGNAME%
set SRC_LOG_FILE_BAK=%SRC_LOG_PATH%%LOGBAKNAME%
set SRC_INFO_FILE=%SRC_LOG_PATH%%INFO_FILE_NAME%
set SRC_INFO_FILEBAK=%SRC_LOG_PATH%%INFO_FILE_NAMEBAK%

set DST_LOG_PATH=%DST_PATH%%LOGFOLDER%\
mkdir %DST_LOG_PATH%
set DST_LOG_FILE=%DST_LOG_PATH%%LOGNAME%
set DST_LOG_FILE_BAK=%DST_LOG_PATH%%LOGBAKNAME%
set DST_INFO_FILE=%DST_LOG_PATH%%INFO_FILE_NAME%
set DST_INFO_FILE_BAK=%DST_LOG_PATH%%INFO_FILE_NAMEBAK%

set FILE_EXCLUDES=/XF %SRC_LOG_FILE% %SRC_LOG_FILE_BAK% %SRC_INFO_FILE%
set DIR_EXCLUDES=/XD "System Volume Information" "$RECYCLE.BIN" %LOGFOLDER%

set ARGUMENTS=%SRC_PATH% %DST_PATH% %FILE_FILTER% %PARAMETER% /unilog:%SRC_LOG_FILE% %FILE_EXCLUDES% %DIR_EXCLUDES%
set COPYCOMMAND=robocopy.exe %ARGUMENTS%


:: Let's go

echo.
echo.
echo *****  BEGIN BACKUP  *****
echo.
echo.
echo Job name:              %JOB_NAME%
echo Source:                %SRC_PATH%
echo Destination:           %DST_PATH%
echo Begin:                 %BEGIN_TIME%
echo Source Logfile:        %SRC_LOG_FILE%
echo Source Infofile:       %SRC_INFO_FILE%
echo Destination Logfile:   %DST_LOG_FILE%
echo Destination Infofile:  %DST_INFO_FILE%
echo.
echo Command:
echo %COPYCOMMAND%
echo.
echo.


:: Copy last log file to .bak

IF EXIST %SRC_LOG_FILE% (
	echo Backup logfile to %SRC_LOG_FILE_BAK%
	COPY %SRC_LOG_FILE% %SRC_LOG_FILE_BAK% /Y
	COPY %SRC_INFO_FILE% %SRC_INFO_FILEBAK% /Y
	echo.
	echo.
)


:: Write information about this backup to the info file

echo ** Write info file -- start info ...
echo.

echo Last backup:                  >%SRC_INFO_FILE%
echo Job Name:    %JOB_NAME%       >>%SRC_INFO_FILE%
echo Source:      %SRC_PATH%       >>%SRC_INFO_FILE%
echo Destination: %DST_PATH%       >>%SRC_INFO_FILE%
echo Command:     %COPYCOMMAND%    >>%SRC_INFO_FILE%
echo Begin:       %BEGIN_TIME%     >>%SRC_INFO_FILE%

echo.
echo    ... finished
echo.


:: Do the actual copy

echo ** Run Robocopy ...
echo.

echo %COPYCOMMAND%
echo.
%COPYCOMMAND%
set BACKUPEXITCODE=%ERRORLEVEL%


echo.
echo    ... finished
echo.


:: Finish line

echo    Copy log file ...
echo.

set FINISHEDTIME=%DATE% %TIME%

copy %SRC_LOG_FILE% %DST_LOG_FILE% /Y
copy %SRC_LOG_FILE_BAK% %DST_LOG_FILE_BAK% /Y

echo.
echo    ... finished
echo.


echo ** Write info file -- end info ...
echo.

echo Finished:    %FINISHEDTIME%   >>%SRC_INFO_FILE%
echo Exit code:   %BACKUPEXITCODE% >>%SRC_INFO_FILE%

copy %SRC_INFO_FILE% %DST_INFO_FILE% /Y
copy %SRC_INFO_FILEBAK% %DST_INFO_FILE_BAK% /Y


echo.
echo    ... finished
echo.

echo.
echo.
echo *****  BACKUP FINISHED  *****
echo.
echo.


endlocal
