Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AF51BCD19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD1UKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 16:10:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13198 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgD1UKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:10:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588104612; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=vgidk6BTEpz/gd67YkiCMhxW3KTz7j3tTENZAmjp+qs=; b=sBKwT0Mx2w1SF3aAcwuUVsJ3Hw/SWFuL7hc9AxfOI26bRG/ltxK4/zXD4JmJ2Mtu+BiOAFCk
 Gh/zmb1pW0xUrZFxfAkvYuSew2i/HSnoP5OQ3UMDQ3NhjkWG3wSOf4cD6+JlHWJgumgLcSGu
 0wFcxXD4dtZttgG5geAfs7M42yI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea88d95.7f0905ff1570-smtp-out-n05;
 Tue, 28 Apr 2020 20:09:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A40AC433F2; Tue, 28 Apr 2020 20:09:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B477C433CB;
        Tue, 28 Apr 2020 20:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B477C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: [PATCH v2 2/2] sched: Add a check for cpu unbound deferrable timers
Date:   Tue, 28 Apr 2020 13:09:39 -0700
Message-Id: <1588104579-8712-3-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588104579-8712-1-git-send-email-psodagud@codeaurora.org>
References: <1588104579-8712-1-git-send-email-psodagud@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for cpu unbound deferrable timer expiry and raise
softirq for handling the expired timers so that the CPU can
process the cpu unbound deferrable times as early as possible
when a cpu tries to enter/exit idle loop.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 include/linux/timer.h    |  3 +++
 kernel/time/tick-sched.c |  8 +++++++-
 kernel/time/timer.c      | 29 ++++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 0dc19a8..e85dd2d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -172,6 +172,9 @@ extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
+#ifdef CONFIG_SMP
+extern bool check_pending_deferrable_timers(int cpu);
+#endif
 
 /*
  * The jiffies value which is added to now, when there is no timer
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b..16aec80 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
+#include <linux/timer.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
 
@@ -1274,8 +1275,13 @@ static inline void tick_nohz_irq_enter(void)
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
-	if (ts->tick_stopped)
+	if (ts->tick_stopped) {
 		tick_nohz_update_jiffies(now);
+#ifdef CONFIG_SMP
+		if (check_pending_deferrable_timers(smp_processor_id()))
+			raise_softirq_irqoff(TIMER_SOFTIRQ);
+#endif
+	}
 }
 
 #else
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5ab8e33..c8327b4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,6 +221,7 @@ static DECLARE_WORK(timer_update_work, timer_update_keys);
 
 #ifdef CONFIG_SMP
 struct timer_base timer_base_deferrable;
+static atomic_t deferrable_pending;
 unsigned int sysctl_timer_migration = 1;
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
@@ -1610,6 +1611,31 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+
+#ifdef CONFIG_SMP
+/*
+ * check_pending_deferrable_timers - Check for unbound deferrable timer expiry
+ * @cpu - Current CPU
+ *
+ * The function checks whether any global deferrable pending timers
+ * are exipired or not. This function does not check cpu bounded
+ * diferrable pending timers expiry.
+ *
+ * The function returns true when a cpu unbounded deferrable timer is expired.
+ */
+bool check_pending_deferrable_timers(int cpu)
+{
+	if (cpu == tick_do_timer_cpu ||
+		tick_do_timer_cpu == TICK_DO_TIMER_NONE) {
+		if (time_after_eq(jiffies, timer_base_deferrable.clk)
+			&& !atomic_cmpxchg(&deferrable_pending, 0, 1)) {
+			return true;
+		}
+	}
+	return false;
+}
+#endif
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1800,7 +1826,8 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
-		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
+		if ((atomic_cmpxchg(&deferrable_pending, 1, 0) &&
+				tick_do_timer_cpu == TICK_DO_TIMER_NONE) ||
 				tick_do_timer_cpu == smp_processor_id())
 			__run_timers(&timer_base_deferrable);
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
