Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C729376D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392310AbgJTJBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:01:54 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:33806 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgJTJBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603184512; x=1634720512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w/JSqe9EhMqEdSn91HD19xQaMzZawG3lkv7krg0C2Ow=;
  b=qE5MYwzS4ospZ5WwTadNWoU5sVWUW7o/IvmRssuc9p0Mqhj5CXcbEqig
   vXMdufZLnkCL5w5pbmUz52WkOZ+xa3EGfWhNfNuqp8sTBdxtEO8lE+Fwu
   9AyxHfYzVq491hOir2qQehztlkqWOGmlp2U1YbijTYQFZEa9U+cYMoCb8
   8=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="85041161"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Oct 2020 09:01:45 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 4064EA2424;
        Tue, 20 Oct 2020 09:01:32 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 09:01:13 +0000
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
Subject: [PATCH v22 03/18] mm/damon: Adaptively adjust regions
Date:   Tue, 20 Oct 2020 10:59:25 +0200
Message-ID: <20201020085940.13875-4-sjpark@amazon.com>
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

Even somehow the initial monitoring target regions are well constructed
to fulfill the assumption (pages in same region have similar access
frequencies), the data access pattern can be dynamically changed.  This
will result in low monitoring quality.  To keep the assumption as much
as possible, DAMON adaptively merges and splits each region based on
their access frequency.

For each ``aggregation interval``, it compares the access frequencies of
adjacent regions and merges those if the frequency difference is small.
Then, after it reports and clears the aggregated access frequency of
each region, it splits each region into two or three regions if the
total number of regions will not exceed the user-specified maximum
number of regions after the split.

