Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC02E2CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgLZBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:52:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lb18so2941853pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15jkmCKfS1m1xn/sVulof+I5g/Kt2DoKoW3K5fEsg+k=;
        b=NBjF8BHM+XJaHT/icVvQv4624yNhoUYFSZXU80vzuWpYJeIU+B32d1AsyV5/PCM24I
         W9ykA6Ah5qiURQTRSVCfmrxeNl16DJxxXsEoVoQgmD8mYFcGFwj5bztSe7yRRJ771Nfi
         4eU1QJgIRoHIHI7AP6nWcYDn9ljqRL+4vMqT+fHjqRbXQG7JxHAnAB8eEz6a2MKrupez
         Qe+KmrW2rZ8POJhXMj/O/K7TxxGcbSGS+KPAzeL2OiijjvoIO8scBBja3Gef/wLuBbna
         a40eSZ9rHwQw4UZe1mmz3dvi2rSAJ5eEEG30aShm9j71BRgsHA5Bt8AR5DPEuv/kna5G
         5d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15jkmCKfS1m1xn/sVulof+I5g/Kt2DoKoW3K5fEsg+k=;
        b=p/oPjZZ0tIUgfDUWlZEqXltBd/HqZB9ehTjLpiqTLow7UpQWp6kNUF+wlrJ60TO3G5
         dX3Eka0ZTEfGT5ozPRJS2ar/pWv84ufnatryzQWswM0sWCUu7w3m6ICNsCy49xwvb7WY
         P4DTX9y3smFOumMxKz+jvgT8rAeIWkCuc9OnTQnD9Ecc2HZsw8sqUcwWId95eZ2pfr3u
         cMPWzRWu1HoiI7ZkjwOM0rtS/dSa32obbLgHDDPaAHbXvMj896af1w8/YY0v2jHOO3Ir
         NYJMgfisKIfaLoQXCRHtsDix9PiibF4aAVpczV7psze5DzpaWWazKmRnQeS63RnPf8Df
         m2OA==
X-Gm-Message-State: AOAM532zGmgy5aIOYZfGGvOGa7YJxEta9ah9qyJCLACZxsjrTTNYnGoK
        ptXqYuOGJ8PiNyrsUpOVzak4V9VgV8M=
X-Google-Smtp-Source: ABdhPJz5+uwNbzkjT+5l0FziwyObTFU5KcSDi6vHslrf4HhGLv+ctH7/4zuWun7rUswXauqDx+BUgQ==
X-Received: by 2002:a17:902:7c04:b029:db:e44d:9366 with SMTP id x4-20020a1709027c04b02900dbe44d9366mr35219811pll.51.1608947489551;
        Fri, 25 Dec 2020 17:51:29 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id o11sm6313909pjs.36.2020.12.25.17.51.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:51:29 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V3 7/8] workqueue: reorganize workqueue_offline_cpu() unbind_workers()
Date:   Sat, 26 Dec 2020 10:51:15 +0800
Message-Id: <20201226025117.2770-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Just move around the code, no functionality changed.
Only wq_pool_attach_mutex protected region becomes a little larger.

It prepares for later patch protecting wq_online_cpumask
in wq_pool_attach_mutex.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 94545e6feda5..dd32398edf55 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4896,61 +4896,57 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
  * cpu comes back online.
  */
 
-static void unbind_workers(int cpu)
+static void unbind_workers(struct worker_pool *pool)
 {
-	struct worker_pool *pool;
 	struct worker *worker;
 
-	for_each_cpu_worker_pool(pool, cpu) {
-		mutex_lock(&wq_pool_attach_mutex);
-		raw_spin_lock_irq(&pool->lock);
+	lockdep_assert_held(&wq_pool_attach_mutex);
 
-		/*
-		 * We've blocked all attach/detach operations. Make all workers
-		 * unbound and set DISASSOCIATED.  Before this, all workers
-		 * except for the ones which are still executing works from
-		 * before the last CPU down must be on the cpu.  After
-		 * this, they may become diasporas.
-		 */
-		for_each_pool_worker(worker, pool)
-			worker->flags |= WORKER_UNBOUND;
+	raw_spin_lock_irq(&pool->lock);
 
-		pool->flags |= POOL_DISASSOCIATED;
+	/*
+	 * We've blocked all attach/detach operations. Make all workers
+	 * unbound and set DISASSOCIATED.  Before this, all workers
+	 * except for the ones which are still executing works from
+	 * before the last CPU down must be on the cpu.  After
+	 * this, they may become diasporas.
+	 */
+	for_each_pool_worker(worker, pool)
+		worker->flags |= WORKER_UNBOUND;
 
-		raw_spin_unlock_irq(&pool->lock);
+	pool->flags |= POOL_DISASSOCIATED;
 
-		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+	raw_spin_unlock_irq(&pool->lock);
 
-		mutex_unlock(&wq_pool_attach_mutex);
+	for_each_pool_worker(worker, pool)
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
-		/*
-		 * Call schedule() so that we cross rq->lock and thus can
-		 * guarantee sched callbacks see the %WORKER_UNBOUND flag.
-		 * This is necessary as scheduler callbacks may be invoked
-		 * from other cpus.
-		 */
-		schedule();
+	/*
+	 * Call schedule() so that we cross rq->lock and thus can
+	 * guarantee sched callbacks see the %WORKER_UNBOUND flag.
+	 * This is necessary as scheduler callbacks may be invoked
+	 * from other cpus.
+	 */
+	schedule();
 
-		/*
-		 * Sched callbacks are disabled now.  Zap nr_running.
-		 * After this, nr_running stays zero and need_more_worker()
-		 * and keep_working() are always true as long as the
-		 * worklist is not empty.  This pool now behaves as an
-		 * unbound (in terms of concurrency management) pool which
-		 * are served by workers tied to the pool.
-		 */
-		atomic_set(&pool->nr_running, 0);
+	/*
+	 * Sched callbacks are disabled now.  Zap nr_running.
+	 * After this, nr_running stays zero and need_more_worker()
+	 * and keep_working() are always true as long as the
+	 * worklist is not empty.  This pool now behaves as an
+	 * unbound (in terms of concurrency management) pool which
+	 * are served by workers tied to the pool.
+	 */
+	atomic_set(&pool->nr_running, 0);
 
-		/*
-		 * With concurrency management just turned off, a busy
-		 * worker blocking could lead to lengthy stalls.  Kick off
-		 * unbound chain execution of currently pending work items.
-		 */
-		raw_spin_lock_irq(&pool->lock);
-		wake_up_worker(pool);
-		raw_spin_unlock_irq(&pool->lock);
-	}
+	/*
+	 * With concurrency management just turned off, a busy
+	 * worker blocking could lead to lengthy stalls.  Kick off
+	 * unbound chain execution of currently pending work items.
+	 */
+	raw_spin_lock_irq(&pool->lock);
+	wake_up_worker(pool);
+	raw_spin_unlock_irq(&pool->lock);
 }
 
 /**
@@ -5122,7 +5118,11 @@ int workqueue_offline_cpu(unsigned int cpu)
 	if (WARN_ON(cpu != smp_processor_id()))
 		return -1;
 
-	unbind_workers(cpu);
+	for_each_cpu_worker_pool(pool, cpu) {
+		mutex_lock(&wq_pool_attach_mutex);
+		unbind_workers(pool);
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
 
 	mutex_lock(&wq_pool_mutex);
 	cpumask_clear_cpu(cpu, wq_online_cpumask);
-- 
2.19.1.6.gb485710b

