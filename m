Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579CA2E2CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgLZBwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:52:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354DC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:37 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t8so3160620pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmioAxNSR6MAY+J4fyGJ9OkjHtlBhIZAxyWFqSA2PTg=;
        b=a9fdtmJm9f3y1e4rkyLB6faMuZKB2ebBCjIGnVqjZBhwxo08r9rCzsflVdyudM2paC
         ohigfDgaJhNEW8bEMWSMLMV6RKZS5/14+6dWpaVWfbgOtSWtF8FYIfPOY/EoSdLN7LVH
         VwxZ32EJeEC15ekK6ybFW9Bc8gvWSUB/gP85fPSwhEoXLXapOi/8BRN31xdsrVXrSzUI
         utbWGDODU9jaG1r6dcP2LnEUxUA6TM6r/LacBx8Z2NPrQ7Cays4PBcU4e3b3UQiADFsV
         aqGCsP4MQmXI+CmeQXfSABTYHEwbjjU/bu4Nfm1dXlUUb5llGuqpsMAeXj5RJBs7OQeO
         iwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmioAxNSR6MAY+J4fyGJ9OkjHtlBhIZAxyWFqSA2PTg=;
        b=eZblD7uAiRKr/t2FdyGAAzsnZ75+chdl8saRcPonKdFd+uWo4UjUMt5xixqI/6dElf
         x7lw6LD7pDkcIaor6yLLiXpnBU+ikqSfMUTV5LLME9Y3EoTpf3aHEPjj8vSQJzMR6E2b
         +72G1CfBHDR82/kdIdVtqpVuPzfyqcXIifLDPmgvfoK9dyaB7rfKOnhvlErrthhpPPOL
         L5U9WFU03XOS7FhVY1gwY28vpVhiDogfENmheE+z6p3FstcIZa9OOae3xck0fcNriQaX
         XeuwWcXQQnjh7OFvExpw5ikKmzsVNWReEnnmgEjlpnCLd/JOkPCgjIHa8acJn4Nh9F5R
         f9uQ==
X-Gm-Message-State: AOAM533QTDOEcvXlfJ1Jz7ILzU/JRnDV+7O+5496X9aLW3EZZtNtMIHt
        bp64RxscMp0yfntxMrDKjPcf1gfEvlE=
X-Google-Smtp-Source: ABdhPJxoetehjnG0HHX1bUnfzEc2bPOTEN3/vDXN+FaQD2lo3rYrdg9TEcgH9saPYmDIPXH9u1yJcg==
X-Received: by 2002:a63:5720:: with SMTP id l32mr22883358pgb.64.1608947497404;
        Fri, 25 Dec 2020 17:51:37 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id y16sm21792055pgg.20.2020.12.25.17.51.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:51:36 -0800 (PST)
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
Subject: [PATCH -tip V3 8/8] workqueue: Fix affinity of kworkers when attaching into pool
Date:   Sat, 26 Dec 2020 10:51:16 +0800
Message-Id: <20201226025117.2770-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When worker_attach_to_pool() is called, we should not put the workers
to pool->attrs->cpumask when there is not CPU online in it.

We have to use wq_online_cpumask in worker_attach_to_pool() to check
if pool->attrs->cpumask is valid rather than cpu_online_mask or
cpu_active_mask due to gaps between stages in cpu hot[un]plug.

So for that late-spawned per-CPU kworker case: the outgoing CPU should have
already been cleared from wq_online_cpumask, so it gets its affinity reset
to the possible mask and the subsequent wakeup will ensure it's put on an
active CPU.

To use wq_online_cpumask in worker_attach_to_pool(), we need to protect
wq_online_cpumask in wq_pool_attach_mutex and we modify workqueue_online_cpu()
and workqueue_offline_cpu() to enlarge wq_pool_attach_mutex protected
region. We also put updating wq_online_cpumask and [re|un]bind_workers()
in the same wq_pool_attach_mutex protected region to make the update
for percpu workqueue atomically.

Cc: Qian Cai <cai@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Link: https://lore.kernel.org/lkml/20201210163830.21514-3-valentin.schneider@arm.com/
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index dd32398edf55..25d50050257c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -310,7 +310,7 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
-/* PL: online cpus (cpu_online_mask with the going-down cpu cleared) */
+/* PL&A: online cpus (cpu_online_mask with the going-down cpu cleared) */
 static cpumask_var_t wq_online_cpumask;
 
 /* CPU where unbound work was last round robin scheduled from this CPU */
@@ -1848,11 +1848,11 @@ static void worker_attach_to_pool(struct worker *worker,
 {
 	mutex_lock(&wq_pool_attach_mutex);
 
-	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	/* Is there any cpu in pool->attrs->cpumask online? */
+	if (cpumask_intersects(pool->attrs->cpumask, wq_online_cpumask))
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+	else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
@@ -5082,13 +5082,12 @@ int workqueue_online_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
-	cpumask_set_cpu(cpu, wq_online_cpumask);
 
-	for_each_cpu_worker_pool(pool, cpu) {
-		mutex_lock(&wq_pool_attach_mutex);
+	mutex_lock(&wq_pool_attach_mutex);
+	cpumask_set_cpu(cpu, wq_online_cpumask);
+	for_each_cpu_worker_pool(pool, cpu)
 		rebind_workers(pool);
-		mutex_unlock(&wq_pool_attach_mutex);
-	}
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
@@ -5118,14 +5117,13 @@ int workqueue_offline_cpu(unsigned int cpu)
 	if (WARN_ON(cpu != smp_processor_id()))
 		return -1;
 
-	for_each_cpu_worker_pool(pool, cpu) {
-		mutex_lock(&wq_pool_attach_mutex);
-		unbind_workers(pool);
-		mutex_unlock(&wq_pool_attach_mutex);
-	}
-
 	mutex_lock(&wq_pool_mutex);
+
+	mutex_lock(&wq_pool_attach_mutex);
 	cpumask_clear_cpu(cpu, wq_online_cpumask);
+	for_each_cpu_worker_pool(pool, cpu)
+		unbind_workers(pool);
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
-- 
2.19.1.6.gb485710b

