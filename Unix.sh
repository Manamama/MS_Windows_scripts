#First things first if e.g. booting off ISO file
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
        sudo mount -t ntfs-36 -0 remove_hiberfile /dev/sda2 /media/zorin/Dysk_02
    
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
sudo apt install neofetch - y
cpufetch
neofetch --off
sudo apt install git cmake clang -y 
sudo apt install lobomp-dev -y 


#Install clang-18
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo apt install libomp-dev -y
#Install OpenMP 18, for llama.cpp etc.:
sudo apt install libomp-18-dev -y 

cd Downloads
git clone https://github.com/Dr-noob/peakperf


cd peakperf

#In CmakeList.txt comment out #Set (SANITY_FLAGS)
sed -i '/set(SANITY_FLAGS/ s/^/#/' CMakeLists.txt

./build.sh
./peakperf
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y

sudo apt install grub-customizer -y

