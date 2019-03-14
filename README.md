# Flame web service (UPF prototype)

In this repository you will find:

+ A Dockerfile to build a Flame (modeling framework) container image
+ `docker-compose.yml` with the configuration to build and serve a web service with two containers: Flame and Padel (Molecular descriptors software).

The images are pulled from the eTransafe docker registry hosted at DTU.

Note that flame is cloned from github, from the branch padel_request, that contains some extra functionalities to work with padel descriptors.