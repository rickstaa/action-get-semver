# action-get-semver

A simple action that returns the current/next major, minor, and patch version based on the given semver
version.

[![Action test](https://github.com/rickstaa/action-get-semver/workflows/Action%20test/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3A%22Action+test%22)
[![Depup bump](https://github.com/rickstaa/action-get-semver/workflows/Depup%20bump/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3A%22Depup%22)
[![release](https://github.com/rickstaa/action-get-semver/workflows/release/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/rickstaa/action-bumpr?logo=github&sort=semver)](https://github.com/rickstaa/action-get-semver/releases)
[![Docker Image CI](https://github.com/rickstaa/action-get-semver/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3A%22Docker+Image+CI%22)

## Input

```yaml
inputs:
  bump_level:
    description: "Version bump level [major,minor,patch]."
    required: False
    default: "patch"
outputs:
  current_version:
    description: "The current version."
  next_version:
    description: "The next major version."
```

## Usage

```yaml
name: release
on:
  push:
    branches:
      - master
jobs:
  check-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: rickstaa/action-get-semver@v1
        with:

      - name: Print semver
        id: get_semver
        with:
          bump_level: "minor"
        run: |
          echo "Current version: ${{ steps.get_semver.outputs.current_version  }}"
          echo "Next version: ${{ steps.get_semver.outputs.next_version }}"
```

### Acknowledgement

This action serves as a wrapper around the [bump](https://github.com/haya14busa/bump) package of [@haya14busa](https://github.com/haya14busa/bump/commits?author=haya14busa).