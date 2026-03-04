FROM registry.access.redhat.com/ubi10/ubi-init:latest

LABEL maintainer="fatherlinux <scott.mccarty@crunchtools.com>"
LABEL description="Lean reverse proxy — Apache httpd + mod_ssl on UBI 10"

# Register with RHSM using build-time secrets (never stored in image layers)
RUN --mount=type=secret,id=activation_key \
    --mount=type=secret,id=org_id \
    if [ -s /run/secrets/activation_key ] && [ -s /run/secrets/org_id ]; then \
        subscription-manager register \
            --activationkey="$(cat /run/secrets/activation_key)" \
            --org="$(cat /run/secrets/org_id)"; \
    fi

# Install only what a reverse proxy needs
RUN dnf install -y --nodocs \
    httpd \
    mod_ssl \
    && dnf clean all

# Unregister to avoid leaking entitlements in the image
RUN subscription-manager unregister 2>/dev/null || true

# Remove default ssl.conf — vhost config is bind-mounted at runtime
RUN rm -f /etc/httpd/conf.d/ssl.conf

# Enable httpd
RUN systemctl enable httpd

# Disable unnecessary systemd services for container
RUN systemctl mask systemd-remount-fs.service \
    systemd-update-done.service \
    systemd-udev-trigger.service

EXPOSE 80 443

STOPSIGNAL SIGRTMIN+3
ENTRYPOINT ["/sbin/init"]
CMD ["/sbin/init"]
