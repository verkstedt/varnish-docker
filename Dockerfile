FROM        ubuntu:14.04.2
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
ENV REFRESHED_AT 2014-10-18

# Update the package repository and install applications
RUN apt-get update -qq && \
  apt-get upgrade -yqq && \
  apt-get -yqq install varnish && \
  apt-get -yqq clean

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

ARG VARNISH_BACKEND_PORT
ENV VARNISH_BACKEND_PORT $VARNISH_BACKEND_PORT

ARG VARNISH_BACKEND_IP
ENV VARNISH_BACKEND_IP $VARNISH_BACKEND_IP

ARG VARNISH_PORT
ENV VARNISH_PORT $VARNISH_PORT

# Expose port 80
EXPOSE 8080

# Expose volumes to be able to use data containers
VOLUME ["/var/lib/varnish", "/etc/varnish"]

ADD start.sh /start.sh
CMD ["/start.sh"]
