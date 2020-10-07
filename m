Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD396285938
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgJGHQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:16:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:29514 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJGHQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602055008; x=1633591008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mIRY6jCt/Ds1TCdCRs9402VAL7E+NUH/LhRYNea7uTg=;
  b=j1SJJaek0A3bIniCFyu3jSwIoDuQ3vx95Q2xhTo+T/B63VWPsQEcmDyu
   e9ltvv1R5qJ+0IwFq0B1KXUdkHIRtph/a/HFd1MhZGrb97poq5AUB7Ixe
   4GgB4Bvs5fSrNADScSICpflpwALtcmDhosPzMTn8cNiAelkUBJPGvT9E/
   w=;
X-IronPort-AV: E=Sophos;i="5.77,345,1596499200"; 
   d="scan'208";a="58285950"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Oct 2020 07:16:46 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id F33342421A8;
        Wed,  7 Oct 2020 07:16:33 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Oct 2020 07:16:17 +0000
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
Subject: [RFC v9 06/10] damon/primitives: Implement callbacks for physical address space monitoring
Date:   Wed, 7 Oct 2020 09:14:05 +0200
Message-ID: <20201007071409.12174-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007071409.12174-1-sjpark@amazon.com>
References: <20201007071409.12174-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D31UWA003.ant.amazon.com (10.43.160.130) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements the primitives for the basic access monitoring of
the physical memory address space.  By using this, users can easily
monitor the accesses to the physical memory.

Internally, it uses the PTE Accessed bit, as similar to that of the
virtual memory support.  Also, it supports only user memory pages, as
idle page tracking also does, for the same reason.  If the monitoring
target physical memory address range contains non-user memory pages,
access check of the pages will do nothing but simply treat the pages as
not accessed.

Users who want to use other access check primitives and/or monitor the
non-user memory regions could implement and use their own callbacks.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   9 +-
 mm/damon/primitives.c | 236 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index decd1374eaa5..afc22b4ea752 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -335,7 +335,14 @@ int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
-#endif	/* CONFIG_DAMON_PRIMITIVES */
+/* Reference callback implementations for physical memory */
+void damon_pa_init_regions(struct damon_ctx *ctx);
+void damon_pa_update_regions(struct damon_ctx *ctx);
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
+bool damon_pa_target_valid(struct damon_target *t);
+void damon_pa_set_primitives(struct damon_ctx *ctx);
 
+#endif	/* CONFIG_DAMON_PRIMITIVES */
 
 #endif
diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
index 01c1ef3f7ff9..462997f9f140 100644
--- a/mm/damon/primitives.c
+++ b/mm/damon/primitives.c
@@ -12,7 +12,9 @@
 #include <linux/mm.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
+#include <linux/pagemap.h>
 #include <linux/random.h>
+#include <linux/rmap.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 
@@ -656,4 +658,238 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.apply_scheme = damon_va_apply_scheme;
 }
 
