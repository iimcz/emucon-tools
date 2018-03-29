FROM phusion/baseimage:0.9.22

COPY scripts /emucon-scripts/

# Set up custom repo
COPY data/bwfla.list /etc/apt/sources.list.d/bwfla.list
COPY data/pin-bwfla.pref /etc/apt/preferences.d/pin-bwfla.pref

RUN /emucon-scripts/install.sh

