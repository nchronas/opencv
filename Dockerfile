FROM resin/rpi-raspbian:latest
RUN apt-get update -y && apt-get install -y \
python python-pip python-dev python-numpy python-dbus python-flask \
dropbear \
nano \
build-essential cmake pkg-config \
libjpeg8-dev libjasper-dev libpng12-dev \
libgtk2.0-dev \
libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
libatlas-base-dev gfortran \
unzip \
wget \
git \
&& apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install virtualenv virtualenvwrapper
//RUN wget -O opencv-2.4.10.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.10/opencv-2.4.10.zip/download
//RUN unzip opencv-2.4.10.zip
//RUN cd opencv-2.4.10 && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON  -D BUILD_EXAMPLES=ON -D WITH_FFMPEG=OFF .. && make -j4 && make install 
RUN mkdir build && cd build && git clone https://github.com/Itseez/opencv.git && cd opencv/ && git checkout tags/3.0.0-beta && mkdir release && cd release/ && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON  -D BUILD_EXAMPLES=ON -D WITH_FFMPEG=OFF .. && make -j8 && make install
COPY . /app
CMD ["bash", "/app/start.sh"]