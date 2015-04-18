FROM masm/archlinux
MAINTAINER Marco Monteiro <marco@neniu.org>

ENTRYPOINT ["/bin/bash", "/script.sh"]

RUN pacman -S inotify-tools nmap --needed --noconfirm --noprogressbar && \
    yes | pacman -Sqcc && \
    rm -rf /usr/share/man/*

COPY script.sh /script.sh
