@ECHO OFF

REM // build the ROM
call build %1

REM  // run fc
echo -------------------------------------------------------------
IF EXIST artbuilt.bin ( fc /b artbuilt.bin artoriginal.bin
) ELSE echo artbuilt.bin does not exist, probably due to an assembly error

REM // clean up after us
IF EXIST art.p del art.p
IF EXIST art.h del art.h
IF EXIST artbuilt.bin del artbuilt.bin
IF EXIST artbuilt.prev.bin del artbuilt.prev.bin
IF EXIST art.log ( IF "%1"=="-pe" del art.log )

REM // if someone ran this from Windows Explorer, prevent the window from disappearing immediately
pause
