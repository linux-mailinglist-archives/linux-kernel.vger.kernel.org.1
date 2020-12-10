Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547C32D622C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391940AbgLJQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:40:39 -0500
Received: from foss.arm.com ([217.140.110.172]:52484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbgLJQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:40:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFBD1396;
        Thu, 10 Dec 2020 08:39:18 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E86D3F66B;
        Thu, 10 Dec 2020 08:39:16 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during late hotplug
Date:   Thu, 10 Dec 2020 16:38:30 +0000
Message-Id: <20201210163830.21514-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201210163830.21514-1-valentin.schneider@arm.com>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per-CPU kworkers forcefully migrated away by hotplug via
workqueue_offline_cpu() can end up spawning more kworkers via

  manage_workers() -> maybe_create_worker()

Workers created at this point will be bound using

  pool->attrs->cpumask

which in this case is wrong, as the hotplug state machine already migrated
all pinned kworkers away from this CPU. This ends up triggering the BUG_ON
condition is sched_cpu_dying() (i.e. there's a kworker enqueued on the
dying rq).

Special-case workers being attached to DISASSOCIATED pools and bind them to
cpu_active_mask, mimicking them being present when workqueue_offline_cpu()
was invoked.

Link: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/workqueue.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c0e272..fb1418edf85c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1848,19 +1848,29 @@ static void worker_attach_to_pool(struct worker *worker,
 {
 	mutex_lock(&wq_pool_attach_mutex);
 
-	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
-
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
 	 * stable across this function.  See the comments above the flag
 	 * definition for details.
+	 *
+	 * Worker might get attached to a pool *after* workqueue_offline_cpu()
+	 * was run - e.g. created by manage_workers() from a kworker which was
+	 * forcefully moved away by hotplug. Kworkers created from this point on
+	 * need to have their affinity changed as if they were present during
+	 * workqueue_offline_cpu().
+	 *
+	 * This will be resolved in rebind_workers().
 	 */
-	if (pool->flags & POOL_DISASSOCIATED)
+	if (pool->flags & POOL_DISASSOCIATED) {
 		worker->flags |= WORKER_UNBOUND;
+		set_cpus_allowed_ptr(worker->task, cpu_active_mask);
+	} else {
+		/*
+		 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
+		 * online CPUs. It'll be re-applied when any of the CPUs come up.
+		 */
+		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	}
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
-- 
2.27.0

