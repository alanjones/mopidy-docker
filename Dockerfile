FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    gnupg && \
    rm -rf /var/lib/apt/lists/*

RUN ls /etc/ssl/certs
RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
    wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list

RUN apt-get update && \
    apt-get install -y \
    tzdata \
    build-essential \
    python3-dev \
    python3-pip \
    python3-gst-1.0 \
    gir1.2-gstreamer-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-libav \
    gstreamer1.0-tools \
    libspotify12 \
    libspotify-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-spotify && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libffi-dev \
    libz-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
    mopidy \
    mopidy-dleyna \
    mopidy-podcast \
    mopidy-podcast-itunes \
    mopidy-tunein \ 
    mopidy-youtube && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install \
    Mopidy-MPD \
    Mopidy-Local \
    Mopidy-Spotify \
    Mopidy-Party \
    Mopidy-Iris

RUN mkdir -p /share/mopidy/data
COPY mopidy.conf /root/.config/mopidy_default.conf
COPY mopidy.sh /usr/local/bin/mopidy.sh
RUN chmod a+x /usr/local/bin/mopidy.sh

EXPOSE 6600 6680
ENTRYPOINT ["/usr/local/bin/mopidy.sh"]
