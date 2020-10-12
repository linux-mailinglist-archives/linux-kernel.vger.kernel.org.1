Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A552328B851
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbgJLNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390171AbgJLNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:51:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC85C0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:51:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j7so3557160pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+oCHPQIsmBHbp5sl5NcvVgDhy7rgRod47PKBZMuX88g=;
        b=MxZT8B7NiPi0u7nN6yQjUKQDwkkel8/3hJ4ZyIrVH71ltmsC9En9XMvJxsuQs4p/vj
         Y2HPCDEQLGvMDpsPKlT9g4P9dZUChtrBb62rbiobHp6VFVsKXFwvP8XfDTOYC//gnQqY
         5yVFWDWVJhHN92C5E6GCuulHheu+eki2thuKUZiz5SbJEj3KJp1P6T8ys8M3nhVNmBkY
         NwkId3BJugqKwuzNJitO8BjHuV8zm5KIwO0pp425/0YBsSwfxWkkn7PyGwU59Gk20BTG
         2mk6hxOj4LTuzx15KOwNUD7rgJiPky8wPFxEKoYYFVxhKiNywQxC0pcYGKYpIN21/x6c
         OOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+oCHPQIsmBHbp5sl5NcvVgDhy7rgRod47PKBZMuX88g=;
        b=boY5YuDM/4QwQCJLUbny9d1DxsnVeejSONgzTDgGNf9uP21EAeX1eY0MT/wJQpJYve
         MS/LJ+52wg87wP4pSx0/4lmyOCRfSPCfsVZW7RH35rABMEbpVRb6hVcFXpYHn0BB/E1u
         R1TvDh5iVSsx9+ol742QgDu8/JFxr2eeEDQnIMI5CQhZsm5Z5MMMUEQ1z0ZTcFG/xP2V
         d+MNKQj4IYjQ2Gr+WSChCKKqXAFaSi4i/7JAZfJGALXsECkotUms6/gMSbZK1mM94Wfk
         wSumne9BOgLgC6y3EWR7J9BGAGalPTXoPCA1KSyddIdjIJmV9L3mCtpGtKF37n+uaCYh
         4GFA==
X-Gm-Message-State: AOAM532hF96/KmZj6Hg/g6N/0D7RkI2N19DqFQ7JUjHDDv3VSzqLODP2
        XDzQshkMwFS+E1hkWIG4KDxMa2Ly9Q==
X-Google-Smtp-Source: ABdhPJwSmQxuZs7W6vQzvkGeWArVdiYNErHfhvVsVWuOoRdYTwIOKZvkN8SvHtTYPOhb95dqrNEFZA==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr13778135pgd.0.1602510661213;
        Mon, 12 Oct 2020 06:51:01 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3sm9354162pju.28.2020.10.12.06.50.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 06:51:00 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH] sched/cputime: correct account of irqtime
Date:   Mon, 12 Oct 2020 21:50:44 +0800
Message-Id: <1602510644-24536-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__do_softirq() may be interrupted by hardware interrupts. In this case,
irqtime_account_irq() will account the time slice as CPUTIME_SOFTIRQ by
mistake.

By passing irqtime_account_irq() an extra param about either hardirq or
softirq, irqtime_account_irq() can handle the above case.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Allen Pais <allen.lkml@gmail.com>
Cc: Romain Perier <romain.perier@gmail.com>
To: linux-kernel@vger.kernel.org
---
 include/linux/hardirq.h |  4 ++--
 include/linux/vtime.h   | 12 ++++++------
 kernel/sched/cputime.c  |  4 ++--
 kernel/softirq.c        |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 754f67a..56e7bb5 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -32,7 +32,7 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
+		account_irq_enter_time(current, true);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
 		lockdep_hardirq_enter();		\
 	} while (0)
@@ -63,7 +63,7 @@ void irq_enter_rcu(void);
 #define __irq_exit()					\
 	do {						\
 		lockdep_hardirq_exit();			\
-		account_irq_exit_time(current);		\
+		account_irq_exit_time(current, true);	\
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca0..294188ae1 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -98,21 +98,21 @@ static inline void vtime_flush(struct task_struct *tsk) { }
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-extern void irqtime_account_irq(struct task_struct *tsk);
+extern void irqtime_account_irq(struct task_struct *tsk, bool hardirq);
 #else
-static inline void irqtime_account_irq(struct task_struct *tsk) { }
+static inline void irqtime_account_irq(struct task_struct *tsk, bool hardirq) { }
 #endif
 
-static inline void account_irq_enter_time(struct task_struct *tsk)
+static inline void account_irq_enter_time(struct task_struct *tsk, bool hardirq)
 {
 	vtime_account_irq_enter(tsk);
-	irqtime_account_irq(tsk);
+	irqtime_account_irq(tsk, hardirq);
 }
 
-static inline void account_irq_exit_time(struct task_struct *tsk)
+static inline void account_irq_exit_time(struct task_struct *tsk, bool hardirq)
 {
 	vtime_account_irq_exit(tsk);
-	irqtime_account_irq(tsk);
+	irqtime_account_irq(tsk, hardirq);
 }
 
 #endif /* _LINUX_KERNEL_VTIME_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d23..166f1d7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -47,7 +47,7 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
  * Called before incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
  */
-void irqtime_account_irq(struct task_struct *curr)
+void irqtime_account_irq(struct task_struct *curr, bool hardirq)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
 	s64 delta;
@@ -68,7 +68,7 @@ void irqtime_account_irq(struct task_struct *curr)
 	 */
 	if (hardirq_count())
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd() && !hardirq)
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 EXPORT_SYMBOL_GPL(irqtime_account_irq);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f6..da59ea39 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -270,7 +270,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
-	account_irq_enter_time(current);
+	account_irq_enter_time(current, false);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
 	in_hardirq = lockdep_softirq_start();
@@ -321,7 +321,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	}
 
 	lockdep_softirq_end(in_hardirq);
-	account_irq_exit_time(current);
+	account_irq_exit_time(current, false);
 	__local_bh_enable(SOFTIRQ_OFFSET);
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
@@ -417,7 +417,7 @@ static inline void __irq_exit_rcu(void)
 #else
 	lockdep_assert_irqs_disabled();
 #endif
-	account_irq_exit_time(current);
+	account_irq_exit_time(current, true);
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
-- 
2.7.5

