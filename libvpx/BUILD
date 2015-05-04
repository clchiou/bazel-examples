package(default_visibility = ['//visibility:public'])

# XXX Bazel doesn't distinguish CFALGS from CXXFLAGS.
COPTS = [
    # Common CFLAGS.
    '-m64',
    '-DNDEBUG',
    '-O3',
    '-U_FORTIFY_SOURCE',
    '-D_FORTIFY_SOURCE=0',
    '-D_LARGEFILE_SOURCE',
    '-D_FILE_OFFSET_BITS=64',
    '-Wall',
    '-Wdeclaration-after-statement',
    '-Wdisabled-optimization',
    '-Wpointer-arith',
    '-Wtype-limits',
    '-Wcast-qual',
    '-Wvla',
    '-Wimplicit-function-declaration',
    '-Wuninitialized',
    '-Wunused-variable',
    '-Wunused-but-set-variable',
    '-Wno-unused-function',

    '-I$(GENDIR)/libvpx',  # Generated headers.
    '-Ilibvpx',  # XXX "Generated" headers copied from somewhere else.
    '-Ilibvpx/libvpx',

    # XXX File-specifix flags set for all sources for convenience.
    '-mmmx',
    '-msse2',
    '-msse3',
    '-mssse3',
    '-msse4.1',
    '-mavx',
    '-mavx2',
]

LINKOPTS = [
    '-m64',
    '-lpthread',
]

ASOPTS = [
    '-f elf64',
    '-I$(GENDIR)/libvpx',  # Generated headers.
    '-Ilibvpx',  # XXX "Generated" headers copied from somewhere else.
    '-Ilibvpx/libvpx',
]

ASSRCS = [
    'libvpx/vp8/common/x86/dequantize_mmx.asm',
    'libvpx/vp8/common/x86/idctllm_mmx.asm',
    'libvpx/vp8/common/x86/idctllm_sse2.asm',
    'libvpx/vp8/common/x86/iwalsh_mmx.asm',
    'libvpx/vp8/common/x86/iwalsh_sse2.asm',
    'libvpx/vp8/common/x86/loopfilter_block_sse2_x86_64.asm',
    'libvpx/vp8/common/x86/loopfilter_mmx.asm',
    'libvpx/vp8/common/x86/loopfilter_sse2.asm',
    'libvpx/vp8/common/x86/mfqe_sse2.asm',
    'libvpx/vp8/common/x86/postproc_mmx.asm',
    'libvpx/vp8/common/x86/postproc_sse2.asm',
    'libvpx/vp8/common/x86/recon_mmx.asm',
    'libvpx/vp8/common/x86/recon_sse2.asm',
    'libvpx/vp8/common/x86/sad_mmx.asm',
    'libvpx/vp8/common/x86/sad_sse2.asm',
    'libvpx/vp8/common/x86/sad_sse3.asm',
    'libvpx/vp8/common/x86/sad_sse4.asm',
    'libvpx/vp8/common/x86/sad_ssse3.asm',
    'libvpx/vp8/common/x86/subpixel_mmx.asm',
    'libvpx/vp8/common/x86/subpixel_sse2.asm',
    'libvpx/vp8/common/x86/subpixel_ssse3.asm',
    'libvpx/vp8/common/x86/variance_impl_mmx.asm',
    'libvpx/vp8/common/x86/variance_impl_sse2.asm',
    'libvpx/vp8/common/x86/variance_impl_ssse3.asm',

    'libvpx/vp8/encoder/x86/dct_mmx.asm',
    'libvpx/vp8/encoder/x86/dct_sse2.asm',
    'libvpx/vp8/encoder/x86/encodeopt.asm',
    'libvpx/vp8/encoder/x86/fwalsh_sse2.asm',
    'libvpx/vp8/encoder/x86/quantize_mmx.asm',
    'libvpx/vp8/encoder/x86/ssim_opt_x86_64.asm',
    'libvpx/vp8/encoder/x86/subtract_mmx.asm',
    'libvpx/vp8/encoder/x86/subtract_sse2.asm',
    'libvpx/vp8/encoder/x86/temporal_filter_apply_sse2.asm',

    'libvpx/vp9/common/x86/vp9_idct_ssse3_x86_64.asm',
    'libvpx/vp9/common/x86/vp9_intrapred_ssse3.asm',
    'libvpx/vp9/common/x86/vp9_intrapred_sse2.asm',
    'libvpx/vp9/common/x86/vp9_copy_sse2.asm',
    'libvpx/vp9/common/x86/vp9_subpixel_bilinear_ssse3.asm',
    'libvpx/vp9/common/x86/vp9_subpixel_8t_ssse3.asm',
    'libvpx/vp9/common/x86/vp9_subpixel_bilinear_sse2.asm',
    'libvpx/vp9/common/x86/vp9_subpixel_8t_sse2.asm',
    'libvpx/vp9/common/x86/vp9_loopfilter_mmx.asm',

    'libvpx/vp9/encoder/x86/vp9_dct_mmx.asm',
    'libvpx/vp9/encoder/x86/vp9_dct_ssse3_x86_64.asm',
    'libvpx/vp9/encoder/x86/vp9_error_sse2.asm',
    'libvpx/vp9/encoder/x86/vp9_quantize_ssse3_x86_64.asm',
    'libvpx/vp9/encoder/x86/vp9_sad4d_sse2.asm',
    'libvpx/vp9/encoder/x86/vp9_sad_sse2.asm',
    'libvpx/vp9/encoder/x86/vp9_sad_sse3.asm',
    'libvpx/vp9/encoder/x86/vp9_sad_sse4.asm',
    'libvpx/vp9/encoder/x86/vp9_sad_ssse3.asm',
    'libvpx/vp9/encoder/x86/vp9_ssim_opt_x86_64.asm',
    'libvpx/vp9/encoder/x86/vp9_subpel_variance.asm',
    'libvpx/vp9/encoder/x86/vp9_subtract_sse2.asm',
    'libvpx/vp9/encoder/x86/vp9_temporal_filter_apply_sse2.asm',

    'libvpx/vpx_ports/x86_abi_support.asm',
    'libvpx/vpx_ports/emms.asm',
]

