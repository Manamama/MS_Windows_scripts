#MSYS2 stuff, after it got installed in Windows or anywhere

pacman -S --noconfirm python3-pip

pip show pip | awk '/Location/ {print $2"/site-packages"}'

rm -rf "$(pip show pip | awk '/Location/ {print $2}')/EXTERNALLY-MANAGED"

pip config set global.break-system-packages true

#torch cpu:
pip config set global.index-url https://pypi.org/simple
pip config set global.extra-index-url https://download.pytorch.org/whl/cpu
pip config list

# Bad method, as manual: mkdir -p ~/.config/pip && echo -e "[global]\nbreak-system-packages = true" >> ~/.config/pip/pip.conf

#Needed for docling  : 

# General development tools

pacman -S --noconfirm base-devel

pacman -S --noconfirm --needed \
  libxml2-devel \
  libxslt-devel \
  git \
  cython

#General version
: '
pacman -S --noconfirm --needed \

  gcc \
  clang \
  openssl \
  meson \
  ninja \

'

# MSYS2-friendly Mingw-w64 versions
pacman -S --noconfirm --needed \
  mingw-w64-x86_64-python \
  mingw-w64-x86_64-meson \
  mingw-w64-x86_64-ninja \
  mingw-w64-x86_64-gcc \
  mingw-w64-x86_64-cmake \
  mingw-w64-x86_64-make \
  mingw-w64-x86_64-openssl \
  mingw-w64-x86_64-python3-pip \
  mingw-w64-x86_64-clang

# "What is being installed?" "What dependencies am I pulling in?" and "What happens next?"

echo
echo "C Compiler Setup Script"
echo "----------------------------------------"
echo "This script ensures that you have a C compiler installed (either GCC or Clang)."
echo "If neither is found, it will guide you through installing one."

# Check if GCC or Clang are installed
echo "Checking for available C compilers..."

if ! command -v gcc >/dev/null && ! command -v clang >/dev/null; then
    echo "Error: No C compiler found (neither GCC nor Clang)."
    echo "Please install GCC or Clang before proceeding."
    exit 1
fi

# Set default compiler if not already set
echo "Setting up compilers..."
export CC=${CC:-$(command -v gcc || command -v clang)}
export CXX=${CXX:-$(command -v g++ || command -v clang++)}

# Show which compiler will be used
echo "Using compiler: $CC"
echo "Compiler setup completed."

# Make the environment variables persist across future sessions
PROFILE_FILE="$HOME/.bashrc"

# Check if the profile file already contains these lines
if ! grep -q 'export CC=' "$PROFILE_FILE"; then
    echo "Adding compiler environment variables to $PROFILE_FILE..."
    echo "export CC=$CC" >> "$PROFILE_FILE"
    echo "export CXX=$CXX" >> "$PROFILE_FILE"
    echo "Environment variables for CC and CXX have been added to $PROFILE_FILE."
fi


# Python scientific and data tools
pacman -S --noconfirm --needed \
  mingw-w64-x86_64-python-numpy \
  mingw-w64-x86_64-python-numba \
  mingw-w64-x86_64-python-numexpr \
  mingw-w64-x86_64-python-numpydoc \
  mingw-w64-x86_64-python-opt_einsum \
  mingw-w64-x86_64-python-soundfile \
  mingw-w64-x86_64-python-pandas \
  mingw-w64-x86_64-python-scipy \
  mingw-w64-x86_64-python-matplotlib \
  mingw-w64-x86_64-python-openpyxl

# Set OpenSSL root directory
export OPENSSL_ROOT_DIR=/mingw64


pip install ninja
pip install poetry
pip install setuptools
pip install -v clang
pip install --upgrade pip setuptools
pip install meson-python
pip install lolcat


#Or:
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#python get-pip.py


pacman -S --noconfirm neofetch cpufetch 
pip install pandas -v
pip install numpy --no-binary numpy -v
pip install poetry
pip install -v -U whisperx docling funasr openai-whisper open-interpreter tts
pip install -U  numpy --no-binary numpy -v

#For Whisperx : 
pip install -U  pyannote.audio  -v
