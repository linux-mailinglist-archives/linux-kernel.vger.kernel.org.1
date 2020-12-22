Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687682DBDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgLPJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:46:46 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:44755 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgLPJqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608112005; x=1639648005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SUQT16FeXJgUgtw4aF8cUXAdkk10Wp5q3gpjNNGwgdo=;
  b=rlCsFYIuIci2ZW7X0PmZ8goqe2ifqYHkqLCUiYIgHZG4EvIlY87fotWM
   NDWNiHciA96qfC0kma41ECWMYezF12uAsVKrkrLAfNFshYIeB/K1MFyvJ
   vh3tpuMKFsf8Im755hnuTyBJLBvdV4gRzNkyHY1ny6fLiMvlpa91V+PnD
   I=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="96475241"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 16 Dec 2020 09:45:57 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id 50515C1D11;
        Wed, 16 Dec 2020 09:45:53 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.31) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 09:44:58 +0000
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
Subject: [RFC v10 07/13] mm/damon: Implement primitives for physical address space monitoring
Date:   Wed, 16 Dec 2020 10:42:15 +0100
Message-ID: <20201216094221.11898-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216094221.11898-1-sjpark@amazon.com>
References: <20201216094221.11898-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.31]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
 include/linux/damon.h |  10 ++
 mm/damon/Kconfig      |   9 ++
 mm/damon/Makefile     |   1 +
 mm/damon/paddr.c      | 222 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 mm/damon/paddr.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ed7e86207e53..ea2fd054b2ef 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -376,4 +376,14 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
 
+#ifdef CONFIG_DAMON_PADDR
+
+/* Monitoring primitives for the physical memory address space */
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
+bool damon_pa_target_valid(void *t);
+void damon_pa_set_primitives(struct damon_ctx *ctx);
+
+#endif	/* CONFIG_DAMON_PADDR */
+
 #endif	/* _DAMON_H */
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 455995152697..89c06ac8c9eb 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -33,6 +33,15 @@ config DAMON_VADDR
 	  This builds the default data access monitoring primitives for DAMON
 	  that works for virtual address spaces.
 
+config DAMON_PADDR
+	bool "Data access monitoring primitives for the physical address space"
+	depends on DAMON && MMU
+	select PAGE_EXTENSION if !64BIT
+	select PAGE_IDLE_FLAG
+	help
+	  This builds the default data access monitoring primitives for DAMON
+	  that works for physical address spaces.
+
 config DAMON_VADDR_KUNIT_TEST
 	bool "Test for DAMON primitives" if !KUNIT_ALL_TESTS
 	depends on DAMON_VADDR && KUNIT=y
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 99b1bfe01ff5..8d9b0df79702 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_DAMON)		:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= prmtv-common.o vaddr.o
+obj-$(CONFIG_DAMON_PADDR)	+= prmtv-common.o paddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
new file mode 100644
index 000000000000..b120f672cc57
--- /dev/null
+++ b/mm/damon/paddr.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON Primitives for The Physical Address Space
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon-pa: " fmt
+
+#include <linux/rmap.h>
+
+#include "prmtv-common.h"
+
+/*
+ * This has no implementations for 'init_target_regions()' and
+ * 'update_target_regions()'.  Users should set the initial regions and update
+ * regions by themselves in the 'before_start' and 'after_aggregation'
+ * callbacks, respectively.  Or, they can implement and use their own version
+ * of the primitives.
+ */
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
+bool damon_pa_target_valid(void *t)
+{
+	return true;
+}
+
+void damon_pa_set_primitives(struct damon_ctx *ctx)
+{
+	ctx->primitive.init_target_regions = NULL;
+	ctx->primitive.update_target_regions = NULL;
+	ctx->primitive.prepare_access_checks = damon_pa_prepare_access_checks;
+	ctx->primitive.check_accesses = damon_pa_check_accesses;
+	ctx->primitive.reset_aggregated = NULL;
+	ctx->primitive.target_valid = damon_pa_target_valid;
+	ctx->primitive.cleanup = NULL;
+	ctx->primitive.apply_scheme = NULL;
+}
-- 
2.17.1

