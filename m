Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785B1274823
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIVS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVS3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:29:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C38C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:29:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z26so22070015oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4m2UNlGzJ+jbmXJyLGWNegG1JcJsLj2dCVvh2LM1ikQ=;
        b=EaTuu1kP/IdBR9+R0dXVyn5b5DPH6cwfQ+teRDezN+dgvZFGH2/zdM0dmxAcolMr+o
         RLTUkKO7eTU7Tq+n/Jkm68WnKHgWwDL4bC6b+lSNLY5yXnAFnraftDTDqYZtm5u/bx5T
         Hcyu24uzBID3guEopXpf1GjfPb7tbAo6+fyXsNL65UncWrzreXWX80qiEDGCNqg3yqOf
         Bp1HgcxX4eEk/4olJMvXXG5CQeIFnTK7UrzU9BZF4V1CMJtwVA1li3lEzJgAnMRAeJe7
         F9rnAHlJFJEbfbpM9UqR6oxkCPQYA5A4zwKnBxixuyfD+JW3iDL+PlUZMBoq58RVj573
         y9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4m2UNlGzJ+jbmXJyLGWNegG1JcJsLj2dCVvh2LM1ikQ=;
        b=cOSDwfJq5ZZngpbxVnM/8oGGGIA/Wie6iUORtw69trprr3DboB+RqW//mKayJnLJ87
         L5h5cKsxVm03PppHjWABXDM0h6HPe+F6BXAdqcvSlZ39YOR+eytdwmlBFHwCP0KDdDZa
         dBV3O/sPZunBFzGFj8xNlGoCsv8Eh8m8A3cOTq8vsVwHrwFjQdYO0OfcFsfKMA9JJq98
         KiWtmgzN5C/FUXYhpDBzq4pGQVd12r+0ilDgT1oT1enaFs4nH6gDkTBAffgkYSNG78Q4
         ce8R6mpwr/Hfh0pkV7hFGUWkqxx1R3FUZf8q4KMxqVWLWqgMPQsBWDvPpO15Fz/umOGE
         1x1w==
X-Gm-Message-State: AOAM530CtLqhgEKjATBa9HVA5wOmdwW4IULoOa4UqLAJ62mEeIBxNU6S
        uBcPX/EDI32nphPxKGPiCA==
X-Google-Smtp-Source: ABdhPJz6PSm5NMbhslJ1UI+o4YDZ6G44i5tTU3MfvJjG+ybNRCONcn531U2hZ9dF+jXcEM+zye7EPg==
X-Received: by 2002:a05:6808:54:: with SMTP id v20mr3320427oic.50.1600799391514;
        Tue, 22 Sep 2020 11:29:51 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id j26sm7992631oor.21.2020.09.22.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:29:50 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.mvista.com (unknown [IPv6:2001:470:b8f6:1b:b947:d467:298:a358])
        by serve.minyard.net (Postfix) with ESMTPA id 5AE8D18003B;
        Tue, 22 Sep 2020 18:29:49 +0000 (UTC)
From:   minyard@acm.org
To:     Wu Bo <wubo40@huawei.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, hidehiro.kawai.ez@hitachi.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] x86: Fix MCE error handing when kdump is enabled
Date:   Tue, 22 Sep 2020 13:29:40 -0500
Message-Id: <20200922182940.31843-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922161311.GQ3674@minyard.net>
References: <20200922161311.GQ3674@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If kdump is enabled, the handling of shooting down CPUs does not use the
RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.

For normal errors that is fine.  MCEs, however, are already running in
an NMI, so sending them an NMI won't do anything.  The MCE code is set
up to receive the RESET_VECTOR because it disables CPUs, but it won't
work on the NMI-only case.

There is already code in place to scan for the NMI callback being ready,
simply call that from the MCE's wait_for_panic() code so it will pick up
and handle it if an NMI shootdown is requested.  This required
propagating the registers down to wait_for_panic().

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
After looking at it a bit, I think this is the proper way to fix the
issue, though I'm not an expert on this code so I'm not sure.

