Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC11ECA46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 09:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFCHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 03:15:12 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54020 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFCHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591168509; x=1622704509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w/wvWrpld90pNUq9YxCX8KV2wshZFfoHjwL1rl4YxuM=;
  b=BeOC0Ko51zCjYhh+R5CyKsW/TCivEPt6PKLVYx4KmrEkdUUsXomZDEiv
   b5ZUVQ+0pE+w49e7ibR+yWDU1+9jeECgS6UsLFynajpAr88FX4jYB0Qxa
   K84uVF2TaKNLcEUJRToOy7Vl3PwBCy1Lu9lwvoCaeWwfjrzF/wr/eXQle
   k=;
IronPort-SDR: kInXsENdARxxwjlItmKKuj8Nc+0nf+H4kepBVOcWIymkojSsnUXVjXKGb8foYTTy0Nr5KCFjGU
 65I6FbxKGFEA==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="35493853"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jun 2020 07:14:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id EAE8BA18B2;
        Wed,  3 Jun 2020 07:14:43 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 07:14:43 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 07:14:26 +0000
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
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v10 3/8] mm/damon: Implement data access monitoring-based operation schemes
Date:   Wed, 3 Jun 2020 09:11:33 +0200
Message-ID: <20200603071138.8152-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603071138.8152-1-sjpark@amazon.com>
References: <20200603071138.8152-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

In many cases, users might use DAMON for simple data access aware
memory management optimizations such as applying an operation scheme to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

To minimize users from spending their time for implementation of such
simple data access monitoring-based operation schemes, this commit makes
DAMON to handle such schemes directly.  With this commit, users can
simply specify their desired schemes to DAMON.

Each of the schemes is composed with conditions for filtering of the
target memory regions and desired memory management action for the
target.  Specifically, the format is::

    <min/max size> <min/max access frequency> <min/max age> <action>

The filtering conditions are size of memory region, number of accesses
to the region monitored by DAMON, and the age of the region.  The age of
region is incremented periodically but reset when its addresses or
access frequency has significantly changed or the action of a scheme was
applied.  For the action, current implementation supports only a few of
madvise() hints, ``MADV_WILLNEED``, ``MADV_COLD``, ``MADV_PAGEOUT``,
``MADV_HUGEPAGE``, and ``MADV_NOHUGEPAGE``.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  50 ++++++++++++++
 mm/damon.c            | 149 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6a8ff2c63c2a..842a01e80c6e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -55,6 +55,52 @@ struct damon_task {
 	struct list_head list;
 };
 
