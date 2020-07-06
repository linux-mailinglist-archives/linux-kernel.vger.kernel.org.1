Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35052156CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgGFLzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 07:55:04 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:20821 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGFLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594036500; x=1625572500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OBUIgvq0SljlrMxzl4rB2EKdYL4ttOzbD4kYPUlDL3I=;
  b=H0iulqDcMhlM+OlI89DPlhAFcSuIQBwJ7XlBZnlHJSSzM/TuxJaEdZyx
   /t0sT/IhvrideO1Sfez0RzM6AVFUZ1JNltStz7xswd3zYiPzEPsIkRJ92
   NRWOD2UOpukWXejMJwC52obhZ6ANjwT1mwjaOJ2QIqyvNDZ7GtUJtuFLl
   0=;
IronPort-SDR: 8HCQVYYZXo+jvqstnOoX5oqGfQUrtp79WEx5JTSKWgNbzwcN4qPQLuLZ+WvVGifwKMcntivz/M
 sS/c6HjoWRrQ==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="41656535"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Jul 2020 11:54:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 092B7A0663;
        Mon,  6 Jul 2020 11:54:53 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:54:53 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:54:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 03/15] mm/damon: Implement region based sampling
Date:   Mon, 6 Jul 2020 13:53:10 +0200
Message-ID: <20200706115322.29598-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706115322.29598-1-sjpark@amazon.com>
References: <20200706115322.29598-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWA003.ant.amazon.com (10.43.160.184) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements DAMON's target address space independent high
level logics for basic access check and region based sampling.  This
doesn't work alone, but needs the target address space specific low
level pritimives implementation for the monitoring target address ranges
construction and the access check, though.  A reference implementation
of those will be provided by a later commit.  Nevertheless, users can
implement and use their own versions for their specific use cases.

Basic Access Check
==================

The output of DAMON says what pages are how frequently accessed for a
given duration.  The resolution of the access frequency is controlled by
setting ``sampling interval`` and ``aggregation interval``.  In detail,
DAMON checks access to each page per ``sampling interval`` and
aggregates the results.  In other words, counts the number of the
accesses to each page.  After each ``aggregation interval`` passes,
DAMON calls callback functions that previously registered by users so
that users can read the aggregated results and then clears the results.
This can be described in below simple pseudo-code::

    while monitoring_on:
        for page in monitoring_target:
            if accessed(page):
                nr_accesses[page] += 1
        if time() % aggregation_interval == 0:
            for callback in user_registered_callbacks:
                callback(monitoring_target, nr_accesses)
            for page in monitoring_target:
                nr_accesses[page] = 0
        sleep(sampling interval)

The monitoring overhead of this mechanism will arbitrarily increase as
the size of the target workload grows.

Region Based Sampling
=====================

To avoid the unbounded increase of the overhead, DAMON groups adjacent
pages that assumed to have the same access frequencies into a region.
As long as the assumption (pages in a region have the same access
frequencies) is kept, only one page in the region is required to be
checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
page in each region, waits for one ``sampling interval``, checks whether
the page is accessed meanwhile, and increases the access frequency of
the region if so.  Therefore, the monitoring overhead is controllable by
setting the number of regions.  DAMON allows users to set the minimum
and the maximum number of regions for the trade-off.

This scheme, however, cannot preserve the quality of the output if the
assumption is not guaranteed.  Next commit will address this problem.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h |  80 ++++++++++++-
 mm/damon.c            | 258 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 335 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c8f8c1c41a45..7adc7b6b3507 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -11,6 +11,8 @@
 #define _DAMON_H_
 
 #include <linux/random.h>
