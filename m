Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EFE2C8E46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgK3Tkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:40:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:56587 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbgK3Tkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:40:45 -0500
IronPort-SDR: KF+/2hK5cM/OSQUE1cQlcCd6BQRKDlFg1uEDmSLc9XcvEptbFWL+BHNupfnmsIaRADMpGDhiOh
 G/noEncdi/kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170134963"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170134963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:39:03 -0800
IronPort-SDR: 3oxZn5WK/hOvQlsLkwweKJpwNa7su56eEYZK8YgwhTvWj92GkF/GzCB960Q3YmIb8xaqxzd6N2
 oSQ2eIZsdBlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480781838"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 11:39:02 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/3] perf/core: Flush PMU internal buffers for per-CPU events
Date:   Mon, 30 Nov 2020 11:38:40 -0800
Message-Id: <20201130193842.10569-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Sometimes the PMU internal buffers have to be flushed for per-CPU events
during a context switch, e.g., large PEBS. Otherwise, the perf tool may
report samples in locations that do not belong to the process where the
samples are processed in, because PEBS does not tag samples with PID/TID.

The current code only flush the buffers for a per-task event. It doesn't
check a per-CPU event.

Add a new event state flag, PERF_ATTACH_SCHED_CB, to indicate that the
PMU internal buffers have to be flushed for this event during a context
switch.

Add sched_cb_entry and perf_sched_cb_usages back to track the PMU/cpuctx
which is required to be flushed.

Only need to invoke the sched_task() for per-CPU events in this patch.
The per-task events have been handled in perf_event_context_sched_in/out
already.

Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
Reported-by: Gabriel Marin <gmx@google.com>
Reported-by: Namhyung Kim <namhyung@kernel.org>
Originally-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 42 ++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d279b97f..530a505e1c7e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -606,6 +606,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_TASK	0x04
 #define PERF_ATTACH_TASK_DATA	0x08
 #define PERF_ATTACH_ITRACE	0x10
+#define PERF_ATTACH_SCHED_CB	0x20
 
 struct perf_cgroup;
 struct perf_buffer;
@@ -872,6 +873,7 @@ struct perf_cpu_context {
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
+	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
 
 	int				online;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1dd49a..c0f7d84a4245 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -383,6 +383,7 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
+static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -3474,11 +3475,16 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 	}
 }
 
+static DEFINE_PER_CPU(struct list_head, sched_cb_list);
+
 void perf_sched_cb_dec(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	--cpuctx->sched_cb_usage;
+	this_cpu_dec(perf_sched_cb_usages);
+
+	if (!--cpuctx->sched_cb_usage)
+		list_del(&cpuctx->sched_cb_entry);
 }
 
 
@@ -3486,7 +3492,10 @@ void perf_sched_cb_inc(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	cpuctx->sched_cb_usage++;
+	if (!cpuctx->sched_cb_usage++)
+		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+
+	this_cpu_inc(perf_sched_cb_usages);
 }
 
 /*
@@ -3515,6 +3524,24 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
+static void perf_pmu_sched_task(struct task_struct *prev,
+				struct task_struct *next,
+				bool sched_in)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (prev == next)
+		return;
+
+	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		/* will be handled in perf_event_context_sched_in/out */
+		if (cpuctx->task_ctx)
+			continue;
+
+		__perf_pmu_sched_task(cpuctx, sched_in);
+	}
+}
+
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
@@ -3537,6 +3564,9 @@ void __perf_event_task_sched_out(struct task_struct *task,
 {
 	int ctxn;
 
+	if (__this_cpu_read(perf_sched_cb_usages))
+		perf_pmu_sched_task(task, next, false);
+
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
@@ -3844,6 +3874,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
+
+	if (__this_cpu_read(perf_sched_cb_usages))
+		perf_pmu_sched_task(prev, task, true);
 }
 
 static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
@@ -4668,7 +4701,7 @@ static void unaccount_event(struct perf_event *event)
 	if (event->parent)
 		return;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
@@ -11065,7 +11098,7 @@ static void account_event(struct perf_event *event)
 	if (event->parent)
 		return;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
@@ -12857,6 +12890,7 @@ static void __init perf_event_init_all_cpus(void)
 #ifdef CONFIG_CGROUP_PERF
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
+		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 	}
 }
 
-- 
2.17.1

