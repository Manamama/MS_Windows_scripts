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

#just in cae: 
pacman -Sy

# MSYS2-friendly Mingw-w64 versions
pacman -S --noconfirm --needed \
mingw-w64-x86_64-toolchain \
  mingw-w64-x86_64-python \
  mingw-w64-x86_64-meson \
  mingw-w64-x86_64-ninja \
  mingw-w64-x86_64-gcc \
  mingw-w64-x86_64-cmake \
  mingw-w64-x86_64-make \
  mingw-w64-x86_64-openssl \
  mingw-w64-x86_64-python3-pip \
  mingw-w64-x86_64-clang \
  mingw-w64-x86_64-openblas \ 
  mingw-w64-x86_64-lfortran \
  mingw-w64-i686-pkgconf \
  mingw-w64-x86_64-vulkan-headers

pacman -S --noconfirm --needed python-devel libatomic_ops-devel findutils


echo "We check the include paths for C++ version:"

# Step 3: Check if we found a valid version
if [ -z "$CXX_VERSION" ]; then
    echo "No C++ include directories found in /mingw64/include/c++. Please check your installation."
else
    echo "Found C++ version: $CXX_VERSION. We set the paths thereto, but add them to your .bashrc etc later:"

    # Step 4: Set environment variables
    export CXXFLAGS="-I/mingw64/include/c++/$CXX_VERSION"  # Specifies additional include paths for C++ compilation.
    export CPLUS_INCLUDE_PATH="/mingw64/include/c++/$CXX_VERSION"  # Specifically tells the C++ compiler where to find header files.
    export CPATH="$CPLUS_INCLUDE_PATH"  # General include path for both C and C++ compilers.

    # Step 5: Print what has been set
    echo "Set CXXFLAGS to: $CXXFLAGS"
    echo "Set CPLUS_INCLUDE_PATH to: $CPLUS_INCLUDE_PATH"
    echo "Set CPATH to: $CPATH"
fi

# Step 6: Verify the paths
echo "Verify include paths in /mingw64/include/c++/:"
ls /mingw64/include/c++/*

# Step 7: Print all C* related environment variables
echo "Current C* environment variables:"
printenv | grep '^C'




export OPENSSL_ROOT_DIR=/mingw64
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

#gcc first: 
export CC=${CC:-$(command -v gcc || command -v clang)}
export CXX=${CXX:-$(command -v g++ || command -v clang++)}

#clang first: 
export CC=${CC:-$(command -v clang || command -v gcc)}
export CXX=${CXX:-$(command -v clang++ || command -v g++)}

# Show which compiler will be used
echo "Using compiler: $CC"
echo "Compiler setup completed."

# Make the environment variables persist across future sessions
PROFILE_FILE="$HOME/.bashrc"

#!/bin/bash

# Check if Clang is installed
if command -v clang &>/dev/null; then
    echo "Clang is installed. Setting up LD_* paths for Clang."

    # Set LD_* variables for Clang (assuming /usr/bin/clang as base directory for Clang)
    export LD_LIBRARY_PATH="/mingw64/lib/clang/$(clang --version | head -n 1 | awk '{print $3}')/lib:$LD_LIBRARY_PATH"
    export LDFLAGS="-L/mingw64/lib/clang/$(clang --version | head -n 1 | awk '{print $3}')/lib $LDFLAGS"
    export LD_RUN_PATH="$LD_LIBRARY_PATH"

    echo "Set LD_LIBRARY_PATH to: $LD_LIBRARY_PATH"
    echo "Set LDFLAGS to: $LDFLAGS"
    echo "Set LD_RUN_PATH to: $LD_RUN_PATH"

elif command -v gcc &>/dev/null; then
    echo "Clang not found. Falling back to GCC. Setting up LD_* paths for GCC."

    # Set LD_* variables for GCC (assuming /usr/bin/gcc as base directory for GCC)
    export LD_LIBRARY_PATH="/mingw64/lib/gcc/$(gcc --version | head -n 1 | awk '{print $3}' | cut -d. -f1)/$LD_LIBRARY_PATH"
    export LDFLAGS="-L/mingw64/lib/gcc/$(gcc --version | head -n 1 | awk '{print $3}' | cut -d. -f1) $LDFLAGS"
    export LD_RUN_PATH="$LD_LIBRARY_PATH"

    echo "Set LD_LIBRARY_PATH to: $LD_LIBRARY_PATH"
    echo "Set LDFLAGS to: $LDFLAGS"
    echo "Set LD_RUN_PATH to: $LD_RUN_PATH"

else
    echo "Neither Clang nor GCC is installed. Please install one of them to proceed."
fi

# Final step: List all LD* variables to confirm
echo "Printing all LD* environment variables:"
printenv | grep '^LD'

# Checking which linker is being used
echo "Checking which linker is being used:"
which ld
which clang
which clang++





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
  mingw-w64-x86_64-python-openpyxl \
  mingw-w64-x86_64-libatomic_ops

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
# you may get:   ../meson.build:5:13: ERROR: Command `/tmp/pip-install-szrpx4_7/pandas_18422d9ebc7a465b94960ab5fa3dfc92/generate_version.py --print` failed with status 1.
 
pip install numpy --no-binary numpy -v
pip install poetry
pip install -v -U whisperx docling funasr openai-whisper open-interpreter tts
pip install -U  numpy --no-binary numpy -v

#For Whisperx : 
pip install -U  pyannote.audio  -v
