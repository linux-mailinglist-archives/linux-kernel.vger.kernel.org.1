Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8A2DE746
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgLRQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgLRQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:10:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B1FC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y8so1631485plp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vzx3qPImfhGp/8u2AOHcKTGQDewF99roxVqEpT2V9A=;
        b=Awtx4ar0vmCMPm89VBdDrSMKlJIGOs4tiwZXcBtIqtHANnSYGL9oqWqPQSjAMxaKWo
         QiPNZna5BOxTh4JmyjH2Uy0PnfSqAiQCwzYKcrnu2MPleQ5ev2U7hmW6fkRDMPuCL3V3
         yGakI4iYYF9OS+bdEZ1nDR/puBXuITQG1/nY5m6npJNmyicrS8UMKetXn2vOgnDoh6Q6
         6VOn0oP0DtxpnSEHRDjLcWyYA/vL2lY7gUx1g+yfvNxnuchx+WjDZIhGg8RFVJggBiYL
         l6NDltMQzatlfwuWHtAhtG9zsB4/aufa4gmpLAUDxfTDvbUB/MyR75I6kmPnBUXs+zBz
         F14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vzx3qPImfhGp/8u2AOHcKTGQDewF99roxVqEpT2V9A=;
        b=pPJJ8TPzwIj0BdDzhk2GL9nxAaGODDV0lX95gVF2nsQ7gLOaBFhX4+58RXgYZhsyHl
         zLpkKLbio0UTo26pUS6Nfs3trGvW96Kcby4IYSfptt6X5bqZcvHQ+nYNwojVE5rSZ5u4
         c2KxayO0Z7rL/iJao/HPVi9vWlxv++P7EcVnvvdws/TVAPIhlzvnTXRgs3IiMmRmaIn/
         Hur5BxlvYVlyNrjf+Y8b/+gUXt42JwjJCr1BjCAjP/4ACJ4+QL2TtdLfa4TBcRCcZqiT
         TOOyJGx3ohXs83nh3MaC8g4axI2jccU/6/G0V5X+xnpv/B3baRwtNdfY/s0pEsk9xf1h
         YfVQ==
X-Gm-Message-State: AOAM530GYcZa6Bf1jz23xpPOOogI+DrJEUEuOU8ylyKK+B8Gko0IIHSf
        vgRaql2V/4F3frrmoBWAZ0I8ttRCr+A=
X-Google-Smtp-Source: ABdhPJxVRwNbCyagZwKTKYbEsSyEqIAM1zugwXXh4oLFaD2lmmlh277TT5wP/szwTsD/PTPiZI+mOA==
X-Received: by 2002:a17:90a:b38d:: with SMTP id e13mr5076553pjr.214.1608307809898;
        Fri, 18 Dec 2020 08:10:09 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id v125sm9585506pgv.6.2020.12.18.08.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:10:09 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH -tip V2 07/10] workqueue: Manually break affinity on hotplug for unbound pool
Date:   Sat, 19 Dec 2020 01:09:16 +0800
Message-Id: <20201218170919.2950-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is possible that a per-node pool/woker's affinity is a single
CPU.  It can happen when wq_unbound_cpumask is changed by system adim
via /sys/devices/virtual/workqueue/cpumask.  And pool->attrs->cpumask
is wq_unbound_cpumask & possible_cpumask_of_the_node, which can be a
single CPU and makes the pool's workers to be "per cpu kthread".

And the scheduler won't break affinity on the "per cpu kthread" workers
when the CPU is going down, so we have to do it by our own.

We do it by reusing existing restore_unbound_workers_cpumask() and rename
it to update_unbound_workers_cpumask().  When the number of the online
CPU of the pool goes from 1 to 0, we break the affinity initiatively.

Note here, we even break the affinity for non-per-cpu-kthread workers,
because first, the code path is slow path which is not worth too much to
optimize, second, we don't need to rely on the code/conditions when the
scheduler forces breaking affinity for us.

The way to break affinity is to set the workers' affinity to
cpu_possible_mask, so that we preserve the same behavisor when
the scheduler breaks affinity for us.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 49 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index eda293097fe1..c2b66679c0aa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5027,16 +5027,16 @@ static void rebind_workers(struct worker_pool *pool)
 }
 
 /**
- * restore_unbound_workers_cpumask - restore cpumask of unbound workers
+ * update_unbound_workers_cpumask - update cpumask of unbound workers
  * @pool: unbound pool of interest
- * @cpu: the CPU which is coming up
+ * @cpu: the CPU which is coming up or going down
  *
  * An unbound pool may end up with a cpumask which doesn't have any online
- * CPUs.  When a worker of such pool get scheduled, the scheduler resets
- * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
- * online CPU before, cpus_allowed of all its workers should be restored.
+ * CPUs.  We have to reset workers' cpus_allowed of such pool.  And we
+ * restore the workers' cpus_allowed when the pool's cpumask has online
+ * CPU for the first time after reset.
  */
-static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
+static void update_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 {
 	static cpumask_t cpumask;
 	struct worker *worker;
@@ -5050,13 +5050,19 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 
 	cpumask_and(&cpumask, pool->attrs->cpumask, wq_online_cpumask);
 
-	/* is @cpu the first one onlined for the @pool? */
-	if (cpumask_weight(&cpumask) > 1)
-		return;
-
-	/* as we're called from CPU_ONLINE, the following shouldn't fail */
-	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+	switch (cpumask_weight(&cpumask)) {
+	case 0: /* @cpu is the last one going down for the @pool. */
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+		break;
+	case 1: /* @cpu is the first one onlined for the @pool. */
+		/* as we're called from CPU_ONLINE, the following shouldn't fail */
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+		break;
+	default: /* other cases, nothing to do */
+		break;
+	}
 }
 
 int workqueue_prepare_cpu(unsigned int cpu)
@@ -5087,7 +5093,7 @@ int workqueue_online_cpu(unsigned int cpu)
 		if (pool->cpu == cpu)
 			rebind_workers(pool);
 		else if (pool->cpu < 0)
-			restore_unbound_workers_cpumask(pool, cpu);
+			update_unbound_workers_cpumask(pool, cpu);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5102,7 +5108,9 @@ int workqueue_online_cpu(unsigned int cpu)
 
 int workqueue_offline_cpu(unsigned int cpu)
 {
+	struct worker_pool *pool;
 	struct workqueue_struct *wq;
+	int pi;
 
 	/* unbinding per-cpu workers should happen on the local CPU */
 	if (WARN_ON(cpu != smp_processor_id()))
@@ -5110,9 +5118,20 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	unbind_workers(cpu);
 
-	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
 	cpumask_clear_cpu(cpu, wq_online_cpumask);
+
+	/* update CPU affinity of workers of unbound pools */
+	for_each_pool(pool, pi) {
+		mutex_lock(&wq_pool_attach_mutex);
+
+		if (pool->cpu < 0)
+			update_unbound_workers_cpumask(pool, cpu);
+
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
+
+	/* update NUMA affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
 		wq_update_unbound_numa(wq, cpu);
 	mutex_unlock(&wq_pool_mutex);
-- 
2.19.1.6.gb485710b

