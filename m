Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740342E2CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgLZBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:52:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E9C061794
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:16 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x126so3162161pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2eGwRUNkILR+pGV+nH32Ywm57TEY06wa+RvUpKw3TA=;
        b=OSKdqL7xEJ8qDoOz/BGfzQw0+wXDKlT/WvqkvnoopomtZgOh89PdrzOO9v/vbgvRi/
         TS8djKz7sIioUC4GufiY1Vq6R+n6JiGt1bD4h5ylPuusTMJquURBtO54shS4oXIOAvvR
         3+wmex87TMpedraW6e5CNy9fenhRYwez5Dtsx/nZza2P5mLTo1UsiWD5R9o+Pq5tWgWc
         jeBbet6bcwuKC67qTVuejrHcFU4Gkpkal/i4m3fgPM7cMQuGIfoyJh8sXtsb36TcsQcT
         rPtf0Vmu/P9ooiMMWQe+28AOia59ckrsSLCtnknQwtb7wwE3SMzx9JB4TSQogcFy+Nx6
         uMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2eGwRUNkILR+pGV+nH32Ywm57TEY06wa+RvUpKw3TA=;
        b=p8fzHolM+zVNPXe9AG4Rs21k0hV8uY0bXGc+PwOYyAc5AaAddsc/25lmuE6axvM5CK
         wF9Mbao7mHVgXDF7QQ+u6qbQsvgNwHFjrjClJuy6VS9BqkVmGfrvuvnIcji2cHGyw+gG
         U8VolEzLcrnxOttWyfhzEVPcmHl8fnIec5v4kodgYIare/4c5NPOqrCEAJKNNfO0gokx
         r9iqrNO59dEYO5WLia6cGLutVb018jC7nz6M/HGK0IQOhYUEFnpHjbDIyTDMaZmZj5nq
         tJ8/VMaYCCiypq7vqo62o163xJc+h8bWyERZ/XYHFcGNmkO5tMdoz2G2Rob+YycIoxT1
         xz1A==
X-Gm-Message-State: AOAM5316xnlNTJCa9R2l54B/IEP0oQED1p0pzA4RhNAaqYplWbVUxTyp
        xEN3J+27DkXnD4V4n7TBScitQ2Ekw90=
X-Google-Smtp-Source: ABdhPJzAMtg88XWdq0aZ9QUyAmQB3CXMD2WibW6FpO/7YMb5FLv1zQe1nIRazyxr2vNNpcy7neDb5Q==
X-Received: by 2002:a63:4346:: with SMTP id q67mr11294635pga.223.1608947476151;
        Fri, 25 Dec 2020 17:51:16 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id z125sm27717912pfz.121.2020.12.25.17.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:51:15 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH -tip V3 5/8] workqueue: Manually break affinity on hotplug for unbound pool
Date:   Sat, 26 Dec 2020 10:51:13 +0800
Message-Id: <20201226025117.2770-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is possible that a per-node pool/woker's affinity is a single
CPU.  It can happen when the workqueue user changes the cpumask of the
workqueue or when wq_unbound_cpumask is changed by system adim via
/sys/devices/virtual/workqueue/cpumask.  And pool->attrs->cpumask
is workqueue's cpumask & wq_unbound_cpumask & possible_cpumask_of_the_node,
which can be a single CPU and makes the pool's workers to be "per cpu
kthread".

And it can also happen when the cpu is the first online and has been
the only online cpu in pool->attrs->cpumask.  In this case, the worker
task cpumask is single cpu no matter what pool->attrs->cpumask since
commit d945b5e9f0e3 ("workqueue: Fix setting affinity of unbound worker
threads").

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
 kernel/workqueue.c | 48 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0a95ae14d46f..79cc87df0cda 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5019,16 +5019,18 @@ static void rebind_workers(struct worker_pool *pool)
 }
 
 /**
- * restore_unbound_workers_cpumask - restore cpumask of unbound workers
+ * update_unbound_workers_cpumask - update cpumask of unbound workers
  * @pool: unbound pool of interest
- * @cpu: the CPU which is coming up
+ * @online: whether @cpu is coming up or going down
+ * @cpu: the CPU which is coming up or going down
  *
  * An unbound pool may end up with a cpumask which doesn't have any online
- * CPUs.  When a worker of such pool get scheduled, the scheduler resets
- * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
- * online CPU before, cpus_allowed of all its workers should be restored.
+ * CPUs.  We have to reset workers' cpus_allowed of such pool.  And we
+ * restore the workers' cpus_allowed when the pool's cpumask has online
+ * CPU.
  */
-static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
+static void update_unbound_workers_cpumask(struct worker_pool *pool,
+					   bool online, int cpu)
 {
 	static cpumask_t cpumask;
 	struct worker *worker;
@@ -5042,6 +5044,23 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 
 	cpumask_and(&cpumask, pool->attrs->cpumask, wq_online_cpumask);
 
+	if (!online) {
+		if (cpumask_weight(&cpumask) > 0)
+			return;
+		/*
+		 * All unbound workers can be possibly "per cpu kthread"
+		 * if this is the only online CPU in pool->attrs->cpumask
+		 * from the last time it has been brought up until now.
+		 * And the scheduler won't break affinity on the "per cpu
+		 * kthread" workers when the CPU is going down, so we have
+		 * to do it by our own.
+		 */
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+
+		return;
+	}
+
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
@@ -5075,7 +5094,7 @@ int workqueue_online_cpu(unsigned int cpu)
 		if (pool->cpu == cpu)
 			rebind_workers(pool);
 		else if (pool->cpu < 0)
-			restore_unbound_workers_cpumask(pool, cpu);
+			update_unbound_workers_cpumask(pool, true, cpu);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5090,7 +5109,9 @@ int workqueue_online_cpu(unsigned int cpu)
 
 int workqueue_offline_cpu(unsigned int cpu)
 {
+	struct worker_pool *pool;
 	struct workqueue_struct *wq;
+	int pi;
 
 	/* unbinding per-cpu workers should happen on the local CPU */
 	if (WARN_ON(cpu != smp_processor_id()))
@@ -5098,9 +5119,20 @@ int workqueue_offline_cpu(unsigned int cpu)
 
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
+			update_unbound_workers_cpumask(pool, false, cpu);
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

