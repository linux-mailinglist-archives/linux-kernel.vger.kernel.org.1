Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82F62B1D35
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgKMOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgKMOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:34 -0500
Message-Id: <20201113141734.442990268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ze6MlncdnmAY8gfHx7Z+rZEVhWAMCevnsPTsGbdb6v0=;
        b=G1UREJyGcaUjT+N2wtoQyCERcLxyjyMAfw8NfT+wy0zwm0us+pf2Ntglv96NgSHbt9/Yjp
        qoaQCmQHCEZLSl4tgh2fObbzd5Eg0IzKsZOwRDqSmqku7HiNL3S3LkyTYUFx3yi5dSfTxu
        MFctcDrCS9gok9I097XT39eWW13m7iPU863iXCxWWkLue2i4sFBBOxeCX2J3FMIX3WJFOU
        XfnbdSiKjTIyQx4waIuiaRF6W5mUn7JksZs9HbxgKcANUpu5giQHMT3WvlrsVLnuu9ttOJ
        05xVo+iYIedu+Z/p/XcxdBOfYtlbWlAMcmQFwZfDQFcdF0rqvP2z6Iy7H5Dc2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ze6MlncdnmAY8gfHx7Z+rZEVhWAMCevnsPTsGbdb6v0=;
        b=Qk1c/61DOVl3kFFVW+aZ3dXfkp84eaNY2QVxxJLj8d6ltQSfXPHHs0VNAwsQ94XeTMC/Dx
        80Ju8vg9dueyHvAQ==
Date:   Fri, 13 Nov 2020 15:02:22 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 15/19] tick/sched: Prevent false positive softirq pending
 warnings on RT
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

