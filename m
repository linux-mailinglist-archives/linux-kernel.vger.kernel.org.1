Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE02D9A67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407939AbgLNO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408278AbgLNOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:55 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D1C061248
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:57 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id h186so1722232pfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koxg5a9WdKnvbIa3TewEU/0z9rl1xHkDIz16eeJukoM=;
        b=knQGs+bxNttXRgpfPG6eqvlmlDruuaVokK9cuDwx6LSJxIsgGV2LLaNhvZLPgupH4i
         6KkLNeOaW9TVu9Y0F3WsjrXsgUSLR6vyZeZckysb7C+VOeKs3Q552GC5WBjB7a4Z4qU3
         0iNMLUzcRiPC2JvyfteKWcOHA6+cpZsjS02RHSVLEQXFua6GVdHBVdp2g1ze0tyt0J3G
         OAMbdD7f9ygiL8ccS2WS70v3nKnknRnnW6gN4dFB9og4gfENq2NHomlbn4yEuuwuG408
         BN5hj34yjlF72FPQZUHg4eR9AIj4Za3Oo+04rZ7Losz9juMfqtBZWO6mur3Lxb8yCX4V
         FStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koxg5a9WdKnvbIa3TewEU/0z9rl1xHkDIz16eeJukoM=;
        b=p/+McEK9tkfaNiN3NFq/PRiy7IdMFzec26WBlhiWlsmoEh5keYanD0Km7NUIetxPdK
         IdMqDk7wjKPGRmb8mHNldV4aiz1cxM2KGaL/SoQHEhpvVQS01P3NUm1BWvnXgPFnd1aR
         bUiXYgqD4VNHxklrG/QjECfNQXIgXrtNdK1slUPEY3EQP4aPXvyfg88lIgluAImGVEll
         71jKPoIJngWayoTfhxdp+XO00vYl7I6HG9ONyyc3E0BypYAndG0CnTpyOi8TbZGYMtPM
         U8ocaFgy1l9tbdCdrjlGpu5C0nh85V4CLKLxCrxBNUHRDqgx1WCFEz3a/uIX0uO0xxht
         qTJw==
X-Gm-Message-State: AOAM5311R6T2s0KXAmRpQJxO5S8vxsqG3MbRNiLdx26hGtv1V96iFucl
        cGmRX89DV1nBIgD9buc2g4CCmRe/mLEnPA==
X-Google-Smtp-Source: ABdhPJzKuRRNODMmpiz92CkBdKqJ4ZlAe0vv9giKJNOw3BhPvYUEzNwICPHcU36RvIySJ0mLrO2c6A==
X-Received: by 2002:a63:d62:: with SMTP id 34mr8290383pgn.276.1607957696619;
        Mon, 14 Dec 2020 06:54:56 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id c10sm4234310pgj.67.2020.12.14.06.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:56 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 10/10] workqueue: Fix affinity of kworkers when attaching into pool
Date:   Mon, 14 Dec 2020 23:54:57 +0800
Message-Id: <20201214155457.3430-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
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

To use wq_online_cpumask in worker_attach_to_pool(), we need to protect
wq_online_cpumask in wq_pool_attach_mutex and we modify workqueue_online_cpu()
and workqueue_offline_cpu() to enlarge wq_pool_attach_mutex protected
region. We also put updating wq_online_cpumask and [re|un]bind_workers()
in the same wq_pool_attach_mutex protected region to make the update
for percpu workqueue atomically.

Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Qian Cai <cai@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Link: https://lore.kernel.org/lkml/20201210163830.21514-3-valentin.schneider@arm.com/
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5ef41c567c2b..7a04cef90c1c 100644
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
+	if (cpumask_any_and(pool->attrs->cpumask, wq_online_cpumask) < nr_cpu_ids)
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+	else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
@@ -5079,13 +5079,12 @@ int workqueue_online_cpu(unsigned int cpu)
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
@@ -5115,14 +5114,13 @@ int workqueue_offline_cpu(unsigned int cpu)
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

