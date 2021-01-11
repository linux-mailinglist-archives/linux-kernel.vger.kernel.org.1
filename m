Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20922F1849
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbhAKO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732873AbhAKO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:27:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE2C0617A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:49 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2so8763pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLOG3rxxBrPw7NL49UBOz1KsxuY6zkedty5u/KMQ8qA=;
        b=bvFw0fozb/TwaoyvwRodFByl9p6ZCmzBVzvB0fh0UHPBGLE4d67Ti6X8DN3mWsa8Rz
         ZXaPqu23J0RgswrKMUAAnjwp5mzNCVKd9OHWmagh1I/MnzFkPAnTgtPoqlTP/Z+FqYb2
         WmfMXcU9aWC8ZC76wsCXbR3E67hDPBmgOhtlpR8ZztZGTS/6IOIWc4D4H8Ucpm59sJSe
         kPweioWjmWqYEVuT4KAjszC53ILKNVaLl8ZZ2JyU5CCpV4Za//4PH1UyOv2/ONh/Jmn7
         u6t8kRyMYHDDVY3iKv6WuGGWfdyEKj1JX9HrQ01xXe+9Y0KlzftCCfbXlfz5Z5P54P07
         pgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLOG3rxxBrPw7NL49UBOz1KsxuY6zkedty5u/KMQ8qA=;
        b=dGkxx86h2J7iLJMb2ZDJYZW2u2R+AVkAq0lfJ1YG1Lau0s+a77FBDIzA2Dyn6hen2L
         h1Ij1nMfTzsAK3qEesOfXhEUS+E+Wil019WizK+vOh+YV+fzvWZhvI96D4V1ciB3KUc9
         zmKKjYg0YIlpyNJxTdljimeaBYjeKBEq7+3NR8HWfr6Iyf+F5AF65XPz0GgLmScVNSSo
         26/pEF3j9Z+vwRlClAoAZLFZaAqdQIbgdbjuvWp0FiJnhp590OWKkyWvtljwDfT1NpG8
         IXXgotUt6uJrytsWKKWNb8UPqDyi6Y/FUZBpIpV5BXessTp6gdd9CTjOE3ZSXMlPvVSS
         c7tg==
X-Gm-Message-State: AOAM531sgMzDjYOUPw9wJAVH/8Il4VPbll6IstIDlvDIAaNC9dL7PHGk
        PYK3nO5BLChGZqJl06uADJxer56aGL8=
X-Google-Smtp-Source: ABdhPJwipVxc5HERMJtqKOasuKx6jo9W2Y//Ul3pEXI5hyHFZfrvcFuZPBPP4Wh2PWMFQfj+jtvgGw==
X-Received: by 2002:a62:7693:0:b029:19d:92fb:4ec1 with SMTP id r141-20020a6276930000b029019d92fb4ec1mr19756918pfc.4.1610375208614;
        Mon, 11 Jan 2021 06:26:48 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id u24sm15615090pjx.56.2021.01.11.06.26.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:48 -0800 (PST)
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
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH -tip V4 7/8] workqueue: Manually break affinity on hotplug for unbound pool
Date:   Mon, 11 Jan 2021 23:26:37 +0800
Message-Id: <20210111152638.2417-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is possible that a per-node pool/woker's affinity is a single
CPU.  It can happen when the workqueue user changes the cpumask of the
workqueue or when wq_unbound_cpumask is changed by system adim via
/sys/devices/virtual/workqueue/cpumask.  And pool->attrs->cpumask
is workqueue's cpumask & wq_unbound_cpumask & possible_cpumask_of_the_node,
which can be a single CPU and makes the pool's workers to be "per cpu
kthread".

And the scheduler won't break affinity on the "per cpu kthread" workers
when the CPU is going down, so we have to do it by ourselves.

We do it by introducing new break_unbound_workers_cpumask() which is a
symmetric version of restore_unbound_workers_cpumask().   When the last
online CPU of the pool goes down, it is time to break the affinity.

The way to break affinity is to set the workers' affinity to
cpu_possible_mask, so that we preserve the same behavisor when
the scheduler breaks affinity for us.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 65 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f2793749bd97..b012adbeff9f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5035,8 +5035,9 @@ static void rebind_workers(struct worker_pool *pool)
  *
  * An unbound pool may end up with a cpumask which doesn't have any online
  * CPUs.  When a worker of such pool get scheduled, the scheduler resets
- * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
- * online CPU before, cpus_allowed of all its workers should be restored.
+ * its cpus_allowed or we had reset it earlier in break_unbound_workers_cpumask().
+ * If @cpu is in @pool's cpumask which didn't have any online CPU before,
+ * cpus_allowed of all its workers should be restored.
  */
 static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 {
@@ -5061,6 +5062,50 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 						  pool->attrs->cpumask) < 0);
 }
 
+/**
+ * break_unbound_workers_cpumask - break cpumask of unbound workers
+ * @pool: unbound pool of interest
+ * @cpu: the CPU which is going down
+ *
+ * An unbound pool may end up with a cpumask which doesn't have any online
+ * CPUs.  When a worker of such pool get scheduled, the scheduler resets
+ * its cpus_allowed unless there is only one CPU in the cpus_allowed which
+ * is the special case we need to handle it on our own and avoid blocking
+ * the hotplug process or causing further harms.
+ */
+static void break_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
+{
+	struct worker *worker;
+
+	lockdep_assert_held(&wq_pool_mutex);
+	lockdep_assert_held(&wq_pool_attach_mutex);
+
+	/* is @cpu allowed for @pool? */
+	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
+		return;
+
+	/*
+	 * is @cpu the last online for @pool?  If so, the scheduler or we
+	 * need to break affinity for the workers.
+	 */
+	if (cpumask_intersects(pool->attrs->cpumask, wq_unbound_online_cpumask))
+		return;
+
+	/*
+	 * is @cpu the only possible CPU for @pool?  If not, scheduler
+	 * will take care of breaking affinity for the workers since the
+	 * workers are all non-per-cpu-kthread.  It is the usual case
+	 * for unbound pools/workers and we don't need to bother to do it.
+	 */
+	if (cpumask_weight(pool->attrs->cpumask) > 1)
+		return;
+
+	/* as we're setting it to cpu_possible_mask, the following shouldn't fail */
+	for_each_pool_worker(worker, pool)
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
+						  cpu_possible_mask) < 0);
+}
+
 int workqueue_prepare_cpu(unsigned int cpu)
 {
 	struct worker_pool *pool;
@@ -5126,13 +5171,27 @@ int workqueue_unbound_online_cpu(unsigned int cpu)
 
 int workqueue_unbound_offline_cpu(unsigned int cpu)
 {
+	struct worker_pool *pool;
 	struct workqueue_struct *wq;
+	int pi;
 
-	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
 	cpumask_clear_cpu(cpu, wq_unbound_online_cpumask);
+
+	/* update CPU affinity of workers of unbound pools */
+	for_each_pool(pool, pi) {
+		mutex_lock(&wq_pool_attach_mutex);
+
+		if (pool->cpu < 0)
+			break_unbound_workers_cpumask(pool, cpu);
+
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
+
+	/* update NUMA affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list)
 		wq_update_unbound_numa(wq, cpu);
+
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
-- 
2.19.1.6.gb485710b

