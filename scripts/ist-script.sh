#! /usr/bin/bash

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt-get update

sudo apt-get install -y ros-kinetic-desktop-full

sudo rosdep init
rosdep update

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo "alias killgazebogym='killall -9 rosout roslaunch rosmaster gzserver nodelet robot_state_publisher gzclient'" >> ~/.bashrc

sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo apt-get install -y ros-kinetic-desktop-full ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control ros-kinetic-ros-control

sudo apt-get install -y ros-kinetic-ros-controllers ros-kinetic-moveit ros-kinetic-navigation ros-kinetic-hector-gazebo-plugins ros-kinetic-yocs-cmd-vel-mux

# Freenect dep
sudo apt-get install -y build-essential cmake pkg-config libusb-1.0-0-dev libturbojpeg libjpeg-turbo8-dev libglfw3-dev libopenni2-dev

# Linking fix
sudo rm /usr/lib/x86_64-linux-gnu/libGL.so
sudo ln -s /usr/lib/x86_64-linux-gnu/libGL.so.1.7.0 /usr/lib/x86_64-linux-gnu/libGL.so


sudo ln -s /usr/lib/python2.7/dist-packages/vtk/libvtkRenderingPythonTkWidgets.x86_64-linux-gnu.so /usr/lib/x86_64-linux-gnu/libvtkRenderingPythonTkWidgets.so

sudo rm /usr/lib/x86_64-linux-gnu/libEGL.so
sudo ln /usr/lib/x86_64-linux-gnu/libEGL.so.1.1.0 /usr/lib/x86_64-linux-gnu/libEGL.so

# Freenect install
cd ~ 
git clone https://github.com/OpenKinect/libfreenect2.git 
cd libfreenect2 
mkdir build && cd build 
cmake ..  -DENABLE_CXX11=ON -DENABLE_OPENCL=ON 
make 
sudo make install 
sudo cp ../platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/ 

# sudo ln -s /usr/lib/python2.7/dist-packages/vtk/libvtkRenderingPythonTkWidgets.x86_64-linux-gnu.so /usr/lib/x86_64-linux-gnu/libvtkRenderingPythonTkWidgets.so


cd ~/ist-robotics/robots/movo/
catkin_make
source devel/setup.bash

# pip install
cd ~
wget https://bootstrap.pypa.io/get-pip.py
sudo python2 get-pip.py



# gym install
cd ~
git clone https://github.com/openai/gym.git
cd gym
pip install --user -e .

# Tensorflow install
cd ~
pip install --user --upgrade tensorflow



# Terminator install
sudo add-apt-repository -y ppa:gnome-terminator
sudo apt-get update
sudo apt-get install -y terminator

sudo update-alternatives --config x-terminal-emulator



echo ""
echo "******************************************************************"
echo "*                                                                *"
echo "*                 IST installation is done! Rebooting!           *"
echo "*                                                                *"
echo "******************************************************************"
echo ""

sudo reboot
