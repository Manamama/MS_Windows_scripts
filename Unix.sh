#First things first if e.g. booting off ISO file
sudo apt install clang
sudo apt install lobomp-dev
sudo apt install cpufetch
sudo apt intall neofetch
cpufetch
neofetch -off
sudo apt install git
sudo apt install cmake
sudo apt install clang

cd Downloads
git clone https://github.com/Dr-noob/peakperf
#In CmakeList.txt comment out #Set (SANITY_FLAGS)
cd peakperf
./build.sh
./peakperf
