FROM ubuntu
RUN apt-get -y update
RUN apt-get update && apt-get install -y gnupg
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:timescale/timescaledb-ppa
RUN apt-get -y update
RUN apt-get install -y timescaledb-postgresql-10
RUN apt-get install -y nano

