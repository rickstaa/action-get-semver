#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

input_bump_level="$(echo ${INPUT_BUMP_LEVEL} | tr '[:upper:]' '[:lower:]')" # Make lowercase
case $input_bump_level in
  "major"|"minor"|"patch")
    ;;
  *)
    printf '%s\n' "Please specify a valid bump level \`${input_bump_level}\` is not valid [major, minor, patch]."
    exit 1
    ;;
esac

git fetch --tags # Fetch existing tags before bump.
# Fetch history as well because bump uses git history (git tag --merged).
git fetch --prune --unshallow
CURRENT_VERSION="$(bump current)" || true
NEXT_VERSION="$(bump ${input_bump_level})" || true

echo "::set-output name=current_version::${CURRENT_VERSION}"
echo "::set-output name=next_version::${NEXT_VERSION}"
