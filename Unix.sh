#First things first if e.g. booting off ISO file
# See also: https://github.com/Manamama/Ubuntu_Scripts_1/blob/main/install_basic_ubuntu_set_1.sh


gnome-system-monitor &



# Check if /dev/sda2 exists
if [ -b /dev/sda2 ]; then
    echo "/dev/sda2 exists."
    sudo mkdir -p /media/zorin/Dysk_02
    sudo mkdir -p /media/zorin/Dysk_03
    # Mount /dev/sda2 to /media/zorin/Dysk_02 if it's not already mounted
    if ! mountpoint -q /media/zorin/Dysk_02; then
        echo "Mounting /dev/sda2 to /media/zorin/Dysk_02..."
        #sudo mount /dev/sda2 /media/zorin/Dysk_02
        sudo mount -t ntfs-3g -o remove_hiberfile /dev/sda2 /media/zorin/Dysk_02
    
    else
        echo "/dev/sda2 is already mounted."
    fi
    
    # Check if over 8GB is available on /media/zorin/Dysk_02
    available_space=$(df /media/zorin/Dysk_02 | awk 'NR==2 {print $4}')
    available_space_gb=$((available_space / 1024 / 1024)) # Convert to GB
    
    if [ "$available_space_gb" -gt 8 ]; then
        echo "Over 8GB available on /media/zorin/Dysk_02."
        
        # Create swapfile of 8GB size (8*1024*1024=8388608 KB)
        swapfile="/media/zorin/Dysk_02/swapfile_linux1.bin"
	
        # Enable the swapfile
        sudo swapon "$swapfile"
	#Create the swapfile too, just in case it was not:
        sudo dd if=/dev/zero of="$swapfile" bs=1M count=8192 status=progress
        
        # Set correct permissions for the swapfile
        sudo chmod 600 "$swapfile"
        
        # Make the swapfile usable
        sudo mkswap "$swapfile"
        
        # Enable the swapfile
        sudo swapon "$swapfile"
        
        echo "Swap file created and activated at $swapfile."
    else
        echo "Not enough space available (over 8GB required)."
    fi
else
    echo "/dev/sda2 does not exist."
fi


sudo apt update
sudo apt install cpufetch -y
sudo apt install neofetch -y
cpufetch
neofetch --off
sudo apt install git cmake clang -y 



#Install clang-18
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo apt install libomp-dev libssl-dev adb fastboot -y
#Install OpenMP 18, for llama.cpp etc.:
#sudo apt install libomp-18-dev -y 

cd Downloads
git clone https://github.com/Dr-noob/peakperf


cd peakperf

#In CmakeList.txt comment out #Set (SANITY_FLAGS)
sed -i '/set(SANITY_FLAGS/ s/^/#/' CMakeLists.txt

./build.sh
./peakperf
sudo apt clean
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y
sudo apt install grub-customizer -y
sudo apt install python3-pip -y 
sudo apt clean
sudo apt autoremove -y
sudo apt install scrcpy -y 
# https://gist.github.com/Ericwyn/e89553d8dfcb9fc9066da506d9e6fd93
cd ~/Downloads

	wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip

	unzip platform-tools-latest-linux.zip

	sudo cp -R -f platform-tools/* /usr/bin/*

	#rm -rf platform-tools/
	#rm platform-tools-latest-linux.zip

	echo "install latest platform success"

	/bin/fastboot --version

wget https://github.com/xxxserxxx/gotop/releases/download/v4.2.0/gotop_v4.2.0_linux_amd64.deb
sudo dpkg -i gotop_v4.2.0_linux_amd64.deb
#llama:
git clone https://github.com/ggerganov/llama.cpp
cmake llama.cpp -B llama.cpp/build     -DBUILD_SHARED_LIBS=OFF  -DLLAMA_CURL=ON 
# If no OpenMP found, use: 
#cmake -B build   -DOpenMP_C_FLAGS="-fopenmp"   -DOpenMP_CXX_FLAGS="-fopenmp"   -DOpenMP_C_LIB_NAMES="libomp"  -DOpenMP_CXX_LIB_NAMES="libomp" 

cmake --install llama.cpp/build
# sudo cmake --build llama.cpp/build --target install

# or: pip install llama-cpp-python -U

#google gh stuff:

#mkdir -p /home/abovetrans/.local/var/lib/dpkg    # And install there for permanence: sudo dpkg --instdir=/home/abovetrans/.local --admindir=/home/abovetrans/.local/var/lib/dpkg --no-triggers -i gotop_v4.2.0_linux_amd64.deb                                                                             #You can bind /home, but not advised, as it is a temp, ephemeral folder:                            # sudo mount --bind /root/home2 /home             sudo mkdir -p /root/home_extended/.cache          echo Mounting --bind /root/home_extended/.cache ~/.cache for more space....                         sudo mount --bind /root/home_extended/.cache ~/.cache                                               sudo chown -R abovetrans:abovetrans /root/home_extended/.cache
