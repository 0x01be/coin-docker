FROM 0x01be/swig:3.0 as swig

FROM alpine as builder

WORKDIR /coinbrew
ENV REVISION=master \
    SWIG_EXECUTABLE=/opt/swig/bin/swig \
    PATH=${PATH}:/opt/swig/bin/
RUN apk add git && git clone --depth 1 --branch ${REVISION} https://www.github.com/coin-or/coinbrew /coinbrew

RUN apk add --no-cache --virtual coin-build-dependencies \
    git \
    build-base \
    pkgconfig \
    bash \
    cmake \
    automake \
    autoconf \
    bison \
    flex \
    gfortran

COPY --from=swig /opt/swig/ /opt/swig/

RUN chmod +x coinbrew &&\
    ln -s /usr/include/fenv.h /usr/include/fpu_control.h
RUN ./coinbrew  fetch  COIN-OR-OptimizationSuite -n --latest-release   || echo "OK"
RUN ./coinbrew  build  COIN-OR-OptimizationSuite -n --prefix=/opt/coin || echo "OK"
RUN ./coinbrew install COIN-OR-OptimizationSuite -n --prefix=/opt/coin || echo "OK"

