Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E522D0AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 07:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLGGoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 01:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgLGGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:44:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00454C0613D4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 22:43:42 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b26so8827212pfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqbax5Dbv5yNKE4iF+gv9rom4MxEy1t7FeY7u7rK6r8=;
        b=cN+6nwPn6B7ucFgkKVAlTbfUqzFRvR/lhJrFajfA1g+nEuikU3wsc+hB3jKhoZ+9cp
         7rvUHj8vBcmVCkne7jaNXkaz9VU0b9vQEjs/kYxoRG0TARu1XhxKJwv6gD0O+1Nmn4D5
         44p0b5GhuDDKbBay4Z+iQe4VqowErcwB2FrzV0KmgBcBHH4iUpBxWTkgUHAV3AWs3BoF
         4oG5V6+vlSOKKtBo4TPQojMBBLZ23kk0M0+KlSyI+hQ0CDtrg17pxB8vHYnszbPw3rx7
         n53o1pn8bbDPUGcHDYonu02d7W0TR0UnyLr1tnIVDDhkmXABS43Ivp5aEgu04aEx7tBk
         l/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqbax5Dbv5yNKE4iF+gv9rom4MxEy1t7FeY7u7rK6r8=;
        b=WNsU1WW7+RLlEXftDahcaK84em+i1X1SKRpZQMd+R2lXnb4vN4FyYktrsUa29tseQq
         IYET6HONnNXlIPg6FmvfsezrOdvf4Q3dU481LvjU1DZBg0ewN/BRoIxrHweAcqxMgLdf
         mBkvyKh7Izwrbc64kt0LOtme5NEAF3gCTEl3Osera3fhgmcGr6QRuwI0uBz8ZweJ/Vuy
         Fk287xuvWohELD+BK3gWE8eihFdxTiAZUvTw9/XQ0awKuHVs2cqA9Rtb3xqGg/cDVjy8
         GRgAUvcw/LqMat0vDP7lgWn9UbsvuwzUC+F8nNwTkIawIGAh3u2pC7HpjtmjSlcIhPEn
         Qw6A==
X-Gm-Message-State: AOAM5326O6OYJCliUxveSMKAThgzsFwr03E6HhVfssf8wc1xt1NkCf3X
        SfFLhZnrWYSZ9OwM7YN1TJM=
X-Google-Smtp-Source: ABdhPJzJwn5CVHyaRWkeYIswJgrj2NG64VIjXmkaMIY9sAP8Vis9NrJmmGMOnl5KBxQ5DfavM9EQCA==
X-Received: by 2002:a17:902:b209:b029:d8:e7a4:bf10 with SMTP id t9-20020a170902b209b02900d8e7a4bf10mr14910473plr.77.1607323422577;
        Sun, 06 Dec 2020 22:43:42 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id o9sm9079984pjl.11.2020.12.06.22.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 22:43:42 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v2 3/3] f2fs-tools:sload.f2fs compress: Fixed automake
Date:   Mon,  7 Dec 2020 14:42:50 +0800
Message-Id: <20201207064250.272240-4-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201207064250.272240-1-robinh3123@gmail.com>
References: <20201207064250.272240-1-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Fixed automake for sload.f2fs compression support

./configure now will by default depends on liblzo2 and liblz4.

To compile without liblzo2 (and thus not support liblzo2 compression),
run ./configure with '--without-lzo2' option.

To compile without liblz4 (and thus not support liblz4 compression),
run ./configure with '--without-lz4' option.

Test: Build with automake OK on glinux
Bug: 170918502
Signed-off-by: Robin Hsu <robinhsu@google.com>
Change-Id: I25d339e4cab4ca196781da89fc3df3e13f869234
---
 configure.ac     | 32 ++++++++++++++++++++++++++++++++
 fsck/Makefile.am |  9 ++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1e5619d..3a357b2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,6 +44,14 @@ AC_ARG_WITH([blkid],
 	AS_HELP_STRING([--without-blkid],
 	  [Ignore presence of libblkid and disable blkid support]))
 
+AC_ARG_WITH([lzo2],
+	AS_HELP_STRING([--without-lzo2],
+	  [Ignore liblzo ver.2 for sload (not supporting lzo compression)]))
+
+AC_ARG_WITH([lz4],
+	AS_HELP_STRING([--without-lz4],
+	  [Ignore liblz4 for sload (not supporting lz4 compression)]))
+
 # Checks for programs.
 AC_PROG_CC
 AC_PROG_LIBTOOL
@@ -52,6 +60,30 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
        [$PATH:/sbin])
 
 # Checks for libraries.
+AS_IF([test "x$with_lzo2" != xno],
+            [AC_CHECK_LIB([lzo2], [main],
+              [AC_SUBST([liblzo2_LIBS], ["-llzo2"])
+               AC_DEFINE([HAVE_LIBLZO2], [1],
+                         [Define if you have liblzo2])
+              ],
+              [if test "x$with_lzo2" != xcheck; then
+                 AC_MSG_FAILURE(
+                   [--with-lzo2 was given (or by default), but test for liblzo2 failed])
+               fi
+              ], [])])
+
+AS_IF([test "x$with_lz4" != xno],
+            [AC_CHECK_LIB([lz4], [main],
+              [AC_SUBST([liblz4_LIBS], ["-llz4"])
+               AC_DEFINE([HAVE_LIBLZ4], [1],
+                         [Define if you have liblz4])
+              ],
+              [if test "x$with_lz4" != xcheck; then
+                 AC_MSG_FAILURE(
+                   [--with-lz4 was given (or by default), but test for liblz4 failed])
+               fi
+              ], [])])
+
 PKG_CHECK_MODULES([libuuid], [uuid])
 
 AS_IF([test "x$with_selinux" != "xno"],
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 1fc7310..74bc4b8 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -3,12 +3,15 @@
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
 sbin_PROGRAMS = fsck.f2fs
-noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h quotaio_tree.h quotaio_v2.h xattr.h
+noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h \
+		quotaio_tree.h quotaio_v2.h xattr.h compress_wrapper.h
 include_HEADERS = $(top_srcdir)/include/quota.h
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c resize.c \
-		node.c segment.c dir.c sload.c xattr.c \
+		node.c segment.c dir.c sload.c xattr.c compress_wrapper.c \
 		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c
-fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
+fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} \
+	${liblzo2_LIBS} ${liblz4_LIBS} \
+	$(top_builddir)/lib/libf2fs.la
 
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
-- 
2.29.2.576.ga3fc446d84-goog

