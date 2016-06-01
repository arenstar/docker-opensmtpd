FROM debian:jessie-backports
RUN apt-get update && apt-get -y install opensmtpd opensmtpd-extras && rm -rf /var/lib/apt/lists/*

WORKDIR /

EXPOSE 25

CMD ["smtpd","-d","-f","/etc/smtpd.conf"]
