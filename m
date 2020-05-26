Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58BE1A0AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgDGKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 06:02:00 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60642 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgDGKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586253719; x=1617789719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rVhxnWJVglQxQxZQLKjyRxBGZxhOkGnjfilc/VW0QuM=;
  b=ObzsuT1lQgAFkIAhsKfdTu/YwQj8as2OSCFkPgxXdI38nSSVVtK+qc3b
   UFbFK9RLEeJkzzeqFYSNpVCvkDQqfTzZ3IyR8P7nC/hBz9JXE/OUMWKZa
   MP/K6rS0TV2phub/VOQgvpBDJdZDtPlfJC36I0+QAKqxKk6sCYh90G72w
   Q=;
IronPort-SDR: 8e+Xhw0Nt+E1Z4jjN9FYkvbs5Ywgx6IHbEWoWbM1oCIzFG7MCyjavNgae0WeL2+2JiSJrFOYVj
 THy8rHQX4bEQ==
X-IronPort-AV: E=Sophos;i="5.72,353,1580774400"; 
   d="scan'208";a="37096690"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 07 Apr 2020 10:01:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id A5462A1856;
        Tue,  7 Apr 2020 10:01:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 10:01:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.171) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 10:01:40 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v6 2/7] mm/damon: Account age of target regions
Date:   Tue, 7 Apr 2020 12:00:01 +0200
Message-ID: <20200407100007.3894-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407100007.3894-1-sjpark@amazon.com>
References: <20200407100007.3894-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D34UWA002.ant.amazon.com (10.43.160.245) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON can be used as a primitive for data access pattern awared memory
maangement optimizations.  However, users who want such optimizations
should run DAMON, read the monitoring results, analyze it, plan a new
memory management scheme, and apply the new scheme by themselves.  It
would not be too hard, but still require some level of efforts.  For
complicated optimizations, this effort is inevitable.

That said, in many cases, users would simply want to apply an actions to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

For such optimizations, users will need to first account the age of each
region themselves.  To reduce such efforts, this commit implements a
simple age account of each region in DAMON.  For each aggregation step,
DAMON compares the access frequency and start/end address of each region
with those from last aggregation and reset the age of the region if the
change is significant.  Else, the age is incremented.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   5 ++
 mm/damon.c            | 105 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 47fb0ec03030..49205c71c63d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -22,6 +22,11 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
+
+	unsigned int age;
+	unsigned long last_vm_start;
+	unsigned long last_vm_end;
+	unsigned int last_nr_accesses;
 };
 
 /* Represents a monitoring target task */
diff --git a/mm/damon.c b/mm/damon.c
index a40d044af45f..7e56011b9b5f 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -78,6 +78,10 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
+	region->age = 0;
+	region->last_vm_start = vm_start;
+	region->last_vm_end = vm_end;
+
 	return region;
 }
 
@@ -659,11 +663,44 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 					sizeof(r->nr_accesses));
 			trace_damon_aggregated(t->pid, nr,
 					r->vm_start, r->vm_end, r->nr_accesses);
