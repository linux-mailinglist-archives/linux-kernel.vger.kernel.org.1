Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0267A2CF2C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgLDRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48690 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbgLDRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:31 -0500
Message-Id: <20201204170804.765109984@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Z7M5dUtcL3KR7VXsxVRHm3Buv+XRwSuxEfs12MLAt/w=;
        b=VZD7afw5ctbek8108g8amw41mXmWx4hmv8vPjZr9oNs7K6+NskUcCOGYljKu8xWhmC2DLP
        hWnjX4KWR2X2TloblXxrwrr3mZHdd7SuBD8/zLmGx3Sk8RyaS+hYZ9cKeSMTj2YzjvDC8m
        D45JjQdDrFMytEnDPK/OuzQU2MywQP07k2IIXQJ1iOcEENiuyc16roURZ60nVAsnxY5505
        dpiKCBWgF2lnVNDZ+rzrf5U59W3Dh4TuYVlnvmnwpYbb7E5M7pWnQncSEP3yHFbX7rL8EZ
        f3gxhMuZsTea22X6PZ/eKlkQw4rDTFh2qDjedrZ9tsywuSMA4W25TDWnO+hPXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Z7M5dUtcL3KR7VXsxVRHm3Buv+XRwSuxEfs12MLAt/w=;
        b=u5fBMe6lIJZ9DFYd5Z9BDTjWw8jteyJHBYfqNc9fIWlENTqKxHJJKRyBIen4ji7jPf0ZIL
        Y+fc0cT42BxiiGAA==
Date:   Fri, 04 Dec 2020 18:01:52 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 1/9] softirq: Add RT specific softirq accounting
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT requires the softirq processing and local bottomhalf disabled regions to
be preemptible. Using the normal preempt count based serialization is
therefore not possible because this implicitely disables preemption.

RT kernels use a per CPU local lock to serialize bottomhalfs. As
local_bh_disable() can nest the lock can only be acquired on the outermost
invocation of local_bh_disable() and released when the nest count becomes
zero. Tasks which hold the local lock can be preempted so its required to
keep track of the nest count per task.

Add a RT only counter to task struct and adjust the relevant macros in
preempt.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Rewrote changelog.
---
 include/linux/hardirq.h |    1 +
 include/linux/preempt.h |    6 +++++-
 include/linux/sched.h   |    3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
+#include <linux/sched.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -79,7 +79,11 @@
 
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#ifdef CONFIG_PREEMPT_RT
+# define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+#else
+# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#endif
 #define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1004,6 +1004,9 @@ struct task_struct {
 	int				softirq_context;
 	int				irq_config;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	int				softirq_disable_cnt;
+#endif
 
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL

