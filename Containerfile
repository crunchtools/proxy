FROM quay.io/crunchtools/ubi10-httpd:latest

LABEL maintainer="fatherlinux <scott.mccarty@crunchtools.com>"
LABEL description="Lean reverse proxy — mod_ssl on ubi10-httpd"

# mod_ssl available in UBI repos — no RHSM needed
RUN dnf install -y --nodocs \
      mod_ssl \
    && dnf clean all

# Remove default ssl.conf — vhost config is bind-mounted at runtime
RUN rm -f /etc/httpd/conf.d/ssl.conf

EXPOSE 80 443
