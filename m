Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4C2DE749
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgLRQLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgLRQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:11:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8FC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f14so1530010pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5N7Urez2Ap/i5iB6KY/YtR+1zUuju8vDKp6VV6ij/s=;
        b=odh4ZXWX/CcH04zRRW2dbx5K9qJBjnB3zaicenSq1CUz2UwSHRJycc/HC9O5ybFyDa
         QmA7wgEL6k0puHixugVLCx5oa1PAFP4OJ6gVrQQV+KNFyxtSn0YU0ASAibzl0FmPB1uf
         5HgPY0bp+x8l8DgICl9BGOGR6GviYqq19QVWp743hSSW5Af2H29yuOVaFk/r8vPp7yCZ
         LYiRYSmVBvmWF8Tou2bRmaBShgDXQcUFI+f08+CbXXv6iyQstNw//suwwyj8bs3KYlyq
         k1mYYD9yWDOSIW7LR21edgfdS0xP49qSa1t4AByW4gDBmLsNrZz/Z9d/k8MqwmnkJlsz
         duRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5N7Urez2Ap/i5iB6KY/YtR+1zUuju8vDKp6VV6ij/s=;
        b=Vqhz65Je5xHKTZa7cXAURsQh2wEdnvEk0yGOAdm/pRIZuiIbIT6Nx+15Uwo49wYJLL
         Qse9Hj8/WqTrxTrUeOc3YH09Ld2kxbj3H2JpOAzKZQUUftMOU/SUvmtY386X5BVI7RKn
         5fq3imeo20/awvEs850natt9xp3xTOEiun0FsUWRj8z9mnK0hTPJYONKAwD233s/ZNFj
         XoOwjVZI/E00Np52ElIbcEKQvvAu0OxArzkGU5cs6kxQZuP3AvGv1ViCQGKJbyFvHcWA
         VGF/Ns9MGHNvTubZ/QEuX3KK2y7GX7EfVLmsqef6Eq2x8pOsJbCaTUOr+ri1Uu8BjKHA
         wNNA==
X-Gm-Message-State: AOAM532PTmJFLfsdgxCtfoXvdnb1NMvQeZIsVscb7r2XrnjpdweSn+6v
        lkk0m2KvSQ+L5CDXGrk9SpHN+SvRRl4=
X-Google-Smtp-Source: ABdhPJxcuG5isbDMe3Iob0qjiv56N+NJypwVZTZ70mxgCoQj/5557u7j8+P9dQ0ocVXq/pJ6IIF2hg==
X-Received: by 2002:a17:90b:228b:: with SMTP id kx11mr5139393pjb.122.1608307823308;
        Fri, 18 Dec 2020 08:10:23 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a31sm9621196pgb.93.2020.12.18.08.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:10:22 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 09/10] workqueue: reorganize workqueue_offline_cpu() unbind_workers()
Date:   Sat, 19 Dec 2020 01:09:18 +0800
Message-Id: <20201218170919.2950-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
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
index dc891b5c0868..65270729454c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4904,61 +4904,57 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
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
@@ -5121,7 +5117,11 @@ int workqueue_offline_cpu(unsigned int cpu)
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

