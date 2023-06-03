@ECHO OFF

REM // make sure we can write to the file artbuilt.bin
REM // also make a backup to artbuilt.prev.bin
IF NOT EXIST artbuilt.bin goto LABLNOCOPY
IF EXIST artbuilt.prev.bin del artbuilt.prev.bin
IF EXIST artbuilt.prev.bin goto LABLNOCOPY
move /Y artbuilt.bin artbuilt.prev.bin
IF EXIST artbuilt.bin goto LABLERROR3
:LABLNOCOPY

REM // delete some intermediate assembler output just in case
IF EXIST art.p del art.p
IF EXIST art.p goto LABLERROR2
IF EXIST art.h del art.h
IF EXIST art.h goto LABLERROR1

REM // clear the output window
REM cls

REM // run the assembler
REM // -xx shows the most detailed error output
REM // -E creates log file for errors/warnings
REM // -A gives us a small speedup
set AS_MSGPATH=AS/win32
set USEANSI=n

REM // allow the user to choose to output error messages to file by supplying the -logerrors parameter
IF "%1"=="-logerrors" ( "AS/win32/asw.exe" -xx -c -E -A art.asm ) ELSE "AS/win32/asw.exe" -xx -c -E -A art.asm

REM // if there were errors, a log file is produced
IF EXIST art.log goto LABLERROR4

REM // combine the assembler output into a rom
IF EXIST art.p "AS/win32/artp2bin" art.p artbuilt.bin art.h

REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST art.p goto LABLPAUSE
IF NOT EXIST artbuilt.bin goto LABLPAUSE
fixheader artbuilt.bin
exit /b
:LABLPAUSE

pause


exit /b

:LABLERROR1
echo Failed to build because write access to art.h was denied.
pause


exit /b

:LABLERROR2
echo Failed to build because write access to art.p was denied.
pause


exit /b

:LABLERROR3
echo Failed to build because write access to artbuilt.bin was denied.
pause

exit /b

:LABLERROR4
REM // display a noticeable message
echo.
echo ***************************************************************************
echo *                                                                         *
echo *   There were build errors/warnings. See art.log for more details.  	   *
echo *                                                                         *
echo ***************************************************************************
echo.
pause

