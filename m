Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078D72F6040
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbhANLhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbhANLhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:14 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC39C06179E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x18so2764727pln.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K53rIUWFg+2NzMpnNP/wzeIo2pw3X/PtpyXjjqm6X/A=;
        b=yha5Sz7nrBOViBAUVVawiHrRfg7B0X6DVDhFqk/rTaSzFzSDjdbt60VG1Ti9mbUg0C
         MuXQdHMPnzu9sTUW57+4FXGQu0jY0XygLy7vSOMsA79LE9WnmeDGxiNZlyYIrQs+uu4/
         Bi92yjJVJyrIy2Rn/1p3NrLfRib7aKX4X4/dgdQGYh4gJw0pss4jAx0+yK5bt9EN3oSZ
         wbhaQ0o4025GjZqU+da/+0cToWRVVpVVOxRM+baVJQZAYRAHT8nrLltqzjd7ksX4uyWI
         5lVOUidpWjZ90eZnZOMX/bgoKBiW9owFi++iVdSS1WPHhek9A9HSh+JrP5Rjaw1DobfM
         z8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K53rIUWFg+2NzMpnNP/wzeIo2pw3X/PtpyXjjqm6X/A=;
        b=SUowqjFSLee98UAtSg60ERu6zLRDblfex/630tj20qZaCP08oG/9cL7dr7UheBw6YO
         XGGVxy1ep8tMzxP9JqaaPnwjdNgqv1arMtBblKco58v3/OSh6h1LPpwDqLckeY0FMI/o
         pjPYdFGB0sNxllra5gy5ntKoN6DYKFzc+P/OoajJxJmn2hPUmjOjbkCFLxo47apqnxMX
         bpDc6mqlkngRqouEroU8Qi5FdZyWvBX9RUt2tTcGcMc6VP6NQh8E1I/8QPBYFoqfpJlA
         9lfYMshnbue/GTRpT31YWnzRPc1cQvhYRymcPpXvzWqq1QhvmQIBswtOt5qJd0gcsZSL
         Au4A==
X-Gm-Message-State: AOAM5302KiPe0BGbrJKzGF92siEjp4vG5UcoJVIgCrVuFwR3nhueBs+s
        ickOdqSbWx39LS/HAPJQ+6jP6w==
X-Google-Smtp-Source: ABdhPJyrhQSFTRly6eOnUfGEEGNcN9Mp6TDf4H+ZJZfpCZV+Ixo+RcxAdTtUVRtYMi7nHjuWFGAVwA==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr1003624pjv.7.1610624183140;
        Thu, 14 Jan 2021 03:36:23 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id h5sm5618766pgl.86.2021.01.14.03.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:36:22 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] arch: s390: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:25 +0530
Message-Id: <d898acaf9320125e9c23b18a16ecd88d70f24170.1610622251.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610622251.git.viresh.kumar@linaro.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "oprofile" user-space tools don't use the kernel OPROFILE support
any more, and haven't in a long time. User-space has been converted to
the perf interfaces.

Remove the old oprofile's architecture specific support.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/s390/Kconfig                 |  1 -
 arch/s390/Makefile                |  3 ---
 arch/s390/configs/debug_defconfig |  1 -
 arch/s390/configs/defconfig       |  1 -
 arch/s390/oprofile/Makefile       | 10 ---------
 arch/s390/oprofile/init.c         | 37 -------------------------------
 6 files changed, 53 deletions(-)
 delete mode 100644 arch/s390/oprofile/Makefile
 delete mode 100644 arch/s390/oprofile/init.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c72874f09741..f84444ef3860 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -174,7 +174,6 @@ config S390
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_NOP_MCOUNT
-	select HAVE_OPROFILE
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 8db267d2a543..e443ed9947bd 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -134,9 +134,6 @@ core-y		+= arch/s390/
 libs-y		+= arch/s390/lib/
 drivers-y	+= drivers/s390/
 
-# must be linked after kernel
-drivers-$(CONFIG_OPROFILE)	+= arch/s390/oprofile/
-
 boot		:= arch/s390/boot
 syscalls	:= arch/s390/kernel/syscalls
 tools		:= arch/s390/tools
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index c4f6ff98a612..8b94347705e5 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -57,7 +57,6 @@ CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
 CONFIG_S390_UNWIND_SELFTEST=y
-CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_STATIC_KEYS_SELFTEST=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 51135893cffe..9db1232e09f4 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -55,7 +55,6 @@ CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_KVM=m
 CONFIG_S390_UNWIND_SELFTEST=m
-CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 # CONFIG_GCC_PLUGINS is not set
diff --git a/arch/s390/oprofile/Makefile b/arch/s390/oprofile/Makefile
deleted file mode 100644
index 36261f9d360b..000000000000
--- a/arch/s390/oprofile/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o  \
-		timer_int.o )
-
-oprofile-y :=	$(DRIVER_OBJS) init.o
diff --git a/arch/s390/oprofile/init.c b/arch/s390/oprofile/init.c
deleted file mode 100644
index 7441857df51b..000000000000
--- a/arch/s390/oprofile/init.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * S390 Version
- *   Copyright IBM Corp. 2002, 2011
- *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
- *   Author(s): Mahesh Salgaonkar (mahesh@linux.vnet.ibm.com)
- *   Author(s): Heinz Graalfs (graalfs@linux.vnet.ibm.com)
- *   Author(s): Andreas Krebbel (krebbel@linux.vnet.ibm.com)
- *
- * @remark Copyright 2002-2011 OProfile authors
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <asm/processor.h>
-#include <asm/unwind.h>
-
-static void s390_backtrace(struct pt_regs *regs, unsigned int depth)
-{
-	struct unwind_state state;
-
-	unwind_for_each_frame(&state, current, regs, 0) {
-		if (depth-- == 0)
-			break;
-		oprofile_add_trace(state.ip);
-	}
-}
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	ops->backtrace = s390_backtrace;
-	return 0;
-}
-
-void oprofile_arch_exit(void)
-{
-}
-- 
2.25.0.rc1.19.g042ed3e048af

