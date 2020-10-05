Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB0283922
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJEPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJEPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:09:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F96C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xxeohqdIv89mzDJfjpwCuX9sjBeh9bJ8xoPvWhDfylk=; b=2/GHSsErGEa8dE66fD0LtlxLzr
        M0tSv04z7ugl3g6wb4HVaPswfnO4cYN4B1AB4JDUw6d06hT3EUp9hUvr4QjhNxTJ//XNDFz9CWRhs
        0WmPzakl0utGw4uub2zigCPfFhod1CNokoeukIxfWnipmS5ooP3tyJJwS2Qx79UQh7qP+gpzVMUdE
        YZT40FmvJNIOwcFsPWq6jdDyDTSNUBo5qajXuUa6RCc24M8SzHv0g4q8yELDgv2w8ZKQ3/wEhttm4
        KNAFWpkYylECbXojANpkSolb2oPHa4YISAntcWrBZpKMcdTpcxd2pmU9GvddP04OWbzBS7hwyH3jE
        6MpIAMvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7U-0008OV-RA; Mon, 05 Oct 2020 15:09:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDF4230504E;
        Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C738329A897B3; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150921.356084807@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 04/17] sched/core: Wait for tasks being pushed away on hotplug
References: <20201005145717.346020688@infradead.org>
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
 kernel/sched/core.c  |   40 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |    4 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6900,8 +6900,21 @@ static bool balance_push(struct rq *rq)
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
@@ -6934,6 +6947,20 @@ static void balance_push_set(int cpu, bo
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
 #else
 
 static inline bool balance_push(struct rq *rq)
@@ -6945,6 +6972,10 @@ static void balance_push_set(int cpu, bo
 {
 }
 
+static inline void balance_hotplug_wait(void)
+{
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -7099,6 +7130,10 @@ int sched_cpu_deactivate(unsigned int cp
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
+
+	/* Wait for all non per CPU kernel threads to vanish. */
+	balance_hotplug_wait();
+
 	return 0;
 }
 
@@ -7339,6 +7374,9 @@ void __init sched_init(void)
 
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


