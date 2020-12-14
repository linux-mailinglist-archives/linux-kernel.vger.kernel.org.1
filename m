Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF62D9A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407923AbgLNO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408263AbgLNOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:49 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:40 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 11so12189835pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhZp5e1xMFfd8D5sn/oHyv8cT6c+0c7AQduv1/b2uaM=;
        b=tuySmeZWrWQTqpcOnr0ZGVewr7ogcPJiKBa1YCto4CwOftH92q5tO5K1Ue9U4neWBY
         X0so7RONjndhltoHmyjZUVvykTzjyx96/ZB7B2jY2iIs8sEpiWFIWMTP+jWN7CBuj3h2
         GadeEHr2sKBfRTYTBS7PBnszkwGxqmJHaN8ViNljiy0Pbt9P6pwjqaLPSO4Kadi86exz
         UsvrJBohS81xZOLyp59tL1MqxkM4HQ2AeZD55prmD754gTmwKkeN+4UxB2ULfY+57ye9
         x0fRdnElNEBAPxVo++RSjDXmv9g6tDZjLxaArr36F94W9shiqALHNpOA/nG0bmILT7L1
         ydxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhZp5e1xMFfd8D5sn/oHyv8cT6c+0c7AQduv1/b2uaM=;
        b=ZysrBbpu7vi/oiLkQrbe/j7AhPef1YTBQFqzw7UOgsJiZXUwk3vwkJSNb32EDQHgMZ
         f8+MRlVOPoz9VR3N3GiCXVKScVZLb4aO5iXF22kM8eAKTeWJdNdwhuO2qRMfukipZ1Xm
         AAULEnYr8kpr6eR+4xfl3o1baTGFxs5S94CFrmtys/RXzPE6dL1tM0vLbj/jgzSuzRyr
         3hfmSgzhv3k4iPsjz1zfh1HzBp7WpVeIB7hfHE2Kah6CiE80BW5M0yP7p4+S/4MwJOz4
         xVKR5IuTVxKP/ClhHcdVWcaykOUx9kF7J2gDYH78/k9pFrIMjSGAl5sNtm6pt+xWp6o2
         lc8g==
X-Gm-Message-State: AOAM533fvh3646QZDqAkP2yU1aqEBOmwjX6b3KXAPCjN4HkcpD5aIj5F
        KSUUkL9VTIwKjt3OiGTv6aItFeStPciuUw==
X-Google-Smtp-Source: ABdhPJwc6DpcVEo5Fg1D2CWdxL9oyqaXChNl4vtvLwTrITrQVlr57Wi60hNkqHbPbaD/Lcois3VX2g==
X-Received: by 2002:aa7:8a99:0:b029:1a6:c8b8:1414 with SMTP id a25-20020aa78a990000b02901a6c8b81414mr940977pfc.66.1607957680244;
        Mon, 14 Dec 2020 06:54:40 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id d6sm20172763pfd.69.2020.12.14.06.54.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:39 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 05/10] workqueue: introduce wq_online_cpumask
Date:   Mon, 14 Dec 2020 23:54:52 +0800
Message-Id: <20201214155457.3430-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

wq_online_cpumask is the cached result of cpu_online_mask with the
going-down cpu cleared.  It is needed for later patches for setting
correct cpumask for workers and break affinity initiatively.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f679c599a70b..8aca3afc88aa 100644
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
 
@@ -3830,12 +3833,10 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
@@ -3849,15 +3850,14 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
@@ -3966,7 +3966,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_node(node) {
-		if (wq_calc_node_cpumask(new_attrs, node, -1, tmp_attrs->cpumask)) {
+		if (wq_calc_node_cpumask(new_attrs, node, tmp_attrs->cpumask)) {
 			ctx->pwq_tbl[node] = alloc_unbound_pwq(wq, tmp_attrs);
 			if (!ctx->pwq_tbl[node])
 				goto out_free;
@@ -4091,7 +4091,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU coming up or going down
- * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
  * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update NUMA affinity of
@@ -4109,11 +4108,9 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
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
@@ -4141,7 +4138,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * and create a new one if they don't match.  If the target cpumask
 	 * equals the default pwq's, the default pwq should be used.
 	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
+	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpumask)) {
 		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
 			return;
 	} else {
@@ -5079,6 +5076,7 @@ int workqueue_online_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
+	cpumask_set_cpu(cpu, wq_online_cpumask);
 
 	for_each_pool(pool, pi) {
 		mutex_lock(&wq_pool_attach_mutex);
@@ -5093,7 +5091,7 @@ int workqueue_online_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, true);
+		wq_update_unbound_numa(wq, cpu);
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -5111,8 +5109,9 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
+	cpumask_clear_cpu(cpu, wq_online_cpumask);
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, false);
+		wq_update_unbound_numa(wq, cpu);
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
@@ -5949,6 +5948,9 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	BUG_ON(!alloc_cpumask_var(&wq_online_cpumask, GFP_KERNEL));
+	cpumask_copy(wq_online_cpumask, cpu_online_mask);
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
 
@@ -6045,7 +6047,7 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_unbound_numa(wq, smp_processor_id(), true);
+		wq_update_unbound_numa(wq, smp_processor_id());
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
-- 
2.19.1.6.gb485710b

