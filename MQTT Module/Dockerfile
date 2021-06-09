ARG hbmBaseImage=agorasdk.azurecr.io/x86_64/hbm-base:1.0.0
FROM $hbmBaseImage

ARG hbmBaseImage
RUN echo Building from Base image : $hbmBaseImage

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-pip python3-setuptools

RUN pip3 install --upgrade "pip < 21"
RUN pip3 install numpy paho-mqtt

ENV PYTHONPATH "${PYTHONPATH}:/usr/lib"
ENV PYTHONOPTIMIZE "1"

COPY lib/* /usr/lib/

COPY module.json /

CMD ["/usr/bin/hbm"]

