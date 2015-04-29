#!/bin/bash

set -o errexit -o nounset -o pipefail

YASM="yasm-1.3.0"
YASM_TARBALL="yasm-1.3.0.tar.gz"
YASM_URL="http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz"

X264_TARBALL="last_x264.tar.bz2"
X264_URL="http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2"

main() {
  if [ ! -d ".git" ]; then
    echo "$0 has to be ran under the root directory"
    exit 1
  fi

  local ROOT="$(pwd)"

  mkdir -p "${ROOT}/tools"
  mkdir -p "${ROOT}/x264"
  mkdir -p "${ROOT}/yasm"

  echo "### bazel"
  checkout_git https://github.com/google/bazel.git tools
  cd "${ROOT}/tools"
  for dir in cpp defaults genrule; do
    [ -d "${dir}" ] || ln -s "bazel/tools/${dir}"
  done

  echo "### x264"
  cd "${ROOT}/x264"
  [ -f "${X264_TARBALL}" ] || wget "${X264_URL}"
  [ -d x264-snapshot* ] || tar xjvf "${X264_TARBALL}"
  [ -e x264 ] || ln -s x264-snapshot* x264

  echo "### yasm"
  cd "${ROOT}/yasm"
  [ -f "${YASM_TARBALL}" ] || wget "${YASM_URL}"
  [ -d "${YASM}" ] || tar xzvf "${YASM_TARBALL}"
  [ -e yasm ] || ln -s "${YASM}" yasm
}

checkout_git() {
  local repo="${1}"
  local path="${2}/$(basename "${repo}")"
  path="${path%.git}"
  [ -d "${path}" ] || git clone "${repo}" "${path}"
}

main
