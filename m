Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFDD2B1D37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgKMOYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52960 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgKMOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:40 -0500
Message-Id: <20201113141734.907075915@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YBANw5+gKo0StNgfq2DAY2w568FUqe7IjvTxRxyhO0o=;
        b=CaNkSgmHOT8cChidgcipppyqnkXkMwbX36+aFt96F4A75TGeSz5Zhl+di5OltLmYsPtOcx
        quLDc5LLj6LblcQBRv5T8U2YTKstywSV4Fnr3VcKozPIF6fRJYoUQ1Olop/0XEo/nvWuKK
        AaWYWZNs1SHuSgrkR+sSNNUqkK/BZ+Mzqxcz+uw6LWxyeMfi7P4VPTLfGShWD5dSRZcvmV
        k6G5XKLQZrLBaSh78ZCTGlgHOMm+unqZIPu2euxm/TvxLdSaJIG/Ema0BvWrq4w4cjd3wq
        /o6/AEK8K3F6hkA6SrcnJ6gUpmrTkYW/8FpCsAN598OKXx8HQHBM1zasSFWkjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YBANw5+gKo0StNgfq2DAY2w568FUqe7IjvTxRxyhO0o=;
        b=0cKyj2lLbsO8b/2NxbYx+cHBAmiqLRZavh3aPgFuRABbFMMdYZx0eS73Lzn7tmtBZWlqdE
        UDGBXB070OjHFACQ==
Date:   Fri, 13 Nov 2020 15:02:26 +0100
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
Subject: [patch 19/19] tasklets: Prevent kill/unlock_wait deadlock on RT
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tasklet_kill() and tasklet_unlock_wait() spin and wait for the
TASKLET_STATE_SCHED resp. TASKLET_STATE_RUN bit in the tasklet state to be
cleared. This works on !RT nicely because the corresponding execution can
only happen on a different CPU.

On RT softirq processing is preemptible, therefore a task preempting the
softirq processing thread can spin forever. Prevent this by invoking
local_bh_disable()/enable() inside the loop. In case that the softirq
processing thread was preempted by the current task, current will block on
the local lock which yields the CPU to the preempted softirq processing
thread. If the tasklet is processed on a different CPU then the
local_bh_disable()/enable() pair is just a waste of processor cycles.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    8 ++------
 kernel/softirq.c          |   38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 7 deletions(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -654,7 +654,7 @@ enum
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
@@ -666,11 +666,7 @@ static inline void tasklet_unlock(struct
 	clear_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
-static inline void tasklet_unlock_wait(struct tasklet_struct *t)
-{
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state))
-		cpu_relax();
-}
+void tasklet_unlock_wait(struct tasklet_struct *t);
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -851,6 +851,29 @@ void tasklet_init(struct tasklet_struct
 }
 EXPORT_SYMBOL(tasklet_init);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+
+void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/*
+			 * Prevent a live lock when current preempted soft
+			 * interrupt processing or prevents ksoftirqd from
+			 * running. If the tasklet runs on a different CPU
+			 * then this has no effect other than doing the BH
+			 * disable/enable dance for nothing.
+			 */
+			local_bh_disable();
+			local_bh_enable();
+		} else {
+			cpu_relax();
+		}
+	}
+}
+EXPORT_SYMBOL(tasklet_unlock_wait);
+#endif
+
 void tasklet_kill(struct tasklet_struct *t)
 {
 	if (in_interrupt())
@@ -858,7 +881,20 @@ void tasklet_kill(struct tasklet_struct
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		do {
-			yield();
+			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+				/*
+				 * Prevent a live lock when current
+				 * preempted soft interrupt processing or
+				 * prevents ksoftirqd from running. If the
+				 * tasklet runs on a different CPU then
+				 * this has no effect other than doing the
+				 * BH disable/enable dance for nothing.
+				 */
+				local_bh_disable();
+				local_bh_enable();
+			} else {
+				yield();
+			}
 		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
 	}
 	tasklet_unlock_wait(t);

