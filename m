Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724042FE7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbhAUKmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbhAUKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:38:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7CC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SP4OilyIG7VTP8HQlRY96D1X2yHrq8pxIsr7yb5ylsY=; b=DcyYET2vpzXJ2ggGeOpOvmFFqV
        DQd3kLFHit6MJbodd86P2ETL8ot7razOE+HBmfKyzhL7xzjcwVMBQBtjCgHtbR/rMI4u57BFudh42
        /Qw3MbTWptHHZhxjsPXclT5XiymaVUAplE1Xy63ZbwIu/0LenOtZt6G5L7oGcwuk4hahXIIIIDwHx
        EwTzFfb5Koejr1A8MYnYS9K0nakfbWCq8Wu1Rsx5D8mRQIwXdH0k19hsBec1OkjWBQuDdnGGnWMa/
        3Dqp22HKXr8j5SFhySZqPqSDpA/YyW0AwHGZCxaU9fOrRxzk2nPab2y4yqg3XIxhjgQbLduESO2jz
        ftOrMaow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2XKJ-00GvZn-MB; Thu, 21 Jan 2021 10:36:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC8903059DD;
        Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4EAFD20C8680D; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121103506.168300054@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 1/9] sched/core: Print out straggler tasks in sched_cpu_dying()
References: <20210121101702.402798862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

Since commit

  1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")

tasks are expected to move themselves out of a out-going CPU. For most
tasks this will be done automagically via BALANCE_PUSH, but percpu kthreads
will have to cooperate and move themselves away one way or another.

Currently, some percpu kthreads (workqueues being a notable exemple) do not
cooperate nicely and can end up on an out-going CPU at the time
sched_cpu_dying() is invoked.

Print the dying rq's tasks to shed some light on the stragglers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210113183141.11974-1-valentin.schneider@arm.com
---
 kernel/sched/core.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7580,6 +7580,25 @@ static void calc_load_migrate(struct rq
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
+static void dump_rq_tasks(struct rq *rq, const char *loglvl)
+{
+	struct task_struct *g, *p;
+	int cpu = cpu_of(rq);
+
+	lockdep_assert_held(&rq->lock);
+
+	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
+	for_each_process_thread(g, p) {
+		if (task_cpu(p) != cpu)
+			continue;
+
+		if (!task_on_rq_queued(p))
+			continue;
+
+		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
+	}
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7589,7 +7608,10 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
+	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
+		WARN(true, "Dying CPU not properly vacated!");
+		dump_rq_tasks(rq, KERN_WARNING);
+	}
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);


