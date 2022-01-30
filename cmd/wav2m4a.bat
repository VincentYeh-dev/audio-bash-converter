echo off
set FFMPEG_EXE_PATH=C:\bin\ffmpeg-2022-01-27-git-3c831847a8-full_build\bin\ffmpeg.exe
set KID_EXE_PATH=C:\bin\kid3-3.9.1-win32-x64\kid3-cli.exe
echo folder path:
set /p folder_to_read=

set volume_scale=1
echo volume scale(default:%volume_scale%):
set /p volume_scale=

set sampling_rate=44100
echo sampling rate(default:%sampling_rate% Hz):
set /p sampling_rate=

set bit_rate=128k
echo sampling rate(default:%bit_rate%):
set /p bit_rate=

echo volume scale(%volume_scale%):
echo sampling rate(%sampling_rate% Hz):
echo sampling rate(%bit_rate%):
set options=-hide_banner -loglevel info -c:a aac -c:v copy -ar %sampling_rate% -b:a %bit_rate% -filter:a "volume=%volume_scale%"
echo options: %options%

pause
FOR /R "%folder_to_read%" %%i IN (*.wav) DO ( 
    IF NOT EXIST "%%~dpim4a" (
        echo Making directory:"%%~dpim4a"
        mkdir "%%~dpim4a"
    )
    %FFMPEG_EXE_PATH% -i "%%i" %options% "%%~dpim4a\%%~ni.m4a"
    timeout -t 1
    echo ----------------------------------
    echo %KID_EXE_PATH% -c "select '%%i'" -c "get all" -c "copy 2" -c "select '%%~dpim4a\%%~ni.m4a'" -c "paste 2" -c "save" -c "get all"
    %KID_EXE_PATH% -c "select '%%i'" -c "get all" -c "copy 2" -c "select '%%~dpim4a\%%~ni.m4a'" -c "paste 2" -c "save" -c "get all"
    echo ----------------------------------
)
pause