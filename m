Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94F02F8BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbhAPF55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 00:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 00:57:56 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 21:57:16 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n10so7386630pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 21:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wr1zj4g5+kSqvyK+nDC+9JpL5hm0tg8hlGdz3cxA7oA=;
        b=a8jfRp9vjjNgrmuKRgonTby9ca7OQ2z7WSdfEyTKfncKhuFz8h8V4LaHMdG5qLaGpM
         acV3OVSYt0BWmsgoBQ8Wbo9kO16I2py8uNmmK+bk320sv5XY8Wz/thNvhl8Z0TCKGZyg
         QbdkBMKgNLf8DKsfrB2KuMf38tD+4CHGAl4EFCJcYmG2Su2ZiXpsqJzd4QBDcPq2XwMp
         g/zeRGPPUSc8sKPK2pIfD027iIV4tY/P3ThYrbhDM+tLLYN3s+jEsKg2ldHk/NTraAPk
         t8GUuzHJb+e7qEtOYm11fJ8bn5jahrS0k8PF4Gl9pi4HtZXg3KVCj182kXZnIuv/BklO
         YqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wr1zj4g5+kSqvyK+nDC+9JpL5hm0tg8hlGdz3cxA7oA=;
        b=j/I+E6Jr9LIjCmZsEk+x2gDJRj3BFxoRdr3O5QgNctOoJPPo+KdqCyxQLuyJG70XJp
         ptmvbjRoUV5T7OQvATrt/N3hgt4+1xXXYIVplVOO/tmyfKmqgl3Xn8tW0PcChdPT822+
         PLrj2SXH+vBUZDWKlIZ1lRaktAG/awTnc1SnKln6kevng8tBIwXWu0cFSLEMaIT+gq3g
         aZecz35Ked53nimY437vR8J10MB4xKMTxcsivWyliDGve3BrQzAEMKNEwrgQEHCrfMYR
         QASeCPCdPikobJH9h0+lHjkTLpGauzDYMgtwdTf6Qd7diyHle0InP2UYUBFgACRAS/cq
         AkHA==
X-Gm-Message-State: AOAM5337rnK6QOIk1gx/byXcJtgNI688DTL9IgpyA85ijUixDjWrSOmq
        kDmpfEGTU8A6aO1Cxj3QWhuG6zUvARc=
X-Google-Smtp-Source: ABdhPJwXhPR8deLOR/IvDHsUqGlw99Tx5pvqbcKFoC+5Pkl9XOjZKSMF/DXKgCWvAclRp6wXjF4ilg==
X-Received: by 2002:a62:17c3:0:b029:19d:ce3b:d582 with SMTP id 186-20020a6217c30000b029019dce3bd582mr16341250pfx.18.1610776635972;
        Fri, 15 Jan 2021 21:57:15 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id 19sm9590510pfu.85.2021.01.15.21.57.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 21:57:15 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: keep unbound rescuer's cpumask to be default cpumask
Date:   Sat, 16 Jan 2021 14:57:53 +0800
Message-Id: <20210116065753.2163-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When we attach a rescuer to a pool, we will set the rescuer's cpumask
to the pool's cpumask.  If there is hotplug ongoing, it may cause
the rescuer running on the dying CPU and cause bug or it may cause
warning of setting online&!active cpumask.

So we have to find a reliable way to set cpumask when attaching
rescuer.

When the pool is percpu pool, we have easy way to reliably
set cpumask with the help of %POOL_DISASSOCIATED.

But when it is unbound rescuer, the problem becomes harder, because
we can't neither use get_online_cpus() here nor test cpu_active_mask
without synchronization.

Atfer investigation, and noticing the unbound nature of the unbound
rescuer, we decide to make it use the wq's default pwq's cpumask so
that we don't need to set the rescuer's cpumask when attaching.

To implement it, we have to set unbound rescuer's cpumask to the
default pwq's cpumask when creation and maintain it when hotplug
or the default pwq is changed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
NOTE:
	this patch is designed to be a complement of Peter's
