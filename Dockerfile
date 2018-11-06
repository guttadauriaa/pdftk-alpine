FROM alpine:latest

MAINTAINER adriano.guttadauria@umons.ac.be

# INSTALL pdftk
RUN apk update && apk upgrade \
	&& apk --no-cache add pdftk

# Create /files directory and add entrypoint script.
RUN mkdir /files
WORKDIR /files
ADD ./files/entrypoint.sh /
VOLUME ["./files"]

# Create a user to disallow root permissions
RUN adduser -Ds /bin/sh newuser
USER newuser

ENTRYPOINT ["/entrypoint.sh"]

