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

load(
    "@bazel_tools//tools/build_defs/repo:git.bzl",
    "git_repository",
    "new_git_repository",
)
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def nginx_repositories():
    # packaging
    new_git_repository(
        name = "nginx_pkgoss",
        build_file = "@nginx//bazel/external:nginx_pkgoss.BUILD",
        commit = "bf9b800b2fc3a037afeb64034e9bf942d1773109",  # nginx-1.21.4
        remote = "https://nginx.googlesource.com/nginx-pkgoss",
        shallow_since = "1635865333 +0300",
    )

    http_archive(
        name = "rules_pkg",
        sha256 = "038f1caa773a7e35b3663865ffb003169c6a71dc995e39bf4815792f385d837d",
        url = "https://github.com/bazelbuild/rules_pkg/releases/download/0.4.0/rules_pkg-0.4.0.tar.gz",
    )

    # BoringSSL
    git_repository(
        name = "boringssl",
        commit = "b9232f9e27e5668bc0414879dcdedb2a59ea75f2",  # 2021-11-24
        remote = "https://boringssl.googlesource.com/boringssl",
        shallow_since = "1637714942 +0000",
    )

    # PCRE
    http_archive(
        name = "pcre",
        build_file = "@nginx//bazel/external:pcre.BUILD",
        sha256 = "aecafd4af3bd0f3935721af77b889d9024b2e01d96b58471bd91a3063fb47728",
        strip_prefix = "pcre-8.44",
        url = "https://downloads.sourceforge.net/project/pcre/pcre/8.44/pcre-8.44.tar.gz",
    )

    # zlib
    http_archive(
        name = "zlib",
        build_file = "@nginx//bazel/external:zlib.BUILD",
        sha256 = "91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9",
        strip_prefix = "zlib-1.2.12",
        url = "https://zlib.net/zlib-1.2.12.tar.gz",
    )

    # ngx_brotli + dependencies
    new_git_repository(
        name = "ngx_brotli",
        build_file = "@nginx//bazel/external:ngx_brotli.BUILD",
        commit = "5ead1ada782b18c7b38a3c2798a40a334801c7b6",  # 2016-12-05
        remote = "https://nginx.googlesource.com/ngx_brotli",
        shallow_since = "1480976257 +0000",
    )

    git_repository(
        name = "org_brotli",
        commit = "222564a95d9ab58865a096b8d9f7324ea5f2e03e",  # 2016-12-02
        remote = "https://github.com/google/brotli.git",
        shallow_since = "1480681940 +0100",
    )
