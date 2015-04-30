package(default_visibility = ['//visibility:public'])

# XXX I wish I could write '$(PACKAGE)/yasm'.
SRC_ROOT = 'yasm/yasm'
RELATIVE = '../../'

COPTS = [
    '-std=gnu99', '-g', '-O2',
    '-DHAVE_CONFIG_H',
    '-I' + SRC_ROOT,
    '-I$(GENDIR)/' + SRC_ROOT,
]

TOOL_COPTS = [
    '-std=gnu99',
    '-I' + SRC_ROOT,
    '-I$(GENDIR)/' + SRC_ROOT,
]

# Build rules.

# TODO...
#cc_binary(
#    name = 'vsyasm',
#    copts = COPTS,
#)

cc_binary(
    name = 'yasm',
    srcs = [
        'yasm/frontends/yasm/yasm-options.c',
        'yasm/frontends/yasm/yasm-options.h',
        # XXX Dependency hack.
        '_dephack/yasm/frontends/yasm/yasm.c',
    ],
    deps = [':libyasm'],
    copts = COPTS + [
        '-I' + SRC_ROOT + '/frontends/yasm',
    ],
)

# TODO...
#cc_binary(
#    name = 'ytasm',
#    copts = COPTS,
#)

cc_library(
    name = 'libyasm',
    srcs = glob(
        # includes
        [
            'yasm/libyasm/*.c',
            'yasm/modules/arch/*/*.c',
            'yasm/modules/dbgfmts/*/*.c',
            'yasm/modules/listfmts/nasm/*.c',
            'yasm/modules/objfmts/bin/*.c',
            'yasm/modules/objfmts/coff/*.c',
            'yasm/modules/objfmts/dbg/*.c',
            'yasm/modules/objfmts/elf/*.c',
            'yasm/modules/objfmts/macho/*.c',
            'yasm/modules/objfmts/rdf/*.c',
            'yasm/modules/objfmts/xdf/*.c',
            'yasm/modules/parsers/gas/*.c',
            'yasm/modules/parsers/nasm/*.c',
            'yasm/modules/preprocs/cpp/*.c',
            'yasm/modules/preprocs/gas/*.c',
            'yasm/modules/preprocs/nasm/*.c',
            'yasm/modules/preprocs/raw/*.c',
        ],
        # excludes
        [
            'yasm/libyasm/cmake-module.c',
            'yasm/libyasm/genmodule.c',
            'yasm/modules/preprocs/nasm/genversion.c',
            # XXX Dependency hack.
            'yasm/modules/arch/x86/x86id.c',
            'yasm/modules/objfmts/coff/coff-objfmt.c',
            'yasm/modules/parsers/nasm/nasm-parser.c',
            'yasm/modules/preprocs/nasm/nasm-preproc.c',
        ],
    ) + [
        # Generated headers.
        'yasm/YASM-VERSION.h',
        'yasm/config.h',
        'yasm/libyasm-stdint.h',
        # Generated sources.
        'yasm/gas-token.c',
        'yasm/lc3bid.c',
        'yasm/module.c',
        'yasm/nasm-token.c',
        'yasm/x86cpu.c',
        'yasm/x86regtmod.c',
        # XXX Dependency hack.
        '_dephack/yasm/modules/arch/x86/x86id.c',
        '_dephack/yasm/modules/objfmts/coff/coff-objfmt.c',
        '_dephack/yasm/modules/parsers/nasm/nasm-parser.c',
        '_dephack/yasm/modules/preprocs/nasm/nasm-preproc.c',
    ],
    copts = COPTS + [
        # XXX Dependency hack.
        '-I' + SRC_ROOT + '/modules/objfmts/coff',
        '-I' + SRC_ROOT + '/modules/parsers/nasm',
        '-I' + SRC_ROOT + '/modules/preprocs/nasm',
    ],
)

# Generate headers.

genrule(
    name = 'YASM-VERSION',
    outs = [
        'YASM-VERSION-GEN.sh',
        'yasm/YASM-VERSION-FILE',
        'yasm/YASM-VERSION.h',
    ],
    tools = ['yasm/YASM-VERSION-GEN.sh'],
    cmd = (
        'cp $(location yasm/YASM-VERSION-GEN.sh) $(location YASM-VERSION-GEN.sh) && ' +
        'sed -i s!YVF=YASM-VERSION-FILE!YVF=' + RELATIVE + '$(location yasm/YASM-VERSION-FILE)! $(location YASM-VERSION-GEN.sh) && ' +
        'sed -i s!YASM-VERSION.h!' + RELATIVE + '$(location yasm/YASM-VERSION.h)! $(location YASM-VERSION-GEN.sh) && ' +
        'cd ' + SRC_ROOT + ' && ' +
        RELATIVE + '$(location YASM-VERSION-GEN.sh)'
    ),
)

