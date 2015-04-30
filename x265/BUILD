package(default_visibility = ['//visibility:public'])

# XXX I wish I could write '$(PACKAGE)/x265'.
SRC_ROOT = 'x265/x265'
RELATIVE = '../../'

# XXX You really need a config tool to generate these flags :(
COPTS = [
    '-Wall',
    '-Wextra',
    '-Wshadow',
    '-Wno-array-bounds',
    '-mstackrealign',
    '-O3',
    '-fPIC',
    '-ffast-math',
    '-fno-exceptions',
    '-D__STDC_LIMIT_MACROS=1',
    '-DHAVE_INT_TYPES_H=1',
    '-DHIGH_BIT_DEPTH=0',
    '-DNDEBUG',
    '-DX265_ARCH_X86=1',
    '-DX86_64=1',
    '-I' + SRC_ROOT + '/source',
    '-I' + SRC_ROOT + '/source/common',
    '-I' + SRC_ROOT + '/source/encoder',
    '-I$(GENDIR)/' + SRC_ROOT + '/source',
]

ASOPTS = [
    '-f elf64',
    '-m amd64',
    '-DARCH_X86_64=1',
    '-DBIT_DEPTH=8',
    '-DHAVE_ALIGNED_STACK=1',
    '-DHIGH_BIT_DEPTH=0',
    '-DPIC',
]

# Build rules.

cc_binary(
    name = 'x265',
    srcs = glob([
        'x265/source/input/*.h',
        'x265/source/output/*.h',
        'x265/source/filters/*.h',
    ]) + [
        'x265/source/x265_config.h',
        'x265/source/x265.cpp',
        'x265/source/input/input.cpp',
        'x265/source/input/yuv.cpp',
        'x265/source/input/y4m.cpp',
        'x265/source/output/output.cpp',
        'x265/source/output/reconplay.cpp',
        'x265/source/output/yuv.cpp',
        'x265/source/output/y4m.cpp',
        'x265/source/output/raw.cpp',
        'x265/source/filters/filters.cpp',
        # XXX Link hack.
        'liblibx265.a',
    ],
    copts = COPTS,
    # XXX You really need a config tool to generate these flags :(
    linkopts = [
        '-lstdc++',
        '-lm',
        '-lrt',
        '-lpthread',
        '-ldl',
    ],
)

# XXX Hack for merging archives because I can't instruct Bazel to
# link with -Wl,--start-group and -Wl,--end-group or resolve static
# archive dependency in any way :(
genrule(
    name = 'libx265',
    srcs = [
        'liblibcommon.a',
        'liblibencoder.a',
        'source/common/libcpu.o.a',
        'source/common/libparam.o.a',
        'source/common/libprimitives.o.a',
        'source/common/libthreading.o.a',
        'source/common/libversion.o.a',
        'source/common/vec/libdct-sse3.o.a',
        'source/common/vec/libdct-ssse3.o.a',
        'source/common/vec/libdct-sse41.o.a',
    ],
    outs = ['liblibx265.a'],
    cmd = (
        'CURDIR="$$(pwd)" && ' +
        'mkdir -p $(GENDIR)/x265/objs && ' +
        'cd $(GENDIR)/x265/objs && ' +
        'for lib in $(SRCS); do ' +
            '$(AR) x "$${CURDIR}/$${lib}" ; ' +
        'done && ' +
        '$(AR) rcsD liblibx265.a *.o && ' +
        'cd "$${CURDIR}" && ' +
        'mv $(GENDIR)/x265/objs/liblibx265.a $@ && ' +
        'rm -rf $(GENDIR)/x265/objs'
    ),
)

cc_library(
    name = 'libcommon',
    srcs = glob(
        # includes
        [
            'x265/source/common/**/*.cpp',
            'x265/source/common/**/*.h',
        ],
        # excludes
        [
            # XXX Exclude sources that require custom COPTS.
            'x265/source/common/cpu.cpp',
            'x265/source/common/param.cpp',
            'x265/source/common/primitives.cpp',
            'x265/source/common/threading.cpp',
            'x265/source/common/version.cpp',
            'x265/source/common/vec/dct-sse3.cpp',
            'x265/source/common/vec/dct-ssse3.cpp',
            'x265/source/common/vec/dct-sse41.cpp',
            # Exclude Windows.
            'x265/source/common/winxp.cpp',
            'x265/source/common/winxp.h',
        ],
    ) + [
        'x265/source/x265_config.h',
        # From assembly code.
        'x265/source/common/x86/blockcopy8.o',
        'x265/source/common/x86/const-a.o',
        'x265/source/common/x86/cpu-a.o',
        'x265/source/common/x86/dct8.o',
        'x265/source/common/x86/intrapred8_allangs.o',
        'x265/source/common/x86/intrapred8.o',
        'x265/source/common/x86/ipfilter8.o',
        'x265/source/common/x86/loopfilter.o',
        'x265/source/common/x86/mc-a2.o',
        'x265/source/common/x86/mc-a.o',
        'x265/source/common/x86/pixel-a.o',
        'x265/source/common/x86/pixeladd8.o',
        'x265/source/common/x86/pixel-util8.o',
        'x265/source/common/x86/sad-a.o',
        'x265/source/common/x86/ssd-a.o',
    ],
    deps = [
        # XXX Sources that require custom COPTS.
        'source/common/cpu.o',
        'source/common/param.o',
        'source/common/primitives.o',
        'source/common/threading.o',
        'source/common/version.o',
        'source/common/vec/dct-sse3.o',
        'source/common/vec/dct-ssse3.o',
        'source/common/vec/dct-sse41.o',
    ],
    copts = COPTS,
)

