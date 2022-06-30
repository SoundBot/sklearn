FROM python:3.11.0b3-alpine3.15

RUN apk add --no-cache --virtual=.build-dependencies g++ gfortrant file binutils musl-dev openblas-dev
RUN apk add libstdc++ openblas git
RUN ln -s locale.h /usr/include/xlocale.h

RIN pip3 install cython

ADD numpy-1.22.3-cp311-cp311-linux_x86_64.whl numpy-1.22.3-cp311-cp311-linux_x86_64.whl
ADD scipy 

RUN git clone https://github.com/scikit-learn/scikit-learn.git && cd /scikit-learn && git checkout tags/0.21.3

RUN cd /scikit-learn && python3 setup.py bdist_wheel

CMD ["/bin/sh", "-c", "cp -r /scikit-learn/dist /data/sklearn && cp /usr/lib/libopenblas.so /data/sklearn/libopenblas.so"]
