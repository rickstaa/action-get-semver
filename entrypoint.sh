#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

input_bump_level="$(echo ${INPUT_BUMP_LEVEL:-patch} | tr '[:upper:]' '[:lower:]')" # Make lowercase
case $input_bump_level in
  "major"|"minor"|"patch")
    ;;
  *)
    printf '%s\n' "Please specify a valid bump level \`${input_bump_level}\` is not valid [major, minor, patch]."
    exit 1
    ;;
esac

CURRENT_VERSION="$(bump current)" || true
NEXT_VERSION="$(bump ${input_bump_level})" || true

# Set next version tag in case existing tags not found.
if [ -z "${NEXT_VERSION}" ] && [ -z "$(git tag)" ]; then
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
fi

if [ -z "${NEXT_VERSION}" ]; then
  echo "Cannot find next version."
  exit 1
fi

echo "::set-output name=current_version::${CURRENT_VERSION}"
echo "::set-output name=next_version::${NEXT_VERSION}"
