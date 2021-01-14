Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198652F6050
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbhANLh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbhANLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:52 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56758C0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so2763024plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MDUnINPotxk6emPsj6PbUHP5VPQPTHck3Pu0D9eg84=;
        b=lStatDlVlBiaLQAoKo2ozg/OqQ93WMd7po2EbL3XMyqbsNVmyOs1COPnszzPkGlHWH
         S6s10VLKHodM9gKDyB6oZ8VjgYarb7I9610jUYduNoV1Auudb1uTxss/kzFElGbokEXP
         WpeLkt67RKtJRlYxgR4tN3deDX2OXi0f6k9+GHEHyU9PZbv1tmrf2uOx7Vr9NJr7/tV7
         U+vM5DR4eIXsDtQtvVD+jXHGUxS50o2L/dEF4ibXTjt2HBUCIVIjGPTjnPwuyCQKSAkR
         9edGpBchaHJm9IGF4IOdA6XIrQmZnd8RYfziDE9R0FxeTqZhSqLpEqC8IgVYghfYuBdi
         p6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MDUnINPotxk6emPsj6PbUHP5VPQPTHck3Pu0D9eg84=;
        b=CFbUkLitG3U6dcCKCWfkJvF+yo1V4Zf1bK+7jBQFEt4NZp24PFtPUm0PfkXn3hHMXJ
         laC4/DxiwRKu4pgZeCo38ZjoT+hP4YHxwD1CwdcEjOLzRFG03rKMxjZbfO59aBnDuuDs
         xNX/bP7CuWaZvQ15hk8/TYoEqY4er/0eOvoPWUAWpkxUKi2repKMgvk1FTfhldHbp12h
         bGiUKuGhwIY6CXoo1miD0QqnzyCAcbwW7OUXh6Qtst2rCGnPal2/3E1EuG+NTZDn/Bse
         YMAmApat291AAxHXLCFrcrILLN6QD9PXlVfrs6t0YEFq2Nv9/tjl8Su7mddN8aI9nfll
         b56Q==
X-Gm-Message-State: AOAM532m3KBkZDiOBeUj4gN1Xw/SIv5fCoX3OTbENqOz58QQsWRoNVRA
        nUDynVGOBgHue5IICvojyFrCvw==
X-Google-Smtp-Source: ABdhPJzd/6v86ISzOE2MR40FYKipTFHdwvHKLoi3cMheh1dv6FVseZFkm5irzTwWnKg+ZO1TwnX+nw==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr581pjv.16.1610624200891;
        Thu, 14 Jan 2021 03:36:40 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id p187sm5035732pfp.60.2021.01.14.03.36.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:36:40 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] arch: xtensa: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:29 +0530
Message-Id: <193f2f177d23eef62b54b48f80e62fb0169c1db9.1610622251.git.viresh.kumar@linaro.org>
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
 arch/xtensa/Kconfig                         |  1 -
 arch/xtensa/Makefile                        |  1 -
 arch/xtensa/configs/audio_kc705_defconfig   |  1 -
 arch/xtensa/configs/generic_kc705_defconfig |  1 -
 arch/xtensa/configs/smp_lx200_defconfig     |  1 -
 arch/xtensa/configs/xip_kc705_defconfig     |  1 -
 arch/xtensa/kernel/stacktrace.c             |  2 +-
 arch/xtensa/oprofile/Makefile               | 10 --------
 arch/xtensa/oprofile/backtrace.c            | 27 ---------------------
 arch/xtensa/oprofile/init.c                 | 26 --------------------
 10 files changed, 1 insertion(+), 70 deletions(-)
 delete mode 100644 arch/xtensa/oprofile/Makefile
 delete mode 100644 arch/xtensa/oprofile/backtrace.c
 delete mode 100644 arch/xtensa/oprofile/init.c

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 37ce1489364e..9ad6b7b82707 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -32,7 +32,6 @@ config XTENSA
 	select HAVE_FUTEX_CMPXCHG if !MMU
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-	select HAVE_OPROFILE
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_STACKPROTECTOR
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 67a7d151d1e7..cf0940708702 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -83,7 +83,6 @@ core-y		+= $(buildvar) $(buildplf)
 core-y 		+= arch/xtensa/boot/dts/
 
 libs-y		+= arch/xtensa/lib/ $(LIBGCC)
-drivers-$(CONFIG_OPROFILE)	+= arch/xtensa/oprofile/
 
 boot		:= arch/xtensa/boot
 
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index eeb4c5383c83..3be62da8089b 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -18,7 +18,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_XTENSA_VARIANT_CUSTOM=y
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index 412f611033cc..e9d6b6f6eca1 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -18,7 +18,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_XTENSA_VARIANT_DC233C=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 4f1c7998b030..a47c85638ec1 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -18,7 +18,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_XTENSA_VARIANT_CUSTOM=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index f9e85c082afc..4f1ff9531f6a 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -31,7 +31,6 @@ CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0
 CONFIG_USE_OF=y
 CONFIG_BUILTIN_DTB_SOURCE="kc705"
 # CONFIG_PARSE_BOOTPARAM is not set
-CONFIG_OPROFILE=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
index c822abb93d20..7f7755cd28f0 100644
--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -16,7 +16,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 
-#if IS_ENABLED(CONFIG_OPROFILE) || IS_ENABLED(CONFIG_PERF_EVENTS)
+#if IS_ENABLED(CONFIG_PERF_EVENTS)
 
 /* Address of common_exception_return, used to check the
  * transition from kernel to user space.
diff --git a/arch/xtensa/oprofile/Makefile b/arch/xtensa/oprofile/Makefile
deleted file mode 100644
index f559b9ffbb3f..000000000000
--- a/arch/xtensa/oprofile/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y := $(DRIVER_OBJS) init.o backtrace.o
diff --git a/arch/xtensa/oprofile/backtrace.c b/arch/xtensa/oprofile/backtrace.c
deleted file mode 100644
index 8f952034e161..000000000000
--- a/arch/xtensa/oprofile/backtrace.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/**
- * @file backtrace.c
- *
- * @remark Copyright 2008 Tensilica Inc.
- * Copyright (C) 2015 Cadence Design Systems Inc.
- * @remark Read the file COPYING
- *
- */
-
-#include <linux/oprofile.h>
-#include <asm/ptrace.h>
-#include <asm/stacktrace.h>
-
-static int xtensa_backtrace_cb(struct stackframe *frame, void *data)
-{
-	oprofile_add_trace(frame->pc);
-	return 0;
-}
-
-void xtensa_backtrace(struct pt_regs * const regs, unsigned int depth)
-{
-	if (user_mode(regs))
-		xtensa_backtrace_user(regs, depth, xtensa_backtrace_cb, NULL);
-	else
-		xtensa_backtrace_kernel(regs, depth, xtensa_backtrace_cb,
-					xtensa_backtrace_cb, NULL);
-}
diff --git a/arch/xtensa/oprofile/init.c b/arch/xtensa/oprofile/init.c
deleted file mode 100644
index a67eea379766..000000000000
--- a/arch/xtensa/oprofile/init.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/**
- * @file init.c
- *
- * @remark Copyright 2008 Tensilica Inc.
- * @remark Read the file COPYING
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/oprofile.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-
-
-extern void xtensa_backtrace(struct pt_regs *const regs, unsigned int depth);
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	ops->backtrace = xtensa_backtrace;
-	return -ENODEV;
-}
-
-
-void oprofile_arch_exit(void)
-{
-}
-- 
2.25.0.rc1.19.g042ed3e048af

