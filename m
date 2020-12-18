Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC22DE744
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgLRQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgLRQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:10:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894EBC061257
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l23so1587105pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipY7Q1jhVxn0AlnDqcYOWnULxtPvfWbfZboz2xJXbxI=;
        b=vSobW+2tRKv61hroDkO8crZRNwuF1Q2sRKkSWeugDzhN4/4MO1qBROeN+8+X/BwtHS
         nDujplK11y8qu0BKU21tWXTR5NX6biv6fqc6ht3xGSHrMRNkB+5iFoUbOL2T+1WgXL98
         7eLuCgjdXv+XFlidnI3M0jJO6YAROZW+PepzSsvSFh1OFRsv1N6NdWiGzcSMyT4u64Wv
         HcXPSuCtz+nw9YrUVfsvVFbyGFd3wOxgS3BIH+NWqGsRlQsnhIImywZfFizb3eNQyLyd
         WZKtVwFua4Pq8sWU8DLEpJWFfXz8m6bgdLhColqd45Ygsy7wLU7ECUF33JEOwlwpKLmk
         ywnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipY7Q1jhVxn0AlnDqcYOWnULxtPvfWbfZboz2xJXbxI=;
        b=sId0sFfYra7TxMMWAWuzskIZFPoVaQatzDxlpwYvA/wl5qgeN3JCm/618+tOMM1MbF
         jLdiu/I0g+u/a8WwMFDdPAt6ZNuMvbVcm/55iPCMq6EZaTmKuhoKIgiwTTq9JAsWZLQD
         oZucr4MV1sUluAgmdRllsBmjgrsaVtKF7lnvddvhn4u4v3lPBdvG1lSoJZIw/A7DJvpQ
         gYHrgY3YdslrOh8tmpIgv5Egcq+teeUXw6i9zGW4b7sIxZq4W41l4u0kKM+dSvTQ48Iy
         rSDqOFOz4sufPAJyJfOS7qcDFagxLeTxI3F3bRDzFuqCbWrzvvmnAWz9QimyLqXukL4t
         j5tQ==
X-Gm-Message-State: AOAM533a0HoijYaoxqq53Gk5goe90Up9t+U71hsBUJk7+LxClP8CAt7l
        9ZEbJaPSq8EHwJMtH4LdniE6z9kCS0Q=
X-Google-Smtp-Source: ABdhPJwECt1yF/qe75F+88AZQ1VXyyl9dgk9qLJIXUfd1SO31fuQ9MM+xqWka3FxBVmGiyTy1uZkSQ==
X-Received: by 2002:a17:90b:128f:: with SMTP id fw15mr4927570pjb.91.1608307761799;
        Fri, 18 Dec 2020 08:09:21 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id b72sm8820254pfb.129.2020.12.18.08.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:09:21 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 05/10] workqueue: introduce wq_online_cpumask
Date:   Sat, 19 Dec 2020 01:09:14 +0800
Message-Id: <20201218170919.2950-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

wq_online_cpumask is the cached result of cpu_online_mask with the
going-down cpu cleared.  It is needed for later patches for setting
correct cpumask for workers and break affinity initiatively.

The first usage of wq_online_cpumask is also in this patch.
wq_calc_node_cpumask() and wq_update_unbound_numa() can be simplified
a little.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5f3c86eaed7a..84842f10e6a2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -310,6 +310,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
+/* PL: online cpus (cpu_online_mask with the going-down cpu cleared) */
+static cpumask_var_t wq_online_cpumask;
+
 /* CPU where unbound work was last round robin scheduled from this CPU */
 static DEFINE_PER_CPU(int, wq_rr_cpu_last);
 
@@ -3833,12 +3836,10 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  * wq_calc_node_cpumask - calculate a wq_attrs' cpumask for the specified node
  * @attrs: the wq_attrs of the default pwq of the target workqueue
  * @node: the target NUMA node
- * @cpu_going_down: if >= 0, the CPU to consider as offline
  * @cpumask: outarg, the resulting cpumask
  *
- * Calculate the cpumask a workqueue with @attrs should use on @node.  If
- * @cpu_going_down is >= 0, that cpu is considered offline during
- * calculation.  The result is stored in @cpumask.
+ * Calculate the cpumask a workqueue with @attrs should use on @node.
+ * The result is stored in @cpumask.
  *
  * If NUMA affinity is not enabled, @attrs->cpumask is always used.  If
  * enabled and @node has online CPUs requested by @attrs, the returned
@@ -3852,15 +3853,14 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
  * %false if equal.
  */
 static bool wq_calc_node_cpumask(const struct workqueue_attrs *attrs, int node,
-				 int cpu_going_down, cpumask_t *cpumask)
+				 cpumask_t *cpumask)
 {
 	if (!wq_numa_enabled || attrs->no_numa)
 		goto use_dfl;
 
 	/* does @node have any online CPUs @attrs wants? */
 	cpumask_and(cpumask, cpumask_of_node(node), attrs->cpumask);
-	if (cpu_going_down >= 0)
-		cpumask_clear_cpu(cpu_going_down, cpumask);
+	cpumask_and(cpumask, cpumask, wq_online_cpumask);
 
 	if (cpumask_empty(cpumask))
 		goto use_dfl;
@@ -3969,7 +3969,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_node(node) {
-		if (wq_calc_node_cpumask(new_attrs, node, -1, tmp_attrs->cpumask)) {
+		if (wq_calc_node_cpumask(new_attrs, node, tmp_attrs->cpumask)) {
 			ctx->pwq_tbl[node] = alloc_unbound_pwq(wq, tmp_attrs);
 			if (!ctx->pwq_tbl[node])
 				goto out_free;
@@ -4094,7 +4094,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU coming up or going down
- * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
  * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update NUMA affinity of
@@ -4112,11 +4111,9 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * affinity, it's the user's responsibility to flush the work item from
  * CPU_DOWN_PREPARE.
  */
-static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
-				   bool online)
+static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu)
 {
 	int node = cpu_to_node(cpu);
-	int cpu_off = online ? -1 : cpu;
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
 	cpumask_t *cpumask;
@@ -4144,7 +4141,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * and create a new one if they don't match.  If the target cpumask
 	 * equals the default pwq's, the default pwq should be used.
 	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
+	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpumask)) {
 		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
 			return;
 	} else {
@@ -5081,6 +5078,7 @@ int workqueue_online_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
+	cpumask_set_cpu(cpu, wq_online_cpumask);
 
 	for_each_pool(pool, pi) {
 		mutex_lock(&wq_pool_attach_mutex);
@@ -5095,7 +5093,7 @@ int workqueue_online_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, true);
+		wq_update_unbound_numa(wq, cpu);
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -5113,8 +5111,9 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
+	cpumask_clear_cpu(cpu, wq_online_cpumask);
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, false);
+		wq_update_unbound_numa(wq, cpu);
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
@@ -5951,6 +5950,9 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	BUG_ON(!alloc_cpumask_var(&wq_online_cpumask, GFP_KERNEL));
+	cpumask_copy(wq_online_cpumask, cpu_online_mask);
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
 
@@ -6047,7 +6049,7 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_unbound_numa(wq, smp_processor_id(), true);
+		wq_update_unbound_numa(wq, smp_processor_id());
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
-- 
2.19.1.6.gb485710b

