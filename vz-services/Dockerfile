# Dockerized UI server

FROM vaultize/sandbox:15.x
MAINTAINER  Akash Shende <akash@anoosmar.com>

RUN mkdir -p /home/web &&\
    chown web:web /home/web &&\
    mkdir /var/run/uwsgi &&\
    chown web:web /var/run/uwsgi &&\
    mkdir /var/log/uwsgi &&\
    chown -R root:root /var/log/uwsgi

VOLUME ["/home/web", "/opt/config", "/var/log/uwsgi"]

USER web

ENTRYPOINT ["/usr/bin/uwsgi"]
CMD ["--ini",  "/opt/config/services.ini:ui"]
