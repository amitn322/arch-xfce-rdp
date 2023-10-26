FROM ghcr.io/linuxserver/baseimage-rdesktop:arch-dbus

# set version label
ARG BUILD_DATE
ARG VERSION
ARG XFCE_VERSION
LABEL build_version="ArchXFCE:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="uidz3ro"

RUN \
  echo "**** install packages ****" && \
  pacman -Syu --noconfirm --needed \
    chromium \
    mousepad \
    exo \
    xfce4 \
    xfce4-settings \
    xfce4-pulseaudio-plugin && \
  echo "**** application tweaks ****" && \
  sed -i \
    's#^Exec=.*#Exec=/usr/local/bin/wrapped-chromium#g' \
    /usr/share/applications/chromium.desktop && \
  mv /usr/bin/exo-open /usr/bin/exo-open-real && \
  echo "**** xfce tweaks ****" && \
  rm -f \
    /etc/xdg/autostart/xfce4-power-manager.desktop \
    /etc/xdg/autostart/xfce-polkit.desktop \
    /etc/xdg/autostart/xscreensaver.desktop \
    /usr/share/xfce4/panel/plugins/power-manager-plugin.desktop && \
  echo "**** cleanup ****" && \
  rm -rf \
    /config/.cache \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /buildfiles /
RUN useradd xrdp
#nt customization
RUN ln -s /sbin/exo-open-real /sbin/exo-open
RUN echo "***** NT CUSTOMIZATIONS ***** " 
RUN pacman -Sy go git base-devel   --noconfirm
RUN mkdir /tmp/abc
WORKDIR /tmp/abc
RUN git clone https://aur.archlinux.org/yay.git
RUN chown -R abc:abc /tmp/abc
ENV GOCACHE="/tmp/abc"
USER abc:abc
RUN ls -l /tmp
WORKDIR /tmp/abc
RUN pwd
WORKDIR /tmp/abc/yay
RUN yes | makepkg -si 
RUN /install-packages.sh
#RUN yes | yay -Sy viber --answerclean All --answerdiff All
#RUN yes | yay -Sy obsidian --answerclean All --answerdiff All

USER root
RUN echo "***** NT CUSTOMIZATION END ********"

#nt customization end

# ports and volumes
EXPOSE 3389
VOLUME /config
