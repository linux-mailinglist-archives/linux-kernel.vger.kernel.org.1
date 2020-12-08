Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7572D2589
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgLHIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgLHIPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:15:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0ACC061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:14:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so6592810plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=;
        b=pwpBCMF7Ac589F0MWudfWG4J+an8qdcMMOsk0y9sgAoZarcFOYz8DrfioDizcINnOT
         7pOvQlqWZg8T6tGF+YsQ4xMUkKPEVbbJ4tpd42ELM/9PtVfTTj9l16wvIU/TqaYY0/gA
         mMN1G4EHG9fQTICKsAhVYuBAPaVQEA3lzjTeoCOA9p2IiLkG6FjSiv/1UutWpjwZ8dHO
         X1QLEWdcWCTfc/Yt6B/TUgW24EpKhB9pYv3ysNuXKwFGeemzinErYjz9s+71mnLioFwc
         pmaijRgmPQehqjO+c2UwgoJWBmISmgX2yeYJLwjdevljYvKnOzfKyE84dRrC70Q/bWKA
         dZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=;
        b=SvbiT+54esegF17JI29goO8OvUazVXDpqFG38R9JkPF3pbYYNLNAKW3oQgnEV/dt+a
         Ng9pvih4jMi3XL2muSD7lCR3ghY/ookzHJ0OE4gl+CG4YJyJiHA1vEgeHLeisf6LsmVj
         3hEhofXNa4XFC+MkjmSzbDllvx/qY5IhQv82HHUrUnQXFu03wtul4Ar2OxGICt2WwVle
         pVQglg/KtfA6l+v/y5LPrhJyJpvrW/f9d6aeKma6uavQ38HfjSWrQLYnXPmTLzxLhqle
         X6JgM1l53yvwr+NQc9+uCw1fDjFa7o4/+T8r65JJ5r9pNCFOUaV1LWZMMmWrA+RBrZlT
         OMdA==
X-Gm-Message-State: AOAM531CfV51YjB5Z0VyaTP2mNLikjC1gb3uPu1OW8kC3LHk5u8p6l2P
        /2X7NHB/6UxBP9Mogtx78UY=
X-Google-Smtp-Source: ABdhPJwaUxxTgog3OXfOln84McY3YXKOUbbMLj8G6MGMSX3lgwUOYCqXLjNNBRPTyLr5s68ommc2Ag==
X-Received: by 2002:a17:902:d385:b029:da:c6e4:5cab with SMTP id e5-20020a170902d385b02900dac6e45cabmr20235431pld.7.1607415290168;
        Tue, 08 Dec 2020 00:14:50 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id 19sm2665387pfu.85.2020.12.08.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:14:49 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH 3/3] f2fs-tools:sload.f2fs compress: Fixed automake
Date:   Tue,  8 Dec 2020 16:13:44 +0800
Message-Id: <20201208081344.652430-4-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208081344.652430-1-robinh3123@gmail.com>
References: <20201208081344.652430-1-robinh3123@gmail.com>
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