+#include <linux/mutex.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 /**
@@ -53,11 +55,87 @@ struct damon_task {
 };
 
 /**
- * struct damon_ctx - Represents a context for each monitoring.
+ * struct damon_ctx - Represents a context for each monitoring.  This is the
+ * main interface that allows users to set the attributes and get the results
+ * of the monitoring.
+ *
+ * @sample_interval:		The time between access samplings.
+ * @aggr_interval:		The time between monitor results aggregations.
+ * @nr_regions:			The number of monitoring regions.
+ *
+ * For each @sample_interval, DAMON checks whether each region is accessed or
+ * not.  It aggregates and keeps the access information (number of accesses to
+ * each region) for @aggr_interval time.  All time intervals are in
+ * micro-seconds.
+ *
+ * @kdamond:		Kernel thread who does the monitoring.
+ * @kdamond_stop:	Notifies whether kdamond should stop.
+ * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
+ *
+ * For each monitoring request (damon_start()), a kernel thread for the
+ * monitoring is created.  The pointer to the thread is stored in @kdamond.
+ *
+ * The monitoring thread sets @kdamond to NULL when it terminates.  Therefore,
+ * users can know whether the monitoring is ongoing or terminated by reading
+ * @kdamond.  Also, users can ask @kdamond to be terminated by writing non-zero
+ * to @kdamond_stop.  Reads and writes to @kdamond and @kdamond_stop from
+ * outside of the monitoring thread must be protected by @kdamond_lock.
+ *
+ * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
+ * @kdamond_lock.  Accesses to other fields must be protected by themselves.
+ *
  * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
+ *
+ * @init_target_regions:	Constructs initial monitoring target regions.
+ * @prepare_access_checks:	Prepares next access check of target regions.
+ * @check_accesses:		Checks the access of target regions.
+ * @sample_cb:			Called for each sampling interval.
+ * @aggregate_cb:		Called for each aggregation interval.
+ *
+ * DAMON can be extended for various address spaces by users.  For this, users
+ * can register the target address space dependent low level functions for
+ * their usecases via the callback pointers of the context.  The monitoring
+ * thread calls @init_target_regions before starting the monitoring, and
+ * @prepare_access_checks and @check_accesses for each @sample_interval.
+ *
+ * @init_target_regions should construct proper monitoring target regions and
+ * link those to the DAMON context struct.
+ * @prepare_access_checks should manipulate the monitoring regions to be
+ * prepare for the next access check.
+ * @check_accesses should check the accesses to each region that made after the
+ * last preparation and update the `->nr_accesses` of each region.
+ *
+ * @sample_cb and @aggregate_cb are called from @kdamond for each of the
+ * sampling intervals and aggregation intervals, respectively.  Therefore,
+ * users can safely access to the monitoring results via @tasks_list without
+ * additional protection of @kdamond_lock.  For the reason, users are
+ * recommended to use these callback for the accesses to the results.
  */
 struct damon_ctx {
+	unsigned long sample_interval;
+	unsigned long aggr_interval;
+	unsigned long nr_regions;
+
+	struct timespec64 last_aggregation;
+
+	struct task_struct *kdamond;
+	bool kdamond_stop;
+	struct mutex kdamond_lock;
+
 	struct list_head tasks_list;	/* 'damon_task' objects */
+
+	/* callbacks */
+	void (*init_target_regions)(struct damon_ctx *context);
+	void (*prepare_access_checks)(struct damon_ctx *context);
+	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*sample_cb)(struct damon_ctx *context);
+	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
+int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long min_nr_reg);
+int damon_start(struct damon_ctx *ctx);
+int damon_stop(struct damon_ctx *ctx);
+
 #endif
diff --git a/mm/damon.c b/mm/damon.c
index 5ab13b1c15cf..5d0b3ab684b3 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,18 +9,27 @@
  * This file is constructed in below parts.
  *
  * - Functions and macros for DAMON data structures
+ * - Functions for DAMON core logics and features
+ * - Functions for the DAMON programming interface
  * - Functions for the module loading/unloading
- *
- * The core parts are not implemented yet.
  */
 
 #define pr_fmt(fmt) "damon: " fmt
 
 #include <linux/damon.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/page_idle.h>
+#include <linux/random.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 
+/* Minimal region size.  Every damon_region is aligned by this. */
+#define MIN_REGION PAGE_SIZE
+
 /*
  * Functions and macros for DAMON data structures
  */
@@ -167,6 +176,251 @@ static unsigned int nr_damon_regions(struct damon_task *t)
 	return nr_regions;
 }
 
