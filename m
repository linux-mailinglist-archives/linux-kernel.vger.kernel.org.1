Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927E72F8D29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbhAPLok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbhAPLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E0C061795
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SP4OilyIG7VTP8HQlRY96D1X2yHrq8pxIsr7yb5ylsY=; b=OjvvdLR8f3fQYiz9QCa4zO7tMr
        sxTG6lQLN0P01IsmXG0UN0prvbdSqEfU1kPbBPMIahYsvGqb2fwfB80VF0ZfaImamUdKrngF+cbGl
        DZFVAKWySWPEzlKR12IgYgLlQoMLejotw4W1c8rVORMwbTqSuuQezi7P9XCAX4Ez91MhiHwfZ0ryo
        3niAXsuCW/rgmYJMsBkoLw22B45p6FWH2gcax8nhL6XHsYqZ3hOYnRoMmlarXxiFpYEn3SPwgXq2j
        0yySTyNj6rCnn0IXNKVt5TeMPiYu4Qz25ZK7IVIf4VCi3LbdAQYYAs5kKSdf19RkoKlA1bgKWcA8P
        jhg5n1ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0jyT-00ADOD-MQ; Sat, 16 Jan 2021 11:42:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BD6B305815;
        Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1ADF0202A3F56; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113919.587070474@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 1/8] sched/core: Print out straggler tasks in sched_cpu_dying()
References: <20210116113033.608340773@infradead.org>
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