cc_library(
    name = 'libencoder',
    srcs = [
        'x265/source/x265.h',
        'x265/source/x265_config.h',
    ] + glob([
        'x265/source/encoder/*.cpp',
        'x265/source/encoder/*.h',
    ]),
    copts = COPTS + ['-Wno-uninitialized'],
)

# XXX Custom COPTS.

cc_library(
    name = 'source/common/cpu.o',
    srcs = [
        'x265/source/common/cpu.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-Wno-narrowing'],
)

cc_library(
    name = 'source/common/param.o',
    srcs = [
        'x265/source/common/param.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-DHAVE_STRTOK_R=1'],
)

cc_library(
    name = 'source/common/primitives.o',
    srcs = [
        'x265/source/common/primitives.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-DENABLE_ASSEMBLY=1'],
)

cc_library(
    name = 'source/common/threading.o',
    srcs = [
        'x265/source/common/threading.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-DENABLE_ASSEMBLY=1'],
)

cc_library(
    name = 'source/common/version.o',
    srcs = [
        'x265/source/common/version.cpp',
        'x265/source/x265_config.h',
        # XXX Bazel doesn't have "compile time data" concept; so I have
        # to make 'version.inc' look like source file :(
        'x265/version.inc',
    ],
    copts = COPTS + [
        # XXX '-DVAR=$$(cat FILE)' doesn't work :(
        '-include $(GENDIR)/' + SRC_ROOT + '/version.inc',
    ],
)

cc_library(
    name = 'source/common/vec/dct-sse3.o',
    srcs = [
        'x265/source/common/vec/dct-sse3.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-Wno-unused-parameter', '-msse3'],
)

cc_library(
    name = 'source/common/vec/dct-ssse3.o',
    srcs = [
        'x265/source/common/vec/dct-ssse3.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-Wno-unused-parameter', '-mssse3'],
)

cc_library(
    name = 'source/common/vec/dct-sse41.o',
    srcs = [
        'x265/source/common/vec/dct-sse41.cpp',
        'x265/source/x265_config.h',
    ],
    copts = COPTS + ['-Wno-unused-parameter', '-msse4.1'],
)

# XXX Partial copy of x265/source/cmake/version.cmake
genrule(
    name = 'version.inc',
    outs = ['x265/version.inc'],
    cmd = (
        'cd ' + SRC_ROOT + ' && ' +
        'printf \'#define X265_VERSION %s+%s-%s\' ' +
            '$$(hg log -r. --template \'{latesttag}\') ' +
            '$$(hg log -r. --template \'{latesttagdistance}\') ' +
            '$$(hg log -r. --template \'{node|short}\') ' +
        '  > ' + RELATIVE + '$@'
    ),
)

# XXX Bazel doesn't support Python for-loop in BUILD file; to reduce
# boilerplates, I will assemble them separately in one genrule.
genrule(
    name = 'assemblies',
    srcs = [
        'x265/source/common/x86/blockcopy8.asm',
        'x265/source/common/x86/const-a.asm',
        'x265/source/common/x86/cpu-a.asm',
        'x265/source/common/x86/dct8.asm',
        'x265/source/common/x86/intrapred8_allangs.asm',
        'x265/source/common/x86/intrapred8.asm',
        'x265/source/common/x86/ipfilter8.asm',
        'x265/source/common/x86/loopfilter.asm',
        'x265/source/common/x86/mc-a2.asm',
        'x265/source/common/x86/mc-a.asm',
        'x265/source/common/x86/pixel-a.asm',
        'x265/source/common/x86/pixeladd8.asm',
        'x265/source/common/x86/pixel-util8.asm',
        'x265/source/common/x86/sad-a.asm',
        'x265/source/common/x86/ssd-a.asm',
    ],
    outs = [
        'x265/source/common/x86/blockcopy8.o',
        'x265/source/common/x86/const-a.o',
        'x265/source/common/x86/cpu-a.o',
        'x265/source/common/x86/dct8.o',
        'x265/source/common/x86/intrapred8_allangs.o',
        'x265/source/common/x86/intrapred8.o',
        'x265/source/common/x86/ipfilter8.o',
        'x265/source/common/x86/loopfilter.o',
        'x265/source/common/x86/mc-a2.o',
        'x265/source/common/x86/mc-a.o',
        'x265/source/common/x86/pixel-a.o',
        'x265/source/common/x86/pixeladd8.o',
        'x265/source/common/x86/pixel-util8.o',
        'x265/source/common/x86/sad-a.o',
        'x265/source/common/x86/ssd-a.o',
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

# XXX It is really bad that every rule has to explicit depend on
# x265_config.h (which is included in x265.h) because x265_config.h
# is a generated file :(
genrule(
    name = 'x265_config.h',
    srcs = [
        'x265/source/CMakeLists.txt',
        'x265/source/x265_config.h.in',
    ],
    outs = ['x265/source/x265_config.h'],
    cmd = (
        'X265_BUILD=$$(perl -ne \'/set\(X265_BUILD (\d+)\)/ && print $$1\' ' +
            '"$(location x265/source/CMakeLists.txt)") && ' +
        'sed "s/\$${X265_BUILD}/$${X265_BUILD}/" ' +
            '"$(location x265/source/x265_config.h.in)" > $@'
    ),
)
