package(default_visibility = ['//visibility:public'])

COPTS = [
    '-DHAVE_CONFIG_H',
    '-O3',
    '-fomit-frame-pointer',
    '-ffast-math',
    '-Wall',
]

cc_binary(
    name = 'lame',
    deps = [
        'libmp3lame',
    ],
    srcs = [
        'lame/config.h',  # Generated.
        'lame/frontend/brhist.c',
        'lame/frontend/console.c',
        'lame/frontend/get_audio.c',
        'lame/frontend/lame_main.c',
        'lame/frontend/lametime.c',
        'lame/frontend/main.c',
        'lame/frontend/parse.c',
        'lame/frontend/timestatus.c',
    ],
    copts = COPTS + [
        '-I$(GENDIR)/lame/lame',  # For config.h
        '-Ilame/lame/frontend',
        '-Ilame/lame/libmp3lame',
        '-Ilame/lame/include',
    ],
    linkopts = [
        '-lm',
    ],
)

cc_library(
    name = 'libmp3lame',
    srcs = [
        'lame/config.h',  # Generated.
    ] + glob([
        'lame/libmp3lame/*.c',
        'lame/libmp3lame/vector/*.c',
        'lame/mpglib/*.c',
    ]),
    copts = COPTS + [
        '-I$(GENDIR)/lame/lame',  # For config.h
        '-Ilame/lame/include',
        '-Ilame/lame/libmp3lame',
        '-Ilame/lame/libmp3lame/vector',
        '-Ilame/lame/mpglib',
    ],
)

genrule(
    name = 'config.h',
    srcs = ['config.h.in'],
    outs = ['lame/config.h'],
    cmd = 'cp $< $@',
)
