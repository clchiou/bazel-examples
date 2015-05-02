#!/bin/bash

set -o errexit -o nounset -o pipefail

LAME_URL="http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz"

OPUS_URL="http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz"

X264_TARBALL="last_x264.tar.bz2"
X264_URL="http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2"

YASM_URL="http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz"

main() {
  if [ ! -d ".git" ]; then
    echo "$0 has to be ran under the root directory"
    exit 1
  fi

  local ROOT="$(pwd)"

  echo "### bazel"
  checkout_git https://github.com/google/bazel.git tools
  cd "${ROOT}/tools"
  for dir in cpp defaults genrule; do
    [ -d "${dir}" ] || ln -s "bazel/tools/${dir}"
  done

  echo "### fdk-aac"
  cd "${ROOT}/fdk-aac"
  [ -d fdk-aac ] || git clone git://github.com/mstorsjo/fdk-aac

  echo "### lame"
  cd "${ROOT}/lame"
  download_tgz lame "${LAME_URL}"

  echo "### opus"
  cd "${ROOT}/opus"
  download_tgz opus "${OPUS_URL}"

  echo "### x264"
  cd "${ROOT}/x264"
  [ -f "${X264_TARBALL}" ] || wget "${X264_URL}"
  [ -d x264-snapshot* ] || tar xjvf "${X264_TARBALL}"
  [ -e x264 ] || ln -s x264-snapshot* x264

  echo "### x265"
  cd "${ROOT}/x265"
  [ -d x265 ] || hg clone https://bitbucket.org/multicoreware/x265

  echo "### yasm"
  cd "${ROOT}/yasm"
  download_tgz yasm "${YASM_URL}"
}

checkout_git() {
  local repo="${1}"
  local path="${2}/$(basename "${repo}")"
  path="${path%.git}"
  [ -d "${path}" ] || git clone "${repo}" "${path}"
}

download_tgz() {
  local package="${1}"
  local url="${2}"
  local tarball="$(basename "${url}")"
  local output_dir="${tarball%.tar.gz}"
  [ -f "${tarball}" ] || wget "${url}"
  [ -d "${output_dir}" ] || tar xzvf "${tarball}"
  [ -e "${package}" ] || ln -s "${output_dir}" "${package}"
}

main