ASOBJS = [
    'libvpx/vp8/common/x86/dequantize_mmx.o',
    'libvpx/vp8/common/x86/idctllm_mmx.o',
    'libvpx/vp8/common/x86/idctllm_sse2.o',
    'libvpx/vp8/common/x86/iwalsh_mmx.o',
    'libvpx/vp8/common/x86/iwalsh_sse2.o',
    'libvpx/vp8/common/x86/loopfilter_block_sse2_x86_64.o',
    'libvpx/vp8/common/x86/loopfilter_mmx.o',
    'libvpx/vp8/common/x86/loopfilter_sse2.o',
    'libvpx/vp8/common/x86/mfqe_sse2.o',
    'libvpx/vp8/common/x86/postproc_mmx.o',
    'libvpx/vp8/common/x86/postproc_sse2.o',
    'libvpx/vp8/common/x86/recon_mmx.o',
    'libvpx/vp8/common/x86/recon_sse2.o',
    'libvpx/vp8/common/x86/sad_mmx.o',
    'libvpx/vp8/common/x86/sad_sse2.o',
    'libvpx/vp8/common/x86/sad_sse3.o',
    'libvpx/vp8/common/x86/sad_sse4.o',
    'libvpx/vp8/common/x86/sad_ssse3.o',
    'libvpx/vp8/common/x86/subpixel_mmx.o',
    'libvpx/vp8/common/x86/subpixel_sse2.o',
    'libvpx/vp8/common/x86/subpixel_ssse3.o',
    'libvpx/vp8/common/x86/variance_impl_mmx.o',
    'libvpx/vp8/common/x86/variance_impl_sse2.o',
    'libvpx/vp8/common/x86/variance_impl_ssse3.o',

    'libvpx/vp8/encoder/x86/dct_mmx.o',
    'libvpx/vp8/encoder/x86/dct_sse2.o',
    'libvpx/vp8/encoder/x86/encodeopt.o',
    'libvpx/vp8/encoder/x86/fwalsh_sse2.o',
    'libvpx/vp8/encoder/x86/quantize_mmx.o',
    'libvpx/vp8/encoder/x86/ssim_opt_x86_64.o',
    'libvpx/vp8/encoder/x86/subtract_mmx.o',
    'libvpx/vp8/encoder/x86/subtract_sse2.o',
    'libvpx/vp8/encoder/x86/temporal_filter_apply_sse2.o',

    'libvpx/vp9/common/x86/vp9_idct_ssse3_x86_64.o',
    'libvpx/vp9/common/x86/vp9_intrapred_ssse3.o',
    'libvpx/vp9/common/x86/vp9_intrapred_sse2.o',
    'libvpx/vp9/common/x86/vp9_copy_sse2.o',
    'libvpx/vp9/common/x86/vp9_subpixel_bilinear_ssse3.o',
    'libvpx/vp9/common/x86/vp9_subpixel_8t_ssse3.o',
    'libvpx/vp9/common/x86/vp9_subpixel_bilinear_sse2.o',
    'libvpx/vp9/common/x86/vp9_subpixel_8t_sse2.o',
    'libvpx/vp9/common/x86/vp9_loopfilter_mmx.o',

    'libvpx/vp9/encoder/x86/vp9_dct_mmx.o',
    'libvpx/vp9/encoder/x86/vp9_dct_ssse3_x86_64.o',
    'libvpx/vp9/encoder/x86/vp9_error_sse2.o',
    'libvpx/vp9/encoder/x86/vp9_quantize_ssse3_x86_64.o',
    'libvpx/vp9/encoder/x86/vp9_sad4d_sse2.o',
    'libvpx/vp9/encoder/x86/vp9_sad_sse2.o',
    'libvpx/vp9/encoder/x86/vp9_sad_sse3.o',
    'libvpx/vp9/encoder/x86/vp9_sad_sse4.o',
    'libvpx/vp9/encoder/x86/vp9_sad_ssse3.o',
    'libvpx/vp9/encoder/x86/vp9_ssim_opt_x86_64.o',
    'libvpx/vp9/encoder/x86/vp9_subpel_variance.o',
    'libvpx/vp9/encoder/x86/vp9_subtract_sse2.o',
    'libvpx/vp9/encoder/x86/vp9_temporal_filter_apply_sse2.o',

    'libvpx/vpx_ports/x86_abi_support.o',
    'libvpx/vpx_ports/emms.o',
]

