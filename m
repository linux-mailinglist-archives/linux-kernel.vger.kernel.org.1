Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DD2D5EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgLJOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbgLJOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFCBC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kmxN9p1TxsDusmqJgv4dMKgjXEziuQG+HTNdqU/nOPw=; b=ea0pjtlqIkGFmhT9QR243LcuoQ
        O2oCi4sJ2pcrggmOQmXIObo+SXkr5gZstEgF7B1SDHNNCRuLBQCEO8jFUCI9TdUhFvYQ+lAeaiA1R
        RQDjLIFNXDm8wnnAJYeNuyW0Myae//J8CAci4SOU3fdEmwYASvrJ6/nmFbZXNLAWNXprGHRreAlAf
        hQ0VST6V6gnYa4MwvxbzO/n2Szdf/yWIDjmYYaPIG9m4ryj2G5MBUucOjTF2QAsNoZue0mQpieXbB
        adhHTXtlqXi0qOdHr0b2lBQt7jmE37cp1UD+O4mhXRb6QUhEeQ6JnQfcFVv3cdM05L62QxTIzLGUu
        tPgPD17w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF5-00042d-5g; Thu, 10 Dec 2020 14:48:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F06343075F1;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DA08F2BAB36D8; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144619.992963688@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:43:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 6/6] locking/selftests: Add local_lock inversion tests
References: <20201210144254.583402167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the local_lock_t inversion scenarios.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/locking-selftest.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -23,6 +23,7 @@
 #include <linux/debug_locks.h>
 #include <linux/irqflags.h>
 #include <linux/rtmutex.h>
+#include <linux/local_lock.h>
 
 /*
  * Change this to 1 if you want to see the failure printouts:
@@ -50,6 +51,7 @@ __setup("debug_locks_verbose=", setup_de
 #define LOCKTYPE_RWSEM	0x8
 #define LOCKTYPE_WW	0x10
 #define LOCKTYPE_RTMUTEX 0x20
+#define LOCKTYPE_LL	0x40
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -135,6 +137,8 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
 
 #endif
 
+static local_lock_t local_A = INIT_LOCAL_LOCK(local_A);
+
 /*
  * non-inlined runtime initializers, to let separate locks share
  * the same lock-class:
@@ -1314,6 +1318,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 # define I_WW(x)	lockdep_reset_lock(&x.dep_map)
+# define I_LOCAL_LOCK(x) lockdep_reset_lock(&local_##x.dep_map)
 #ifdef CONFIG_RT_MUTEXES
 # define I_RTMUTEX(x)	lockdep_reset_lock(&rtmutex_##x.dep_map)
 #endif
@@ -1324,6 +1329,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_
 # define I_MUTEX(x)
 # define I_RWSEM(x)
 # define I_WW(x)
+# define I_LOCAL_LOCK(x)
 #endif
 
 #ifndef I_RTMUTEX
@@ -1364,11 +1370,15 @@ static void reset_locks(void)
 	I1(X1); I1(X2); I1(Y1); I1(Y2); I1(Z1); I1(Z2);
 	I_WW(t); I_WW(t2); I_WW(o.base); I_WW(o2.base); I_WW(o3.base);
 	I_RAW_SPINLOCK(A); I_RAW_SPINLOCK(B);
+	I_LOCAL_LOCK(A);
+
 	lockdep_reset();
+
 	I2(A); I2(B); I2(C); I2(D);
 	init_shared_classes();
 	raw_spin_lock_init(&raw_lock_A);
 	raw_spin_lock_init(&raw_lock_B);
+	local_lock_init(&local_A);
 
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -2605,6 +2615,91 @@ static void wait_context_tests(void)
 	pr_cont("\n");
 }
 
+static void local_lock_2(void)
+{
+	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock_release(&local_A);
+
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);		/* IN-IRQ */
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT()
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
+	local_lock_release(&local_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+}
+
+static void local_lock_3A(void)
+{
+	local_lock_acquire(&local_A);	/* IRQ-ON */
+	spin_lock(&lock_B);		/* IRQ-ON */
+	spin_unlock(&lock_B);
+	local_lock_release(&local_A);
+
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);		/* IN-IRQ */
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT()
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_lock_release(&local_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+}
+
+static void local_lock_3B(void)
+{
+	local_lock_acquire(&local_A);	/* IRQ-ON */
+	spin_lock(&lock_B);		/* IRQ-ON */
+	spin_unlock(&lock_B);
+	local_lock_release(&local_A);
+
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);		/* IN-IRQ */
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT()
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_lock_release(&local_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	spin_lock(&lock_B);		/* IN-IRQ <-> IRQ-ON cycle, true */
+	spin_unlock(&lock_B);
+	spin_unlock(&lock_A);
+	HARDIRQ_DISABLE();
+
+}
+
+static void local_lock_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | local_lock tests |\n");
+	printk("  ---------------------\n");
+
+	print_testname("local_lock inversion  2");
+	dotest(local_lock_2, SUCCESS, LOCKTYPE_LL);
+	pr_cont("\n");
+
+	print_testname("local_lock inversion 3A");
+	dotest(local_lock_3A, SUCCESS, LOCKTYPE_LL);
+	pr_cont("\n");
+
+	print_testname("local_lock inversion 3B");
+	dotest(local_lock_3B, FAILURE, LOCKTYPE_LL);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2729,6 +2824,8 @@ void locking_selftest(void)
 	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING))
 		wait_context_tests();
 
+	local_lock_tests();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;


