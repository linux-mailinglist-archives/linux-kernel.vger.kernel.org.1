Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685D02CF2CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgLDRKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgLDRKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46229C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:09:55 -0800 (PST)
Message-Id: <20201204170805.232293729@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ut+xfhfjAeWR5XwkEIdbGgZ0xpY7Wr1KR2JhRfjIcFw=;
        b=uKeix71pEV3HfcAcSDX0+4oZBH4sNEZcErSi68m83BpmzEuzQIT9Kaj85wU2h/UFeJyWsE
        FDswEpwcbonfn+ftPN+mEEVFVOSotsUrzym7Xci6qBfGIYQjVk8bkp7OOR7yt0c1t1L/H5
        cpQ7hzmhyN4U+4b7bX4niXRSx0jQFHSr8Rj92/nTBWFQ6OqeKeyfKZs7MahwnYJH+S9ELs
        Sm56IWEGofQjcqPJ6IuTPc7LwFhR11VevfVV1EMlVDwNDv+Kar22qr/ce5nJR8aDUCtJph
        GoCDVGyQpk3NZQCu/Tff+3ot5GcMZmBemH9u8RyPrVvFuSuOYtfunMGo2pzJtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ut+xfhfjAeWR5XwkEIdbGgZ0xpY7Wr1KR2JhRfjIcFw=;
        b=zf6hYzPBEDNYaiQCMlFoT2FDLoJM/IIGo98sDE/J62XZ+r6AK9cfx3M201Pgqc0PD5P5Lf
        lJAZEsnxLvNZdeBA==
Date:   Fri, 04 Dec 2020 18:01:56 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 5/9] tick/sched: Prevent false positive softirq pending
 warnings on RT
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On RT a task which has soft interrupts disabled can block on a lock and
schedule out to idle while soft interrupts are pending. This triggers the
warning in the NOHZ idle code which complains about going idle with pending
soft interrupts. But as the task is blocked soft interrupt processing is
temporarily blocked as well which means that such a warning is a false
positive.

To prevent that check the per CPU state which indicates that a scheduled
out task has soft interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/bottom_half.h |    6 ++++++
 kernel/softirq.c            |   15 +++++++++++++++
 kernel/time/tick-sched.c    |    2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -32,4 +32,10 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+extern bool local_bh_blocked(void);
+#else
+static inline bool local_bh_blocked(void) { return false; }
+#endif
+
 #endif /* _LINUX_BH_H */
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -138,6 +138,21 @@ static DEFINE_PER_CPU(struct softirq_ctr
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+/**
+ * local_bh_blocked() - Check for idle whether BH processing is blocked
+ *
+ * Returns false if the per CPU softirq::cnt is 0 otherwise true.
+ *
+ * This is invoked from the idle task to guard against false positive
+ * softirq pending warnings, which would happen when the task which holds
+ * softirq_ctrl::lock was the only running task on the CPU and blocks on
+ * some other lock.
+ */
+bool local_bh_blocked(void)
+{
+	return this_cpu_read(softirq_ctrl.cnt) != 0;
+}
+
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -925,7 +925,7 @@ static bool can_stop_idle_tick(int cpu,
 	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !local_bh_blocked() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());

