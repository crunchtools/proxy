# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/) and this project adheres to
[Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- `mcp.crunchtools.com` vhost proxying the Trentina MCP gateway
  (`127.0.0.1:8019`), scoped to the single `gemini-app` profile path for the
  Gemini Apps custom connector. All other gateway profiles remain
  localhost-only.

## [1.0.0] - 2026-09-20

First tagged release. This image has been running in production since before
it had version control; this release marks the current state as the baseline
going forward.
