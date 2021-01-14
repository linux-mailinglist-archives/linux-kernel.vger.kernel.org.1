Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0652F604D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbhANLhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbhANLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:45 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C1C0617A1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x126so3168690pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6pF8PwYGSaz1ZNaOhy9eKako4g3V/oIeMmrhtfC4/U=;
        b=CsSujw74vjPO179JQOPKW/rS1joWHpCwXZ9woY1wPVme3WAmvsGEaiSIDOC4bPY383
         kykq0E2awkeW2MtqV11hIbVbxB03xIhelK/YYPGyfPUALPSGp3c9NGmd59Yq7i8MEnPO
         wopQhNlkjySWoJOrs5BRjRRmSrQNRpm/XRLArgaq3uozCcw7iHuY7U2b+H19oZwigSKW
         k4HPflZ6HvALdn4p9tAu9hp51TciKpOLJ3b05FntKt4FigTQ7bP0172DyCJYcLosab0w
         q4cIfYBBQh7bHa08WG+ogOs+OI9wPZCYCmWXH15OFc4XXn+lkywC9X4cDWv/f15H35/P
         YS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6pF8PwYGSaz1ZNaOhy9eKako4g3V/oIeMmrhtfC4/U=;
        b=qruXSCTmw+UD2khQ2yOu9hfHNKgAtd5OqqywCNbixri2jSEjO7kumcr0POmwjzzkmn
         Sp/UawzJszh27mjewsoPMZrvyX35rAzzpIBDnJ3BmqnQqzqAi5q0jfrs7DPS8JAGg76w
         HqtzOD/DYCGRPWLNp3hJ1ZvWilzKa3tPT9Tdy3DpZxYaH5CBE3k3gIVCfX1X7b23Q4Cw
         h6AuEBbYNVSDJD3HMkml+y+f2GlZjLm48ArGW/RVIViSBU9A1HyLciGmLEfPnHNSlEUv
         N1wet0UOuZT6+Pffu551Kr4qq2gZHOqvljiO0ot+oMO0xghxajhzznC4q0eaejrZaw0S
         0+lg==
X-Gm-Message-State: AOAM530w/ndtwQRRpVmf455IazZphyDG8eK5/r4f8KI3rHCZww0Lh6xy
        7DC5F3AiC8GFNWxPJfUlHa1Cdw==
X-Google-Smtp-Source: ABdhPJytxvrmQFEFVBn8jmaBSosHOxPCkaBSBW+Xc9VZXjkpx3bc9vjZ5mbLWyEbqDMQWC+mg3ixdg==
X-Received: by 2002:a65:690e:: with SMTP id s14mr7095987pgq.302.1610624191657;
        Thu, 14 Jan 2021 03:36:31 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id s13sm5251972pfd.99.2021.01.14.03.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:36:30 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 14/18] arch: sparc: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:27 +0530
Message-Id: <048b9e7918a847a6ad549350e30855a1b5d7c58e.1610622251.git.viresh.kumar@linaro.org>
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
 Documentation/kbuild/makefiles.rst   |  1 -
 arch/sparc/Kconfig                   |  1 -
 arch/sparc/Makefile                  |  1 -
 arch/sparc/configs/sparc64_defconfig |  1 -
 arch/sparc/oprofile/Makefile         | 10 ----
 arch/sparc/oprofile/init.c           | 87 ----------------------------
 6 files changed, 101 deletions(-)
 delete mode 100644 arch/sparc/oprofile/Makefile
 delete mode 100644 arch/sparc/oprofile/init.c

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 9f6a11881951..d7b2e027c1f8 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1317,7 +1317,6 @@ a few targets.
 		libs-y                 += arch/sparc/lib/
 
 		drivers-$(CONFIG_PM) += arch/sparc/power/
-		drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
 7.5 Architecture-specific boot images
 -------------------------------------
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c9c34dc52b7d..caf95e61162b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -20,7 +20,6 @@ config SPARC
 	select OF_PROMTREE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_IDE
-	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_SECCOMP if SPARC64
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 4a0919581697..bee99e65fe23 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -65,7 +65,6 @@ libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
 drivers-$(CONFIG_PM) += arch/sparc/power/
-drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
 boot := arch/sparc/boot
 
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index bde4d21a8ac8..d91eb6a76dd1 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -8,7 +8,6 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sparc/oprofile/Makefile b/arch/sparc/oprofile/Makefile
deleted file mode 100644
index fe906e403d3a..000000000000
--- a/arch/sparc/oprofile/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y				:= $(DRIVER_OBJS) init.o
diff --git a/arch/sparc/oprofile/init.c b/arch/sparc/oprofile/init.c
deleted file mode 100644
index 43730c9b1c86..000000000000
--- a/arch/sparc/oprofile/init.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/**
- * @file init.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/oprofile.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/param.h>	/* for HZ */
- 
-#ifdef CONFIG_SPARC64
-#include <linux/notifier.h>
-#include <linux/rcupdate.h>
-#include <linux/kdebug.h>
-#include <asm/nmi.h>
-
-static int profile_timer_exceptions_notify(struct notifier_block *self,
-					   unsigned long val, void *data)
-{
-	struct die_args *args = data;
-	int ret = NOTIFY_DONE;
-
-	switch (val) {
-	case DIE_NMI:
-		oprofile_add_sample(args->regs, 0);
-		ret = NOTIFY_STOP;
-		break;
-	default:
-		break;
-	}
-	return ret;
-}
-
-static struct notifier_block profile_timer_exceptions_nb = {
-	.notifier_call	= profile_timer_exceptions_notify,
-};
-
-static int timer_start(void)
-{
-	if (register_die_notifier(&profile_timer_exceptions_nb))
-		return 1;
-	nmi_adjust_hz(HZ);
-	return 0;
-}
-
-
-static void timer_stop(void)
-{
-	nmi_adjust_hz(1);
-	unregister_die_notifier(&profile_timer_exceptions_nb);
-	synchronize_rcu();  /* Allow already-started NMIs to complete. */
-}
-
-static int op_nmi_timer_init(struct oprofile_operations *ops)
-{
-	if (atomic_read(&nmi_active) <= 0)
-		return -ENODEV;
-
-	ops->start = timer_start;
-	ops->stop = timer_stop;
-	ops->cpu_type = "timer";
-	printk(KERN_INFO "oprofile: Using perfctr NMI timer interrupt.\n");
-	return 0;
-}
-#endif
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	int ret = -ENODEV;
-
-#ifdef CONFIG_SPARC64
-	ret = op_nmi_timer_init(ops);
-	if (!ret)
-		return ret;
-#endif
-
-	return ret;
-}
-
-void oprofile_arch_exit(void)
-{
-}
-- 
2.25.0.rc1.19.g042ed3e048af

