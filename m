Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2E2D15E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgLGQYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgLGQYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:24:16 -0500
Date:   Mon, 7 Dec 2020 08:23:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607358215;
        bh=RtjDqwhG7C9VhOOl+aSC4bpaP4bWy/pDESZGvoZx9zU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=DU++70I+51+gNFDYK6kI4FDLSxpKQIioYgO98XUgQD5TEitNO8fdoO6ZTJvlt/1/W
         p098+X1lEHR6GVBVarJB9paZJikaNWVh9rC9zVEOnF+38dt7Cb1DVavSB3d4Ou94Lv
         006HQuqQMKuB1t4xq9n7jvVjFRadF035QrAsnLtr19qUgWftR3pj/UUTq3AvIs1Hym
         apmeZ0zxAs9vRgvpqBojlDjk/diVfwzykjYg6t3wsQz9fbFC7g/cbazu07923RBEKI
         dLWNhiGeS/dEfhyC3uIsO3x3y69Ux7EVAFWzUmsn/F3O/o8RYgp+0G+SG6wGe1fmvi
         xEQpVuRG7eSQg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Robin Hsu <robinh3123@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
        linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: Re: [PATCH v2 3/3] f2fs-tools:sload.f2fs compress: Fixed automake
Message-ID: <X85XBTIuQghbh7Cw@google.com>
References: <20201207064250.272240-1-robinh3123@gmail.com>
 <20201207064250.272240-4-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207064250.272240-4-robinh3123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Robin Hsu wrote:
> From: Robin Hsu <robinhsu@google.com>
> 
> Fixed automake for sload.f2fs compression support
> 
> ./configure now will by default depends on liblzo2 and liblz4.
> 
> To compile without liblzo2 (and thus not support liblzo2 compression),
> run ./configure with '--without-lzo2' option.
> 
> To compile without liblz4 (and thus not support liblz4 compression),
> run ./configure with '--without-lz4' option.
> 
> Test: Build with automake OK on glinux
> Bug: 170918502
> Signed-off-by: Robin Hsu <robinhsu@google.com>
> Change-Id: I25d339e4cab4ca196781da89fc3df3e13f869234
> ---
>  configure.ac     | 32 ++++++++++++++++++++++++++++++++
>  fsck/Makefile.am |  9 ++++++---
>  2 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 1e5619d..3a357b2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -44,6 +44,14 @@ AC_ARG_WITH([blkid],
>  	AS_HELP_STRING([--without-blkid],
>  	  [Ignore presence of libblkid and disable blkid support]))
>  
> +AC_ARG_WITH([lzo2],
> +	AS_HELP_STRING([--without-lzo2],
> +	  [Ignore liblzo ver.2 for sload (not supporting lzo compression)]))
> +
> +AC_ARG_WITH([lz4],
> +	AS_HELP_STRING([--without-lz4],
> +	  [Ignore liblz4 for sload (not supporting lz4 compression)]))
> +
>  # Checks for programs.
>  AC_PROG_CC
>  AC_PROG_LIBTOOL
> @@ -52,6 +60,30 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
>         [$PATH:/sbin])
>  
>  # Checks for libraries.
> +AS_IF([test "x$with_lzo2" != xno],
> +            [AC_CHECK_LIB([lzo2], [main],
> +              [AC_SUBST([liblzo2_LIBS], ["-llzo2"])
> +               AC_DEFINE([HAVE_LIBLZO2], [1],
> +                         [Define if you have liblzo2])
> +              ],
> +              [if test "x$with_lzo2" != xcheck; then
> +                 AC_MSG_FAILURE(
> +                   [--with-lzo2 was given (or by default), but test for liblzo2 failed])
> +               fi
> +              ], [])])
> +
> +AS_IF([test "x$with_lz4" != xno],
> +            [AC_CHECK_LIB([lz4], [main],
> +              [AC_SUBST([liblz4_LIBS], ["-llz4"])
> +               AC_DEFINE([HAVE_LIBLZ4], [1],
> +                         [Define if you have liblz4])
> +              ],
> +              [if test "x$with_lz4" != xcheck; then
> +                 AC_MSG_FAILURE(
> +                   [--with-lz4 was given (or by default), but test for liblz4 failed])
> +               fi
> +              ], [])])
> +

Please don't bother users to be aware of libraries only for sload.f2fs using
compression.

>  PKG_CHECK_MODULES([libuuid], [uuid])
>  
>  AS_IF([test "x$with_selinux" != "xno"],
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> index 1fc7310..74bc4b8 100644
> --- a/fsck/Makefile.am
> +++ b/fsck/Makefile.am
> @@ -3,12 +3,15 @@
>  AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
>  AM_CFLAGS = -Wall
>  sbin_PROGRAMS = fsck.f2fs
> -noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h quotaio_tree.h quotaio_v2.h xattr.h
> +noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h \
> +		quotaio_tree.h quotaio_v2.h xattr.h compress_wrapper.h
>  include_HEADERS = $(top_srcdir)/include/quota.h
>  fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c resize.c \
> -		node.c segment.c dir.c sload.c xattr.c \
> +		node.c segment.c dir.c sload.c xattr.c compress_wrapper.c \
>  		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c
> -fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
> +fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} \
> +	${liblzo2_LIBS} ${liblz4_LIBS} \
> +	$(top_builddir)/lib/libf2fs.la
>  
>  install-data-hook:
>  	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
> -- 
> 2.29.2.576.ga3fc446d84-goog
