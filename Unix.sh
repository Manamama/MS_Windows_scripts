#First things first if e.g. booting off ISO file

sudo apt install cpufetch -y
sudo apt install neofetch - y
cpufetch
neofetch --off
sudo apt install git cmake clang -y 
sudo apt install lobomp-dev -y 


#Install clang-18
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

#Install OpenMP 18, for llama.cpp etc.:
sudo apt install libomp-18-dev -y 

cd Downloads
git clone https://github.com/Dr-noob/peakperf
#In CmakeList.txt comment out #Set (SANITY_FLAGS)
cd peakperf
./build.sh
./peakperf
