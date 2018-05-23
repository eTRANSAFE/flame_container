FROM continuumio/miniconda3

LABEL base.image="continuumio/miniconda3"
LABEL software="flame"
LABEL software.version=" v0.0.1-dev"
LABEL description="Python scripts to build and manage QSAR models. Predictive modeling within the eTRANSAFE (http://etransafe.eu) project."
LABEL website="https://github.com/phi-grib/flame"

MAINTAINER Biel Stela <biel.stela@upf.edu>

WORKDIR /opt

RUN git clone -b padel_request --single-branch https://github.com/phi-grib/flame &&\
    cd flame && \
    conda env create -f environment.yml
ENV PATH /opt/conda/envs/flame/bin:$PATH

WORKDIR /opt/flame/flame

RUN apt-get update &&\
    apt-get install -y libxrender-dev libgl1-mesa-dev &&\
    apt-get clean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    mv ../mols/minicaco.sdf _minicaco.sdf &&\
    python flame.py -c build -e CACO2 -f _minicaco.sdf &&\
    rm _minicaco.sdf 

EXPOSE 8080

ENTRYPOINT [ "python", "predict-ws.py" ]