I have not even tested this patch, I have only compiled it.  But from
what I can tell, things waiting in NMIs for a shootdown should call
run_crash_ipi_callback() in their wait loop.

 arch/x86/kernel/cpu/mce/core.c | 67 ++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..3a842b3773b3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -282,20 +282,35 @@ static int fake_panic;
 static atomic_t mce_fake_panicked;
 
 /* Panic in progress. Enable interrupts and wait for final IPI */
-static void wait_for_panic(void)
+static void wait_for_panic(struct pt_regs *regs)
 {
 	long timeout = PANIC_TIMEOUT*USEC_PER_SEC;
 
 	preempt_disable();
 	local_irq_enable();
-	while (timeout-- > 0)
+	while (timeout-- > 0) {
+		/*
+		 * We are in an NMI waiting to be stopped by the
+		 * handing processor.  For kdump handling, we need to
+		 * be monitoring crash_ipi_issued since that is what
+		 * is used for an NMI stop used by kdump.  But we also
+		 * need to have interrupts enabled some so that
+		 * RESET_VECTOR will interrupt us on a normal
+		 * shutdown.
+		 */
+		local_irq_disable();
+		run_crash_ipi_callback(regs);
+		local_irq_enable();
+
 		udelay(1);
+	}
 	if (panic_timeout == 0)
 		panic_timeout = mca_cfg.panic_timeout;
 	panic("Panicing machine check CPU died");
 }
 
