#MSYS2 stuff, after it got installed in Windows or anywhere

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
pip install lolcat
pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-cmake
pacman -S mingw-w64-x86_64-make
pacman -S mingw-w64-x86_64-python
#pacman -S mingw-w64-ucrt-x86_64-python-pip

pacman -S mingw-w64-ucrt-x86_64-python3-pip
#Best pip:
pacman -S $MINGW_PACKAGE_PREFIX-python3-pip

#Or:
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python get-pip.py

pacman -S mingw-w64-x86_64-ninja


pacman -S --noconfirm cython cmake ninja
pacman -S --noconfirm mingw-w64-clang-x86_64-python-pandas
pacman -S --noconfirm base-devel

pacman -S --noconfirm neofetch cpufetch 
pacman -S --noconfirm mingw-w64-x86_64-python-numpy mingw-w64-x86_64-python-numba mingw-w64-x86_64-python-numexpr mingw-w64-x86_64-python-numpydoc mingw-w64-x86_64-python-opt_einsum mingw-w64-x86_64-python-soundfile   mingw-w64-x86_64-python-pandas  mingw-w64-x86_64-python-scipy  mingw-w64-x86_64-python-matplotlib  mingw-w64-x86_64-python-numexpr mingw-w64-x86_64-python-openpyxl
pip install pandas -v
pip install numpy --no-binary numpy -v
pip install poetry
pip install -v -U whisperx docling funasr openai-whisper open-interpreter tts
pip install -U  numpy --no-binary numpy -v

#For Whisperx : 
pip install -U  pyannote.audio  -v
