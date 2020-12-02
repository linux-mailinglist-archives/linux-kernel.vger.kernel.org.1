Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB102CB1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgLBA6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLBA6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:58:43 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED410C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 16:58:02 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o4so32557pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8Dqx64NtmWE/rcfljGWWSOnLh5E2fpRKEuO+95a5Mw=;
        b=R4tZgus2TolOesFRuuT6Jjb5JWsdoXO4wMxobsSJTb8kf0yphnYFU1hza/hCdkhQ/d
         LFq4X3RmrruWoICQ7GkTLCEkpM/l0DPyg8IZMLyj9Gm5XvqLN5yLUY7nmlTLrk+Lo7Jl
         7hHlMmndG/0H4SHV3NgdyP/h8r67Vt6JbEyTWl+SqjuHslfiJVpeAPjoUKLx1U47+rTy
         IZ3ZPVwaNyenOQt6kKdR8t+BHwhxscDxW0gETHwaXNSycOxqi+EG9CAMBS35FJBn0HeD
         XmItne9sitScBGWDZEt+rWh4axdMQWMX5FnBTQDkYfgedxnMykl3k1aGJDp6djy2ud+O
         8IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8Dqx64NtmWE/rcfljGWWSOnLh5E2fpRKEuO+95a5Mw=;
        b=rQwBBvKXowri9nYFF/SS/X5yojti24toq6cew7tYmCc8KA3YgACuT+8fMn/dUQIUJP
         tD0u6h8uL+u1JeMQHr4hORZ79NW5g6EoLYqYi1NmpzXw6a4/P00silIKSSePx9ICCgNq
         T64VKkimFFQuOhLS0OMNllcCtyVEQsvAXtY4m6mc3jtANI9UhHL6Yz1+FXB6wx+6zNXu
         GIoEfr8AzMxD/an+GiUtb+Uaf35UaGZKX2MhbVoXSf6iXKXsgb/AC6sWT3nFWlmYoqWN
         njuTJLtFRiwRIHf6NqHM2FyaDCa3f5VWO7KOeZxPs84/sIxL/+XR71/9aLNhdyiao4Xx
         5/Zw==
X-Gm-Message-State: AOAM530lCv+curg2xuSYlf1RqidAk63yNGOYA95xHjwXgifHqnxiDMsf
        SLO3gOH3kbdp+0dW6fSqxMk=
X-Google-Smtp-Source: ABdhPJwIK6+WSHA8JoySjXhZByAYfzH8jZKoYpm78uaROn55/IEnmMyfyzTNxD/2mllhcbVVB9TMJA==
X-Received: by 2002:aa7:9315:0:b029:18b:6372:d43e with SMTP id 21-20020aa793150000b029018b6372d43emr132090pfj.2.1606870682552;
        Tue, 01 Dec 2020 16:58:02 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id gz2sm116974pjb.2.2020.12.01.16.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 16:58:02 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH 3/3] f2fs-tools:sload.f2fs compress: Fixed automake
Date:   Wed,  2 Dec 2020 08:57:24 +0800
Message-Id: <20201202005724.691458-4-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202005724.691458-1-robinh3123@gmail.com>
References: <20201202005724.691458-1-robinh3123@gmail.com>
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

Signed-off-by: Robin Hsu <robinhsu@google.com>
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
2.29.2.454.gaff20da3a2-goog