-static void mce_panic(const char *msg, struct mce *final, char *exp)
+static void mce_panic(const char *msg, struct mce *final, char *exp,
+		      struct pt_regs *regs)
 {
 	int apei_err = 0;
 	struct llist_node *pending;
@@ -306,7 +321,7 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		 * Make sure only one CPU runs in machine check panic
 		 */
 		if (atomic_inc_return(&mce_panicked) > 1)
-			wait_for_panic();
+			wait_for_panic(regs);
 		barrier();
 
 		bust_spinlocks(1);
@@ -817,7 +832,7 @@ static atomic_t mce_callin;
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
-static int mce_timed_out(u64 *t, const char *msg)
+static int mce_timed_out(u64 *t, const char *msg, struct pt_regs *regs)
 {
 	/*
 	 * The others already did panic for some reason.
@@ -827,12 +842,12 @@ static int mce_timed_out(u64 *t, const char *msg)
 	 */
 	rmb();
 	if (atomic_read(&mce_panicked))
-		wait_for_panic();
+		wait_for_panic(regs);
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
 		if (mca_cfg.tolerant <= 1)
-			mce_panic(msg, NULL, NULL);
+			mce_panic(msg, NULL, NULL, regs);
 		cpu_missing = 1;
 		return 1;
 	}
@@ -866,7 +881,7 @@ static int mce_timed_out(u64 *t, const char *msg)
  * All the spin loops have timeouts; when a timeout happens a CPU
  * typically elects itself to be Monarch.
  */
-static void mce_reign(void)
+static void mce_reign(struct pt_regs *regs)
 {
 	int cpu;
 	struct mce *m = NULL;
@@ -896,7 +911,7 @@ static void mce_reign(void)
 	 * other CPUs.
 	 */
 	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
-		mce_panic("Fatal machine check", m, msg);
+		mce_panic("Fatal machine check", m, msg, regs);
 
 	/*
 	 * For UC somewhere we let the CPU who detects it handle it.
@@ -909,7 +924,8 @@ static void mce_reign(void)
 	 * source or one CPU is hung. Panic.
 	 */
 	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
-		mce_panic("Fatal machine check from unknown source", NULL, NULL);
+		mce_panic("Fatal machine check from unknown source", NULL, NULL,
+			  regs);
 
 	/*
 	 * Now clear all the mces_seen so that they don't reappear on
@@ -928,7 +944,7 @@ static atomic_t global_nwo;
  * in the entry order.
  * TBD double check parallel CPU hotunplug
  */
-static int mce_start(int *no_way_out)
+static int mce_start(int *no_way_out, struct pt_regs *regs)
 {
 	int order;
 	int cpus = num_online_cpus();
@@ -949,7 +965,8 @@ static int mce_start(int *no_way_out)
 	 */
 	while (atomic_read(&mce_callin) != cpus) {
 		if (mce_timed_out(&timeout,
-				  "Timeout: Not all CPUs entered broadcast exception handler")) {
+				  "Timeout: Not all CPUs entered broadcast exception handler",
+				  regs)) {
 			atomic_set(&global_nwo, 0);
 			return -1;
 		}
@@ -975,7 +992,8 @@ static int mce_start(int *no_way_out)
 		 */
 		while (atomic_read(&mce_executing) < order) {
 			if (mce_timed_out(&timeout,
-					  "Timeout: Subject CPUs unable to finish machine check processing")) {
+					  "Timeout: Subject CPUs unable to finish machine check processing",
+					  regs)) {
 				atomic_set(&global_nwo, 0);
 				return -1;
 			}
@@ -995,7 +1013,7 @@ static int mce_start(int *no_way_out)
  * Synchronize between CPUs after main scanning loop.
  * This invokes the bulk of the Monarch processing.
  */
-static int mce_end(int order)
+static int mce_end(int order, struct pt_regs *regs)
 {
 	int ret = -1;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
@@ -1020,12 +1038,13 @@ static int mce_end(int order)
 		 */
 		while (atomic_read(&mce_executing) <= cpus) {
 			if (mce_timed_out(&timeout,
-					  "Timeout: Monarch CPU unable to finish machine check processing"))
+					  "Timeout: Monarch CPU unable to finish machine check processing",
+					  regs))
 				goto reset;
 			ndelay(SPINUNIT);
 		}
 
-		mce_reign();
+		mce_reign(regs);
 		barrier();
 		ret = 0;
 	} else {
@@ -1034,7 +1053,8 @@ static int mce_end(int order)
 		 */
 		while (atomic_read(&mce_executing) != 0) {
 			if (mce_timed_out(&timeout,
-					  "Timeout: Monarch CPU did not finish machine check processing"))
+					  "Timeout: Monarch CPU did not finish machine check processing",
+					  regs))
 				goto reset;
 			ndelay(SPINUNIT);
 		}
@@ -1286,9 +1306,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 */
 	if (lmce) {
 		if (no_way_out)
-			mce_panic("Fatal local machine check", &m, msg);
+			mce_panic("Fatal local machine check", &m, msg, regs);
 	} else {
-		order = mce_start(&no_way_out);
+		order = mce_start(&no_way_out, regs);
 	}
 
 	__mc_scan_banks(&m, final, toclear, valid_banks, no_way_out, &worst);
@@ -1301,7 +1321,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0)
+		if (mce_end(order, regs) < 0)
 			no_way_out = worst >= MCE_PANIC_SEVERITY;
 	} else {
 		/*
@@ -1314,7 +1334,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 */
 		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
 			mce_severity(&m, cfg->tolerant, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
+			mce_panic("Local fatal machine check!", &m, msg, regs);
 		}
 	}
 
@@ -1325,7 +1345,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if (cfg->tolerant == 3)
 		kill_it = 0;
 	else if (no_way_out)
-		mce_panic("Fatal machine check on current CPU", &m, msg);
+		mce_panic("Fatal machine check on current CPU", &m, msg, regs);
 
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
@@ -1361,7 +1381,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 */
 		if (m.kflags & MCE_IN_KERNEL_RECOV) {
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
+				mce_panic("Failed kernel mode recovery", &m,
+					  msg, regs);
 		}
 	}
 }
-- 
2.17.1

