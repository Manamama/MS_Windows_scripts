#Meta info - how to surive in Windows non-admin environment, messy as hell for now
#Ver 4.0.1
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


choco install wget ffmpeg nano exiftool mpv.portable note

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
setx PATH "%LOCALAPPDATA%\miniconda3\;%LOCALAPPDATA%\miniconda3\Library\bin\;%LOCALAPPDATA%\Microsoft\WindowsApps;C:\ProgramData\chocoportable\bin;%LOCALAPPDATA%\miniconda3\Scripts;%USERPROFILE%\AppData\Local\Programs\Git\bin;%LOCALAPPDATA%\Chocolatey; C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;%USERPROFILE%\Chocolatey\bin\;%LOCALAPPDATA%\Microsoft\WindowsApps\;%USERPROFILE%\Documents\anaconda3\scripts;%PROGRAMDATA%\chocolatey\bin\;C:\Users\IFP\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts\;C:\ProgramData\mingw64\mingw64\bin\"


REM plus: %PATH%

refreshenv

echo New path: 
echo %PATH%
REM Or opening new terminal many times may be needed



#exit

# Update PATH to include necessary directories
export PATH="$PATH:$LOCALAPPDATA/miniconda3:$LOCALAPPDATA/miniconda3/Library/bin:$LOCALAPPDATA/Microsoft/WindowsApps:/c/ProgramData/chocolatey/bin:/c/ProgramData/chocoportable/bin:$LOCALAPPDATA/miniconda3/Scripts:$USERPROFILE/AppData/Local/Programs/Git/bin:$LOCALAPPDATA/Chocolatey:$LOCALAPPDATA/chocolatey/lib/make/tools/install/bin:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0:/c/Windows/System32/OpenSSH:$USERPROFILE/Chocolatey/bin:$LOCALAPPDATA/Microsoft/WindowsApps:$USERPROFILE/Documents/anaconda3/scripts:$PROGRAMDATA/chocolatey/bin"

# Add Python scripts directory to PATH
export PATH="$PATH:$USERPROFILE/AppData/Local/Packages/PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0/LocalCache/local-packages/Python312/Scripts"

refreshenv
echo %PATH%




#MSYS2 stuff

pacman -S --noconfirm python3-pip

pip show pip | awk '/Location/ {print $2"/site-packages"}'

rm -rf "$(pip show pip | awk '/Location/ {print $2}')/EXTERNALLY-MANAGED"

pip config set global.break-system-packages true

#torch cpu:
pip config set global.index-url https://pypi.org/simple
pip config set global.extra-index-url https://download.pytorch.org/whl/cpu
pip config list

# Bad: mkdir -p ~/.config/pip && echo -e "[global]\nbreak-system-packages = true" >> ~/.config/pip/pip.conf


pacman -S --noconfirm libxml2 libxslt
pacman -S --noconfirm libxml2-devel
pacman -S --noconfirm gcc
pacman -S --noconfirm clang
pacman -S --noconfirm openssl
export OPENSSL_ROOT_DIR=/mingw64
pacman -S --noconfirm meson
pacman -S --noconfirm ninja
pacman -S --noconfirm git

pacman -S mingw-w64-x86_64-python
pacman -S mingw-w64-x86_64-meson
pacman -S mingw-w64-x86_64-ninja


pip install ninja
pip install poetry
pip install setuptools
pip install -v clang
pip install --upgrade pip setuptools
pip install meson-python

pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-cmake
pacman -S mingw-w64-x86_64-make
pacman -S mingw-w64-x86_64-python
#pacman -S mingw-w64-ucrt-x86_64-python-pip

pacman -S mingw-w64-ucrt-x86_64-python3-pip

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python get-pip.py

pacman -S mingw-w64-x86_64-ninja


pacman -S --noconfirm cython cmake ninja
pacman -S --noconfirm mingw-w64-clang-x86_64-python-pandas
pacman -S --noconfirm base-devel
pacman -S --noconfirm mingw-w64-x86_64-python-numpy mingw-w64-x86_64-python-numba mingw-w64-x86_64-python-numexpr mingw-w64-x86_64-python-numpydoc mingw-w64-x86_64-python-opt_einsum mingw-w64-x86_64-python-soundfile   mingw-w64-x86_64-python-pandas  mingw-w64-x86_64-python-scipy  mingw-w64-x86_64-python-matplotlib  mingw-w64-x86_64-python-numexpr mingw-w64-x86_64-python-openpyxl
pip install pandas -v
pip install numpy --no-binary numpy -v
pip install poetry
pip install -v -U whisperx docling funasr openai-whisper open-interpreter tts

pip install -U  numpy --no-binary numpy -v
#For Whisperx : 
pip install -U  pyannote.audio  -v


