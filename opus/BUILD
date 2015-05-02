package(default_visibility = ['//visibility:public'])

COPTS = [
    '-DHAVE_CONFIG_H',
    '-I$(GENDIR)/opus/opus',  # For config.h.
    '-Iopus/opus/celt',
    '-Iopus/opus/include',
    '-Iopus/opus/silk',
    '-Iopus/opus/silk/fixed',
    '-Iopus/opus/silk/float',
    '-std=gnu99',
    '-O2',
    '-g',
    '-fvisibility=hidden',
    '-W',
    '-Wall',
    '-Wextra',
    '-Wcast-align',
    '-Wnested-externs',
    '-Wshadow',
    '-Wstrict-prototypes',
]

cc_binary(
    name = 'opus_demo',
    deps = ['libopus'],
    srcs = [
        'opus/config.h',  # Generated.
        'opus/src/opus_demo.c',
    ],
    copts = COPTS,
    linkopts = ['-lm'],
)

cc_binary(
    name = 'repacketizer_demo',
    deps = ['libopus'],
    srcs = [
        'opus/config.h',  # Generated.
        'opus/src/repacketizer_demo.c',
    ],
    copts = COPTS,
    linkopts = ['-lm'],
)

cc_library(
    name = 'libopus',
    srcs = glob(
        # includes
        [
            'opus/celt/*.c',
            'opus/silk/*.c',
            'opus/silk/float/*.c',
        ],
        # excludes
        [
            'opus/celt/opus_custom_demo.c',
        ],
    ) + [
        'opus/config.h',  # Generated.
        'opus/src/analysis.c',
        'opus/src/mlp.c',
        'opus/src/mlp_data.c',
        'opus/src/opus.c',
        'opus/src/opus_decoder.c',
        'opus/src/opus_encoder.c',
        'opus/src/opus_multistream.c',
        'opus/src/opus_multistream_decoder.c',
        'opus/src/opus_multistream_encoder.c',
        'opus/src/repacketizer.c',
    ],
    copts = COPTS,
)

genrule(
    name = 'config.h',
    srcs = ['config.h.in'],
    outs = ['opus/config.h'],
    cmd = 'cp $< $@',
)
