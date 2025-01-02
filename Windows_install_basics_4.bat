#Meta info - private list of how to surive in MS Windows OS in a non-admin environment, messy as hell for now
#Ver 4.1.1
#Note to self: fuller info and tricks may be on the Droid, SD Card, Installs ... folder
#REM - see also here : https://docs.google.com/document/d/1FtANN49gR8vE4B7cskDL4Yajw6cRQ7Fw8VrJugRGlaQ/edit?pli=1&tab=t.0  , for now
#REM - see C:\Users\IFP\Documents\Portable_when_on_Public_comps\_Meta_scripts etc. 


Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy]
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{48981759-12F2-42A6-A048-028B3973495F} Machine\System\CurrentControlSet\Policies]
"LongPathsEnabled"=dword:00000001

#Or, needs admin:
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001

#Msys2 asap install:

REM choco install, in cmd: 
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin;;C:\Users\%USERPROFILE%\Documents\Python_script"

powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; $chocoPath = Join-Path $env:LOCALAPPDATA 'Chocolatey'; mkdir $chocoPath -ErrorAction SilentlyContinue; $installScriptUrl = 'https://chocolatey.org/install.ps1'; $installScriptPath = Join-Path $chocoPath 'install.ps1'; Invoke-WebRequest -Uri $installScriptUrl -OutFile $installScriptPath; & $installScriptPath; $binPath = Join-Path $chocoPath 'bin'; [Environment]::SetEnvironmentVariable('PATH', '$binPath;$env:PATH', 'User'); if (Get-Command choco -ErrorAction SilentlyContinue) { Write-Host 'Chocolatey installed successfully.' } else { Write-Host 'Chocolatey installation failed.' }"



echo Chocolatey exe files are at:
dir C:\choco.exe /s /b


echo Winget exe files are at:
dir C:\winget.exe /s /b
echo %PATH%
REM choco install winget --force


choco install wget ffmpeg nano exiftool llvm.portable  mpv.portable note dotnetcore-runtime.portable

#choco install llvm.portable --force 
REM winget install python

REM For git:
winget install --id Git.Git -e --source winget
REM refreshenv
dir C:\bash.exe /s /b

REM or use that one:
REM cd C:\Users\%USERPROFILE%\Documents\Portable_when_on_Public_comps\git-bash.exe

Rem Or: choco install git

Rem Conda:
winget install --id=Anaconda.Miniconda3 -e --source winget
REM then run all in the Anaconda shell

winget install abd
REM or: choco install adb



REM Note about Python and long paths. Below may not work:

REM Define the path to the registry key
set registryPath=HKLM\SYSTEM\CurrentControlSet\Control\FileSystem

REM Define the name of the registry entry and its value
set Name=LongPathsEnabled
set value=1

REM Add the registry entry
reg add "%registryPath%" /v %Name% /t REG_DWORD /d %value% /f

pip install easyocr whisperx openai-whisper open-interpreter funasr torch 
pip install tts





REM Gnirehtet for ANdroid: 

REM git clone https://github.com/Genymobile/gnirehtet.git

REM cd gnirehtet\relay-rust
REM cargo build --release
REM And then copy the target/release to some in %PATH%
wget https://github.com/Genymobile/gnirehtet/releases/download/v2.5.1/gnirehtet-rust-win64-v2.5.1.zip
tar -xaf gnirehtet-rust-win64-v2.5.1.zip
copy gnirehtet-rust-win64\gnirehtet.exe %USERPROFILE%\Chocolatey\bin\
rem gnirehtet  start
Rem setx PYTHONPATH "%PYTHONPATH%;C:\Users\%USERPROFILE%\Documents\Python_script"

wget https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.1/npp.8.7.1.portable.x64.zip


@echo off
mkdir "C:\ProgramData\chocoportable\bin"
wget https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.1/npp.8.7.1.portable.x64.zip
tar -xaf "npp.8.7.1.portable.x64.zip" -C "C:\ProgramData\chocoportable\bin"
start "" "C:\ProgramData\chocoportable\bin\notepad++.exe"


#PATHs:


@echo off
echo - Run this file manually whenever needed, and open new terminal too:
REM Update PATH to include necessary directories
setx PATH "%LOCALAPPDATA%\miniconda3\;%LOCALAPPDATA%\miniconda3\Library\bin\;%LOCALAPPDATA%\Microsoft\WindowsApps;C:\ProgramData\chocoportable\bin;%LOCALAPPDATA%\miniconda3\Scripts;%USERPROFILE%\AppData\Local\Programs\Git\bin;%LOCALAPPDATA%\Chocolatey; C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;%USERPROFILE%\Chocolatey\bin\;%LOCALAPPDATA%\Microsoft\WindowsApps\;%USERPROFILE%\Documents\anaconda3\scripts;%PROGRAMDATA%\chocolatey\bin\;C:\Users\IFP\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts\;C:\ProgramData\mingw64\mingw64\bin\:$USERPROFILE\Documents\Msys64\mingw64\bin"


REM plus: %PATH%

refreshenv

echo New path: 
echo %PATH%
REM Or opening new terminal many times may be needed



#exit

refreshenv
echo %PATH%
conda install -c conda-forge exiftool
#Must be in conda to run:
conda activate

echo Now install the lot from Unix: https://github.com/Manamama/MS_Windows_scripts/blob/main/msys2_1.sh and try : https://github.com/Manamama/Ubuntu_Scripts_1/blob/main/docling_me.sh

echo
echo And pray that it works. 

