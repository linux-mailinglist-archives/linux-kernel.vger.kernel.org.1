Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14D2F602E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbhANLg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbhANLgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:36:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DDEC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c13so3157454pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3miStr5HPvL3tok66rpMH2xLUVW2T1RfRMyao/L8oI=;
        b=TOAdcs8NBr223I5TfWZ0FrNaEM4qLk8aLGRF1rwT+LzLK1ZGhqPbUZ/eh1K+JrMC4A
         N1aJLO1W1My9V7+JZkkbhYylveqKKPmSi/xf9GwIhbTo2kBTtBHcoontXdWkwgEfxNWv
         cwv3z9MCHVslKFvEnGVEFillNtPCP775Gw2ulmY79oo/GA+LXLPeloaW2EeSnoZBXawe
         woTex5lSf+94tBTToFMkrcnxnIsnpQvG49Vn9Ql62Dr7rhOUPcEWB465+okTTGkDv3HV
         1DNwNKf1ccjU1gYuu4bEgpwvo5pIqjGjwJqNETTJU7YkA5B4GQopQqa1rTMrfRX2nfrJ
         USvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3miStr5HPvL3tok66rpMH2xLUVW2T1RfRMyao/L8oI=;
        b=p4+RCXHp7UW747WidYEhTtImj0Ye+TX37BIqhsfBHEseiuDfIqnAvuSsxV9qtyM4sK
         WMbfWscSPnZH1FbNVKUldM9P6clpO3DHaRpIWMMmXEm6Ea+T8QSAIGS7a+m8aejwpZEH
         aLUtQWR2zudu2wGXZtEZkNUXjQBY57XTCl/JOP+Qu+GOp0yD2xExnR05fQUug6IHtsSE
         qwKHcoS++Be275WWiZqIJpVT3ts0GoUA6RZwc0uij3V98z+EN/Leg4xAZylgCyVr3AFS
         bYC/4eIWiMrKwF5ZI/Bp/6Fdf8uErqWXDGfHScf4ZY4gbutpse8J/5H7zMafP224IoAi
         MJQQ==
X-Gm-Message-State: AOAM530ldJdJv6UU1yAnpAkFHovqU14sp3+YK1l6YMykONLWxR6Kwqc/
        Xgd+UsTpepxSLtYhUfCnoQvATw==
X-Google-Smtp-Source: ABdhPJwIDJ4+2a32uFnRWjL6mCUHowGHpk47kmMCHOD85a+ali9zSChUA0yVKuvJx76uMLvw1p38Dw==
X-Received: by 2002:a62:1c16:0:b029:1a6:8b06:68e9 with SMTP id c22-20020a621c160000b02901a68b0668e9mr6948312pfc.45.1610624136470;
        Thu, 14 Jan 2021 03:35:36 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id t25sm5389324pgv.30.2021.01.14.03.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:35:35 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] arch: alpha: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:14 +0530
Message-Id: <19c586d05f9615a710ab3e54037f8ecd9c8adb5a.1610622251.git.viresh.kumar@linaro.org>
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
 arch/alpha/Kconfig                  |   1 -
 arch/alpha/Makefile                 |   1 -
 arch/alpha/oprofile/Makefile        |  20 ---
 arch/alpha/oprofile/common.c        | 189 --------------------
 arch/alpha/oprofile/op_impl.h       |  55 ------
 arch/alpha/oprofile/op_model_ev4.c  | 114 ------------
 arch/alpha/oprofile/op_model_ev5.c  | 209 ----------------------
 arch/alpha/oprofile/op_model_ev6.c  | 101 -----------
 arch/alpha/oprofile/op_model_ev67.c | 261 ----------------------------
 9 files changed, 951 deletions(-)
 delete mode 100644 arch/alpha/oprofile/Makefile
 delete mode 100644 arch/alpha/oprofile/common.c
 delete mode 100644 arch/alpha/oprofile/op_impl.h
 delete mode 100644 arch/alpha/oprofile/op_model_ev4.c
 delete mode 100644 arch/alpha/oprofile/op_model_ev5.c
 delete mode 100644 arch/alpha/oprofile/op_model_ev6.c
 delete mode 100644 arch/alpha/oprofile/op_model_ev67.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 1f51437d5765..a401c1481a11 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -14,7 +14,6 @@ config ALPHA
 	select HAVE_AOUT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_IDE
-	select HAVE_OPROFILE
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select NEED_DMA_MAP_STATE
diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
index 12dee59b011c..c2946431d88d 100644
--- a/arch/alpha/Makefile
+++ b/arch/alpha/Makefile
@@ -40,7 +40,6 @@ head-y := arch/alpha/kernel/head.o
 
 core-y				+= arch/alpha/kernel/ arch/alpha/mm/
 core-$(CONFIG_MATHEMU)		+= arch/alpha/math-emu/