+			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
 	}
 }
 
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Increase or reset the age of the given monitoring target region
+ *
+ * If the area or '->nr_accesses' has changed significantly, reset the '->age'.
+ * Else, increase the age.
+ */
+static void damon_do_count_age(struct damon_region *r, unsigned int threshold)
+{
+	unsigned long sz_threshold = (r->vm_end - r->vm_start) / 5;
+
+	if (diff_of(r->vm_start, r->last_vm_start) +
+			diff_of(r->vm_end, r->last_vm_end) > sz_threshold)
+		r->age = 0;
+	else if (diff_of(r->nr_accesses, r->last_nr_accesses) > threshold)
+		r->age = 0;
+	else
+		r->age++;
+}
+
+static void kdamond_count_age(struct damon_ctx *c, unsigned int threshold)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(c, t) {
+		damon_for_each_region(r, t)
+			damon_do_count_age(r, threshold);
+	}
+}
+
 #define sz_damon_region(r) (r->vm_end - r->vm_start)
 
 /*
@@ -672,33 +709,86 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 static void damon_merge_two_regions(struct damon_region *l,
 				struct damon_region *r)
 {
-	l->nr_accesses = (l->nr_accesses * sz_damon_region(l) +
-			r->nr_accesses * sz_damon_region(r)) /
-			(sz_damon_region(l) + sz_damon_region(r));
+	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
+
+	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
+			(sz_l + sz_r);
+	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->vm_end = r->vm_end;
 	damon_destroy_region(r);
 }
 
-#define diff_of(a, b) (a > b ? a - b : b - a)
+static inline void set_last_area(struct damon_region *r, struct region *last)
+{
+	r->last_vm_start = last->start;
+	r->last_vm_end = last->end;
+}
+
+static inline void get_last_area(struct damon_region *r, struct region *last)
+{
+	last->start = r->last_vm_start;
+	last->end = r->last_vm_end;
+}
 
 /*
  * Merge adjacent regions having similar access frequencies
  *
  * t		task that merge operation will make change
  * thres	merge regions having '->nr_accesses' diff smaller than this
+ *
+ * After each merge, the biggest mergee region becomes the last shape of the
+ * new region.  If two regions are split from one region at the end of previous
+ * aggregation interval are merged into one region, we handle the two regions
+ * as one big mergee, because it can lead to unproper last shape record if we
+ * don't do so.
+ *
+ * To understand why we take special care for regions split from one region,
+ * suppose that a region of size 10 has split into two regions of size 4 and 6.
+ * Two regions show similar access frequency for next aggregation interval and
+ * thus now be merged into one region again.  Because the split is made
+ * regardless of the access pattern, DAMON should say the region of size 10 had
+ * no area change for last aggregation interval.  However, if the two mergees
+ * are handled seperatively, DAMON will say the merged region has changed its
+ * size from 6 to 10.
  */
 static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 {
 	struct damon_region *r, *prev = NULL, *next;
+	struct region biggest_mergee;	/* the biggest region being merged */
+	unsigned long sz_biggest = 0;	/* size of the biggest_mergee */
+	unsigned long sz_mergee = 0;	/* size of current mergee */
 
 	damon_for_each_region_safe(r, next, t) {
 		if (!prev || prev->vm_end != r->vm_start ||
 		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
+			if (sz_biggest)
+				set_last_area(prev, &biggest_mergee);
+
 			prev = r;
+			sz_biggest = sz_damon_region(prev);
+			get_last_area(prev, &biggest_mergee);
 			continue;
 		}
+
+
+		/* Set size of current mergee and biggest mergee */
+		sz_mergee += sz_damon_region(r);
+		if (sz_mergee > sz_biggest) {
+			sz_biggest = sz_mergee;
+			get_last_area(r, &biggest_mergee);
+		}
+
+		/*
+		 * If next region and current region is not originated from
+		 * same region, initialize the size of mergee.
+		 */
+		if (r->last_vm_start != next->last_vm_start)
+			sz_mergee = 0;
+
 		damon_merge_two_regions(prev, r);
 	}
+	if (sz_biggest)
+		set_last_area(prev, &biggest_mergee);
 }
 
 /*
@@ -731,6 +821,12 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	struct damon_region *new;
 
 	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	new->age = r->age;
+	new->last_vm_start = r->vm_start;
+	new->last_nr_accesses = r->last_nr_accesses;
+
+	r->last_vm_start = r->vm_start;
+	r->last_vm_end = r->vm_end;
 	r->vm_end = new->vm_start;
 
 	damon_insert_region(new, r, damon_next_region(r));
@@ -912,6 +1008,7 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			kdamond_count_age(ctx, max_nr_accesses / 10);
 			if (ctx->aggregate_cb)
 				ctx->aggregate_cb(ctx);
 			kdamond_reset_aggregated(ctx);
-- 
2.17.1

