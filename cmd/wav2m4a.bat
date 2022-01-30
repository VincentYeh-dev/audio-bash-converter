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
    @REM echo %%i
    set wav_file="%%i"
    call set wav_file=%%wav_file%%
    call set escape_wav_file=%%wav_file:'=\'%%
    @REM call echo "select '%%escape_wav_file:"=%%'"

    set wav_folder="%%~dpi"
    call set wav_folder=%%wav_folder%%
    call echo "%%wav_folder:"=%%"

    call set m4a_file="%%wav_folder:"=%%m4a\%%~ni.m4a"
    call set escape_m4a_file=%%m4a_file:'=\'%%

    IF NOT EXIST "%%~dpim4a" (
        echo Making directory:"%%~dpim4a"
        mkdir "%%~dpim4a"
    )

    @REM call echo %FFMPEG_EXE_PATH% -i %%wav_file%% %options% %%m4a_file%%
    call %FFMPEG_EXE_PATH% -i %%wav_file%% %options% %%m4a_file%%
    echo ----------------------------------
    @REM call echo %KID_EXE_PATH% -c "select '%%escape_wav_file:"=%%'" -c "get all" -c "copy 2" -c "select '%%escape_m4a_file:"=%%'" -c "paste 2" -c "save" -c "get all"
    call %KID_EXE_PATH% -c "select '%%escape_wav_file:"=%%'" -c "get all" -c "copy 2" -c "select '%%escape_m4a_file:"=%%'" -c "paste 2" -c "save" -c "get all"
    echo ----------------------------------
)
pause