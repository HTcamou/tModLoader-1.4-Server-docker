FROM debian:stretch-slim

#Install dependencies
RUN apt update

WORKDIR /home

#Copy script
COPY tModLoaderServerStart.sh .

#Allow execution
RUN chmod +x /home/tModLoaderServerStart.sh

ENTRYPOINT ["/home/tModLoaderServerStart.sh"]
