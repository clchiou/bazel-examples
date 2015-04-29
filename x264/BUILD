package(default_visibility = ['//visibility:public'])

# XXX I wish I could write '$(PACKAGE)/x264'.
SRC_ROOT = 'x264/x264'

COPTS = [
    '-std=gnu99',
    '-m64',
    '-mpreferred-stack-boundary=5',
    '-Wall',
    '-Wno-maybe-uninitialized',
    '-Wshadow',
    '-O3',
    '-ffast-math',
    '-fomit-frame-pointer',
    '-fno-tree-vectorize',
    '-I' + SRC_ROOT,
    '-I$(GENDIR)/' + SRC_ROOT,
]

ASOPTS = [
    '-f elf',
    '-m amd64',
    '-Worphan-labels',
    '-DARCH_X86_64=1',
    '-DBIT_DEPTH=8',
    '-DHIGH_BIT_DEPTH=0',
    '-DSTACK_ALIGNMENT=32',
    '-I' + SRC_ROOT,
    '-I' + SRC_ROOT + '/common/x86',
]

LINKOPTS = [
    '-ldl',
    '-lgpac_static',
    '-lz',
    '-lm',
    '-lpthread',
    '-ldl',
]

# Build rules.

# XXX Using this library needs `-lpthread -lm -ldl`, but how to
# express this in Bazel?
cc_library(
    name = 'libx264',
    hdrs = [
        'x264/x264.h',
        'x264/x264_config.h',
    ],
    srcs = [
        'x264/common/bitstream.c',
        'x264/common/cabac.c',
        'x264/common/common.c',
        'x264/common/cpu.c',
        'x264/common/dct.c',
        'x264/common/deblock.c',
        'x264/common/frame.c',
        'x264/common/macroblock.c',
        'x264/common/mc.c',
        'x264/common/mvpred.c',
        'x264/common/opencl.c',
        'x264/common/osdep.c',
        'x264/common/pixel.c',
        'x264/common/predict.c',
        'x264/common/quant.c',
        'x264/common/rectangle.c',
        'x264/common/set.c',
        'x264/common/threadpool.c',
        'x264/common/vlc.c',
        'x264/common/x86/mc-c.c',
        'x264/common/x86/predict-c.c',
        'x264/encoder/analyse.c',
        'x264/encoder/cabac.c',
        'x264/encoder/cavlc.c',
        'x264/encoder/encoder.c',
        'x264/encoder/lookahead.c',
        'x264/encoder/macroblock.c',
        'x264/encoder/me.c',
        'x264/encoder/ratecontrol.c',
        'x264/encoder/set.c',
        'x264/encoder/slicetype-cl.c',
        # From assembly code.
        'x264/common/x86/bitstream-a.o',
        'x264/common/x86/cabac-a.o',
        'x264/common/x86/const-a.o',
        'x264/common/x86/cpu-a.o',
        'x264/common/x86/dct-64.o',
        'x264/common/x86/dct-a.o',
        'x264/common/x86/deblock-a.o',
        'x264/common/x86/mc-a2.o',
        'x264/common/x86/mc-a.o',
        'x264/common/x86/pixel-a.o',
        'x264/common/x86/predict-a.o',
        'x264/common/x86/quant-a.o',
        'x264/common/x86/sad-a.o',
        'x264/common/x86/trellis-64.o',
        # Generated sources.
        'x264/config.h',
        'x264/common/oclobj.h',
    ],
    copts = COPTS,
)

cc_binary(
    name = 'x264',
    deps = ['libx264'],
    srcs = [
        'x264/x264.c',
        'x264/filters/filters.c',
        'x264/filters/video/cache.c',
        'x264/filters/video/crop.c',
        'x264/filters/video/depth.c',
        'x264/filters/video/fix_vfr_pts.c',
        'x264/filters/video/internal.c',
        'x264/filters/video/resize.c',
        'x264/filters/video/select_every.c',
        'x264/filters/video/source.c',
        'x264/filters/video/video.c',
        'x264/input/avs.c',
        'x264/input/input.c',
        'x264/input/raw.c',
        'x264/input/thread.c',
        'x264/input/timecode.c',
        'x264/input/y4m.c',
        'x264/output/flv_bytestream.c',
        'x264/output/flv.c',
        'x264/output/matroska.c',
        'x264/output/matroska_ebml.c',
        'x264/output/mp4.c',
        'x264/output/raw.c',
    ],
    copts = COPTS,
    linkopts = LINKOPTS,
)

# XXX Bazel doesn't support Python for-loop; so to save boilerplates,
# I will assemble them separately in one genrule.
genrule(
    name = 'assemblies',
    srcs = [
        'x264/common/x86/bitstream-a.asm',
        'x264/common/x86/cabac-a.asm',
        'x264/common/x86/const-a.asm',
        'x264/common/x86/cpu-a.asm',
        'x264/common/x86/dct-64.asm',
        'x264/common/x86/dct-a.asm',
        'x264/common/x86/deblock-a.asm',
        'x264/common/x86/mc-a2.asm',
        'x264/common/x86/mc-a.asm',
        'x264/common/x86/pixel-a.asm',
        'x264/common/x86/predict-a.asm',
        'x264/common/x86/quant-a.asm',
        'x264/common/x86/sad-a.asm',
        'x264/common/x86/trellis-64.asm',
    ],
    outs = [
        'x264/common/x86/bitstream-a.o',
        'x264/common/x86/cabac-a.o',
        'x264/common/x86/const-a.o',
        'x264/common/x86/cpu-a.o',
        'x264/common/x86/dct-64.o',
        'x264/common/x86/dct-a.o',
        'x264/common/x86/deblock-a.o',
        'x264/common/x86/mc-a2.o',
        'x264/common/x86/mc-a.o',
        'x264/common/x86/pixel-a.o',
        'x264/common/x86/predict-a.o',
        'x264/common/x86/quant-a.o',
        'x264/common/x86/sad-a.o',
        'x264/common/x86/trellis-64.o',
    ],
    tools = ['//yasm:yasm'],
    cmd = (
        'for src in $(SRCS); do ' +
        '  $(location //yasm:yasm) ' +
            ' '.join(ASOPTS) +
            ' -o $(GENDIR)/$${src%.asm}.o $${src}; ' +
        'done'
    ),
)


# Generated sources.

# XXX Use generated config.h for generated config.h :(
genrule(
    name = 'config.h',
    srcs = ['config.h.in'],
    outs = ['x264/config.h'],
    cmd = 'cp $< $@',
)

# XXX Use generated x264_config.h for generated x264_config.h :(
genrule(
    name = 'x264_config.h',
    srcs = ['x264_config.h.in'],
    outs = ['x264/x264_config.h'],
    tools = ['x264/version.sh'],
    cmd = (
        'cp $< $@ && ' +
        '$(location x264/version.sh) ' + SRC_ROOT + ' >> $@'
    ),
)

genrule(
    name = 'oclobj.h',
    srcs = [
        'x264/common/opencl/x264-cl.h',
        'x264/common/opencl/bidir.cl',
        'x264/common/opencl/downscale.cl',
        'x264/common/opencl/intra.cl',
        'x264/common/opencl/motionsearch.cl',
        'x264/common/opencl/subpel.cl',
        'x264/common/opencl/weightp.cl',
    ],
    outs = ['x264/common/oclobj.h'],
    tools = ['x264/tools/cltostr.sh'],
    cmd = 'cat $(SRCS) | $(location x264/tools/cltostr.sh) $@',
)