patchset https://lore.kernel.org/lkml/20210112144344.850850975@infradead.org/
where it has a problem dealing with rescuer.

 kernel/workqueue.c | 101 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c0e272..901abab945d4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,16 +1849,37 @@ static void worker_attach_to_pool(struct worker *worker,
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
-
-	/*
+	 * If we called from create_worker(), we don't need to call
+	 * set_cpus_allowed_ptr() since we just call kthread_bind_mask()
+	 * on it with proper cpumask.
+	 *
+	 * The only other path gets us here is rescuer_thread().  And we
+	 * only call set_cpus_allowed_ptr() to rescuer for percpu pool.
+	 *
+	 * For bound percpu pool, the task's mask is set to the pool's
+	 * mask.  For unbound percpu pool whose cpu is offline, the task's
+	 * mask is set to cpu_possible_mask instead of sticking to the
+	 * previous served percpu pool's mask.
+	 *
+	 * Unboud wq's rescuer's cpumask is kept as the same as the wq's
+	 * default pwq's cpumask and maintained when cpu hotplug and
+	 * the update of the wq's default pwq.
+	 *
+	 * set_cpus_allowed_ptr() will not fail here since the pool's CPU
+	 * is online for !POOL_DISASSOCIATED and set_cpus_allowed_ptr() can
+	 * not fail on cpu_possible_mask.
+	 *
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
 	 * stable across this function.  See the comments above the flag
 	 * definition for details.
 	 */
+	if (worker->rescue_wq && pool->cpu >= 0) {
+		if (!(pool->flags & POOL_DISASSOCIATED))
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+		else
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+	}
+
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
 
@@ -4003,6 +4024,25 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	link_pwq(ctx->dfl_pwq);
 	swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
 
+	if (ctx->wq->rescuer) {
+		struct task_struct *task = ctx->wq->rescuer->task;
+		struct cpumask *dfl_mask = ctx->dfl_pwq->pool->attrs->cpumask;
+
+		/*
+		 * set the rescuer's cpumask to default pwq's cpumask.
+		 *
+		 * There might be no CPUs online in the default pwq's
+		 * cpumask and set_cpus_allowed_ptr() will fail on this
+		 * cpumask, so we use cpu_possible_mask instead and
+		 * restore_unbound_rescuer_cpumask() will restore for us
+		 * when the CPUs are back.
+		 */
+		if (cpumask_intersects(dfl_mask, cpu_online_mask))
+			WARN_ON_ONCE(set_cpus_allowed_ptr(task, dfl_mask) < 0);
+		else
+			WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpu_possible_mask) < 0);
+	}
+
 	mutex_unlock(&ctx->wq->mutex);
 }
 
@@ -4241,7 +4281,14 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	wq->rescuer = rescuer;
-	kthread_bind_mask(rescuer->task, cpu_possible_mask);
+	if (wq->flags & WQ_UNBOUND) {
+		/* grab wq->mutex for accessing wq->dfl_pwq */
+		mutex_lock(&wq->mutex);
+		kthread_bind_mask(rescuer->task, wq->dfl_pwq->pool->attrs->cpumask);
+		mutex_unlock(&wq->mutex);
+	} else {
+		kthread_bind_mask(rescuer->task, cpu_possible_mask);
+	}
 	wake_up_process(rescuer->task);
 
 	return 0;
@@ -5042,8 +5089,42 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
 
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
-	for_each_pool_worker(worker, pool)
+	for_each_pool_worker(worker, pool) {
+		/* rescuer is handled via restore_unbound_rescuer_cpumask() */
+		if (worker->rescue_wq)
+			continue;
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
+	}
+}
+
+/**
+ * restore_unbound_rescuer_cpumask - restore cpumask of an unbound rescuer
+ * @wq: unbound wq of interest
+ * @cpu: the CPU which is coming up
+ *
+ * An unbound rescuer may end up with a cpumask which doesn't have any
+ * online CPUs.  When this rescuer gets scheduled, the scheduler resets
+ * its cpus_allowed.  We restore the rescuer's cpus_allowed one by one
+ * when its CPU gets online.
+ */
+static void restore_unbound_rescuer_cpumask(struct workqueue_struct *wq, int cpu)
+{
+	static cpumask_t cpumask;
+
+	lockdep_assert_held(&wq_pool_attach_mutex);
+
+	/* is @wq unbound and does it have unbound rescuer? */
+	if (!(wq->flags & WQ_UNBOUND) || !wq->rescuer)
+		return;
+
+	/* is @cpu allowed for @wq's default cpumask? */
+	if (!cpumask_test_cpu(cpu, wq->dfl_pwq->pool->attrs->cpumask))
+		return;
+
+	cpumask_and(&cpumask, wq->dfl_pwq->pool->attrs->cpumask, cpu_online_mask);
+
+	/* as we're called from CPU_ONLINE, the following shouldn't fail */
+	WARN_ON_ONCE(set_cpus_allowed_ptr(wq->rescuer->task, &cpumask) < 0);
 }
 
 int workqueue_prepare_cpu(unsigned int cpu)
@@ -5079,8 +5160,10 @@ int workqueue_online_cpu(unsigned int cpu)
 	}
 
 	/* update NUMA affinity of unbound workqueues */
-	list_for_each_entry(wq, &workqueues, list)
+	list_for_each_entry(wq, &workqueues, list) {
 		wq_update_unbound_numa(wq, cpu, true);
+		restore_unbound_rescuer_cpumask(wq, cpu);
+	}
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
-- 
2.19.1.6.gb485710b