genrule(
    name = 'version.mac',
    outs = ['yasm/version.mac'],
    tools = ['genversion'],
    cmd = '$(location genversion) $@',
)

# XXX Use generated config.h as template.
genrule(
    name = 'config.h',
    srcs = ['yasm/YASM-VERSION-FILE'],
    outs = ['yasm/config.h'],
    tools = ['config.h.sh'],
    cmd = '$(location config.h.sh) `cat $(location yasm/YASM-VERSION-FILE)` > $@',
)

# XXX Use generated libyasm-stdint.h as template.
genrule(
    name = 'libyasm-stdint.h',
    srcs = ['yasm/YASM-VERSION-FILE'],
    outs = ['yasm/libyasm-stdint.h'],
    tools = ['libyasm-stdint.h.sh'],
    cmd = '$(location libyasm-stdint.h.sh) `cat $(location yasm/YASM-VERSION-FILE)` > $@',
)

# Generate sources.

genrule(
    name = 'gas-token.c',
    srcs = ['yasm/modules/parsers/gas/gas-token.re'],
    outs = ['yasm/gas-token.c'],
    tools = ['re2c'],
    cmd = '$(location re2c) -b -o $@ $<',
)

genrule(
    name = 'lc3bid.c',
    srcs = ['yasm/modules/arch/lc3b/lc3bid.re'],
    outs = ['yasm/lc3bid.c'],
    tools = ['re2c'],
    cmd = '$(location re2c) -s -o $@ $<',
)

genrule(
    name = 'license.c',
    srcs = ['yasm/COPYING'],
    outs = ['yasm/license.c'],
    tools = ['genstring'],
    cmd = '$(location genstring) license_msg $@ $<',
)

genrule(
    name = 'module.c',
    srcs = [
        'yasm/Makefile.am',
        'yasm/libyasm/module.in',
    ],
    outs = ['yasm/module.c'],
    tools = ['genmodule'],
    cmd = (
        'cd ' + SRC_ROOT + ' && ' +
        RELATIVE + '$(location genmodule) libyasm/module.in Makefile.am > ' + RELATIVE + '$@'
    ),
)

genrule(
    name = 'nasm-macros.c',
    srcs = ['yasm/modules/parsers/nasm/nasm-std.mac'],
    outs = ['yasm/nasm-macros.c'],
    tools = ['genmacro'],
    cmd = '$(location genmacro) $@ nasm_standard_mac $<',
)

genrule(
    name = 'nasm-token.c',
    srcs = ['yasm/modules/parsers/nasm/nasm-token.re'],
    outs = ['yasm/nasm-token.c'],
    tools = ['re2c'],
    cmd = '$(location re2c) -b -o $@ $<',
)

genrule(
    name = 'nasm-version.c',
    srcs = ['yasm/version.mac'],
    outs = ['yasm/nasm-version.c'],
    tools = ['genmacro'],
    cmd = '$(location genmacro) $@ nasm_version_mac $<',
)

genrule(
    name = 'win64-gas.c',
    srcs = ['yasm/modules/objfmts/coff/win64-gas.mac'],
    outs = ['yasm/win64-gas.c'],
    tools = ['genmacro'],
    cmd = '$(location genmacro) $@ win64_gas_stdmac $<',
)

genrule(
    name = 'win64-nasm.c',
    srcs = ['yasm/modules/objfmts/coff/win64-nasm.mac'],
    outs = ['yasm/win64-nasm.c'],
    tools = ['genmacro'],
    cmd = '$(location genmacro) $@ win64_nasm_stdmac $<',
)

genrule(
    name = 'x86cpu.c',
    srcs = ['yasm/modules/arch/x86/x86cpu.gperf'],
    outs = ['yasm/x86cpu.c'],
    tools = ['genperf'],
    cmd = '$(location genperf) $< $@',
)

genrule(
    name = 'x86insn',
    outs = [
        'yasm/x86insn_gas.gperf',
        'yasm/x86insn_gas.c',
        'yasm/x86insn_nasm.gperf',
        'yasm/x86insn_nasm.c',
        'yasm/x86insns.c',
    ],
    tools = [
        'gen_x86_insn.py',
        'genperf',
    ],
    cmd = (
        'python $(location gen_x86_insn.py) ' +
            '$(location yasm/x86insns.c) ' +
            '$(location yasm/x86insn_gas.gperf) ' +
            '$(location yasm/x86insn_nasm.gperf) && ' +
        '$(location genperf) ' +
            '$(location yasm/x86insn_gas.gperf) ' +
            '$(location yasm/x86insn_gas.c) && ' +
        '$(location genperf) ' +
            '$(location yasm/x86insn_nasm.gperf) ' +
            '$(location yasm/x86insn_nasm.c)'
    ),
)

