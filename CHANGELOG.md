# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/) and this project adheres to
[Semantic Versioning](https://semver.org/).

## [Unreleased]

### Changed
- Promote signs the image with the fleet cosign key (`sign: true`), because
  bootc hosts are moving to trust only signed `quay.io/crunchtools` images
  (crunchtools/rhel10-bootc-server#47). Needs the repo's `cosign-signing`
  environment to hold `COSIGN_PRIVATE_KEY` and `COSIGN_PASSWORD`.
- The container release runs constitution v1.51.0's `container-release.yml`
  (was v1.46.0) and grants it `issues: write`, so a failed scheduled rebuild
  opens an issue instead of only warning. A `v*` promote now also refuses an image whose `version` label names a
  different release of this repo; this Containerfile sets no `version` label of
  its own, so nothing changes here.

## [1.1.2] - 2026-11-13

### Security
- Rebuilt on ubi10-httpd with mod_http2 2.0.29-5.el10_3.1 (CVE-2026-119618).

## [1.1.1] - 2026-11-11

### Changed
- No functional change. First release on the build-once container pipeline (RT#1550): `:latest` now names a digest that passed the release gates.

## [1.1.0] - 2026-11-08

### Changed
- Constitution is now a v1.18.0 manifest: fleet and profile rules apply by
  reference, and only this repo's specifics are kept.
- Constitution validation is pinned via `constitution.yml`.
- Dependabot auto-merges GitHub Actions minor and patch updates.

### Removed
- `proxy.crunchtools.com.conf` — a duplicate of the live vhost config. The image
  never used it: the Containerfile removes the stock `ssl.conf` and the running
  container bind-mounts the real config from
  `/srv/proxy.crunchtools.com/config/`, tracked in the `lotor-srv` repo. Keeping
  a second copy here let the two diverge silently — this repo's copy was four
  vhosts behind production and overwriting the host file from it caused a
  gateway outage on 2026-09-20. One deployed config file, one git home. See
  RT #1498 (drift check) for the detection follow-up.

### Note
- The `mcp.crunchtools.com` vhost (Trentina gateway, scoped to the `gemini-app`
  profile path for the Gemini Apps custom connector) is deployed via the
  bind-mounted `/srv` config, not this repo.

## [1.0.0] - 2026-09-20

First tagged release. This image has been running in production since before
it had version control; this release marks the current state as the baseline
going forward.
