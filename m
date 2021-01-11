Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41712F1847
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbhAKO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388786AbhAKO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:27:17 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A1C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:36 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so12597052pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9F5Euxlk/BDv+iwStIONsTGPjBlbxX81m0xZKZwM+0Q=;
        b=Pu8OkMehc2KkkEjQWZ7U+7IT+wAT+F6ThCfjGFAgt0lmtBuoHMjPS6obFAJkhJs8yB
         wLrzVg+IuOhvpES8O4+FxalfnibOyueVB0HD1K1GOHV4KG0X7Sg4blyabxDAVrfxqM2X
         EljKMWqujvvG0q2c9yGWeHN+5ejAfgxG/3mUpz0pqKt0v6J9WqnNMdUwQPwCU5lrj5av
         z77+HuY+Nuz7q2RhrMYqw+Ga4PlVwCgqz9mg8RzTzsV4IXTUE5F4+2RURu4vgUbqemKe
         X3pG9tBG1jX/p8acOhn4Y0dHV9uZN1cAVkWwxizNel2C4+iviyA0O8Hr6PwUWwwwiJDR
         x7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9F5Euxlk/BDv+iwStIONsTGPjBlbxX81m0xZKZwM+0Q=;
        b=Lx3i1u75eTte53U4S7ZLnfzo9apjoY25fYPnbLh4fiiVYVTo7Bd7ai9pXqTO3tO4Cj
         kWr2GARmbMnaNIxaSUPE40GdNy7D6LMy3Bc6CKEi9rZSlXy7GRvuSxBs2TTyYB565pgW
         kE2ZngrQFo1j3moCS+TorvjvSzJCoBGuMe4W5tOprDLdWCZs/FLvf266DrSYuW4wh7PJ
         pz8llcPWDjRCDO2HRi3AmC1ZqazAZIvvl5BfGpJJDdWASi+PLuNtQMi57lH0fCGoVmrS
         DyJzhVYeEeo9dHkcV43GjNVrxQF0QTNzd31w6VneWtWuRz4EVTonUSL3pyhaC17UExL5
         Vfug==
X-Gm-Message-State: AOAM530OylRHG/W0j+TxA9YVWLYbaMW4OfcDbg08usMWDvPgpbjP3v4X
        xQrwaqMQlWzSFJ4Bk6zxNffZWLPPxL0=
X-Google-Smtp-Source: ABdhPJyG0qpEsYuOOBqeuoNdSGfLDBJSvC0HO9XCgArsD7JQDZAdK7HpY57Rj+gFQTwADo6f4neqaA==
X-Received: by 2002:a65:58c7:: with SMTP id e7mr19713401pgu.350.1610375196235;
        Mon, 11 Jan 2021 06:26:36 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id ay21sm15956341pjb.1.2021.01.11.06.26.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:35 -0800 (PST)
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
Subject: [PATCH -tip V4 5/8] workqueue: introduce wq_unbound_online_cpumask
Date:   Mon, 11 Jan 2021 23:26:35 +0800
Message-Id: <20210111152638.2417-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

wq_unbound_online_cpumask is the cached result of cpu_online_mask with
the going-down cpu cleared before the cpu is cleared from cpu_active_mask.
It is used to track the cpu hotplug process so the creation/attachment
of unbound workers can know where it is in the process when there is
ongoing cpu hotplug and so that workqueue can cooperate with hotplug and
scheduler correctly in later patches for setting correct cpumask for
workers and break affinity initiatively.

The first usage of wq_unbound_online_cpumask is also in this patch.
wq_calc_node_cpumask() and wq_update_unbound_numa() can be simplified
a little.

Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aed08eddeb83..d01cca8e51f9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -310,6 +310,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 /* PL: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
+/* PL: online cpus (cpu_online_mask with the going-down cpu cleared) */
+static cpumask_var_t wq_unbound_online_cpumask;
+
 /* CPU where unbound work was last round robin scheduled from this CPU */
 static DEFINE_PER_CPU(int, wq_rr_cpu_last);
 
@@ -3835,12 +3838,10 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
@@ -3854,15 +3855,14 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
+	cpumask_and(cpumask, cpumask, wq_unbound_online_cpumask);
 
 	if (cpumask_empty(cpumask))
 		goto use_dfl;
@@ -3971,7 +3971,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_node(node) {
-		if (wq_calc_node_cpumask(new_attrs, node, -1, tmp_attrs->cpumask)) {
+		if (wq_calc_node_cpumask(new_attrs, node, tmp_attrs->cpumask)) {
 			ctx->pwq_tbl[node] = alloc_unbound_pwq(wq, tmp_attrs);
 			if (!ctx->pwq_tbl[node])
 				goto out_free;
@@ -4096,7 +4096,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU coming up or going down
- * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
  * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update NUMA affinity of
@@ -4114,11 +4113,9 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
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
@@ -4146,7 +4143,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * and create a new one if they don't match.  If the target cpumask
 	 * equals the default pwq's, the default pwq should be used.
 	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
+	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpumask)) {
 		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
 			return;
 	} else {
@@ -5106,6 +5103,7 @@ int workqueue_unbound_online_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
+	cpumask_set_cpu(cpu, wq_unbound_online_cpumask);
 
 	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
@@ -5119,7 +5117,7 @@ int workqueue_unbound_online_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, true);
+		wq_update_unbound_numa(wq, cpu);
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -5131,8 +5129,9 @@ int workqueue_unbound_offline_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
+	cpumask_clear_cpu(cpu, wq_unbound_online_cpumask);
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, false);
+		wq_update_unbound_numa(wq, cpu);
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
@@ -5969,6 +5968,9 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	BUG_ON(!alloc_cpumask_var(&wq_unbound_online_cpumask, GFP_KERNEL));
+	cpumask_copy(wq_unbound_online_cpumask, cpu_online_mask);
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
 
@@ -6065,7 +6067,7 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_unbound_numa(wq, smp_processor_id(), true);
+		wq_update_unbound_numa(wq, smp_processor_id());
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
-- 
2.19.1.6.gb485710b

