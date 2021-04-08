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

load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

licenses(["notice"])

genrule(
    name = "debian_nginx_preinst",
    srcs = [
        "debian/nginx.preinst",
    ],
    outs = [
        "nginx.preinst",
    ],
    cmd = "sed -e 's|#DEBHELPER#||g'" +
          " < $(<) > $(@)",
)

filegroup(
    name = "debian_preinst",
    srcs = [
        "nginx.preinst",
    ],
    visibility = [
        "//visibility:public",
    ],
)

genrule(
    name = "debian_nginx_postinst",
    srcs = [
        "debian/nginx.postinst",
    ],
    outs = [
        "nginx.postinst",
    ],
    cmd = "sed -e 's|#DEBHELPER#|" +
          "if [ -x \"/etc/init.d/nginx\" ]; then\\n" +
          "\\tupdate-rc.d nginx defaults >/dev/null \\|\\| exit $$?\\n" +
          "fi\\n" +
          "|g'" +
          " < $(<) > $(@)",
)

filegroup(
    name = "debian_postinst",
    srcs = [
        "nginx.postinst",
    ],
    visibility = [
        "//visibility:public",
    ],
)

genrule(
    name = "debian_nginx_prerm",
    srcs = [
        "debian/nginx.prerm",
    ],
    outs = [
        "nginx.prerm",
    ],
    cmd = "sed -e 's|#DEBHELPER#||g'" +
          " < $(<) > $(@)",
)

filegroup(
    name = "debian_prerm",
    srcs = [
        "nginx.prerm",
    ],
    visibility = [
        "//visibility:public",
    ],
)

genrule(
    name = "debian_nginx_postrm",
    srcs = [
        "debian/nginx.postrm",
    ],
    outs = [
        "nginx.postrm",
    ],
    cmd = "sed -e 's|#DEBHELPER#|" +
          "if [ \"$$1\" = \"purge\" ] ; then\\n" +
          "\\tupdate-rc.d nginx remove >/dev/null\\n" +
          "fi\\n" +
          "\\n" +
          "if [ -d /run/systemd/system ] ; then\\n" +
          "\\tsystemctl --system daemon-reload >/dev/null \\|\\| true\\n" +
          "fi\\n" +
          "|g'" +
          " < $(<) > $(@)",
)

filegroup(
    name = "debian_postrm",
    srcs = [
        "nginx.postrm",
    ],
    visibility = [
        "//visibility:public",
    ],
)

genrule(
    name = "debian_etc_default_nginx",
    srcs = [
        "debian/nginx.default",
    ],
    outs = [
        "etc/default/nginx",
    ],
    cmd = "cp -p $(<) $(@)",
)

genrule(
    name = "debian_etc_init_d_nginx",
    srcs = [
        "debian/nginx.init.in",
    ],
    outs = [
        "etc/init.d/nginx",
    ],
    cmd = "sed -e 's|%%PROVIDES%%|nginx|g'" +
          " -e 's|%%DEFAULTSTART%%|2 3 4 5|g'" +
          " -e 's|%%DEFAULTSTOP%%|0 1 6|g'" +
          " < $(<) > $(@)",
)

genrule(
    name = "debian_etc_logrotate_d_nginx",
    srcs = [
        "debian/nginx.logrotate",
    ],
    outs = [
        "etc/logrotate.d/nginx",
    ],
    cmd = "cp -p $(<) $(@)",
)

genrule(
    name = "debian_etc_nginx_conf_d_default_conf",
    srcs = [
        "debian/nginx.vh.default.conf",
    ],
    outs = [
        "etc/nginx/conf.d/default.conf",
    ],
    cmd = "cp -p $(<) $(@)",
)

genrule(
    name = "debian_etc_nginx_nginx_conf",
    srcs = [
        "debian/nginx.conf",
    ],
    outs = [
        "etc/nginx/nginx.conf",
    ],
    cmd = "cp -p $(<) $(@)",
)

genrule(
    name = "debian_usr_share_man_man8_nginx_8",
    srcs = [
        "@nginx//:docs/man/nginx.8",
    ],
    outs = [
        "usr/share/man/man8/nginx.8",
    ],
    cmd = "sed -e 's|%%PREFIX%%|/etc/nginx|g'" +
          " -e 's|%%CONF_PATH%%|/etc/nginx/nginx.conf|g'" +
          " -e 's|%%ERROR_LOG_PATH%%|/var/log/nginx/error.log|g'" +
          " -e 's|%%PID_PATH%%|/var/run/nginx.pid|g'" +
          " < $(<) > $(@)",
)

genrule(
    name = "debian_var_cache_nginx",
    outs = [
        "var/cache/nginx/.empty",
    ],
    cmd = "touch $(@)",
)

genrule(
    name = "debian_var_log_nginx",
    outs = [
        "var/log/nginx/.empty",
    ],
    cmd = "touch $(@)",
)

pkg_tar(
    name = "debian_etc_nginx",
    srcs = [
        "@nginx//:config_includes",
    ],
    mode = "0644",
    package_dir = "/etc/nginx",
)

pkg_tar(
    name = "debian_usr_share_nginx_html",
    srcs = [
        "@nginx//:html_files",
    ],
    mode = "0644",
    package_dir = "/usr/share/nginx/html",
)

pkg_tar(
    name = "debian_var",
    srcs = [
        "var/cache/nginx/.empty",
        "var/log/nginx/.empty",
    ],
    mode = "0644",
    strip_prefix = ".",
)

pkg_tar(
    name = "debian_overlay",
    srcs = [
        "etc/default/nginx",
        "etc/init.d/nginx",
        "etc/logrotate.d/nginx",
        "etc/nginx/conf.d/default.conf",
        "etc/nginx/nginx.conf",
        "usr/share/man/man8/nginx.8",
    ],
    mode = "0644",
    modes = {
        "etc/init.d/nginx": "0755",
    },
    strip_prefix = ".",
    visibility = [
        "//visibility:public",
    ],
    deps = [
        ":debian_etc_nginx",
        ":debian_usr_share_nginx_html",
        ":debian_var",
    ],
)