+/*
+ * Primitives for the physical address space
+ */
+
+/*
+ * The initial regions construction function for the physical address space.
+ *
+ * This default version does nothing in actual.  Users should set the initial
+ * regions by themselves before passing their damon_ctx to 'damon_start()', or
+ * implement their version of this and set '->init_target_regions' of their
+ * damon_ctx to point it.
+ */
+void damon_pa_init_regions(struct damon_ctx *ctx)
+{
+}
+
+/*
+ * The dynamic monitoring target regions update function for the physical
+ * address space.
+ *
+ * This default version does nothing in actual.  Users should update the
+ * regions in other callbacks such as '->after_aggregation', or implement their
+ * version of this and set the '->init_target_regions' of their damon_ctx to
+ * point it.
+ */
+void damon_pa_update_regions(struct damon_ctx *ctx)
+{
+}
+
+/* access check functions for physical address based regions */
+
+/*
+ * Get a page by pfn if it is in the LRU list.  Otherwise, returns NULL.
+ *
+ * The body of this function is stollen from the 'page_idle_get_page()'.  We
+ * steal rather than reuse it because the code is quite simple.
+ */
+static struct page *damon_pa_get_page(unsigned long pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+	pg_data_t *pgdat;
+
+	if (!page || !PageLRU(page) ||
+	    !get_page_unless_zero(page))
+		return NULL;
+
+	pgdat = page_pgdat(page);
+	spin_lock_irq(&pgdat->lru_lock);
+	if (unlikely(!PageLRU(page))) {
+		put_page(page);
+		page = NULL;
+	}
+	spin_unlock_irq(&pgdat->lru_lock);
+	return page;
+}
+
+static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	damon_va_mkold(vma->vm_mm, addr);
+	return true;
+}
+
+static void damon_pa_mkold(unsigned long paddr)
+{
+	struct page *page = damon_pa_get_page(PHYS_PFN(paddr));
+	struct rmap_walk_control rwc = {
+		.rmap_one = __damon_pa_mkold,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return;
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		set_page_idle(page);
+		put_page(page);
+		return;
+	}
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page)) {
+		put_page(page);
+		return;
+	}
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+	put_page(page);
+}
+
+static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
+					    struct damon_region *r)
+{
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+
+	damon_pa_mkold(r->sampling_addr);
+}
+
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			__damon_pa_prepare_access_check(ctx, r);
+	}
+}
+
+struct damon_pa_access_chk_result {
+	unsigned long page_sz;
+	bool accessed;
+};
+
+static bool damon_pa_accessed(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	struct damon_pa_access_chk_result *result = arg;
+
+	result->accessed = damon_va_young(vma->vm_mm, addr, &result->page_sz);
+
+	/* If accessed, stop walking */
+	return !result->accessed;
+}
+
+static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
+{
+	struct page *page = damon_pa_get_page(PHYS_PFN(paddr));
+	struct damon_pa_access_chk_result result = {
+		.page_sz = PAGE_SIZE,
+		.accessed = false,
+	};
+	struct rmap_walk_control rwc = {
+		.arg = &result,
+		.rmap_one = damon_pa_accessed,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return false;
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		if (page_is_idle(page))
+			result.accessed = false;
+		else
+			result.accessed = true;
+		put_page(page);
+		goto out;
+	}
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page)) {
+		put_page(page);
+		return NULL;
+	}
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+	put_page(page);
+
+out:
+	*page_sz = result.page_sz;
+	return result.accessed;
+}
+
+/*
+ * Check whether the region was accessed after the last preparation
+ *
+ * mm	'mm_struct' for the given virtual address space
+ * r	the region of physical address space that needs to be checked
+ */
+static void __damon_pa_check_access(struct damon_ctx *ctx,
+				    struct damon_region *r)
+{
+	static unsigned long last_addr;
+	static unsigned long last_page_sz = PAGE_SIZE;
+	static bool last_accessed;
+
+	/* If the region is in the last checked page, reuse the result */
+	if (ALIGN_DOWN(last_addr, last_page_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
+		if (last_accessed)
+			r->nr_accesses++;
+		return;
+	}
+
+	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
+	if (last_accessed)
+		r->nr_accesses++;
+
+	last_addr = r->sampling_addr;
+}
+
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			__damon_pa_check_access(ctx, r);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
+bool damon_pa_target_valid(struct damon_target *t)
+{
+	if (!mutex_is_locked(&page_idle_lock))
+		return false;
+	return true;
+}
+
+void damon_pa_set_primitives(struct damon_ctx *ctx)
+{
+	ctx->primitive.init_target_regions = damon_pa_init_regions;
+	ctx->primitive.update_target_regions = damon_pa_update_regions;
+	ctx->primitive.prepare_access_checks = damon_pa_prepare_access_checks;
+	ctx->primitive.check_accesses = damon_pa_check_accesses;
+	ctx->primitive.target_valid = damon_pa_target_valid;
+	ctx->primitive.cleanup = NULL;
+	ctx->primitive.apply_scheme = NULL;
+}
+
 #include "primitives-test.h"
-- 
2.17.1

