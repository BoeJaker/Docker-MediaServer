FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    tigervnc-standalone-server \
    fluxbox

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]