genrule(
    name = 'x86regtmod.c',
    srcs = ['yasm/modules/arch/x86/x86regtmod.gperf'],
    outs = ['yasm/x86regtmod.c'],
    tools = ['genperf'],
    cmd = '$(location genperf) $< $@',
)

# Code-generation tools.

cc_binary(
    name = 'genstring',
    srcs = ['yasm/genstring.c'],
    copts = TOOL_COPTS,
)

cc_binary(
    name = 're2c',
    srcs = glob([
        'yasm/tools/re2c/*.c',
        'yasm/tools/re2c/*.h',
    ]),
    copts = TOOL_COPTS,
)

cc_binary(
    name = 'genmacro',
    srcs = ['yasm/tools/genmacro/genmacro.c'],
    copts = TOOL_COPTS,
)

cc_binary(
    name = 'genperf',
    srcs = glob([
        'yasm/tools/genperf/*.c',
        'yasm/tools/genperf/*.h',
    ]) + [
        'yasm/config.h',
        'yasm/libyasm-stdint.h',
        'yasm/libyasm/phash.c',
        'yasm/libyasm/xmalloc.c',
        'yasm/libyasm/xstrdup.c',
    ],
    copts = TOOL_COPTS,
)

cc_binary(
    name = 'genversion',
    srcs = [
        'yasm/config.h',
        'yasm/modules/preprocs/nasm/genversion.c',
    ],
    copts = TOOL_COPTS,
)

cc_binary(
    name = 'genmodule',
    srcs = [
        'genmodule.c',
        'yasm/libyasm/compat-queue.h',
    ],
    copts = TOOL_COPTS + ['-I' + SRC_ROOT + '/libyasm'],
)

genrule(
    name = 'patch-genmodule.c',
    srcs = ['yasm/libyasm/genmodule.c'],
    outs = ['genmodule.c'],
    cmd = 'sed s!"module.c"!"/dev/stdout"! < $< > $@',
)

genrule(
    name = 'patch-gen_x86_insn.py',
    srcs = ['yasm/modules/arch/x86/gen_x86_insn.py'],
    outs = ['gen_x86_insn.py'],
    cmd = (
        'cp $< $@ && ' +
        'sed -i \'s/from sys import/from sys import argv,/\' $@ && ' +
        'sed -i \'s/"x86insns.c"/argv[1]/\' $@ && ' +
        'sed -i \'s/"x86insn_gas.gperf"/argv[2]/\' $@ && ' +
        'sed -i \'s/"x86insn_nasm.gperf"/argv[3]/\' $@'
    ),
)

# XXX Dependency hack.

genrule(
    name = 'yasm.c',
    srcs = [
        'yasm/frontends/yasm/yasm.c',
        # Dependencies.
        'yasm/license.c',
    ],
    outs = ['_dephack/yasm/frontends/yasm/yasm.c'],
    tools = ['dephack.py'],
    cmd = '$(location dephack.py) $(SRCS) > $@',
)

genrule(
    name = 'x86id.c',
    srcs = [
        'yasm/modules/arch/x86/x86id.c',
        # Dependencies.
        'yasm/x86insn_gas.c',
        'yasm/x86insn_nasm.c',
        'yasm/x86insns.c',
    ],
    outs = ['_dephack/yasm/modules/arch/x86/x86id.c'],
    tools = ['dephack.py'],
    cmd = '$(location dephack.py) $(SRCS) > $@',
)

genrule(
    name = 'coff-objfmt.c',
    srcs = [
        'yasm/modules/objfmts/coff/coff-objfmt.c',
        # Dependencies.
        'yasm/win64-gas.c',
        'yasm/win64-nasm.c',
    ],
    outs = ['_dephack/yasm/modules/objfmts/coff/coff-objfmt.c'],
    tools = ['dephack.py'],
    cmd = '$(location dephack.py) $(SRCS) > $@',
)

genrule(
    name = 'nasm-parser.c',
    srcs = [
        'yasm/modules/parsers/nasm/nasm-parser.c',
        # Dependencies.
        'yasm/nasm-macros.c',
    ],
    outs = ['_dephack/yasm/modules/parsers/nasm/nasm-parser.c'],
    tools = ['dephack.py'],
    cmd = '$(location dephack.py) $(SRCS) > $@',
)

genrule(
    name = 'nasm-preproc.c',
    srcs = [
        'yasm/modules/preprocs/nasm/nasm-preproc.c',
        # Dependencies.
        'yasm/nasm-version.c',
    ],
    outs = ['_dephack/yasm/modules/preprocs/nasm/nasm-preproc.c'],
    tools = ['dephack.py'],
    cmd = '$(location dephack.py) $(SRCS) > $@',
)
