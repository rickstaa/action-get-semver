#!/bin/sh
set -e

# Apply hotfix for 'fatal: unsafe repository' error (see #14)
git config --global --add safe.directory "${GITHUB_WORKSPACE}"

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

input_bump_level="$(echo ${INPUT_BUMP_LEVEL:-patch} | tr '[:upper:]' '[:lower:]')" # Make lowercase
case $input_bump_level in
  "major" | "minor" | "patch") ;;

  *)
    printf '%s\n' "[action-get-semver] Please specify a valid bump level \`${input_bump_level}\` is not valid [major, minor, patch]."
    exit 1
  ;;
esac

CURRENT_VERSION="$(bump current)" || true
NEXT_VERSION="$(bump ${input_bump_level})" || true

if [[ -z "${CURRENT_VERSION}" ]]; then
  echo "[action-get-semver] Current version tag not found."
  echo "error=true" >> "${GITHUB_OUTPUT}"
  if [[ "${INPUT_FRAIL}" = 'true' ]]; then
    exit 1
  fi

  # Create current and next tag
  CURRENT_VERSION="v0.0.0"
  case "${input_bump_level}" in
    major)
      NEXT_VERSION="v1.0.0"
    ;;
    minor)
      NEXT_VERSION="v0.1.0"
    ;;
    patch)
      NEXT_VERSION="v0.0.1"
    ;;
  esac
else
  echo "error=false" >> "${GITHUB_OUTPUT}"
fi

if [ -z "${NEXT_VERSION}" ]; then
  echo "Cannot find next version."
  exit 1
fi

if [ "${INPUT_VERBOSE}" == "true" ]; then
  echo "[action-get-semver] Current_version: ${CURRENT_VERSION}"
  echo "[action-get-semver] Next_version: ${NEXT_VERSION}"
fi
echo "current_version=${CURRENT_VERSION}" >> "${GITHUB_OUTPUT}"
echo "next_version=${NEXT_VERSION}" >> "${GITHUB_OUTPUT}"
