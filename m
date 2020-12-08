Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2602D2598
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLHIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:17:14 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27BC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:16:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so11509225pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=;
        b=BWUgMeS7C73PPLQ+/D0+gd5Hbr1sRVwdsA4PlFl+qr6lchxiCLwvp0uThxF9xjeg2P
         1E7rTwr9537r3Q0QrUj8BPhZIbo/cJFwXWVfZP+9pwrwHS5Dt6lbPulUwg8mthwvEqFy
         LNSptu0B/Oaoy4RvPX6TAe6HvkArtlNM9ZHsslpfjZO5IYKtQLNo+oxvM8pBtHKiYwRp
         +w2uDImsLdEEM5c2cZAIiBPAHJzzEuC2m6LWCC8ttDZHQe/vSTgTkiUJzI25H35BnHZa
         L5Byrk/Bq6/3AV7oDzHr4d3uKTzM6Z77QZiLW6THOSPwRTc6zb9f4Fjvc8gXRi3Kqxw+
         zq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=;
        b=nobcVteDI2y/3MaBsl4MmO22NCQULP1KcpnXkJaexVM8VKwl6MwZsgjcjfybVSY9ok
         TKQR8+m2wT9QIdxO0iHAZSLnIZzgtA2c8RGUN21MYJ3AVwlPAqIol92MVZDoKF3rNMSy
         ZS/YV40dDWAkAc8MuCO+837ouIQ9qlayIz/s4D2N8/9xCRVcmV/CF6to1LP2NeqoVm4F
         x7soEotVV8kVhkqRWdf7tIbgQ8h0uBFpjx947R0HzAyCYts6ThcfCi8o3EZhA1J1rdiX
         FTXz50h8GsULShCjgwPE+RuXApO/aHqEOkOveVRRffWE9FqxN571iH3Tk+kVTIoHjP+X
         QH4g==
X-Gm-Message-State: AOAM530D2K3d6sQsZMCGduY09SUJvWFH/kUAfA9rRlwrEfW2wCZqRXA9
        pFN7nvcE2nM7SemlDrIA7N0=
X-Google-Smtp-Source: ABdhPJyAy099yWD65prigmyuRklbUEuvGo/7MOmEQKupg1xm525YnUbf9PtN53sQtco6k7/yCo+4Yg==
X-Received: by 2002:a17:90b:68e:: with SMTP id m14mr3156632pjz.228.1607415394346;
        Tue, 08 Dec 2020 00:16:34 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id d4sm2093574pjz.28.2020.12.08.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:16:33 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH v3 3/3] f2fs-tools:sload.f2fs compress: Fixed automake
Date:   Tue,  8 Dec 2020 16:15:55 +0800
Message-Id: <20201208081555.652932-4-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208081555.652932-1-robinh3123@gmail.com>
References: <20201208081555.652932-1-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Fixed automake for sload.f2fs compression support

./configure automatcally compile in liblzo2 (for sload to support -a LZO)
and liblz4 (for sload to support -a LZ4), whhen the libraries present.

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 configure.ac     | 12 ++++++++++++
 fsck/Makefile.am |  9 ++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1e5619d..01d1a05 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,18 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
        [$PATH:/sbin])
 
 # Checks for libraries.
+AC_CHECK_LIB([lzo2], [main],
+	[AC_SUBST([liblzo2_LIBS], ["-llzo2"])
+		AC_DEFINE([HAVE_LIBLZO2], [1],
+		[Define if you have liblzo2])
+	], [], [])
+
+AC_CHECK_LIB([lz4], [main],
+	[AC_SUBST([liblz4_LIBS], ["-llz4"])
+		AC_DEFINE([HAVE_LIBLZ4], [1],
+		[Define if you have liblz4])
+	], [], [])
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

