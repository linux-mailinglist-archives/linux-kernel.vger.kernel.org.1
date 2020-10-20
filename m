Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D96293760
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392271AbgJTJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:01:26 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53173 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390216AbgJTJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603184482; x=1634720482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dARCre0biGrRSqz/sAes9zlAIFNWsxlae2wsWUh+NM4=;
  b=rX9Vm00DCYlZqXYVWUa5GHI6kCoTApbz22AG2K+qMdfjkREOPDTnanXE
   MFkyNslscL/8tOhpc5zxG6nziOKXk5fyM4Z6n3/i0AxAEh1TBZB1kHMbg
   6rZPbk0sMlTfA9qnDV+Xt/COH9UmuIv10MyHB7NTFdpGCRt89CvEIIZhF
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="86288243"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-41350382.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Oct 2020 09:01:15 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-41350382.us-west-2.amazon.com (Postfix) with ESMTPS id 4E7C7C2971;
        Tue, 20 Oct 2020 09:01:12 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 09:00:53 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v22 02/18] mm/damon: Implement region based sampling
Date:   Tue, 20 Oct 2020 10:59:24 +0200
Message-ID: <20201020085940.13875-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020085940.13875-1-sjpark@amazon.com>
References: <20201020085940.13875-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D41UWC001.ant.amazon.com (10.43.162.107) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON separates its monitoring target address space independent high
level logics from the target space dependent low level primitives for
flexible support of various address spaces.

This commit implements DAMON's target address space independent high
level logics for basic access check and region based sampling.  Hence,
without the target address space specific parts implementations, this
doesn't work alone.  A reference implementation of those will be
provided by a later commit.

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
 include/linux/damon.h | 133 ++++++++++++++++-
 mm/damon/core.c       | 333 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 465 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 183e0edd7f43..1f7b095646c2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -8,6 +8,8 @@
 #ifndef _DAMON_H_
 #define _DAMON_H_
 
+#include <linux/mutex.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 /**
@@ -23,11 +25,13 @@ struct damon_addr_range {
 /**
  * struct damon_region - Represents a monitoring target region.
  * @ar:			The address range of the region.
+ * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
  */
 struct damon_region {
 	struct damon_addr_range ar;
+	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
 };
@@ -50,12 +54,130 @@ struct damon_target {
 	struct list_head list;
 };
 
+struct damon_ctx;
+
 /**
- * struct damon_ctx - Represents a context for each monitoring.
+ * struct damon_primitive	Monitoring primitives for given use cases.
+ *
+ * @init_target_regions:	Constructs initial monitoring target regions.
+ * @prepare_access_checks:	Prepares next access check of target regions.
+ * @check_accesses:		Checks the access of target regions.
+ * @target_valid:		Determine if the target is valid.
+ * @cleanup:			Cleans up the context.
+ *
+ * DAMON can be extended for various address spaces and usages.  For this,
+ * users should register the low level primitives for their target address
+ * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
+ * calls @init_target_regions before starting the monitoring and
+ * @prepare_access_checks, @check_accesses, and @target_valid for each
+ * @sample_interval.
+ *
+ * @init_target_regions should construct proper monitoring target regions and
+ * link those to the DAMON context struct.
+ * @prepare_access_checks should manipulate the monitoring regions to be
+ * prepare for the next access check.
+ * @check_accesses should check the accesses to each region that made after the
+ * last preparation and update the `->nr_accesses` of each region.  It should
+ * also return max &damon_region.nr_accesses that made as a result of its
+ * update.
+ * @target_valid should check whether the target is still valid for the
+ * monitoring.
+ * @cleanup is called from @kdamond just before its termination.  After this
+ * call, only @kdamond_lock and @kdamond will be touched.
+ */
+struct damon_primitive {
+	void (*init_target_regions)(struct damon_ctx *context);
+	void (*prepare_access_checks)(struct damon_ctx *context);
+	unsigned int (*check_accesses)(struct damon_ctx *context);
+	bool (*target_valid)(struct damon_target *target);
+	void (*cleanup)(struct damon_ctx *context);
+};
+
+/*
+ * struct damon_callback	Monitoring events notification callbacks.
+ *
+ * @before_start:	Called before starting the monitoring.
+ * @after_sampling:	Called after each sampling.
+ * @after_aggregation:	Called after each aggregation.
+ * @before_terminate:	Called before terminating the monitoring.
+ * @private:		User private data.
+ *
+ * The monitoring thread (&damon_ctx->kdamond) calls @before_start and
+ * @before_terminate just before starting the monitoring and just before
+ * finishing the monitoring.  Therefore, those are good places for installing
+ * and cleaning @private.
+ *
+ * The monitoring thread calls @after_sampling and @after_aggregation for each
+ * of the sampling intervals and aggregation intervals, respectively.
+ * Therefore, users can safely access the monitoring results via
+ * &damon_ctx.targets_list without additional protection of
+ * damon_ctx.kdamond_lock.  For the reason, users are recommended to use these
+ * callback for the accesses to the results.
+ *
+ * If any callback returns non-zero, monitoring stops.
+ */
+struct damon_callback {
+	void *private;
+
+	int (*before_start)(struct damon_ctx *context);
+	int (*after_sampling)(struct damon_ctx *context);
+	int (*after_aggregation)(struct damon_ctx *context);
+	int (*before_terminate)(struct damon_ctx *context);
+};
+
+/**
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
+ * For each monitoring context, one kernel thread for the monitoring is
+ * created.  The pointer to the thread is stored in @kdamond.
+ *
+ * Once started, the monitoring thread runs until explicitly required to be
+ * terminated or every monitoring target is invalid.  The validity of the
+ * targets is checked via the @target_valid callback.  The termination can also
+ * be explicitly requested by writing non-zero to @kdamond_stop.  The thread
+ * sets @kdamond to NULL when it terminates.  Therefore, users can know whether
+ * the monitoring is ongoing or terminated by reading @kdamond.  Reads and
+ * writes to @kdamond and @kdamond_stop from outside of the monitoring thread
+ * must be protected by @kdamond_lock.
+ *
+ * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
+ * @kdamond_lock.  Accesses to other fields must be protected by themselves.
+ *
  * @targets_list:	Head of monitoring targets (&damon_target) list.
+ *
+ * @primitive:	Set of monitoring primitives for given use cases.
+ * @callback:	Set of callbacks for monitoring events notifications.
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
 	struct list_head targets_list;	/* 'damon_target' objects */
+
+	struct damon_primitive primitive;
+	struct damon_callback callback;
 };
 
 #define damon_next_region(r) \