In this way, DAMON provides its best-effort quality and minimal overhead
while keeping the upper-bound overhead that users set.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h |  11 ++-
 mm/damon/core.c       | 196 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 195 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1f7b095646c2..0797bdfbfc24 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -132,7 +132,8 @@ struct damon_callback {
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
- * @nr_regions:			The number of monitoring regions.
+ * @min_nr_regions:		The minimum number of monitoring regions.
+ * @max_nr_regions:		The maximum number of monitoring regions.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
@@ -166,7 +167,8 @@ struct damon_callback {
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
-	unsigned long nr_regions;
+	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
 
 	struct timespec64 last_aggregation;
 
@@ -214,8 +216,9 @@ unsigned int damon_nr_regions(struct damon_target *t);
 
 int damon_set_targets(struct damon_ctx *ctx,
 		unsigned long *ids, ssize_t nr_ids);
-int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long nr_reg);
+int damon_set_attrs(struct damon_ctx *ctx,
+		unsigned long sample_int, unsigned long aggr_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg);
 
 int damon_nr_running_ctxs(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index eb4ebeaa064d..ed364b42721d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,6 +10,7 @@
 #include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
@@ -19,6 +20,9 @@
  * Functions and macros for DAMON data structures
  */
 
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 
@@ -164,29 +168,57 @@ int damon_set_targets(struct damon_ctx *ctx,
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
  * @aggr_int:		time interval between aggregations
- * @nr_reg:		number of regions
+ * @min_nr_reg:		minimal number of regions
+ * @max_nr_reg:		maximum number of regions
  *
  * This function should not be called while the kdamond is running.
  * Every time interval is in micro-seconds.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		    unsigned long aggr_int, unsigned long nr_reg)
+int damon_set_attrs(struct damon_ctx *ctx,
+		    unsigned long sample_int, unsigned long aggr_int,
+		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
-	if (nr_reg < 3) {
-		pr_err("nr_regions (%lu) must be at least 3\n",
-				nr_reg);
+	if (min_nr_reg < 3) {
+		pr_err("min_nr_regions (%lu) must be at least 3\n",
+				min_nr_reg);
+		return -EINVAL;
+	}
+	if (min_nr_reg > max_nr_reg) {
+		pr_err("invalid nr_regions.  min (%lu) > max (%lu)\n",
+				min_nr_reg, max_nr_reg);
 		return -EINVAL;
 	}
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
-	ctx->nr_regions = nr_reg;
+	ctx->min_nr_regions = min_nr_reg;
+	ctx->max_nr_regions = max_nr_reg;
 
 	return 0;
 }
 
+/* Returns the size upper limit for each monitoring region */
+static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long sz = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			sz += r->ar.end - r->ar.start;
+	}
+
+	if (ctx->min_nr_regions)
+		sz /= ctx->min_nr_regions;
+	if (sz < MIN_REGION)
+		sz = MIN_REGION;
+
+	return sz;
+}
+
 static bool damon_kdamond_running(struct damon_ctx *ctx)
 {
 	bool running;
@@ -357,6 +389,146 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+#define sz_damon_region(r) (r->ar.end - r->ar.start)
+
+/*
+ * Merge two adjacent regions into one region
+ */
+static void damon_merge_two_regions(struct damon_region *l,
+				struct damon_region *r)
+{
+	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
+
+	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
+			(sz_l + sz_r);
+	l->ar.end = r->ar.end;
+	damon_destroy_region(r);
+}
+
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * t		target affected by this merge operation
+ * thres	'->nr_accesses' diff threshold for the merge
+ * sz_limit	size upper limit of each region
+ */
+static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
+				   unsigned long sz_limit)
+{
+	struct damon_region *r, *prev = NULL, *next;
+
+	damon_for_each_region_safe(r, next, t) {
+		if (prev && prev->ar.end == r->ar.start &&
+		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
+		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
+			damon_merge_two_regions(prev, r);
+		else
+			prev = r;
+	}
+}
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * threshold	'->nr_accesses' diff threshold for the merge
+ * sz_limit	size upper limit of each region
+ *
+ * This function merges monitoring target regions which are adjacent and their
+ * access frequencies are similar.  This is for minimizing the monitoring
+ * overhead under the dynamically changeable access pattern.  If a merge was
+ * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ */
+static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
+				  unsigned long sz_limit)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c)
+		damon_merge_regions_of(t, threshold, sz_limit);
+}
+
+/*
+ * Split a region in two smaller regions
+ *
+ * r		the region to be split
+ * sz_r		size of the first sub-region that will be made
+ */
+static void damon_split_region_at(struct damon_ctx *ctx,
+				  struct damon_region *r, unsigned long sz_r)
+{
+	struct damon_region *new;
+
+	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
+	r->ar.end = new->ar.start;
+
+	damon_insert_region(new, r, damon_next_region(r));
+}
+
+/* Split every region in the given target into 'nr_subs' regions */
+static void damon_split_regions_of(struct damon_ctx *ctx,
+				     struct damon_target *t, int nr_subs)
+{
+	struct damon_region *r, *next;
+	unsigned long sz_region, sz_sub = 0;
+	int i;
+
+	damon_for_each_region_safe(r, next, t) {
+		sz_region = r->ar.end - r->ar.start;
+
+		for (i = 0; i < nr_subs - 1 &&
+				sz_region > 2 * MIN_REGION; i++) {
+			/*
+			 * Randomly select size of left sub-region to be at
+			 * least 10 percent and at most 90% of original region
+			 */
+			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
+					sz_region / 10, MIN_REGION);
+			/* Do not allow blank region */
+			if (sz_sub == 0 || sz_sub >= sz_region)
+				continue;
+
+			damon_split_region_at(ctx, r, sz_sub);
+			sz_region = sz_sub;
+		}
+	}
+}
+
+/*
+ * Split every target region into randomly-sized small regions
+ *
+ * This function splits every target region into random-sized small regions if
+ * current total number of the regions is equal or smaller than half of the
+ * user-specified maximum number of regions.  This is for maximizing the
+ * monitoring accuracy under the dynamically changeable access patterns.  If a
+ * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
+ * it.
+ */
+static void kdamond_split_regions(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_regions = 0;
+	static unsigned int last_nr_regions;
+	int nr_subregions = 2;
+
+	damon_for_each_target(t, ctx)
+		nr_regions += damon_nr_regions(t);
+
+	if (nr_regions > ctx->max_nr_regions / 2)
+		return;
+
+	/* Maybe the middle of the region has different access frequency */
+	if (last_nr_regions == nr_regions &&
+			nr_regions < ctx->max_nr_regions / 3)
+		nr_subregions = 3;
+
+	damon_for_each_target(t, ctx)
+		damon_split_regions_of(ctx, t, nr_subregions);
+
+	last_nr_regions = nr_regions;
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -414,23 +586,31 @@ static int kdamond_fn(void *data)
 	struct damon_ctx *ctx = (struct damon_ctx *)data;
 	struct damon_target *t;
 	struct damon_region *r, *next;
+	unsigned int max_nr_accesses = 0;
+	unsigned long sz_limit = 0;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 
 	kdamond_call_prmt(ctx, init_target_regions);
 	kdamond_callback(ctx, before_start);
 
+	sz_limit = damon_region_sz_limit(ctx);
+
 	while (!kdamond_need_stop(ctx)) {
 		kdamond_call_prmt(ctx, prepare_access_checks);
 		kdamond_callback(ctx, after_sampling);
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
-		kdamond_call_prmt(ctx, check_accesses);
+		if (ctx->primitive.check_accesses)
+			max_nr_accesses = ctx->primitive.check_accesses(ctx);
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
+			kdamond_merge_regions(ctx, max_nr_accesses / 10,
+					sz_limit);
 			kdamond_callback(ctx, after_aggregation);
 			kdamond_reset_aggregated(ctx);
+			kdamond_split_regions(ctx);
 		}
 	}
 	damon_for_each_target(t, ctx) {
-- 
2.17.1

