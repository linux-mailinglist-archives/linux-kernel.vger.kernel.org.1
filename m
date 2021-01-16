Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256752F8D28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhAPLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E05C061794
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Oh7lrRt5oilfVSMIiVwfXj1sKUuD0GvuQD8uxMTs6qo=; b=V6wvKR+q/1HdBXyKXgEdCug93L
        lIU5hE0/9D5fsj9ezhsucScQmzXLrPp/TQA4+mTJ7rbwXr9p/+9OBxDlWYoDBtV6iL/xik5fhuDKZ
        zeK4DdEAoSh8r4VlHQTgx1UMS9FyZFrp4KiTrMArK0Ty5pcWn89LpvPDwG/n5CnAr9grZi8Qk8X7D
        vH5iiIdWfCYmoYTv+ecLFSAVP4Si1X4f7dWzVuUW1IoLJEOKZl5kjQmu8DRvI99PCZSutmqsbKR0S
        fWREDalc/K/7ES52n0d6TNWmLc1qHk3ABfZUKZyW2AdLrDO1yxbUX+fsCO3c7ZZU1kvaHYm8WfK6y
        JopZdrIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0jyT-00ADOC-MF; Sat, 16 Jan 2021 11:42:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2A3E3060C5;
        Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2B71E20285FAC; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113919.933156564@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 5/8] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
References: <20210116113033.608340773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the per-cpu workqueue workers as KTHREAD_IS_PER_CPU.

Workqueues have unfortunate semantics in that per-cpu workers are not
default flushed and parked during hotplug, however a subset does
manual flush on hotplug and hard relies on them for correctness.

Therefore play silly games..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/workqueue.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct
 	 */
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
+	else
+		kthread_set_per_cpu(worker->task, pool->cpu);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1883,6 +1885,7 @@ static void worker_detach_from_pool(stru
 
 	mutex_lock(&wq_pool_attach_mutex);
 
+	kthread_set_per_cpu(worker->task, -1);
 	list_del(&worker->node);
 	worker->pool = NULL;
 
@@ -2368,6 +2371,7 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
 woke_up:
+	kthread_parkme();
 	raw_spin_lock_irq(&pool->lock);
 
 	/* am I supposed to die? */
@@ -2425,7 +2429,7 @@ static int worker_thread(void *__worker)
 			move_linked_works(work, &worker->scheduled, NULL);
 			process_scheduled_works(worker);
 		}
-	} while (keep_working(pool));
+	} while (keep_working(pool) && !kthread_should_park());
 
 	worker_set_flags(worker, WORKER_PREP);
 sleep:
@@ -2437,9 +2441,12 @@ static int worker_thread(void *__worker)
 	 * event.
 	 */
 	worker_enter_idle(worker);
-	__set_current_state(TASK_IDLE);
+	set_current_state(TASK_IDLE);
 	raw_spin_unlock_irq(&pool->lock);
-	schedule();
+
+	if (!kthread_should_park())
+		schedule();
+
 	goto woke_up;
 }
 
@@ -4919,8 +4926,10 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool)
+		for_each_pool_worker(worker, pool) {
+			kthread_set_per_cpu(worker->task, -1);
 			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
@@ -4972,9 +4981,11 @@ static void rebind_workers(struct worker
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
+	for_each_pool_worker(worker, pool) {
+		WARN_ON_ONCE(kthread_park(worker->task) < 0);
+		kthread_set_per_cpu(worker->task, pool->cpu);
+		kthread_unpark(worker->task);
+	}
 
 	raw_spin_lock_irq(&pool->lock);
 


