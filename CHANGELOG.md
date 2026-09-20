# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/) and this project adheres to
[Semantic Versioning](https://semver.org/).

## [Unreleased]

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
