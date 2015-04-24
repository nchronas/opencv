FROM resin/rpi-raspbian:latest
RUN apt-get update -y && apt-get install -y \
python python-pip python-dev python-dbus python-flask \
dropbear \
nano \
build-essential cmake pkg-config \
libjpeg8-dev libjasper-dev libpng12-dev \
libgtk2.0-dev \
libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
libatlas-base-dev gfortran \
&& apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install virtualenv virtualenvwrapper
COPY . /app
CMD ["bash", "/app/start.sh"]
