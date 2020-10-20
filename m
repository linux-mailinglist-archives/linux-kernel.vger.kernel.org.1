Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF27228344C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJEK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:57:12 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:47470 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJEK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601895432; x=1633431432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W9kSAKoOLQv3AHQf0FEjIO8dSIA8gkB5QXnaMZyK5Tw=;
  b=Su30kn74dTjh8yEIYfXbmXKc7ZMUgoMoJrDJlRFXodzUh8ZNtjwxkV7W
   AYD5ayD8lKgaMhHPrgTJjGlYGiv12eRt1LTQgzI+JlCLn52pCHYFYJ1nM
   MjI4UYEPbkVtzijMSU6Saw1qjxEYuXznBCtVQdOOoXPhag2uSSG9817xO
   A=;
X-IronPort-AV: E=Sophos;i="5.77,338,1596499200"; 
   d="scan'208";a="73421496"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Oct 2020 10:57:08 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 59919A2455;
        Mon,  5 Oct 2020 10:57:05 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.146) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Oct 2020 10:56:48 +0000
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
Subject: [PATCH v21 04/18] mm/damon: Track dynamic monitoring target regions update
Date:   Mon, 5 Oct 2020 12:55:08 +0200
Message-ID: <20201005105522.23841-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005105522.23841-1-sjpark@amazon.com>
References: <20201005105522.23841-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.146]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The monitoring target address range can be dynamically changed.  For
example, virtual memory could be dynamically mapped and unmapped.
Physical memory could be hot-plugged.

As the changes could be quite frequent in some cases, DAMON checks the
dynamic memory mapping changes and applies it to the abstracted target
area only for each of a user-specified time interval, ``regions update
interval``.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h | 21 ++++++++++++++++-----
 mm/damon/core.c       | 22 ++++++++++++++++++++--
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0797bdfbfc24..53107182bbed 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -60,6 +60,7 @@ struct damon_ctx;
  * struct damon_primitive	Monitoring primitives for given use cases.
  *
  * @init_target_regions:	Constructs initial monitoring target regions.
+ * @update_target_regions:	Updates monitoring target regions.
  * @prepare_access_checks:	Prepares next access check of target regions.
  * @check_accesses:		Checks the access of target regions.
  * @target_valid:		Determine if the target is valid.
@@ -68,12 +69,17 @@ struct damon_ctx;
  * DAMON can be extended for various address spaces and usages.  For this,
  * users should register the low level primitives for their target address
  * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
- * calls @init_target_regions before starting the monitoring and
+ * calls @init_target_regions before starting the monitoring,
+ * @update_target_regions for each @regions_update_interval, and
  * @prepare_access_checks, @check_accesses, and @target_valid for each
  * @sample_interval.
+
  *
  * @init_target_regions should construct proper monitoring target regions and
  * link those to the DAMON context struct.
+ * @update_target_regions should update the monitoring target regions for
+ * current status.
+
  * @prepare_access_checks should manipulate the monitoring regions to be
  * prepare for the next access check.
  * @check_accesses should check the accesses to each region that made after the
@@ -87,6 +93,7 @@ struct damon_ctx;
  */
 struct damon_primitive {
 	void (*init_target_regions)(struct damon_ctx *context);
+	void (*update_target_regions)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	bool (*target_valid)(struct damon_target *target);
@@ -132,13 +139,15 @@ struct damon_callback {
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
+ * @regions_update_interval:	The time between monitor regions updates.
  * @min_nr_regions:		The minimum number of monitoring regions.
  * @max_nr_regions:		The maximum number of monitoring regions.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for @aggr_interval time.  All time intervals are in
- * micro-seconds.
+ * each region) for @aggr_interval time.  DAMON also checks whether the target
+ * memory regions need update (e.g., by ``mmap()`` calls from the application,
+ * @regions_update_interval.  All time intervals are in micro-seconds.
  *
  * @kdamond:		Kernel thread who does the monitoring.
  * @kdamond_stop:	Notifies whether kdamond should stop.
@@ -167,10 +176,12 @@ struct damon_callback {
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
+	unsigned long regions_update_interval;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 
 	struct timespec64 last_aggregation;
+	struct timespec64 last_regions_update;
 
 	struct task_struct *kdamond;
 	bool kdamond_stop;
@@ -216,8 +227,8 @@ unsigned int damon_nr_regions(struct damon_target *t);
 
 int damon_set_targets(struct damon_ctx *ctx,
 		unsigned long *ids, ssize_t nr_ids);
-int damon_set_attrs(struct damon_ctx *ctx,
-		unsigned long sample_int, unsigned long aggr_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
 
 int damon_nr_running_ctxs(void);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ed364b42721d..36428327e848 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -167,6 +167,7 @@ int damon_set_targets(struct damon_ctx *ctx,
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
  * @sample_int:		time interval between samplings
+ * @regions_update_int:	time interval between target regions update
  * @aggr_int:		time interval between aggregations
  * @min_nr_reg:		minimal number of regions
  * @max_nr_reg:		maximum number of regions
@@ -176,8 +177,8 @@ int damon_set_targets(struct damon_ctx *ctx,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_set_attrs(struct damon_ctx *ctx,
-		    unsigned long sample_int, unsigned long aggr_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		    unsigned long aggr_int, unsigned long regions_update_int,
 		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3) {
@@ -193,6 +194,7 @@ int damon_set_attrs(struct damon_ctx *ctx,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 
@@ -529,6 +531,17 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 	last_nr_regions = nr_regions;
 }
 
+/*
+ * Check whether it is time to check and apply the target monitoring regions
+ *
+ * Returns true if it is.
+ */
+static bool kdamond_need_update_regions(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_regions_update,
+			ctx->regions_update_interval);
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -612,6 +625,11 @@ static int kdamond_fn(void *data)
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
+
+		if (kdamond_need_update_regions(ctx)) {
+			kdamond_call_prmt(ctx, update_target_regions);
+			sz_limit = damon_region_sz_limit(ctx);
+		}
 	}
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
-- 
2.17.1

