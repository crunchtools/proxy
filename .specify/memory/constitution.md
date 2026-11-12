# proxy Constitution

> **Version:** 2.1.1
> **Ratified:** 2026-03-10
> **Amended:** 2026-11-11
> **Status:** Active
> **Inherits:** [crunchtools/constitution](https://github.com/crunchtools/constitution) v1.40.0
> **Profile:** Container Image

This file holds what is specific to proxy. The fleet rules and the Container
Image profile (license, versioning, LABELs, the RHSM secret-mount pattern,
systemd conventions, registry, testing and quality gates) apply at the
inherited version and are checked against this repo's files by
`constitution.yml`. They are not restated here.

## Purpose

Lean reverse proxy image: mod_ssl on ubi10-httpd. It runs as the single
entry point for all containerized services. No database, no PHP, no
application runtime. Published as `quay.io/crunchtools/proxy`.

## Parent Image

`quay.io/crunchtools/ubi10-httpd:latest`. It inherits httpd (enabled) and
everything ubi10-core provides. mod_ssl is in the UBI repos; no RHSM
registration.

## Packages and Services

- **Packages:** mod_ssl, installed with `--nodocs`.
- **Services:** none added; httpd comes enabled from the parent.
- **Ports:** 80 and 443.
- The stock `ssl.conf` is removed; the image ships no vhost config.

## Runtime

- `--network=host`, binding host ports 80 and 443 directly.
- Vhost config and TLS certificates are bind-mounted from
  `/srv/proxy.crunchtools.com/config/`, which is tracked outside this repo.
- Backends are reached with `ProxyPass` to `127.0.0.1:<port>`.

## Test Coverage

CI builds the image; the repo has no smoke test yet. Vulnerability scanning is
not a build step: published images are scanned on a schedule by the fleet CVE check (grype + Nagios), which pages on a new fixable Critical (constitution 1.40.0, RT #1551).

## History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-03-04 | Initial proxy image: httpd + mod_ssl on UBI 10 |
| 2.0.0 | 2026-03-10 | Rebased onto ubi10-httpd; RHSM removed |
| 2.0.1 | 2026-09-25 | Gatehouse review, triage and pre-commit gates |
| 2.1.0 | 2026-10-02 | Manifest under constitution v1.18.0: profile restatement removed, image specifics kept |
| 2.1.1 | 2026-11-11 | Test coverage no longer claims a Trivy scan: the per-build scan is retired (constitution 1.40.0) and published images are scanned by the fleet CVE check (RT #1551) |
