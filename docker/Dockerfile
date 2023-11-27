FROM ubuntu:jammy-20231004
LABEL authors="jasonmarks"

ARG wgrib2_file_name=wgrib2.tgz
ARG pywgrib2_file_name=pywgrib2_s.tgz

COPY $wgrib2_file_name /tmp/
COPY $pywgrib2_file_name /tmp/

RUN tar -xzf /tmp/$wgrib2_file_name --directory /opt/ && \
    tar -xzf /tmp/$pywgrib2_file_name --directory /opt/grib2 && \
    rm /tmp/$wgrib2_file_name && \
    rm /tmp/$pywgrib2_file_name

# relevant dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    wget \
    python3 \
    libnetcdf-dev \
    libhdf5-dev \
    libmysqlclient-dev \
    pip

# required for pywgrib2_s
RUN pip install numpy

# this makefile is preconfigured to work with ubuntu:jammy-20231004
COPY makefile_jammy20231004_sharedlib /opt/grib2/makefile

# compile wgrib2 with the preconfigured makefile and install the python library
RUN cd /opt/grib2 && \
    make && \
    make lib && \
    mkdir PYTHON_DIR && \
    cp lib/libwgrib2.so PYTHON_DIR/ && \
    cp pywgrib2_s/pywgrib2_s.py PYTHON_DIR/ && \
    cd PYTHON_DIR && \
    python3 pywgrib2_s.py
