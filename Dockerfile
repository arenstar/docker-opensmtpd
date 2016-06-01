FROM debian:jessie-backports
RUN apt-get update && apt-get -y install opensmtpd opensmtpd-extras ca-certificates && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
  wget \
  file \
  g++ \
  make \
  libevent-dev \
  libssl-dev

RUN wget http://www.opensmtpd.org/archives/opensmtpd-extras-latest.tar.gz
RUN tar xzvf opensmtpd-extras-latest.tar.gz
RUN  cd opensmtpd-extras* && \
    ./configure --with-filter-dkim-signer && \
    make && \
    make install

RUN mv /usr/local/libexec/opensmtpd/filter-dkim-signer /usr/lib/x86_64-linux-gnu/opensmtpd/filter-dkim-signer
RUN mv /usr/local/share/man/man8/filter-dkim-signer.8 /usr/share/man/man8/filter-dkim-signer.8
RUN mv /usr/local/share/man/man3/filter_api.3 /usr/share/man/man3/filter_api.3


WORKDIR /

EXPOSE 25

CMD ["smtpd","-d","-f","/etc/smtpd.conf"]
