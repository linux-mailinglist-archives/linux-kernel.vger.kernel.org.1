Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BABC2F184A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbhAKO1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387984AbhAKO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:27:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y12so3647887pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1Q+CnZQ1RwsIXw54gOMHhCMb9MqSqNh4KWTQHw3xe8=;
        b=sbqi3lilJD+am1yDwSFQxSq9HQ1IVSN/ezBcwaEPcRhywZcJ/aPJFO3eBVk/miWhOQ
         CGbHPBrcsNhjZMpcxA6JrhjYAFulR79LfCdJuj82t4PnXzO4zN8ApTK4Z2eGXAd2zfQG
         Dw26h4A8G52n02pyiGFCSN7PUYMlQQ6q0JPTIzya2ey5pLTqmMfthLzIVEVoH402oOIT
         2AUB/0W5Nl61WIO+cvSwKd7MEYACd7LFiaZ7cboiXRuYiwnJgUUs2T34aN+Fe7p8vewc
         k4hC5juegCeaPR3Lb8woTO8IEMAxcBaDhmSo94G3RniqdMmlj+kwyKMYO21jFf1soCGP
         RqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1Q+CnZQ1RwsIXw54gOMHhCMb9MqSqNh4KWTQHw3xe8=;
        b=cy08YoCVUC11c28hnECXp1NWIsDjRwPKGut+1H5vMfCiKL7OpEMqEp27ipYIXFVYlN
         82peEmkZbV9upMpva2N0VucE1NYiV5PKBDZH9SueOir1zB4xCBDoMjoF9stPtj+qPvmn
         qWQHr7s09TmKJ2tiol8md81WZJo81P3uLVCqlyv97zkx+e9wBU86N+XBNGG8W4mJOdTd
         7xTfFbCNofIbNk8lpTzqICC7lQtIoMXAqkvTEtnWAp2ygxN23o53d6syo5U9WKzAz1KD
         CyGPZO9+o9gHHAUPjXY4mZdl7WSurq+EIgXVZQRM4GVdytzvbolYXp0dz+pBgAaksgoL
         NZOg==
X-Gm-Message-State: AOAM530AxunBOUhf5P3p3GS4RfOaxQOX1SYDD1SA0hwSrDPIgBCorrEj
        swNrLvPdgBI7v2kx3leAkHcPTitbaIA=
X-Google-Smtp-Source: ABdhPJxqAmJw/M8ABgk7EfQd/sX/+fkOc4UkjmzC+SOx1myyl1J/c+6tiObm4COp1VtHoVJws/7VAA==
X-Received: by 2002:a17:902:b706:b029:dc:3817:4da5 with SMTP id d6-20020a170902b706b02900dc38174da5mr16355103pls.23.1610375215886;
        Mon, 11 Jan 2021 06:26:55 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a10sm18647403pfi.168.2021.01.11.06.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:55 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hillf Danton <hdanton@sina.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V4 8/8] workqueue: Fix affinity of kworkers when attaching into pool
Date:   Mon, 11 Jan 2021 23:26:38 +0800
Message-Id: <20210111152638.2417-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When worker_attach_to_pool() is called, we should not put the workers
to pool->attrs->cpumask when there is or will be no CPU online in it.

Otherwise, it may cause BUG_ON(): (quote from Valentin:)
  Per-CPU kworkers forcefully migrated away by hotplug via
  workqueue_offline_cpu() can end up spawning more kworkers via

    manage_workers() -> maybe_create_worker()

  Workers created at this point will be bound using

    pool->attrs->cpumask

  which in this case is wrong, as the hotplug state machine already
  migrated all pinned kworkers away from this CPU. This ends up
  triggering the BUG_ON condition is sched_cpu_dying() (i.e. there's
  a kworker enqueued on the dying rq).
(end of quote)

We need to find out where it is in the hotplug stages to determind
whether pool->attrs->cpumask is valid.  So we have to check
%POOL_DISASSOCIATED and wq_unbound_online_cpumask which are indications
for the hotplug stages.

So for per-CPU kworker case, %POOL_DISASSOCIATED marks the kworkers
of the pool are bound or unboud, so it is used to detect whether
pool->attrs->cpumask is valid to use when attachment.

For unbound workers, we should not set online&!active cpumask to workers.
Just introduced wq_unound_online_cpumask has the features that going-down
cpu is cleared earlier in it than in cpu_active_mask and bring-up cpu
is set later in it than cpu_active_mask.  So it is perfect to be used to
detect whether the pool->attrs->cpumask is valid to use.

To use wq_unound_online_cpumask in worker_attach_to_pool(), we need to protect
wq_unbound_online_cpumask in wq_pool_attach_mutex.

Cc: Qian Cai <cai@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Link: https://lore.kernel.org/lkml/20201210163830.21514-3-valentin.schneider@arm.com/
Link: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
Reported-by: Qian Cai <cai@redhat.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b012adbeff9f..d1f1b863c52a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -310,7 +310,7 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
-/* PL: online cpus (cpu_online_mask with the going-down cpu cleared) */
+/* PL&A: online cpus (cpu_online_mask with the going-down cpu cleared) */
 static cpumask_var_t wq_unbound_online_cpumask;
 
 /* CPU where unbound work was last round robin scheduled from this CPU */
@@ -1849,19 +1849,36 @@ static struct worker *alloc_worker(int node)
 static void worker_attach_to_pool(struct worker *worker,
 				   struct worker_pool *pool)
 {
+	bool pool_cpumask_active;
+
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
+	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED and
+	 * wq_unbound_online_cpumask remain stable across this function.
+	 * See the comments above the definitions of the flag and
+	 * wq_unbound_online_cpumask for details.
+	 *
+	 * For percpu pools, whether pool->attrs->cpumask is legitimate
+	 * for @worker task depends on where it is in the hotplug stages
+	 * divided by workqueue_online/offline_cpu().  Refer the functions
+	 * to see how they toggle %POOL_DISASSOCIATED and update cpumask
+	 * of the workers.
+	 *
+	 * For unbound pools, whether pool->attrs->cpumask is legitimate
+	 * for @worker task depends on where it is in the hotplug stages
+	 * divided by workqueue_unbound_online/offline_cpu().  Refer the
+	 * functions to see how they update wq_unbound_online_cpumask and
+	 * update cpumask of the workers.
 	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	pool_cpumask_active = pool->cpu >= 0 ? !(pool->flags & POOL_DISASSOCIATED) :
+		cpumask_intersects(pool->attrs->cpumask, wq_unbound_online_cpumask);
+
+	if (pool_cpumask_active)
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+	else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
-	/*
-	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
-	 * stable across this function.  See the comments above the flag
-	 * definition for details.
-	 */
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
 
@@ -5149,7 +5166,9 @@ int workqueue_unbound_online_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
+	mutex_lock(&wq_pool_attach_mutex);
 	cpumask_set_cpu(cpu, wq_unbound_online_cpumask);
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
@@ -5176,7 +5195,9 @@ int workqueue_unbound_offline_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
+	mutex_lock(&wq_pool_attach_mutex);
 	cpumask_clear_cpu(cpu, wq_unbound_online_cpumask);
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
-- 
2.19.1.6.gb485710b

