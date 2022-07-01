FROM debian:stretch-slim

ENV Autoupdate=false
ENV TMOD_VERSION=v2022.05.103.34

EXPOSE 7777

RUN apt update

WORKDIR /root

#Copy script
COPY tModLoaderServerStart.sh .
COPY serverconfig.txt .

#Allow execution
RUN chmod +x /root/tModLoaderServerStart.sh

ENTRYPOINT ["/root/tModLoaderServerStart.sh"]