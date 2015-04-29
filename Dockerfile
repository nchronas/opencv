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
RUN mkdir build && cd build && git clone https://github.com/Itseez/opencv.git && cd opencv/ && git checkout tags/3.0.0-beta && mkdir release && cd release/ && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON  -D BUILD_EXAMPLES=ON -D WITH_FFMPEG=OFF .. && make -j8 && make install && ldconfig
COPY . /app
CMD ["bash", "/app/start.sh"]