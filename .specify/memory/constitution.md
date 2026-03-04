# proxy Constitution

> **Version:** 1.0.0
> **Ratified:** 2026-03-04
> **Status:** Active
> **Inherits:** [crunchtools/constitution](https://github.com/crunchtools/constitution) v1.0.0
> **Profile:** Container Image

Lean reverse proxy image — Apache httpd + mod_ssl on UBI 10. Runs with `--network=host` on Lotor as the single entry point for all containerized services. No database, no PHP, no application runtime.

---

## License

AGPL-3.0-or-later

## Versioning

Follow Semantic Versioning 2.0.0. MAJOR/MINOR/PATCH.

## Base Image

`registry.access.redhat.com/ubi10/ubi-init:latest` — systemd-based for httpd service management.

## Registry

Published to `quay.io/crunchtools/proxy`.

## RHSM Registration

Uses build-arg based subscription-manager registration to access RHEL repos for mod_ssl.

## Containerfile Conventions

- Uses `Containerfile` (not Dockerfile)
- Required LABELs: `maintainer`, `description`
- `dnf install -y --nodocs` followed by `dnf clean all`
- `subscription-manager unregister` after package installation
- systemd service enabled: httpd
- systemd services masked: systemd-remount-fs, systemd-update-done, systemd-udev-trigger
- Default `ssl.conf` removed — vhost config bind-mounted at runtime
- `STOPSIGNAL SIGRTMIN+3` for proper systemd shutdown
- `ENTRYPOINT ["/sbin/init"]`

## Packages Installed

httpd, mod_ssl

## Runtime

- `--network=host` — binds directly to host ports 80/443
- Vhost config bind-mounted from `/srv/proxy.crunchtools.com/config/`
- SSL certs bind-mounted from the same config directory
- All backend services proxied via `ProxyPass` to `127.0.0.1:<port>`

## Testing

- **Build test**: CI builds the Containerfile successfully
- **Security scan**: Recommended (not yet implemented)

## Quality Gates

1. Build — CI builds the Containerfile successfully
2. Weekly rebuild — cron job picks up base image updates every Monday 6 AM UTC
