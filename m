Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F02D9A64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407720AbgLNO4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408270AbgLNOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2848C061285
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:53 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so12221286pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lj0rYiA6KV/073B7GQRoueHC5XhtWNfwjV79hGwDLqk=;
        b=oO+RntzefCBckZ2Qm1qTX5444GHbvoR/aoLzd3V9af/4cEhls66Vq9XtWESu7Tdwaf
         8kGse6tDQltxP1/lL+PopVGUIyXtjPM7cJ1g5wb10YX81y5wEYH5CGpFhFPBxutvTZ9r
         bRKAYcwkMwIgQImoUgz8/Pq8teVyLzrq2msLERBcnEmtlmWGGWx/T/uoSnavbOlKpy2w
         KGgOPnaTtUNviYxVqViobVPS9Xnivm6THDDZOG4ZpaHJKsdSnXObyE4Dym1N5HnLFqSg
         zwg7qjWY11EagwC5Bqra6lha+oHzcRGcB3rlyQRkLYdFfQZa/JMoU2IqNu7xY/052Voh
         UuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj0rYiA6KV/073B7GQRoueHC5XhtWNfwjV79hGwDLqk=;
        b=GsgGAK7aCbVuecmap9kVibupJumO7hp/BcLpVTyQ1CalB8G957muQvgJw0rZhSDYqF
         XjiiPt0Bxo49sXqIZzQCMkKmy5DXOg1J8izs0PtP44rlhcx++++NJ3V5P2kkNPaLZARs
         rTkiCb4Vxlwu2oLHWuKWeUna4IGlAZtUft753BYfdPSDVGMabsZ9sFKJSSgc/QG0PGVO
         3scYxP4EbRksWAhmOdMrUWNqyHVqoyFHeXVWULBTUAXelg5hlpTCs3jWNymhswIgsjJO
         ggRz/jTCIf35n63gt+wxfo7JWqb3iZ3dfrTcdJDcgLqu6ojwGeXRI96AJC+oOXpORDVY
         oVtQ==
X-Gm-Message-State: AOAM532kxtPBBxmkc9E5nrK2H6WSvjIz0sVplNzDp3pmEHvOLSD4Xzo7
        +PwvPDWxAreSffcE4HDKIWsZAxZhCG13pQ==
X-Google-Smtp-Source: ABdhPJytAnH6PPDjDp3SHAW4Ksivd+FCNCrcxVD9DmfDLu5UKSTNT8mN+xoW2+KJlHw1xeJgKT1kBw==
X-Received: by 2002:a63:f919:: with SMTP id h25mr24837811pgi.440.1607957693380;
        Mon, 14 Dec 2020 06:54:53 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id 22sm19779165pfn.190.2020.12.14.06.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:52 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 09/10] workqueue: reorganize workqueue_offline_cpu() unbind_workers()
Date:   Mon, 14 Dec 2020 23:54:56 +0800
Message-Id: <20201214155457.3430-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Just move around the code, no functionality changed.
Only wq_pool_attach_mutex protected region become a little larger.

It prepares for later patch protecting wq_online_cpumask
in wq_pool_attach_mutex.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 92 +++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fa29b7a083a6..5ef41c567c2b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4901,62 +4901,58 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
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
 
-		/* don't rely on the scheduler to force break affinity for us. */
-		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+	raw_spin_unlock_irq(&pool->lock);
 
-		mutex_unlock(&wq_pool_attach_mutex);
+	/* don't rely on the scheduler to force break affinity for us. */
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
@@ -5119,7 +5115,11 @@ int workqueue_offline_cpu(unsigned int cpu)
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