-drivers-$(CONFIG_OPROFILE)	+= arch/alpha/oprofile/
 libs-y				+= arch/alpha/lib/
 
 # export what is needed by arch/alpha/boot/Makefile
diff --git a/arch/alpha/oprofile/Makefile b/arch/alpha/oprofile/Makefile
deleted file mode 100644
index 79f32820a42f..000000000000
--- a/arch/alpha/oprofile/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-ccflags-y := -Werror -Wno-sign-compare
-
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y				:= $(DRIVER_OBJS) common.o
-oprofile-$(CONFIG_ALPHA_GENERIC)	+= op_model_ev4.o \
-					   op_model_ev5.o \
-					   op_model_ev6.o \
-					   op_model_ev67.o
-oprofile-$(CONFIG_ALPHA_EV4)		+= op_model_ev4.o
-oprofile-$(CONFIG_ALPHA_EV5)		+= op_model_ev5.o
-oprofile-$(CONFIG_ALPHA_EV6)		+= op_model_ev6.o \
-					   op_model_ev67.o
diff --git a/arch/alpha/oprofile/common.c b/arch/alpha/oprofile/common.c
deleted file mode 100644
index 1b1259c7d7d1..000000000000
--- a/arch/alpha/oprofile/common.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/**
- * @file arch/alpha/oprofile/common.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <asm/ptrace.h>
-#include <asm/special_insns.h>
-
-#include "op_impl.h"
-
-extern struct op_axp_model op_model_ev4 __attribute__((weak));
-extern struct op_axp_model op_model_ev5 __attribute__((weak));
-extern struct op_axp_model op_model_pca56 __attribute__((weak));
-extern struct op_axp_model op_model_ev6 __attribute__((weak));
-extern struct op_axp_model op_model_ev67 __attribute__((weak));
-
-static struct op_axp_model *model;
-
-extern void (*perf_irq)(unsigned long, struct pt_regs *);
-static void (*save_perf_irq)(unsigned long, struct pt_regs *);
-
-static struct op_counter_config ctr[20];
-static struct op_system_config sys;
-static struct op_register_config reg;
-
-/* Called from do_entInt to handle the performance monitor interrupt.  */
-
-static void
-op_handle_interrupt(unsigned long which, struct pt_regs *regs)
-{
-	model->handle_interrupt(which, regs, ctr);
-
-	/* If the user has selected an interrupt frequency that is
-	   not exactly the width of the counter, write a new value
-	   into the counter such that it'll overflow after N more
-	   events.  */
-	if ((reg.need_reset >> which) & 1)
-		model->reset_ctr(&reg, which);
-}
- 
-static int
-op_axp_setup(void)
-{
-	unsigned long i, e;
-
-	/* Install our interrupt handler into the existing hook.  */
-	save_perf_irq = perf_irq;
-	perf_irq = op_handle_interrupt;
-
-	/* Compute the mask of enabled counters.  */
-	for (i = e = 0; i < model->num_counters; ++i)
-		if (ctr[i].enabled)
-			e |= 1 << i;
-	reg.enable = e;
-
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(&reg, ctr, &sys);
-
-	/* Configure the registers on all cpus.  */
-	smp_call_function(model->cpu_setup, &reg, 1);
-	model->cpu_setup(&reg);
-	return 0;
-}
-
-static void
-op_axp_shutdown(void)
-{
-	/* Remove our interrupt handler.  We may be removing this module.  */
-	perf_irq = save_perf_irq;
-}
-
-static void
-op_axp_cpu_start(void *dummy)
-{
-	wrperfmon(1, reg.enable);
-}
-
-static int
-op_axp_start(void)
-{
-	smp_call_function(op_axp_cpu_start, NULL, 1);
-	op_axp_cpu_start(NULL);
-	return 0;
-}
-
-static inline void
-op_axp_cpu_stop(void *dummy)
-{
-	/* Disable performance monitoring for all counters.  */
-	wrperfmon(0, -1);
-}
-
-static void
-op_axp_stop(void)
-{
-	smp_call_function(op_axp_cpu_stop, NULL, 1);
-	op_axp_cpu_stop(NULL);
-}
-
-static int
-op_axp_create_files(struct dentry *root)
-{
-	int i;
-
-	for (i = 0; i < model->num_counters; ++i) {
-		struct dentry *dir;
-		char buf[4];
-
-		snprintf(buf, sizeof buf, "%d", i);
-		dir = oprofilefs_mkdir(root, buf);
-
-		oprofilefs_create_ulong(dir, "enabled", &ctr[i].enabled);
-                oprofilefs_create_ulong(dir, "event", &ctr[i].event);
-		oprofilefs_create_ulong(dir, "count", &ctr[i].count);
-		/* Dummies.  */
-		oprofilefs_create_ulong(dir, "kernel", &ctr[i].kernel);
-		oprofilefs_create_ulong(dir, "user", &ctr[i].user);
-		oprofilefs_create_ulong(dir, "unit_mask", &ctr[i].unit_mask);
-	}
-
-	if (model->can_set_proc_mode) {
-		oprofilefs_create_ulong(root, "enable_pal",
-					&sys.enable_pal);
-		oprofilefs_create_ulong(root, "enable_kernel",
-					&sys.enable_kernel);
-		oprofilefs_create_ulong(root, "enable_user",
-					&sys.enable_user);
-	}
-
-	return 0;
-}
-
-int __init
-oprofile_arch_init(struct oprofile_operations *ops)
-{
-	struct op_axp_model *lmodel = NULL;
-
-	switch (implver()) {
-	case IMPLVER_EV4:
-		lmodel = &op_model_ev4;
-		break;
-	case IMPLVER_EV5:
-		/* 21164PC has a slightly different set of events.
-		   Recognize the chip by the presence of the MAX insns.  */
-		if (!amask(AMASK_MAX))
-			lmodel = &op_model_pca56;
-		else
-			lmodel = &op_model_ev5;
-		break;
-	case IMPLVER_EV6:
-		/* 21264A supports ProfileMe.
-		   Recognize the chip by the presence of the CIX insns.  */
-		if (!amask(AMASK_CIX))
-			lmodel = &op_model_ev67;
-		else
-			lmodel = &op_model_ev6;
-		break;
-	}
-
-	if (!lmodel)
-		return -ENODEV;
-	model = lmodel;
-
-	ops->create_files = op_axp_create_files;
-	ops->setup = op_axp_setup;
-	ops->shutdown = op_axp_shutdown;
-	ops->start = op_axp_start;
-	ops->stop = op_axp_stop;
-	ops->cpu_type = lmodel->cpu_type;
-
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       lmodel->cpu_type);
-
-	return 0;
-}
-
-
-void
-oprofile_arch_exit(void)
-{
-}
diff --git a/arch/alpha/oprofile/op_impl.h b/arch/alpha/oprofile/op_impl.h
deleted file mode 100644
index b2b87ae9a353..000000000000
--- a/arch/alpha/oprofile/op_impl.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_impl.h
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#ifndef OP_IMPL_H
-#define OP_IMPL_H 1
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long enabled;
-	unsigned long event;
-	unsigned long count;
-	/* Dummies because I am too lazy to hack the userspace tools.  */
-	unsigned long kernel;
-	unsigned long user;
-	unsigned long unit_mask;
-};
-
-/* System-wide configuration as set via oprofilefs.  */
-struct op_system_config {
-	unsigned long enable_pal;
-	unsigned long enable_kernel;
-	unsigned long enable_user;
-};
-
-/* Cached values for the various performance monitoring registers.  */
-struct op_register_config {
-	unsigned long enable;
-	unsigned long mux_select;
-	unsigned long proc_mode;
-	unsigned long freq;
-	unsigned long reset_values;
-	unsigned long need_reset;
-};
-
-/* Per-architecture configuration and hooks.  */
-struct op_axp_model {
-	void (*reg_setup) (struct op_register_config *,
-			   struct op_counter_config *,
-			   struct op_system_config *);
-	void (*cpu_setup) (void *);
-	void (*reset_ctr) (struct op_register_config *, unsigned long);
-	void (*handle_interrupt) (unsigned long, struct pt_regs *,
-				  struct op_counter_config *);
-	char *cpu_type;
-	unsigned char num_counters;
-	unsigned char can_set_proc_mode;
-};
-
-#endif
diff --git a/arch/alpha/oprofile/op_model_ev4.c b/arch/alpha/oprofile/op_model_ev4.c
deleted file mode 100644
index 086a0d5445c5..000000000000
--- a/arch/alpha/oprofile/op_model_ev4.c
+++ /dev/null
@@ -1,114 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_model_ev4.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#include <linux/oprofile.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-
-#include "op_impl.h"
-
-
-/* Compute all of the registers in preparation for enabling profiling.  */
-
-static void
-ev4_reg_setup(struct op_register_config *reg,
-	      struct op_counter_config *ctr,
-	      struct op_system_config *sys)
-{
-	unsigned long ctl = 0, count, hilo;
-
-	/* Select desired events.  We've mapped the event numbers
-	   such that they fit directly into the event selection fields.
-
-	   Note that there is no "off" setting.  In both cases we select
-	   the EXTERNAL event source, hoping that it'll be the lowest
-	   frequency, and set the frequency counter to LOW.  The interrupts
-	   for these "disabled" counter overflows are ignored by the
-	   interrupt handler.
-
-	   This is most irritating, because the hardware *can* enable and
-	   disable the interrupts for these counters independently, but the
-	   wrperfmon interface doesn't allow it.  */
-
-	ctl |= (ctr[0].enabled ? ctr[0].event << 8 : 14 << 8);
-	ctl |= (ctr[1].enabled ? (ctr[1].event - 16) << 32 : 7ul << 32);
-
-	/* EV4 can not read or write its counter registers.  The only
-	   thing one can do at all is see if you overflow and get an
-	   interrupt.  We can set the width of the counters, to some
-	   extent.  Take the interrupt count selected by the user,
-	   map it onto one of the possible values, and write it back.  */
-
-	count = ctr[0].count;
-	if (count <= 4096)
-		count = 4096, hilo = 1;
-	else
-		count = 65536, hilo = 0;
-	ctr[0].count = count;
-	ctl |= (ctr[0].enabled && hilo) << 3;
-
-	count = ctr[1].count;
-	if (count <= 256)
-		count = 256, hilo = 1;
-	else
-		count = 4096, hilo = 0;
-	ctr[1].count = count;
-	ctl |= (ctr[1].enabled && hilo);
-
-	reg->mux_select = ctl;
-
-	/* Select performance monitoring options.  */
-	/* ??? Need to come up with some mechanism to trace only
-	   selected processes.  EV4 does not have a mechanism to
-	   select kernel or user mode only.  For now, enable always.  */
-	reg->proc_mode = 0;
-
-	/* Frequency is folded into mux_select for EV4.  */
-	reg->freq = 0;
-
-	/* See above regarding no writes.  */
-	reg->reset_values = 0;
-	reg->need_reset = 0;
-
-}
-
-/* Program all of the registers in preparation for enabling profiling.  */
-
-static void
-ev4_cpu_setup(void *x)
-{
-	struct op_register_config *reg = x;
-
-	wrperfmon(2, reg->mux_select);
-	wrperfmon(3, reg->proc_mode);
-}
-
-static void
-ev4_handle_interrupt(unsigned long which, struct pt_regs *regs,
-		     struct op_counter_config *ctr)
-{
-	/* EV4 can't properly disable counters individually.
-	   Discard "disabled" events now.  */
-	if (!ctr[which].enabled)
-		return;
-
-	/* Record the sample.  */
-	oprofile_add_sample(regs, which);
-}
-
-
-struct op_axp_model op_model_ev4 = {
-	.reg_setup		= ev4_reg_setup,
-	.cpu_setup		= ev4_cpu_setup,
-	.reset_ctr		= NULL,
-	.handle_interrupt	= ev4_handle_interrupt,
-	.cpu_type		= "alpha/ev4",
-	.num_counters		= 2,
-	.can_set_proc_mode	= 0,
-};
diff --git a/arch/alpha/oprofile/op_model_ev5.c b/arch/alpha/oprofile/op_model_ev5.c
deleted file mode 100644
index c300f5ef3482..000000000000
--- a/arch/alpha/oprofile/op_model_ev5.c
+++ /dev/null
@@ -1,209 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_model_ev5.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#include <linux/oprofile.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-
-#include "op_impl.h"
-
-
-/* Compute all of the registers in preparation for enabling profiling.
-
-   The 21164 (EV5) and 21164PC (PCA65) vary in the bit placement and
-   meaning of the "CBOX" events.  Given that we don't care about meaning
-   at this point, arrange for the difference in bit placement to be
-   handled by common code.  */
-
-static void
-common_reg_setup(struct op_register_config *reg,
-		 struct op_counter_config *ctr,
-		 struct op_system_config *sys,
-		 int cbox1_ofs, int cbox2_ofs)
-{
-	int i, ctl, reset, need_reset;
-
-	/* Select desired events.  The event numbers are selected such
-	   that they map directly into the event selection fields:
-
-		PCSEL0:	0, 1
-		PCSEL1:	24-39
-		 CBOX1: 40-47
-		PCSEL2: 48-63
-		 CBOX2: 64-71
-
-	   There are two special cases, in that CYCLES can be measured
-	   on PCSEL[02], and SCACHE_WRITE can be measured on CBOX[12].
-	   These event numbers are canonicalizes to their first appearance.  */
-
-	ctl = 0;
-	for (i = 0; i < 3; ++i) {
-		unsigned long event = ctr[i].event;
-		if (!ctr[i].enabled)
-			continue;
-
-		/* Remap the duplicate events, as described above.  */
-		if (i == 2) {
-			if (event == 0)
-				event = 12+48;
-			else if (event == 2+41)
-				event = 4+65;
-		}
-
-		/* Convert the event numbers onto mux_select bit mask.  */
-		if (event < 2)
-			ctl |= event << 31;
-		else if (event < 24)
-			/* error */;
-		else if (event < 40)
-			ctl |= (event - 24) << 4;
-		else if (event < 48)
-			ctl |= (event - 40) << cbox1_ofs | 15 << 4;
-		else if (event < 64)
-			ctl |= event - 48;
-		else if (event < 72)
-			ctl |= (event - 64) << cbox2_ofs | 15;
-	}
-	reg->mux_select = ctl;
-
-	/* Select processor mode.  */
-	/* ??? Need to come up with some mechanism to trace only selected
-	   processes.  For now select from pal, kernel and user mode.  */
-	ctl = 0;
-	ctl |= !sys->enable_pal << 9;
-	ctl |= !sys->enable_kernel << 8;
-	ctl |= !sys->enable_user << 30;
-	reg->proc_mode = ctl;
-
-	/* Select interrupt frequencies.  Take the interrupt count selected
-	   by the user, and map it onto one of the possible counter widths.
-	   If the user value is in between, compute a value to which the
-	   counter is reset at each interrupt.  */
-
-	ctl = reset = need_reset = 0;
-	for (i = 0; i < 3; ++i) {
-		unsigned long max, hilo, count = ctr[i].count;
-		if (!ctr[i].enabled)
-			continue;
-
-		if (count <= 256)
-			count = 256, hilo = 3, max = 256;
-		else {
-			max = (i == 2 ? 16384 : 65536);
-			hilo = 2;
-			if (count > max)
-				count = max;
-		}
-		ctr[i].count = count;
-
-		ctl |= hilo << (8 - i*2);
-		reset |= (max - count) << (48 - 16*i);
-		if (count != max)
-			need_reset |= 1 << i;
-	}
-	reg->freq = ctl;
-	reg->reset_values = reset;
-	reg->need_reset = need_reset;
-}
-
-static void
-ev5_reg_setup(struct op_register_config *reg,
-	      struct op_counter_config *ctr,
-	      struct op_system_config *sys)
-{
-	common_reg_setup(reg, ctr, sys, 19, 22);
-}
-
-static void
-pca56_reg_setup(struct op_register_config *reg,
-	        struct op_counter_config *ctr,
-	        struct op_system_config *sys)
-{
-	common_reg_setup(reg, ctr, sys, 8, 11);
-}
-
-/* Program all of the registers in preparation for enabling profiling.  */
-
-static void
-ev5_cpu_setup (void *x)
-{
-	struct op_register_config *reg = x;
-
-	wrperfmon(2, reg->mux_select);
-	wrperfmon(3, reg->proc_mode);
-	wrperfmon(4, reg->freq);
-	wrperfmon(6, reg->reset_values);
-}
-
-/* CTR is a counter for which the user has requested an interrupt count
-   in between one of the widths selectable in hardware.  Reset the count
-   for CTR to the value stored in REG->RESET_VALUES.
-
-   For EV5, this means disabling profiling, reading the current values,
-   masking in the value for the desired register, writing, then turning
-   profiling back on.
-
-   This can be streamlined if profiling is only enabled for user mode.
-   In that case we know that the counters are not currently incrementing
-   (due to being in kernel mode).  */
-
-static void
-ev5_reset_ctr(struct op_register_config *reg, unsigned long ctr)
-{
-	unsigned long values, mask, not_pk, reset_values;
-
-	mask = (ctr == 0 ? 0xfffful << 48
-	        : ctr == 1 ? 0xfffful << 32
-		: 0x3fff << 16);
-
-	not_pk = 1 << 9 | 1 << 8;
-
-	reset_values = reg->reset_values;
-
-	if ((reg->proc_mode & not_pk) == not_pk) {
-		values = wrperfmon(5, 0);
-		values = (reset_values & mask) | (values & ~mask & -2);
-		wrperfmon(6, values);
-	} else {
-		wrperfmon(0, -1);
-		values = wrperfmon(5, 0);
-		values = (reset_values & mask) | (values & ~mask & -2);
-		wrperfmon(6, values);
-		wrperfmon(1, reg->enable);
-	}
-}
-
-static void
-ev5_handle_interrupt(unsigned long which, struct pt_regs *regs,
-		     struct op_counter_config *ctr)
-{
-	/* Record the sample.  */
-	oprofile_add_sample(regs, which);
-}
-
-
-struct op_axp_model op_model_ev5 = {
-	.reg_setup		= ev5_reg_setup,
-	.cpu_setup		= ev5_cpu_setup,
-	.reset_ctr		= ev5_reset_ctr,
-	.handle_interrupt	= ev5_handle_interrupt,
-	.cpu_type		= "alpha/ev5",
-	.num_counters		= 3,
-	.can_set_proc_mode	= 1,
-};
-
-struct op_axp_model op_model_pca56 = {
-	.reg_setup		= pca56_reg_setup,
-	.cpu_setup		= ev5_cpu_setup,
-	.reset_ctr		= ev5_reset_ctr,
-	.handle_interrupt	= ev5_handle_interrupt,
-	.cpu_type		= "alpha/pca56",
-	.num_counters		= 3,
-	.can_set_proc_mode	= 1,
-};
diff --git a/arch/alpha/oprofile/op_model_ev6.c b/arch/alpha/oprofile/op_model_ev6.c
deleted file mode 100644
index 02edf5971614..000000000000
--- a/arch/alpha/oprofile/op_model_ev6.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_model_ev6.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#include <linux/oprofile.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-
-#include "op_impl.h"
-
-
-/* Compute all of the registers in preparation for enabling profiling.  */
-
-static void
-ev6_reg_setup(struct op_register_config *reg,
-	      struct op_counter_config *ctr,
-	      struct op_system_config *sys)
-{
-	unsigned long ctl, reset, need_reset, i;
-
-	/* Select desired events.  We've mapped the event numbers
-	   such that they fit directly into the event selection fields.  */
-	ctl = 0;
-	if (ctr[0].enabled && ctr[0].event)
-		ctl |= (ctr[0].event & 1) << 4;
-	if (ctr[1].enabled)
-		ctl |= (ctr[1].event - 2) & 15;
-	reg->mux_select = ctl;
-
-	/* Select logging options.  */
-	/* ??? Need to come up with some mechanism to trace only
-	   selected processes.  EV6 does not have a mechanism to
-	   select kernel or user mode only.  For now, enable always.  */
-	reg->proc_mode = 0;
-
-	/* EV6 cannot change the width of the counters as with the
-	   other implementations.  But fortunately, we can write to
-	   the counters and set the value such that it will overflow
-	   at the right time.  */
-	reset = need_reset = 0;
-	for (i = 0; i < 2; ++i) {
-		unsigned long count = ctr[i].count;
-		if (!ctr[i].enabled)
-			continue;
-
-		if (count > 0x100000)
-			count = 0x100000;
-		ctr[i].count = count;
-		reset |= (0x100000 - count) << (i ? 6 : 28);
-		if (count != 0x100000)
-			need_reset |= 1 << i;
-	}
-	reg->reset_values = reset;
-	reg->need_reset = need_reset;
-}
-
-/* Program all of the registers in preparation for enabling profiling.  */
-
-static void
-ev6_cpu_setup (void *x)
-{
-	struct op_register_config *reg = x;
-
-	wrperfmon(2, reg->mux_select);
-	wrperfmon(3, reg->proc_mode);
-	wrperfmon(6, reg->reset_values | 3);
-}
-
-/* CTR is a counter for which the user has requested an interrupt count
-   in between one of the widths selectable in hardware.  Reset the count
-   for CTR to the value stored in REG->RESET_VALUES.  */
-
-static void
-ev6_reset_ctr(struct op_register_config *reg, unsigned long ctr)
-{
-	wrperfmon(6, reg->reset_values | (1 << ctr));
-}
-
-static void
-ev6_handle_interrupt(unsigned long which, struct pt_regs *regs,
-		     struct op_counter_config *ctr)
-{
-	/* Record the sample.  */
-	oprofile_add_sample(regs, which);
-}
-
-
-struct op_axp_model op_model_ev6 = {
-	.reg_setup		= ev6_reg_setup,
-	.cpu_setup		= ev6_cpu_setup,
-	.reset_ctr		= ev6_reset_ctr,
-	.handle_interrupt	= ev6_handle_interrupt,
-	.cpu_type		= "alpha/ev6",
-	.num_counters		= 2,
-	.can_set_proc_mode	= 0,
-};
diff --git a/arch/alpha/oprofile/op_model_ev67.c b/arch/alpha/oprofile/op_model_ev67.c
deleted file mode 100644
index adb1744d20f3..000000000000
--- a/arch/alpha/oprofile/op_model_ev67.c
+++ /dev/null
@@ -1,261 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_model_ev67.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- * @author Falk Hueffner <falk@debian.org>
- */
-
-#include <linux/oprofile.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-
-#include "op_impl.h"
-
-
-/* Compute all of the registers in preparation for enabling profiling.  */
-
-static void
-ev67_reg_setup(struct op_register_config *reg,
-	       struct op_counter_config *ctr,
-	       struct op_system_config *sys)
-{
-	unsigned long ctl, reset, need_reset, i;
-
-	/* Select desired events.  */
-	ctl = 1UL << 4;		/* Enable ProfileMe mode. */
-
-	/* The event numbers are chosen so we can use them directly if
-	   PCTR1 is enabled.  */
-	if (ctr[1].enabled) {
-		ctl |= (ctr[1].event & 3) << 2;
-	} else {
-		if (ctr[0].event == 0) /* cycles */
-			ctl |= 1UL << 2;
-	}
-	reg->mux_select = ctl;
-
-	/* Select logging options.  */
-	/* ??? Need to come up with some mechanism to trace only
-	   selected processes.  EV67 does not have a mechanism to
-	   select kernel or user mode only.  For now, enable always.  */
-	reg->proc_mode = 0;
-
-	/* EV67 cannot change the width of the counters as with the
-	   other implementations.  But fortunately, we can write to
-	   the counters and set the value such that it will overflow
-	   at the right time.  */
-	reset = need_reset = 0;
-	for (i = 0; i < 2; ++i) {
-		unsigned long count = ctr[i].count;
-		if (!ctr[i].enabled)
-			continue;
-
-		if (count > 0x100000)
-			count = 0x100000;
-		ctr[i].count = count;
-		reset |= (0x100000 - count) << (i ? 6 : 28);
-		if (count != 0x100000)
-			need_reset |= 1 << i;
-	}
-	reg->reset_values = reset;
-	reg->need_reset = need_reset;
-}
-
-/* Program all of the registers in preparation for enabling profiling.  */
-
-static void
-ev67_cpu_setup (void *x)
-{
-	struct op_register_config *reg = x;
-
-	wrperfmon(2, reg->mux_select);
-	wrperfmon(3, reg->proc_mode);
-	wrperfmon(6, reg->reset_values | 3);
-}
-
-/* CTR is a counter for which the user has requested an interrupt count
-   in between one of the widths selectable in hardware.  Reset the count
-   for CTR to the value stored in REG->RESET_VALUES.  */
-
-static void
-ev67_reset_ctr(struct op_register_config *reg, unsigned long ctr)
-{
-	wrperfmon(6, reg->reset_values | (1 << ctr));
-}
-
-/* ProfileMe conditions which will show up as counters. We can also
-   detect the following, but it seems unlikely that anybody is
-   interested in counting them:
-    * Reset
-    * MT_FPCR (write to floating point control register)
-    * Arithmetic trap
-    * Dstream Fault
-    * Machine Check (ECC fault, etc.)
-    * OPCDEC (illegal opcode)
-    * Floating point disabled
-    * Differentiate between DTB single/double misses and 3 or 4 level
-      page tables
-    * Istream access violation
-    * Interrupt
-    * Icache Parity Error.
-    * Instruction killed (nop, trapb)
-
-   Unfortunately, there seems to be no way to detect Dcache and Bcache
-   misses; the latter could be approximated by making the counter
-   count Bcache misses, but that is not precise.
-
-   We model this as 20 counters:
-    * PCTR0
-    * PCTR1
-    * 9 ProfileMe events, induced by PCTR0
-    * 9 ProfileMe events, induced by PCTR1
-*/
-
-enum profileme_counters {
-	PM_STALLED,		/* Stalled for at least one cycle
-				   between the fetch and map stages  */
-	PM_TAKEN,		/* Conditional branch taken */
-	PM_MISPREDICT,		/* Branch caused mispredict trap */
-	PM_ITB_MISS,		/* ITB miss */
-	PM_DTB_MISS,		/* DTB miss */
-	PM_REPLAY,		/* Replay trap */
-	PM_LOAD_STORE,		/* Load-store order trap */
-	PM_ICACHE_MISS,		/* Icache miss */
-	PM_UNALIGNED,		/* Unaligned Load/Store */
-	PM_NUM_COUNTERS
-};
-
-static inline void
-op_add_pm(unsigned long pc, int kern, unsigned long counter,
-	  struct op_counter_config *ctr, unsigned long event)
-{
-	unsigned long fake_counter = 2 + event;
-	if (counter == 1)
-		fake_counter += PM_NUM_COUNTERS;
-	if (ctr[fake_counter].enabled)
-		oprofile_add_pc(pc, kern, fake_counter);
-}
-
-static void
-ev67_handle_interrupt(unsigned long which, struct pt_regs *regs,
-		      struct op_counter_config *ctr)
-{
-	unsigned long pmpc, pctr_ctl;
-	int kern = !user_mode(regs);
-	int mispredict = 0;
-	union {
-		unsigned long v;
-		struct {
-			unsigned reserved:	30; /*  0-29 */
-			unsigned overcount:	 3; /* 30-32 */
-			unsigned icache_miss:	 1; /*    33 */
-			unsigned trap_type:	 4; /* 34-37 */
-			unsigned load_store:	 1; /*    38 */
-			unsigned trap:		 1; /*    39 */
-			unsigned mispredict:	 1; /*    40 */
-		} fields;
-	} i_stat;
-
-	enum trap_types {
-		TRAP_REPLAY,
-		TRAP_INVALID0,
-		TRAP_DTB_DOUBLE_MISS_3,
-		TRAP_DTB_DOUBLE_MISS_4,
-		TRAP_FP_DISABLED,
-		TRAP_UNALIGNED,
-		TRAP_DTB_SINGLE_MISS,
-		TRAP_DSTREAM_FAULT,
-		TRAP_OPCDEC,
-		TRAP_INVALID1,
-		TRAP_MACHINE_CHECK,
-		TRAP_INVALID2,
-		TRAP_ARITHMETIC,
-		TRAP_INVALID3,
-		TRAP_MT_FPCR,
-		TRAP_RESET
-	};
-
-	pmpc = wrperfmon(9, 0);
-	/* ??? Don't know how to handle physical-mode PALcode address.  */
-	if (pmpc & 1)
-		return;
-	pmpc &= ~2;		/* clear reserved bit */
-
-	i_stat.v = wrperfmon(8, 0);
-	if (i_stat.fields.trap) {
-		switch (i_stat.fields.trap_type) {
-		case TRAP_INVALID1:
-		case TRAP_INVALID2:
-		case TRAP_INVALID3:
-			/* Pipeline redirection occurred. PMPC points
-			   to PALcode. Recognize ITB miss by PALcode
-			   offset address, and get actual PC from
-			   EXC_ADDR.  */
-			oprofile_add_pc(regs->pc, kern, which);
-			if ((pmpc & ((1 << 15) - 1)) ==  581)
-				op_add_pm(regs->pc, kern, which,
-					  ctr, PM_ITB_MISS);
-			/* Most other bit and counter values will be
-			   those for the first instruction in the
-			   fault handler, so we're done.  */
-			return;
-		case TRAP_REPLAY:
-			op_add_pm(pmpc, kern, which, ctr,
-				  (i_stat.fields.load_store
-				   ? PM_LOAD_STORE : PM_REPLAY));
-			break;
-		case TRAP_DTB_DOUBLE_MISS_3:
-		case TRAP_DTB_DOUBLE_MISS_4:
-		case TRAP_DTB_SINGLE_MISS:
-			op_add_pm(pmpc, kern, which, ctr, PM_DTB_MISS);
-			break;
-		case TRAP_UNALIGNED:
-			op_add_pm(pmpc, kern, which, ctr, PM_UNALIGNED);
-			break;
-		case TRAP_INVALID0:
-		case TRAP_FP_DISABLED:
-		case TRAP_DSTREAM_FAULT:
-		case TRAP_OPCDEC:
-		case TRAP_MACHINE_CHECK:
-		case TRAP_ARITHMETIC:
-		case TRAP_MT_FPCR:
-		case TRAP_RESET:
-			break;
-		}
-
-		/* ??? JSR/JMP/RET/COR or HW_JSR/HW_JMP/HW_RET/HW_COR
-		   mispredicts do not set this bit but can be
-		   recognized by the presence of one of these
-		   instructions at the PMPC location with bit 39
-		   set.  */
-		if (i_stat.fields.mispredict) {
-			mispredict = 1;
-			op_add_pm(pmpc, kern, which, ctr, PM_MISPREDICT);
-		}
-	}
-
-	oprofile_add_pc(pmpc, kern, which);
-
-	pctr_ctl = wrperfmon(5, 0);
-	if (pctr_ctl & (1UL << 27))
-		op_add_pm(pmpc, kern, which, ctr, PM_STALLED);
-
-	/* Unfortunately, TAK is undefined on mispredicted branches.
-	   ??? It is also undefined for non-cbranch insns, should
-	   check that.  */
-	if (!mispredict && pctr_ctl & (1UL << 0))
-		op_add_pm(pmpc, kern, which, ctr, PM_TAKEN);
-}
-
-struct op_axp_model op_model_ev67 = {
-	.reg_setup		= ev67_reg_setup,
-	.cpu_setup		= ev67_cpu_setup,
-	.reset_ctr		= ev67_reset_ctr,
-	.handle_interrupt	= ev67_handle_interrupt,
-	.cpu_type		= "alpha/ev67",
-	.num_counters		= 20,
-	.can_set_proc_mode	= 0,
-};
-- 
2.25.0.rc1.19.g042ed3e048af

