# proxy Constitution

> **Version:** 2.0.0
> **Ratified:** 2026-03-10
> **Status:** Active
> **Inherits:** [crunchtools/constitution](https://github.com/crunchtools/constitution) v1.0.0
> **Profile:** Container Image

Lean reverse proxy image — mod_ssl on ubi10-httpd. Inherits Apache httpd from ubi10-httpd and troubleshooting tools from ubi10-core. Runs with `--network=host` on Lotor as the single entry point for all containerized services. No database, no PHP, no application runtime.

---

## License

AGPL-3.0-or-later

## Versioning

Follow Semantic Versioning 2.0.0. MAJOR/MINOR/PATCH.

## Base Image

`quay.io/crunchtools/ubi10-httpd:latest` — inherits httpd (enabled), troubleshooting tools, and systemd hardening.

## Registry

Published to `quay.io/crunchtools/proxy`.

## RHSM Registration

Not required. mod_ssl is available in UBI repos.

## Containerfile Conventions

- Uses `Containerfile` (not Dockerfile)
- Required LABELs: `maintainer`, `description`
- `dnf install -y --nodocs` followed by `dnf clean all`
- No RHSM registration needed
- Default `ssl.conf` removed — vhost config bind-mounted at runtime
- Inherits from parent chain: httpd (enabled), systemd-remount-fs/systemd-update-done/systemd-udev-trigger (masked)
- Inherits `STOPSIGNAL SIGRTMIN+3` and `ENTRYPOINT ["/sbin/init"]` from ubi10-core

## Packages Installed

mod_ssl

Inherited from ubi10-httpd: httpd
Inherited from ubi10-core: iputils, bind-utils, net-tools, less, cronie, procps-ng, diffutils

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
2. Push — image published after successful build
3. Weekly rebuild — cron job picks up base image updates every Monday 4:30 AM UTC