+/*
+ * Functions for DAMON core logics and features
+ */
+
+/*
+ * damon_check_reset_time_interval() - Check if a time interval is elapsed.
+ * @baseline:	the time to check whether the interval has elapsed since
+ * @interval:	the time interval (microseconds)
+ *
+ * See whether the given time interval has passed since the given baseline
+ * time.  If so, it also updates the baseline to current time for next check.
+ *
+ * Return:	true if the time interval has passed, or false otherwise.
+ */
+static bool damon_check_reset_time_interval(struct timespec64 *baseline,
+		unsigned long interval)
+{
+	struct timespec64 now;
+
+	ktime_get_coarse_ts64(&now);
+	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
+			interval * 1000)
+		return false;
+	*baseline = now;
+	return true;
+}
+
+/*
+ * Check whether it is time to flush the aggregated information
+ */
+static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_aggregation,
+			ctx->aggr_interval);
+}
+
+/*
+ * Reset the aggregated monitoring results
+ */
+static void kdamond_reset_aggregated(struct damon_ctx *c)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(t, c) {
+		damon_for_each_region(r, t)
+			r->nr_accesses = 0;
+	}
+}
+
+/*
+ * Check whether current monitoring should be stopped
+ *
+ * The monitoring is stopped when either the user requested to stop, or all
+ * monitoring target tasks are dead.
+ *
+ * Returns true if need to stop current monitoring.
+ */
+static bool kdamond_need_stop(struct damon_ctx *ctx)
+{
+	struct damon_task *t;
+	struct task_struct *task;
+	bool stop;
+
+	mutex_lock(&ctx->kdamond_lock);
+	stop = ctx->kdamond_stop;
+	mutex_unlock(&ctx->kdamond_lock);
+	if (stop)
+		return true;
+
+	damon_for_each_task(t, ctx) {
+		/* -1 is reserved for non-process bounded monitoring */
+		if (t->pid == -1)
+			return false;
+
+		task = damon_get_task_struct(t);
+		if (task) {
+			put_task_struct(task);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * The monitoring daemon that runs as a kernel thread
+ */
+static int kdamond_fn(void *data)
+{
+	struct damon_ctx *ctx = (struct damon_ctx *)data;
+	struct damon_task *t;
+	struct damon_region *r, *next;
+
+	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
+	if (ctx->init_target_regions)
+		ctx->init_target_regions(ctx);
+	while (!kdamond_need_stop(ctx)) {
+		if (ctx->prepare_access_checks)
+			ctx->prepare_access_checks(ctx);
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
+
+		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
+
+		if (ctx->check_accesses)
+			ctx->check_accesses(ctx);
+
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
+			kdamond_reset_aggregated(ctx);
+		}
+
+	}
+	damon_for_each_task(t, ctx) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
+	mutex_lock(&ctx->kdamond_lock);
+	ctx->kdamond = NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	do_exit(0);
+}
+
+/*
+ * Functions for the DAMON programming interface
+ */
+
+static bool damon_kdamond_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return running;
+}
+
+/**
+ * damon_start() - Starts monitoring with given context.
+ * @ctx:	monitoring context
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_start(struct damon_ctx *ctx)
+{
+	int err = -EBUSY;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (!ctx->kdamond) {
+		err = 0;
+		ctx->kdamond_stop = false;
+		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
+		if (IS_ERR(ctx->kdamond))
+			err = PTR_ERR(ctx->kdamond);
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return err;
+}
+
+/**
+ * damon_stop() - Stops monitoring of given context.
+ * @ctx:	monitoring context
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_stop(struct damon_ctx *ctx)
+{
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ctx->kdamond_stop = true;
+		mutex_unlock(&ctx->kdamond_lock);
+		while (damon_kdamond_running(ctx))
+			usleep_range(ctx->sample_interval,
+					ctx->sample_interval * 2);
+		return 0;
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return -EPERM;
+}
+
+/**
+ * damon_set_pids() - Set monitoring target processes.
+ * @ctx:	monitoring context
+ * @pids:	array of target processes pids
+ * @nr_pids:	number of entries in @pids
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
+{
+	ssize_t i;
+	struct damon_task *t, *next;
+
+	damon_for_each_task_safe(t, next, ctx)
+		damon_destroy_task(t);
+
+	for (i = 0; i < nr_pids; i++) {
+		t = damon_new_task(pids[i]);
+		if (!t) {
+			pr_err("Failed to alloc damon_task\n");
+			return -ENOMEM;
+		}
+		damon_add_task(ctx, t);
+	}
+
+	return 0;
+}
+
+/**
+ * damon_set_attrs() - Set attributes for the monitoring.
+ * @ctx:		monitoring context
+ * @sample_int:		time interval between samplings
+ * @aggr_int:		time interval between aggregations
+ * @nr_reg:		number of regions
+ *
+ * This function should not be called while the kdamond is running.
+ * Every time interval is in micro-seconds.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long nr_reg)
+{
+	if (nr_reg < 3) {
+		pr_err("nr_regions (%lu) must be at least 3\n",
+				nr_reg);
+		return -EINVAL;
+	}
+
+	ctx->sample_interval = sample_int;
+	ctx->aggr_interval = aggr_int;
+	ctx->nr_regions = nr_reg;
+
+	return 0;
+}
+
 /*
  * Functions for the module loading/unloading
  */
-- 
2.17.1

