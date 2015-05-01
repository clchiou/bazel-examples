package(default_visibility = ['//visibility:public'])

COPTS = [
    '-DPACKAGE_NAME="fdk-aac"',
    '-DPACKAGE_TARNAME="fdk-aac"',
    '-DPACKAGE_VERSION="0.1.4"',
    '-DPACKAGE_STRING="fdk-aac 0.1.4"',
    '-DPACKAGE_BUGREPORT="http://sourceforge.net/projects/opencore-amr/"',
    '-DPACKAGE_URL=""',
    '-DPACKAGE="fdk-aac"',
    '-DVERSION="0.1.4"',  # XXX You should grep this from configure.ac.
    '-DSTDC_HEADERS=1',
    '-DHAVE_SYS_TYPES_H=1',
    '-DHAVE_SYS_STAT_H=1',
    '-DHAVE_STDLIB_H=1',
    '-DHAVE_STRING_H=1',
    '-DHAVE_MEMORY_H=1',
    '-DHAVE_STRINGS_H=1',
    '-DHAVE_INTTYPES_H=1',
    '-DHAVE_STDINT_H=1',
    '-DHAVE_UNISTD_H=1',
    '-DHAVE_DLFCN_H=1',
    # XXX I wish I could write '$(PACKAGE)/fdk-aac'.
    '-Ifdk-aac/fdk-aac',
    '-Ifdk-aac/fdk-aac/libAACdec/include',
    '-Ifdk-aac/fdk-aac/libAACenc/include',
    '-Ifdk-aac/fdk-aac/libSBRdec/include',
    '-Ifdk-aac/fdk-aac/libSBRenc/include',
    '-Ifdk-aac/fdk-aac/libMpegTPDec/include',
    '-Ifdk-aac/fdk-aac/libMpegTPEnc/include',
    '-Ifdk-aac/fdk-aac/libSYS/include',
    '-Ifdk-aac/fdk-aac/libFDK/include',
    '-Ifdk-aac/fdk-aac/libPCMutils/include',
    '-fno-exceptions',
    '-fno-rtti',
    '-g',
    '-O2',
]

cc_library(
    name = 'libfdk-aac',
    srcs = glob(
        # includes
        [
            'fdk-aac/**/*.cpp',
        ],
        # excludes
        [
            'fdk-aac/libAACdec/src/arm/*.cpp',
            'fdk-aac/libFDK/src/arm/*.cpp',
            'fdk-aac/libFDK/src/mips/*.cpp',
            'fdk-aac/libSBRdec/src/arm/*.cpp',
            'fdk-aac/libSYS/src/linux/*.cpp',
            'fdk-aac/libSYS/src/mips/*.cpp',
        ],
    ),
    copts = COPTS,
    linkopts = ['-lm'],
)
