# action-get-semver

A simple action that returns the current/next major, minor, and patch version based on the given semver
version.

[![Action test](https://github.com/rickstaa/action-get-semver/workflows/Action%20test/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3A%22Action+test%22)
[![Depup](https://github.com/rickstaa/action-get-semver/workflows/Depup/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3ADepup)
[![Release](https://github.com/rickstaa/action-get-semver/workflows/Release/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3ARelease)
[![Docker Image CI](https://github.com/rickstaa/action-get-semver/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/rickstaa/action-get-semver/actions?query=workflow%3A%22Docker+Image+CI%22)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/rickstaa/action-get-semver?logo=github&sort=semver)](https://github.com/rickstaa/action-get-semver/releases)

## Inputs

```yaml
inputs:
  bump_level:
    description: "Version bump level [major, minor, patch]."
    required: False
    default: "patch"
  verbose:
    description: "Print current and next version."
    required: False
    default: "false"
  frail:
    description: "Return exit code of 1 when no version tag is found."
    required: False
    default: "false"
```

## Outputs

```yaml
outputs:
  current_version:
    description: "The current version."
  next_version:
    description: "The next major version."
  error:
    descriptor: "Whether an error was encountered when retrieving the current semver."
```

## Usage

```yaml
name: release
on:
  push:
    branches:
      - main
jobs:
  check-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - uses: rickstaa/action-get-semver@v1
        id: get_semver
        with:
          bump_level: "minor"
      - name: Print current and next version
        run: |
          echo "Current version: ${{ steps.get_semver.outputs.current_version  }}"
          echo "Next version: ${{ steps.get_semver.outputs.next_version }}"
```

❗ **NOTE:** This action requires the `fetch-depth: 0` argument to be set in the [actions/checkout@v3](https://github.com/actions/checkout) step (see [actions/checkout#fetch-all-history-for-all-tags-and-branches
](https://github.com/actions/checkout#fetch-all-history-for-all-tags-and-branches)).

## Contributing

Feel free to open an issue if you have ideas on how to make this GitHub action better or if you want to report a bug! All contributions are welcome. :rocket: Please consult the [contribution guidelines](CONTRIBUTING.md) for more information.

### Acknowledgement

This action serves as a wrapper around the [bump](https://github.com/haya14busa/bump) package of [@haya14busa](https://github.com/haya14busa/bump/commits?author=haya14busa).
