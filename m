Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB231BDC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgD2Mrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 08:47:47 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:47403 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2Mrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588164466; x=1619700466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=442HC5FPOiO29U9cNw6XmZSbfWza2aGlO9luTz7Ex+s=;
  b=vYTbpuMPAHWIQAtz/Th1Vw9dFdsoDqIunZ9SXOs4abnpjc12KJPi6677
   d7GDcR+fmt8aK2sF3x+aXRjxBOZHn9RRJTkfmKLwf7dQ1PqEkrcBTu/jX
   7LBAVt+hTSkBHil+rZ+lWLCSYrFEY560hf6XyrgyB7WnhxArnxj4LfQVE
   k=;
IronPort-SDR: hy95kK9rGamWLY3R7kQ2zgdwH+E3XhTucPsNKhE1x6X5mOtaUhDCoE85YJECEyOUB+lzGyOJB7
 hipxgdwnV0uA==
X-IronPort-AV: E=Sophos;i="5.73,332,1583193600"; 
   d="scan'208";a="31873101"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Apr 2020 12:47:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 5F460A1C19;
        Wed, 29 Apr 2020 12:47:37 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Apr 2020 12:47:36 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.200) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Apr 2020 12:47:20 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v7 3/7] mm/damon: Implement data access monitoring-based operation schemes
Date:   Wed, 29 Apr 2020 14:45:36 +0200
Message-ID: <20200429124540.32232-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429124540.32232-1-sjpark@amazon.com>
References: <20200429124540.32232-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D06UWC004.ant.amazon.com (10.43.162.97) To
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
 include/linux/damon.h |  24 +++++++
 mm/damon.c            | 149 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7276b2a31c38..0f26d8aad33c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -36,6 +36,27 @@ struct damon_task {
 	struct list_head list;
 };
 
+/* Data Access Monitoring-based Operation Scheme */
+enum damos_action {
+	DAMOS_WILLNEED,
+	DAMOS_COLD,
+	DAMOS_PAGEOUT,
+	DAMOS_HUGEPAGE,
+	DAMOS_NOHUGEPAGE,
+	DAMOS_ACTION_LEN,
+};
+
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
 /*
  * For each 'sample_interval', DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
@@ -65,6 +86,7 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+	struct list_head schemes_list;	/* 'damos' objects */
 
 	/* callbacks */
 	void (*sample_cb)(struct damon_ctx *context);
@@ -75,6 +97,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
+int damon_set_schemes(struct damon_ctx *ctx,
+			struct damos **schemes, ssize_t nr_schemes);
 int damon_set_recording(struct damon_ctx *ctx,
 				unsigned int rbuf_len, char *rfile_path);
 int damon_start(struct damon_ctx *ctx);
diff --git a/mm/damon.c b/mm/damon.c
index 704462ff30d9..56a4fb4d1e4a 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -11,6 +11,7 @@
 
 #define CREATE_TRACE_POINTS
 
+#include <asm-generic/mman-common.h>
 #include <linux/damon.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -52,6 +53,12 @@
 #define damon_for_each_task_safe(ctx, t, next) \
 	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
 
+#define damon_for_each_scheme(ctx, r) \
+	list_for_each_entry(r, &(ctx)->schemes_list, list)
+
+#define damon_for_each_scheme_safe(ctx, s, next) \
+	list_for_each_entry_safe(s, next, &(ctx)->schemes_list, list)
+
 #define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
 #define MAX_RFILE_PATH_LEN	256
 
@@ -167,6 +174,27 @@ static void damon_destroy_task(struct damon_task *t)
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
@@ -702,6 +730,101 @@ static void kdamond_count_age(struct damon_ctx *c, unsigned int threshold)
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
+	damon_for_each_scheme(c, s) {
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
+	damon_for_each_task(c, t) {
+		damon_for_each_region(r, t)
+			damon_do_apply_schemes(c, t, r);
+	}
+}
+
 #define sz_damon_region(r) (r->vm_end - r->vm_start)
 
 /*
@@ -1040,6 +1163,7 @@ static int kdamond_fn(void *data)
 			kdamond_count_age(ctx, max_nr_accesses / 10);
 			if (ctx->aggregate_cb)
 				ctx->aggregate_cb(ctx);
+			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
@@ -1120,6 +1244,30 @@ int damon_stop(struct damon_ctx *ctx)
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
+	damon_for_each_scheme_safe(ctx, s, next)
+		damon_destroy_scheme(s);
+	for (i = 0; i < nr_schemes; i++)
+		damon_add_scheme(ctx, schemes[i]);
+	return 0;
+}
+
 /**
  * damon_set_pids() - Set monitoring target processes.
  * @ctx:	monitoring context
@@ -1554,6 +1702,7 @@ static int __init damon_init_user_ctx(void)
 	mutex_init(&ctx->kdamond_lock);
 
 	INIT_LIST_HEAD(&ctx->tasks_list);
+	INIT_LIST_HEAD(&ctx->schemes_list);
 
 	return 0;
 }
-- 
2.17.1