+/**
+ * enum damos_action - Represents an action of a Data Access Monitoring-based
+ * Operation Scheme.
+ *
+ * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
+ * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
+ * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
+ * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
+ * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ * @DAMOS_ACTION_LEN:	Number of supported actions.
+ */
+enum damos_action {
+	DAMOS_WILLNEED,
+	DAMOS_COLD,
+	DAMOS_PAGEOUT,
+	DAMOS_HUGEPAGE,
+	DAMOS_NOHUGEPAGE,
+	DAMOS_ACTION_LEN,
+};
+
+/**
+ * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
+ * @min_sz_region:	Minimum size of target regions.
+ * @max_sz_region:	Maximum size of target regions.
+ * @min_nr_accesses:	Minimum ``->nr_accesses`` of target regions.
+ * @max_nr_accesses:	Maximum ``->nr_accesses`` of target regions.
+ * @min_age_region:	Minimum age of target regions.
+ * @max_age_region:	Maximum age of target regions.
+ * @action:		&damo_action to be applied to the target regions.
+ * @list:		List head for siblings.
+ *
+ * For each aggregation interval, DAMON applies @action to monitoring target
+ * regions fit in the condition and updates the statistics.  Note that both
+ * the minimums and the maximums are inclusive.
+ */
+struct damos {
+	unsigned int min_sz_region;
+	unsigned int max_sz_region;
+	unsigned int min_nr_accesses;
+	unsigned int max_nr_accesses;
+	unsigned int min_age_region;
+	unsigned int max_age_region;
+	enum damos_action action;
+	struct list_head list;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
@@ -98,6 +144,7 @@ struct damon_task {
  * @kdamond_lock.  Accesses to other fields must be protected by themselves.
  *
  * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
+ * @schemes_list:	Head of schemes (&damos) list.
  *
  * @sample_cb:			Called for each sampling interval.
  * @aggregate_cb:		Called for each aggregation interval.
@@ -128,6 +175,7 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+	struct list_head schemes_list;	/* 'damos' objects */
 
 	/* callbacks */
 	void (*sample_cb)(struct damon_ctx *context);
@@ -138,6 +186,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
+int damon_set_schemes(struct damon_ctx *ctx,
+			struct damos **schemes, ssize_t nr_schemes);
 int damon_set_recording(struct damon_ctx *ctx,
 				unsigned int rbuf_len, char *rfile_path);
 int damon_start(struct damon_ctx *ctx);
diff --git a/mm/damon.c b/mm/damon.c
index 6e9cc3330589..ffb755a14447 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -11,6 +11,7 @@
 
 #define CREATE_TRACE_POINTS
 
+#include <asm-generic/mman-common.h>
 #include <linux/damon.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -52,6 +53,12 @@
 #define damon_for_each_task_safe(t, next, ctx) \
 	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
 
+#define damon_for_each_scheme(s, ctx) \
+	list_for_each_entry(s, &(ctx)->schemes_list, list)
+
+#define damon_for_each_scheme_safe(s, next, ctx) \
+	list_for_each_entry_safe(s, next, &(ctx)->schemes_list, list)
+
 #define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
 #define MAX_RFILE_PATH_LEN	256
 
@@ -166,6 +173,27 @@ static void damon_destroy_task(struct damon_task *t)
 	damon_free_task(t);
 }
 
+static void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
+{
+	list_add_tail(&s->list, &ctx->schemes_list);
+}
+
+static void damon_del_scheme(struct damos *s)
+{
+	list_del(&s->list);
+}
+
+static void damon_free_scheme(struct damos *s)
+{
+	kfree(s);
+}
+
+static void damon_destroy_scheme(struct damos *s)
+{
+	damon_del_scheme(s);
+	damon_free_scheme(s);
+}
+
 static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
@@ -668,6 +696,101 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+#ifndef CONFIG_ADVISE_SYSCALLS
+static int damos_madvise(struct damon_task *task, struct damon_region *r,
+			int behavior)
+{
+	return -EINVAL;
+}
+#else
+static int damos_madvise(struct damon_task *task, struct damon_region *r,
+			int behavior)
+{
+	struct task_struct *t;
+	struct mm_struct *mm;
+	int ret = -ENOMEM;
+
+	t = damon_get_task_struct(task);
+	if (!t)
+		goto out;
+	mm = damon_get_mm(task);
+	if (!mm)
+		goto put_task_out;
+
+	ret = do_madvise(t, mm, PAGE_ALIGN(r->vm_start),
+			PAGE_ALIGN(r->vm_end - r->vm_start), behavior);
+	mmput(mm);
+put_task_out:
+	put_task_struct(t);
+out:
+	return ret;
+}
+#endif	/* CONFIG_ADVISE_SYSCALLS */
+
+static int damos_do_action(struct damon_task *task, struct damon_region *r,
+			enum damos_action action)
+{
+	int madv_action;
+
+	switch (action) {
+	case DAMOS_WILLNEED:
+		madv_action = MADV_WILLNEED;
+		break;
+	case DAMOS_COLD:
+		madv_action = MADV_COLD;
+		break;
+	case DAMOS_PAGEOUT:
+		madv_action = MADV_PAGEOUT;
+		break;
+	case DAMOS_HUGEPAGE:
+		madv_action = MADV_HUGEPAGE;
+		break;
+	case DAMOS_NOHUGEPAGE:
+		madv_action = MADV_NOHUGEPAGE;
+		break;
+	default:
+		pr_warn("Wrong action %d\n", action);
+		return -EINVAL;
+	}
+
+	return damos_madvise(task, r, madv_action);
+}
+
+static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
+				struct damon_region *r)
+{
+	struct damos *s;
+	unsigned long sz;
+
+	damon_for_each_scheme(s, c) {
+		sz = r->vm_end - r->vm_start;
+		if ((s->min_sz_region && sz < s->min_sz_region) ||
+				(s->max_sz_region && s->max_sz_region < sz))
+			continue;
+		if ((s->min_nr_accesses && r->nr_accesses < s->min_nr_accesses)
+				|| (s->max_nr_accesses &&
+					s->max_nr_accesses < r->nr_accesses))
+			continue;
+		if ((s->min_age_region && r->age < s->min_age_region) ||
+				(s->max_age_region &&
+				 s->max_age_region < r->age))
+			continue;
+		damos_do_action(t, r, s->action);
+		r->age = 0;
+	}
+}
+
+static void kdamond_apply_schemes(struct damon_ctx *c)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(t, c) {
+		damon_for_each_region(r, t)
+			damon_do_apply_schemes(c, t, r);
+	}
+}
+
 #define sz_damon_region(r) (r->vm_end - r->vm_start)
 
 /*
@@ -971,6 +1094,7 @@ static int kdamond_fn(void *data)
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
 			if (ctx->aggregate_cb)
 				ctx->aggregate_cb(ctx);
+			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
@@ -1051,6 +1175,30 @@ int damon_stop(struct damon_ctx *ctx)
 	return -EPERM;
 }
 
+/**
+ * damon_set_schemes() - Set data access monitoring based operation schemes.
+ * @ctx:	monitoring context
+ * @schemes:	array of the schemes
+ * @nr_schemes:	number of entries in @schemes
+ *
+ * This function should not be called while the kdamond of the context is
+ * running.
+ *
+ * Return: 0 if success, or negative error code otherwise.
+ */
+int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
+			ssize_t nr_schemes)
+{
+	struct damos *s, *next;
+	ssize_t i;
+
+	damon_for_each_scheme_safe(s, next, ctx)
+		damon_destroy_scheme(s);
+	for (i = 0; i < nr_schemes; i++)
+		damon_add_scheme(ctx, schemes[i]);
+	return 0;
+}
+
 /**
  * damon_set_pids() - Set monitoring target processes.
  * @ctx:	monitoring context
@@ -1491,6 +1639,7 @@ static int __init damon_init_user_ctx(void)
 	mutex_init(&ctx->kdamond_lock);
 
 	INIT_LIST_HEAD(&ctx->tasks_list);
+	INIT_LIST_HEAD(&ctx->schemes_list);
 
 	return 0;
 }
-- 
2.17.1

