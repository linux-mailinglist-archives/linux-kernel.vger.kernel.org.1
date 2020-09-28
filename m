Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C658527ABE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1Kg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:36:58 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13559 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1Kg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601289416; x=1632825416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=c/MK2pCSgOMGVOP2p7S4cmlEP6k8s8TkAwQl4lTQDDY=;
  b=tbJlE3CcVuNa1n7weeepTnRud12OB7gTNHEsVLdebpXLFwvH4VnPr9Ah
   SEZ3PKs7+s6LkNSRVUvIclyV/bnXtwV8G2ZIJ1V5IK5jf5GUT0mbeMGQF
   9rjAV603HQj9ScqTvrydns+NxB1eXORDQCXGS0ox+5l2LluXteVU/sMnj
   U=;
X-IronPort-AV: E=Sophos;i="5.77,313,1596499200"; 
   d="scan'208";a="56638137"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Sep 2020 10:36:56 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id AE83DA1DB6;
        Mon, 28 Sep 2020 10:36:43 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 10:36:25 +0000
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
Subject: [RFC PATCH 2/5] mm/damon: Separate DAMON schemes application to primitives
Date:   Mon, 28 Sep 2020 12:35:25 +0200
Message-ID: <20200928103528.4256-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928103528.4256-1-sjpark@amazon.com>
References: <20200928103528.4256-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D10UWA003.ant.amazon.com (10.43.160.248) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON-based operation schemes feature is implemented inside DAMON
'core'.  Though the access pattern based schemes target region tracking
part makes sense to reside in the 'core', applying the scheme action
would better to be reside in the 'primitives', as the work highly
depends on the type of the target region.

For the reason, this commit moves the part to 'primitives' by adding one
more context callback, 'apply_scheme' and implementing it in the
reference primitives implementation for the virtual address spaces.
Note that this doesn't add the implementation for the physical address
space, as it didn't exist before.  Nonetheless, the extension for
physical space would be easily done in this way in future.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  8 +++++
 mm/damon/core.c       | 65 ++------------------------------------
 mm/damon/damon.h      | 28 -----------------
 mm/damon/primitives.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 82 insertions(+), 92 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 264958a62c02..505e6261cefa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -170,6 +170,7 @@ struct damos {
  * @check_accesses:		Checks the access of target regions.
  * @target_valid:		Determine if the target is valid.
  * @cleanup:			Cleans up the context.
+ * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @sample_cb:			Called for each sampling interval.
  * @aggregate_cb:		Called for each aggregation interval.
  *
@@ -193,6 +194,9 @@ struct damos {
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.  After this
  * call, only @kdamond_lock and @kdamond will be touched.
+ * @apply_scheme is called from @kdamond when a region for user provided
+ * DAMON-based operation scheme is found.  It should apply the scheme's action
+ * to the region.
  *
  * @sample_cb and @aggregate_cb are called from @kdamond for each of the
  * sampling intervals and aggregation intervals, respectively.  Therefore,
@@ -229,6 +233,8 @@ struct damon_ctx {
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	bool (*target_valid)(struct damon_target *target);
 	void (*cleanup)(struct damon_ctx *context);
+	int (*apply_scheme)(struct damon_ctx *context, struct damon_target *t,
+			struct damon_region *r, struct damos *scheme);
 	void (*sample_cb)(struct damon_ctx *context);
 	void (*aggregate_cb)(struct damon_ctx *context);
 };
@@ -312,6 +318,8 @@ void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
 unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
 bool kdamond_vm_target_valid(struct damon_target *t);
 void kdamond_vm_cleanup(struct damon_ctx *ctx);
+int kdamond_vm_apply_scheme(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_set_vaddr_primitives(struct damon_ctx *ctx);
 
 /* Reference callback implementations for physical memory */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d85ade7b5e23..ba52421a2673 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -701,68 +701,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
-#ifndef CONFIG_ADVISE_SYSCALLS
-static int damos_madvise(struct damon_target *target, struct damon_region *r,
-			int behavior)
-{
-	return -EINVAL;
-}
-#else
-static int damos_madvise(struct damon_target *target, struct damon_region *r,
-			int behavior)
-{
-	struct task_struct *t;
-	struct mm_struct *mm;
-	int ret = -ENOMEM;
-
-	t = damon_get_task_struct(target);
-	if (!t)
-		goto out;
-	mm = damon_get_mm(target);
-	if (!mm)
-		goto put_task_out;
-
-	ret = do_madvise(t, mm, PAGE_ALIGN(r->ar.start),
-			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
-	mmput(mm);
-put_task_out:
-	put_task_struct(t);
-out:
-	return ret;
-}
-#endif	/* CONFIG_ADVISE_SYSCALLS */
-
-static int damos_do_action(struct damon_target *target, struct damon_region *r,
-			enum damos_action action)
-{
-	int madv_action;
-
-	switch (action) {
-	case DAMOS_WILLNEED:
-		madv_action = MADV_WILLNEED;
-		break;
-	case DAMOS_COLD:
-		madv_action = MADV_COLD;
-		break;
-	case DAMOS_PAGEOUT:
-		madv_action = MADV_PAGEOUT;
-		break;
-	case DAMOS_HUGEPAGE:
-		madv_action = MADV_HUGEPAGE;
-		break;
-	case DAMOS_NOHUGEPAGE:
-		madv_action = MADV_NOHUGEPAGE;
-		break;
-	case DAMOS_STAT:
-		return 0;
-	default:
-		pr_warn("Wrong action %d\n", action);
-		return -EINVAL;
-	}
-
-	return damos_madvise(target, r, madv_action);
-}
-
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -781,7 +719,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 		s->stat_count++;
 		s->stat_sz += sz;
-		damos_do_action(t, r, s->action);
+		if (c->apply_scheme)
+			c->apply_scheme(c, t, r, s);
 		if (s->action != DAMOS_STAT)
 			r->age = 0;
 	}
diff --git a/mm/damon/damon.h b/mm/damon/damon.h
index fc565fff4953..4315dadcca8a 100644
--- a/mm/damon/damon.h
+++ b/mm/damon/damon.h
@@ -5,31 +5,3 @@
 
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32() % (r - l))
-
-/*
- * 't->id' should be the pointer to the relevant 'struct pid' having reference
- * count.  Caller must put the returned task, unless it is NULL.
- */
-#define damon_get_task_struct(t) \
-	(get_pid_task((struct pid *)t->id, PIDTYPE_PID))
-
-/*
- * Get the mm_struct of the given target
- *
- * Caller _must_ put the mm_struct after use, unless it is NULL.
- *
- * Returns the mm_struct of the target on success, NULL on failure
- */
-static inline struct mm_struct *damon_get_mm(struct damon_target *t)
-{
-	struct task_struct *task;
-	struct mm_struct *mm;
-
-	task = damon_get_task_struct(t);
-	if (!task)
-		return NULL;
-
-	mm = get_task_mm(task);
-	put_task_struct(task);
-	return mm;
-}
diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
index d7796cbffbd8..e762dc8a5f2e 100644
--- a/mm/damon/primitives.c
+++ b/mm/damon/primitives.c
@@ -38,8 +38,11 @@
 #endif
 
 /*
- * Functions for the initial monitoring target regions construction
+ * 't->id' should be the pointer to the relevant 'struct pid' having reference
+ * count.  Caller must put the returned task, unless it is NULL.
  */
+#define damon_get_task_struct(t) \
+	(get_pid_task((struct pid *)t->id, PIDTYPE_PID))
 
 /*
  * Get the mm_struct of the given target
@@ -62,6 +65,10 @@ struct mm_struct *damon_get_mm(struct damon_target *t)
 	return mm;
 }
 
+/*
+ * Functions for the initial monitoring target regions construction
+ */
+
 /*
  * Size-evenly split a region into 'nr_pieces' small regions
  *
@@ -788,6 +795,68 @@ void kdamond_vm_cleanup(struct damon_ctx *ctx)
 	}
 }
 
+#ifndef CONFIG_ADVISE_SYSCALLS
+static int damos_madvise(struct damon_target *target, struct damon_region *r,
+			int behavior)
+{
+	return -EINVAL;
+}
+#else
+static int damos_madvise(struct damon_target *target, struct damon_region *r,
+			int behavior)
+{
+	struct task_struct *t;
+	struct mm_struct *mm;
+	int ret = -ENOMEM;
+
+	t = damon_get_task_struct(target);
+	if (!t)
+		goto out;
+	mm = damon_get_mm(target);
+	if (!mm)
+		goto put_task_out;
+
+	ret = do_madvise(t, mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
+	mmput(mm);
+put_task_out:
+	put_task_struct(t);
+out:
+	return ret;
+}
+#endif	/* CONFIG_ADVISE_SYSCALLS */
+
+int kdamond_vm_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+	int madv_action;
+
+	switch (scheme->action) {
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
+	case DAMOS_STAT:
+		return 0;
+	default:
+		pr_warn("Wrong action %d\n", scheme->action);
+		return -EINVAL;
+	}
+
+	return damos_madvise(t, r, madv_action);
+}
+
 void damon_set_vaddr_primitives(struct damon_ctx *ctx)
 {
 	ctx->init_target_regions = kdamond_init_vm_regions;
@@ -796,6 +865,7 @@ void damon_set_vaddr_primitives(struct damon_ctx *ctx)
 	ctx->check_accesses = kdamond_check_vm_accesses;
 	ctx->target_valid = kdamond_vm_target_valid;
 	ctx->cleanup = kdamond_vm_cleanup;
+	ctx->apply_scheme = kdamond_vm_apply_scheme;
 }
 
 void damon_set_paddr_primitives(struct damon_ctx *ctx)
@@ -806,6 +876,7 @@ void damon_set_paddr_primitives(struct damon_ctx *ctx)
 	ctx->check_accesses = kdamond_check_phys_accesses;
 	ctx->target_valid = NULL;
 	ctx->cleanup = NULL;
+	ctx->apply_scheme = NULL;
 }
 
 #include "primitives-test.h"
-- 
2.17.1

