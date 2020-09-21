Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB88272FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgIURBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgIUQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:39:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10605C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NU2sC79nECRu0pUbQoIs8Nl8Vljm+Db7VBOWY1hgrn8=; b=Pae0ddY9qDiAxtnQogth+6cZFA
        WAZnK8APkR4zd1qjx7uwwgHBRCwuwAfjzE5XPGk6VBN16C5RyCH3vdmO2M28WjJvl5NmUaKEK4/UW
        rgStzYHwSrcXMdAKkWoOvmm6+j2BWWez544mTnw5PfdXppJ3sq9lNfyWVAYqVz4df3F65qDGEozZW
        g57z8I7NmF5/JnCPGqBoNs+0amVtZp5nCRRdHx2i2ZXX14OaVZotfIQsU2R2fZsw5sgXmK2xKnqGZ
        SAKes7J8ktm6zX/QxzZ1VveD9PeoZukbJycdvWg0IvIp1Ha7tAFSoIuNu6Ck80DreQf1zoTKzq7Lb
        KIBuumVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKOqD-000162-96; Mon, 21 Sep 2020 16:39:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D66C3307A5B;
        Mon, 21 Sep 2020 18:38:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A7BBA201DA662; Mon, 21 Sep 2020 18:38:59 +0200 (CEST)
Message-ID: <20200921163845.582326981@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 18:36:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: [PATCH 4/9] sched/core: Wait for tasks being pushed away on hotplug
References: <20200921163557.234036895@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT kernels need to ensure that all tasks which are not per CPU kthreads
have left the outgoing CPU to guarantee that no tasks are force migrated
within a migrate disabled section.

There is also some desire to (ab)use fine grained CPU hotplug control to
clear a CPU from active state to force migrate tasks which are not per CPU
kthreads away for power control purposes.

Add a mechanism which waits until all tasks which should leave the CPU
after the CPU active flag is cleared have moved to a different online CPU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   38 +++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |    4 ++++
 2 files changed, 41 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2588,6 +2588,20 @@ void sched_ttwu_pending(void *arg)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
+/*
+ * Invoked from a CPUs hotplug control thread after the CPU has been marked
+ * inactive. All tasks which are not per CPU kernel threads are either
+ * pushed off this CPU now via balance_push() or placed on a different CPU
+ * during wakeup. Wait until the CPU is quiescent.
+ */
+static void balance_hotplug_wait(void)
+{
+	struct rq *rq = this_rq();
+
+	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+			   TASK_UNINTERRUPTIBLE);
+}
+
 void send_call_function_single_ipi(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -6898,8 +6912,21 @@ static bool balance_push(struct rq *rq)
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task))
+	if (is_per_cpu_kthread(push_task)) {
+		/*
+		 * If this is the idle task on the outgoing CPU try to wake
+		 * up the hotplug control thread which might wait for the
+		 * last task to vanish. The rcuwait_active() check is
+		 * accurate here because the waiter is pinned on this CPU
+		 * and can't obviously be running in parallel.
+		 */
+		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
+			raw_spin_unlock(&rq->lock);
+			rcuwait_wake_up(&rq->hotplug_wait);
+			raw_spin_lock(&rq->lock);
+		}
 		return false;
+	}
 
 	get_task_struct(push_task);
 	/*
@@ -6939,6 +6966,8 @@ static inline bool balance_push(struct r
 	return false;
 }
 
+static inline void balance_hotplug_wait(void) { }
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -7093,6 +7122,10 @@ int sched_cpu_deactivate(unsigned int cp
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
+
+	/* Wait for all non per CPU kernel threads to vanish. */
+	balance_hotplug_wait();
+
 	return 0;
 }
 
@@ -7333,6 +7366,9 @@ void __init sched_init(void)
 
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+		rcuwait_init(&rq->hotplug_wait);
+#endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1004,6 +1004,10 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	struct rcuwait		hotplug_wait;
+#endif
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING


