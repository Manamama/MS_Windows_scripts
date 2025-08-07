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
sudo apt install git -y
sudo apt install neofetch -y
 
neofetch --off 

git clone https://github.com/Manamama/Ubuntu_Scripts_1

bash Ubuntu_Scripts_1/install_basic_ubuntu_set_1.sh
echo
echo Finished. 
 
