#!/bin/bash

if [ -z "${1}" ]; then
  echo "Usage: ${0} VERSION" 1>&2
  exit 1
fi

VERSION="${1}"

cat <<END
/* Auto-generated.  Do not edit! */
#ifndef _YASM_LIBYASM_STDINT_H
#define _YASM_LIBYASM_STDINT_H 1
#ifndef _GENERATED_STDINT_H
#define _GENERATED_STDINT_H "yasm ${VERSION}"
#define _STDINT_HAVE_STDINT_H 1
#include <stdint.h>
#endif
#endif
END
