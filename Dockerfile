FROM continuumio/miniconda3

WORKDIR /opt

RUN git clone https://github.com/phi-grib/flame.git &&\
    cd flame && \
    conda env create -f environment.yml

ENV PATH /opt/conda/envs/flame/bin:$PATH
WORKDIR /opt/flame/flame

RUN apt-get update &&\
    apt-get install -y libxrender-dev libgl1-mesa-dev &&\
    apt-get clean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    mv models/CACO2/dev/minicaco.sdf _minicaco.sdf &&\
    python flame.py -c build -e CACO2 -f _minicaco.sdf &&\
    rm _minicaco.sdf 

EXPOSE 8080

ENTRYPOINT [ "python", "predict-ws.py" ]
#ENTRYPOINT [ "/bin/bash" ]