@@ -90,6 +212,15 @@ void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t);
 unsigned int damon_nr_regions(struct damon_target *t);
 
+int damon_set_targets(struct damon_ctx *ctx,
+		unsigned long *ids, ssize_t nr_ids);
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long nr_reg);
+
+int damon_nr_running_ctxs(void);
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+
 #endif	/* CONFIG_DAMON */
 
 #endif
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4562b2458719..eb4ebeaa064d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -8,12 +8,20 @@
 #define pr_fmt(fmt) "damon: " fmt
 
 #include <linux/damon.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/slab.h>
 
+/* Minimal region size.  Every damon_region is aligned by this. */
+#define MIN_REGION PAGE_SIZE
+
 /*
  * Functions and macros for DAMON data structures
  */
 
+static DEFINE_MUTEX(damon_lock);
+static int nr_running_ctxs;
+
 /*
  * Construct a damon_region struct
  *
@@ -119,3 +127,328 @@ unsigned int damon_nr_regions(struct damon_target *t)
 
 	return nr_regions;
 }
+
+/**
+ * damon_set_targets() - Set monitoring targets.
+ * @ctx:	monitoring context
+ * @ids:	array of target ids
+ * @nr_ids:	number of entries in @ids
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_targets(struct damon_ctx *ctx,
+		      unsigned long *ids, ssize_t nr_ids)
+{
+	ssize_t i;
+	struct damon_target *t, *next;
+
+	damon_for_each_target_safe(t, next, ctx)
+		damon_destroy_target(t);
+
+	for (i = 0; i < nr_ids; i++) {
+		t = damon_new_target(ids[i]);
+		if (!t) {
+			pr_err("Failed to alloc damon_target\n");
+			return -ENOMEM;
+		}
+		damon_add_target(ctx, t);
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
+		    unsigned long aggr_int, unsigned long nr_reg)
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
+static int kdamond_fn(void *data);
+
+/*
+ * __damon_start() - Starts monitoring with given context.
+ * @ctx:	monitoring context
+ *
+ * This function should be called while damon_lock is hold.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int __damon_start(struct damon_ctx *ctx)
+{
+	int err = -EBUSY;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (!ctx->kdamond) {
+		err = 0;
+		ctx->kdamond_stop = false;
+		ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond.%d",
+				nr_running_ctxs);
+		if (IS_ERR(ctx->kdamond))
+			err = PTR_ERR(ctx->kdamond);
+		else
+			wake_up_process(ctx->kdamond);
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return err;
+}
+
+/**
+ * damon_start() - Starts the monitorings for a given group of contexts.
+ * @ctxs:	an array of the pointers for contexts to start monitoring
+ * @nr_ctxs:	size of @ctxs
+ *
+ * This function starts a group of monitoring threads for a group of monitoring
+ * contexts.  One thread per each context is created and run in parallel.  The
+ * caller should handle synchronization between the threads by itself.  If a
+ * group of threads that created by other 'damon_start()' call is currently
+ * running, this function does nothing but returns -EBUSY.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
+{
+	int i;
+	int err = 0;
+
+	mutex_lock(&damon_lock);
+	if (nr_running_ctxs) {
+		mutex_unlock(&damon_lock);
+		return -EBUSY;
+	}
+
+	for (i = 0; i < nr_ctxs; i++) {
+		err = __damon_start(ctxs[i]);
+		if (err)
+			break;
+		nr_running_ctxs++;
+	}
+	mutex_unlock(&damon_lock);
+
+	return err;
+}
+
+/*
+ * __damon_stop() - Stops monitoring of given context.
+ * @ctx:	monitoring context
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int __damon_stop(struct damon_ctx *ctx)
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
+ * damon_stop() - Stops the monitorings for a given group of contexts.
+ * @ctxs:	an array of the pointers for contexts to stop monitoring
+ * @nr_ctxs:	size of @ctxs
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_ctxs; i++) {
+		/* nr_running_ctxs is decremented in kdamond_fn */
+		err = __damon_stop(ctxs[i]);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+/*
+ * Functions for DAMON core logics
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
+ * Reset the aggregated monitoring results ('nr_accesses' of each region).
+ */
+static void kdamond_reset_aggregated(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t)
+			r->nr_accesses = 0;
+	}
+}
+
+/*
+ * Check whether current monitoring should be stopped
+ *
+ * The monitoring is stopped when either the user requested to stop, or all
+ * monitoring targets are invalid.
+ *
+ * Returns true if need to stop current monitoring.
+ */
+static bool kdamond_need_stop(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	bool stop;
+
+	mutex_lock(&ctx->kdamond_lock);
+	stop = ctx->kdamond_stop;
+	mutex_unlock(&ctx->kdamond_lock);
+	if (stop)
+		return true;
+
+	if (!ctx->primitive.target_valid)
+		return false;
+
+	damon_for_each_target(t, ctx) {
+		if (ctx->primitive.target_valid(t))
+			return false;
+	}
+
+	return true;
+}
+
+static void set_kdamond_stop(struct damon_ctx *ctx, bool stop)
+{
+	mutex_lock(&ctx->kdamond_lock);
+	ctx->kdamond_stop = stop;
+	mutex_unlock(&ctx->kdamond_lock);
+}
+
+#define kdamond_call_prmt(ctx, fn)			\
+	do {						\
+		if (ctx->primitive.fn)			\
+			ctx->primitive.fn(ctx);		\
+	} while (0)
+
+#define kdamond_callback(ctx, fn)				\
+	do {							\
+		if (ctx->callback.fn && ctx->callback.fn(ctx))	\
+			set_kdamond_stop(ctx, true);		\
+	} while (0)
+
+/*
+ * The monitoring daemon that runs as a kernel thread
+ */
+static int kdamond_fn(void *data)
+{
+	struct damon_ctx *ctx = (struct damon_ctx *)data;
+	struct damon_target *t;
+	struct damon_region *r, *next;
+
+	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
+
+	kdamond_call_prmt(ctx, init_target_regions);
+	kdamond_callback(ctx, before_start);
+
+	while (!kdamond_need_stop(ctx)) {
+		kdamond_call_prmt(ctx, prepare_access_checks);
+		kdamond_callback(ctx, after_sampling);
+
+		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
+
+		kdamond_call_prmt(ctx, check_accesses);
+
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			kdamond_callback(ctx, after_aggregation);
+			kdamond_reset_aggregated(ctx);
+		}
+	}
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+
+	kdamond_callback(ctx, before_terminate);
+	kdamond_call_prmt(ctx, cleanup);
+
+	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
+	mutex_lock(&ctx->kdamond_lock);
+	ctx->kdamond = NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	mutex_lock(&damon_lock);
+	nr_running_ctxs--;
+	mutex_unlock(&damon_lock);
+
+	do_exit(0);
+}
-- 
2.17.1

