# Copyright (C) 2015-2021 Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

load("@rules_cc//cc:defs.bzl", "cc_library")

licenses(["notice"])

exports_files(["LICENCE"])

genrule(
    name = "config_h",
    srcs = [
        "config.h.generic",
    ],
    outs = [
        "config.h",
    ],
    cmd = "cp -p $(<) $(@)",
)

genrule(
    name = "pcre_h",
    srcs = [
        "pcre.h.generic",
    ],
    outs = [
        "pcre.h",
    ],
    cmd = "cp -p $(<) $(@)",
)

genrule(
    name = "pcre_chartables_c",
    srcs = [
        "pcre_chartables.c.dist",
    ],
    outs = [
        "pcre_chartables.c",
    ],
    cmd = "cp -p $(<) $(@)",
)

cc_library(
    name = "sljit",
    srcs = [
        "sljit/sljitConfig.h",
        "sljit/sljitConfigInternal.h",
        "sljit/sljitLir.h",
    ],
    hdrs = [
        "sljit/sljitExecAllocator.c",
        "sljit/sljitLir.c",
        "sljit/sljitNativeX86_64.c",
        "sljit/sljitNativeX86_common.c",
        "sljit/sljitUtils.c",
    ],
)

cc_library(
    name = "pcre",
    srcs = [
        "config.h",
        "pcre_byte_order.c",
        "pcre_chartables.c",
        "pcre_compile.c",
        "pcre_config.c",
        "pcre_dfa_exec.c",
        "pcre_exec.c",
        "pcre_fullinfo.c",
        "pcre_get.c",
        "pcre_globals.c",
        "pcre_internal.h",
        "pcre_jit_compile.c",
        "pcre_maketables.c",
        "pcre_newline.c",
        "pcre_ord2utf8.c",
        "pcre_refcount.c",
        "pcre_study.c",
        "pcre_tables.c",
        "pcre_ucd.c",
        "pcre_valid_utf8.c",
        "pcre_version.c",
        "pcre_xclass.c",
        "ucp.h",
    ],
    hdrs = [
        "pcre.h",
    ],
    copts = [
        "-DHAVE_CONFIG_H",
        "-DHAVE_MEMMOVE",
        "-DHAVE_STDINT_H",
        "-DNO_RECURSE",
        "-DSUPPORT_JIT",
        "-DSUPPORT_PCRE8",
        "-DSUPPORT_UCP",
        "-DSUPPORT_UTF",
        "-Wno-maybe-uninitialized",
        "-Wno-unknown-warning-option",
    ],
    includes = [
        ".",
    ],
    visibility = [
        "//visibility:public",
    ],
    deps = [
        ":sljit",
    ],
)
