#First things first if e.g. booting off ISO file

sudo apt install cpufetch
sudo apt install neofetch
cpufetch
neofetch -off
sudo apt install git cmake clang -y 
sudo apt install lobomp-dev -y 

cd Downloads
git clone https://github.com/Dr-noob/peakperf
#In CmakeList.txt comment out #Set (SANITY_FLAGS)
cd peakperf
./build.sh
./peakperf
