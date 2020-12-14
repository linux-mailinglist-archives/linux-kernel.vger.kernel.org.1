Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDA2D9A66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408291AbgLNO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408268AbgLNOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:54 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E039C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:47 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id m6so2457958pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AV9kUFo+qnytoNh4O6K2DtnLoM5ht60Sj2OMHfGgRU=;
        b=GsOfl6q1Y/p5why5owjFUr9eM6ILzZqM9gE3FLksiUkDykQX/iMcjKbT7MIFHrmzaq
         XmzTQBJ1vPUPRVUuohO+wYGAyB8W4xb/w9SVpO2nj4I95XO+yjl+LveKCLXyg6ETAq0E
         Al63x8rIHxBA5Sx5AWVD7f5rSNYH0C1fGjXPQI2q3KJBF05Br7OXGmhf0/+h3xj3TCtu
         5FCvs6UsGT7KVIp+az86bQ2ulcP8zg1QJdW9iUBpPpSsgYMdKHjbStX/tmL6Y4KOxE9d
         YuRb2Jv67gTeL8yQsoQaKQd6DyGL74O7gZBJw/uW42fX1LfbW//vfOCZG+9E7rd+W5uz
         +lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AV9kUFo+qnytoNh4O6K2DtnLoM5ht60Sj2OMHfGgRU=;
        b=Npvf2fO6H1DK5l7MYv4JR4zWLSWn3lk+SzlbxftRAz+DHBEG5cwr5xkq1vCV1rr0rw
         wPvNcfK/8RMVTZJFA3xV81LZS4g3Z4zkP3fGZu99urJGyRY9YZ0HXuRlLHPJlZWaBMjP
         l0O0gQXTeCXW62lrkb2JBb1mU15t9L2XHwptDy3xCpuhoUJEbvr+apU8CfUiqsc7j7Nw
         KTA8NY+ObfhTOWSH7Id63a922AVj6yW/fQPnVfKVqNXIweXgweBoIX8UxA7if4cEC8zX
         AEm/UyTypuz5BgBvkRLfD25x7wcC4DDUILB8WbA6N94BBqcDqMcjxWOsbauVc52CN6Z7
         KDng==
X-Gm-Message-State: AOAM532dx8Z8ahEZKSQ5bbMFSTF+0d7/bqKDZzb+gqBK6cIxPfweFdIO
        TH91SmxNwp75bAGMTEGKUInsLm2mSlpSIQ==
X-Google-Smtp-Source: ABdhPJx8jV9QW+12gM26Mt/FF69W+/a2P+OrJLIChvvX5ISYRemzcKtkPBBHbfFhA9mQ1uXllIFurw==
X-Received: by 2002:a63:5416:: with SMTP id i22mr24407573pgb.8.1607957686863;
        Mon, 14 Dec 2020 06:54:46 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id s21sm20691626pgk.52.2020.12.14.06.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:46 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 07/10] workqueue: Manually break affinity on hotplug for unbound pool
Date:   Mon, 14 Dec 2020 23:54:54 +0800
Message-Id: <20201214155457.3430-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When all of the CPUs of the unbound pool go down, the scheduler
will break affinity on the workers for us.  We can do it by our own
and don't rely on the scheduler to force break affinity for us.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 49 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 878ed83e5908..eea58f77a37b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5025,16 +5025,16 @@ static void rebind_workers(struct worker_pool *pool)
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
+ * CPU at the first time after reset.
  */
-static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
+static void update_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 {
 	static cpumask_t cpumask;
 	struct worker *worker;
@@ -5048,13 +5048,19 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 
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
@@ -5085,7 +5091,7 @@ int workqueue_online_cpu(unsigned int cpu)
 		if (pool->cpu == cpu)
 			rebind_workers(pool);
 		else if (pool->cpu < 0)
-			restore_unbound_workers_cpumask(pool, cpu);
+			update_unbound_workers_cpumask(pool, cpu);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5100,7 +5106,9 @@ int workqueue_online_cpu(unsigned int cpu)
 
 int workqueue_offline_cpu(unsigned int cpu)
 {
+	struct worker_pool *pool;
 	struct workqueue_struct *wq;
+	int pi;
 
 	/* unbinding per-cpu workers should happen on the local CPU */
 	if (WARN_ON(cpu != smp_processor_id()))
@@ -5108,9 +5116,20 @@ int workqueue_offline_cpu(unsigned int cpu)
 
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

