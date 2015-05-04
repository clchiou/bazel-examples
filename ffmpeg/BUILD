package(default_visibility = ['//visibility:public'])

COPTS = [
    '-std=c99',
    '-O3',
    '-g',
    '-fno-math-errno',
    '-fno-signed-zeros',
    '-fno-tree-vectorize',
    '-fomit-frame-pointer',
    '-pthread',

    '-D_FILE_OFFSET_BITS=64',
    '-D_GNU_SOURCE=1',
    '-D_ISOC99_SOURCE',
    '-D_LARGEFILE_SOURCE',
    '-D_POSIX_C_SOURCE=200112',
    '-D_REENTRANT',
    '-D_XOPEN_SOURCE=600',
    '-DHAVE_AV_CONFIG_H',
    '-DZLIB_CONST',

    '-I$(GENDIR)/ffmpeg',
    '-Iffmpeg/ffmpeg',

    # XXX Copy generated headers :(
    '-Iffmpeg',

    # XXX Work around Bazel's ban on using system headers.
    '-Iffmpeg/usr/include/freetype2',
    '-Iffmpeg/usr/include/fribidi',
    '-Iffmpeg/usr/include/freetype2',
    '-Iffmpeg/usr/include/SDL',

    # TODO...
    #'-I/home/clchiou/ffmpeg/build/include',
    #'-I/home/clchiou/ffmpeg/build/include/opus',
    #'-I/home/clchiou/ffmpeg/build/include',
    #'-I/home/clchiou/ffmpeg/build/include',

    '-Wall',
    '-Wdeclaration-after-statement',
    '-Wdisabled-optimization',
    '-Wempty-body',
    '-Werror=format-security',
    '-Werror=implicit-function-declaration',
    '-Werror=missing-prototypes',
    '-Werror=return-type',
    '-Werror=vla',
    '-Wformat',
    '-Wmissing-prototypes',
    '-Wno-format-zero-length',
    '-Wno-maybe-uninitialized',
    '-Wno-parentheses',
    '-Wno-pointer-sign',
    '-Wno-pointer-to-int-cast',
    '-Wno-switch',
    '-Wpointer-arith',
    '-Wredundant-decls',
    '-Wstrict-prototypes',
    '-Wtype-limits',
    '-Wundef',
    '-Wwrite-strings',
]

DEPS = [
    'libavcodec',
    'libavdevice',
    'libavfilter',
    'libavformat',
    #'libavresample',
    'libavutil',
    'libpostproc',
    'libswscale',
    'libswresample',
]

cc_binary(
    name = 'ffmpeg',
    deps = DEPS,
    copts = COPTS,
)


cc_binary(
    name = 'ffplay',
    deps = DEPS,
    copts = COPTS,
)

cc_binary(
    name = 'ffprobe',
    deps = DEPS,
    copts = COPTS,
)

cc_binary(
    name = 'ffserver',
    deps = DEPS,
    copts = COPTS,
)

cc_library(
    name = 'libavdevice',
    deps = [
        '//fdk-aac:libfdk-aac',
        '//opus:libopus',
        '//lame:libmp3lame',
        '//libvpx:libvpx',
        '//x264:libx264',
    ],
    srcs = [
        # XXX Workaround genrule hack :(
        '//x265:liblibx265.a',
        # XXX Copy generated header :(
        'config.h',
        'libavutil/avconfig.h',
        # Generated header.
        'libavutil/ffversion.h',
        # Sources.
        'ffmpeg/libavdevice/alldevices.c',
        'ffmpeg/libavdevice/alsa.c',
        'ffmpeg/libavdevice/alsa_dec.c',
        'ffmpeg/libavdevice/alsa_enc.c',
        'ffmpeg/libavdevice/avdevice.c',
        'ffmpeg/libavdevice/dv1394.c',
        'ffmpeg/libavdevice/fbdev_common.c',
        'ffmpeg/libavdevice/fbdev_dec.c',
        'ffmpeg/libavdevice/fbdev_enc.c',
        'ffmpeg/libavdevice/lavfi.c',
        'ffmpeg/libavdevice/oss.c',
        'ffmpeg/libavdevice/oss_dec.c',
        'ffmpeg/libavdevice/oss_enc.c',
        'ffmpeg/libavdevice/sdl.c',
        'ffmpeg/libavdevice/timefilter.c',
        'ffmpeg/libavdevice/utils.c',
        'ffmpeg/libavdevice/v4l2.c',
        'ffmpeg/libavdevice/v4l2-common.c',
        'ffmpeg/libavdevice/v4l2enc.c',
        'ffmpeg/libavdevice/xcbgrab.c',
    ],
    copts = COPTS,
)

cc_library(
    name = 'libavfilter',
    copts = COPTS,
)

cc_library(
    name = 'libavformat',
    copts = COPTS,
)

cc_library(
    name = 'libavcodec',
    copts = COPTS,
)

cc_library(
    name = 'libpostproc',
    copts = COPTS,
)

cc_library(
    name = 'libswresample',
    copts = COPTS,
)

cc_library(
    name = 'libswscale',
    copts = COPTS,
)

cc_library(
    name = 'libavutil',
    copts = COPTS,
)

genrule(
    name = 'ffversion.h',
    outs = ['libavutil/ffversion.h'],
    tools = ['ffmpeg/version.sh'],
    cmd = '$(location ffmpeg/version.sh) ffmpeg/ffmpeg $@',
)
