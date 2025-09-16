FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
        cowsay \
        fortune-mod \
        fortunes \
        netcat

ENV PATH="/usr/games:${PATH}"

WORKDIR /app

COPY wisecow.sh .

RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["./wisecow.sh"]