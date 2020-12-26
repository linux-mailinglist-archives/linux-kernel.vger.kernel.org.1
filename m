Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213A42E2CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgLZBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:51:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78633C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z21so3804380pgj.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8HZXsef7FZkOgU1XsfsCuC+ukty+UZ3E8S5aBbnH94=;
        b=VNg9kjgWn5VtKwRwmftl2Jg0JJLi+NkQjquGJpdgtdnUfjFBZJ2A3d1xVAvSfGgio4
         dO1WYoj+/JUk31+HfSahI+IJjVsgjTvjTSz7N2XWaNVfxlLEDWVXdKkCrABq+93+D+Zo
         EbHqdv+fhEBlImC0DrL7sVsvYml16KRq9UjOJv16IEMppYaKQ9LGTjHTu8No6XZW8jKf
         KTIdLUXzQv3M8ROF0QrYRNyzI5/rxzKX+Mj7mnIjSfysIAkJAcAlqQgXJ8wD9dfntnPF
         k/0kqKM9MRcmyran7nlUy4n3HwbmfZK1/h1LB/t97pGtJqq+3DneX5GPTjegYqA5SNKA
         tUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8HZXsef7FZkOgU1XsfsCuC+ukty+UZ3E8S5aBbnH94=;
        b=Y7wdfKWasPpLUwJTrQhffJHGImFJW/YVoEz8ml73m+zDQkrRPBY9wk6VhQyR4Q+bNx
         6W0NtBJegnVqJ2pgw1fWaUDXvWb91ZmcpC2fmNkxEKA8mJcTI5GGrW7AkRPtR8ecaFFy
         0Ygkq5y3YZhZuXKtTf7HnNFSfy2sfOvXlwyIfvNbOmEdGXg+AOs0ljtzfMVC4mKDMntL
         4sZSNFPQ39rqs1dvwNV6H8IaO3ca9zt5e4G/TllAx1jUbUuz7wVO5u8gJUjI9z0/cCL4
         EJUEskW1S6VLoAID+t3JcIFhI46ds4D2ORoKPKAbgC21Lqw7m4CGjCkdgbwB+sB9frFk
         X06Q==
X-Gm-Message-State: AOAM533CPNw03MIOD4CA+VehN3CDzCrQ6z7wyvoJpbJGky2XNfhaW+nG
        IYmKduxm1GKBEBqUZERnDOVUaD56d8k=
X-Google-Smtp-Source: ABdhPJxcjsBhpoPMQQJH9ZleLDP4VtNmW+7DsuI8jqNWn6pxw/zZ5XJvXySWH/8Khr4zKSUJsnaEtQ==
X-Received: by 2002:a63:74b:: with SMTP id 72mr34620937pgh.4.1608947462868;
        Fri, 25 Dec 2020 17:51:02 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id f92sm6423222pjk.54.2020.12.25.17.51.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:51:02 -0800 (PST)
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
Subject: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
Date:   Sat, 26 Dec 2020 10:51:11 +0800
Message-Id: <20201226025117.2770-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
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
index ccbceacaea1b..6f75f7ebeb17 100644
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
 
@@ -3825,12 +3828,10 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
@@ -3844,15 +3845,14 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
@@ -3961,7 +3961,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_node(node) {
-		if (wq_calc_node_cpumask(new_attrs, node, -1, tmp_attrs->cpumask)) {
+		if (wq_calc_node_cpumask(new_attrs, node, tmp_attrs->cpumask)) {
 			ctx->pwq_tbl[node] = alloc_unbound_pwq(wq, tmp_attrs);
 			if (!ctx->pwq_tbl[node])
 				goto out_free;
@@ -4086,7 +4086,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU coming up or going down
- * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
  * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update NUMA affinity of
@@ -4104,11 +4103,9 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
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
@@ -4136,7 +4133,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * and create a new one if they don't match.  If the target cpumask
 	 * equals the default pwq's, the default pwq should be used.
 	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
+	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpumask)) {
 		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
 			return;
 	} else {
@@ -5069,6 +5066,7 @@ int workqueue_online_cpu(unsigned int cpu)
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
+	cpumask_set_cpu(cpu, wq_online_cpumask);
 
 	for_each_pool(pool, pi) {
 		mutex_lock(&wq_pool_attach_mutex);
@@ -5083,7 +5081,7 @@ int workqueue_online_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, true);
+		wq_update_unbound_numa(wq, cpu);
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -5101,8 +5099,9 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
+	cpumask_clear_cpu(cpu, wq_online_cpumask);
 	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, false);
+		wq_update_unbound_numa(wq, cpu);
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
@@ -5939,6 +5938,9 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	BUG_ON(!alloc_cpumask_var(&wq_online_cpumask, GFP_KERNEL));
+	cpumask_copy(wq_online_cpumask, cpu_online_mask);
+
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
 
@@ -6035,7 +6037,7 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_unbound_numa(wq, smp_processor_id(), true);
+		wq_update_unbound_numa(wq, smp_processor_id());
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
-- 
2.19.1.6.gb485710b

