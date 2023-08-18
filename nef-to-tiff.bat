@echo off
setlocal enabledelayedexpansion

set tiff_folder=TIFF
set nef_folder=NEF

if not exist %nef_folder% (
    md %nef_folder%
) else (
    set "found=0"
    for %%A in (%nef_folder%\*.nef) do (
        set "found=1"
        goto :ok
    )
    if not !found! == 1 (
        echo You have no files in NEF folder!
        pause
    )
)

:ok
if not exist %tiff_folder% (
    md %tiff_folder%
)

for %%f in (%nef_folder%\*.nef) do (
    set "file_name=%%~nf"
    if exist "%tiff_folder%\!file_name!.tiff" (
	goto :und
    ) else (
        echo Converting : !file_name!
        magick convert "%%f" "%tiff_folder%\!file_name!.tiff"
    )
)
goto :go_to_end
end.
:und
echo You already have files in %tiff_folder% !
set /p "confirmation=Erase TIFF files? (Y/N): "

if /i "%confirmation%"=="Y" (
    for %%f in ("%tiff_folder%\*.*") do (
        del "%%f"
    )
    echo TIFFS deleted.
) else (
    end
)
:go_to_end
end