cc_library(
    name = 'libvpx',
    srcs = glob(
        [
            'libvpx/vpx/src/*.c',
            'libvpx/vpx_mem/*.c',
            'libvpx/vpx_scale/*.c',
            'libvpx/vpx_scale/generic/*.c',

            'libvpx/vp8/*.c',
            'libvpx/vp8/common/x86/*.c',
            'libvpx/vp8/decoder/*.c',
            'libvpx/vp8/encoder/x86/*.c',

            'libvpx/vp9/*.c',
            'libvpx/vp9/common/x86/*.c',
            'libvpx/vp9/decoder/*.c',
            'libvpx/vp9/encoder/x86/*.c',
        ],
        [
            # XXX Disabled by configuration.
            'libvpx/vpx/src/svc_encodeframe.c',
            'libvpx/vp8/decoder/error_concealment.c',
            'libvpx/vp9/common/x86/vp9_high_loopfilter_intrin_sse2.c',
            'libvpx/vp9/encoder/x86/vp9_denoiser_sse2.c',
            'libvpx/vp9/encoder/x86/vp9_highbd_block_error_intrin_sse2.c',
            'libvpx/vp9/encoder/x86/vp9_highbd_quantize_intrin_sse2.c',
            'libvpx/vp9/encoder/x86/vp9_highbd_variance_sse2.c',
        ],
    ) + [
        # XXX Generated files that are just copied to here.
        'vpx_config.h',
        'vpx_config.c',
        'vpx_version.h',
        'vpx_scale_rtcd.h',
        'vp8_rtcd.h',
        'vp9_rtcd.h',
    ] + ASOBJS,
    copts = COPTS,
    linkopts = LINKOPTS,
    linkstatic = 1,  # XXX Why can't build .so?
)

genrule(
    name = 'assemblies',
    srcs = ASSRCS,
    outs = ASOBJS,
    tools = ['//yasm:yasm'],
    cmd = (
        'for src in $(SRCS); do ' +
        '  $(location //yasm:yasm) ' +
            ' '.join(ASOPTS) +
            ' -o $(GENDIR)/$${src%.asm}.o $${src}; ' +
        'done'
    ),
)

genrule(
    name = 'gen-vpx_version.h',
    outs = ['vpx_version.h'],
    tools = ['libvpx/build/make/version.sh'],
    cmd = '$(location libvpx/build/make/version.sh) libvpx/libvpx $@',
)
