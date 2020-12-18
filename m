Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6502DE74A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgLRQLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgLRQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:11:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70314C061282
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lj6so1545370pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sE1ngNsSQLQ3CWzphVt8Uunn1oE9E2vWliXBsardTR8=;
        b=nh2Gve5sS/oeXaCQ4ziH9ZUxaDRgjYbNkhINKBiygkjczzmd1YoBGvxHPwP4Mtg7JH
         Q2zFtAtuoYcm50NttlFQffV80yvILuHOPuv59Sl64PABYJJ3NwHX7NbPdd+55rQlhLEj
         10c8yW225oF4wq4mPqDJ7gBqbXbTt669j3KcK9xBG0bNzxMqDFg3ulcUwtZURogLDclz
         p7VNBhgeF6XSOnOIw03ANXaEvByc473JpQkS6sD+fZwtbfeKTufLDyWfF8BbhrnKLU33
         rQi7FoSs9fZrqLuQ8v75rMDyOB/INQlC+CjyhIaSYAc3E++lCFpz/x0Z++WfEublMXdG
         Az6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sE1ngNsSQLQ3CWzphVt8Uunn1oE9E2vWliXBsardTR8=;
        b=FT0w+/nH5nKES0dibsCPxCTBhdTJbFlR5825wpW/TA9NCIsLIVgrvpXYRAKkawXKhp
         8XdU8aXW0IUIRKI24euA6w8xWMGvLg+Dv9oRW+Aie2Jvf8m049NOVGjNDc+smbshHCBf
         KNnfIBpvxnPmdtuf1qRKK/wbje/FSqL5eVg2s/VnqrGiY6Qgh2IBE81l7seY8hK3Xee/
         rgM5PXYJOwc3RmwpjVGVWcLizePTMZZibmnsnx2dM5Jnp9jTFXYNFL324iukNTdYPwbX
         o3Mi0+kjAt0NEyaA/hPEs2ft5Er5coLj9r0gYjM17uXAhD/MsBSQ7qsoMZFRb0ITWgp7
         n/3w==
X-Gm-Message-State: AOAM533mRhz8JKLGNjjKbxI2IAb/GT7G6wMIBTE+FItK1HqBCUXcC7xf
        JFqOjE+LCLaWv/kjIncVXmcL/e/HFqc=
X-Google-Smtp-Source: ABdhPJy16Y1F66FWrCnBNd0+2ZUHN5GTXIRUDTInSeA+A+dzWitaMIuEpr/MGKobvyTeAJC44ZPpxA==
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr4932376pjr.229.1608307829627;
        Fri, 18 Dec 2020 08:10:29 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id q9sm9378669pgb.82.2020.12.18.08.10.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:10:29 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 10/10] workqueue: Fix affinity of kworkers when attaching into pool
Date:   Sat, 19 Dec 2020 01:09:19 +0800
Message-Id: <20201218170919.2950-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
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
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 65270729454c..eeb726598f80 100644
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
@@ -5081,13 +5081,12 @@ int workqueue_online_cpu(unsigned int cpu)
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
@@ -5117,14 +5116,13 @@ int workqueue_offline_cpu(unsigned int cpu)
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

