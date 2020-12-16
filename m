Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5A2DBDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLPJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:48:27 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:20180 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgLPJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608112106; x=1639648106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OfAxiI1TGWAm938TQnf2Mv9tv9ZVjwG7ArzBDalULAM=;
  b=MnHFZ8OUvK3NEZpXj/k1Xd4IEFpCwdUZeL2jH7tgX0jo4bOxoz7WWwDW
   KA7Sv2fBcdXbR5CELDPwiGw3Ei3J0dhtI6djFIZ3fbKM+kH0Y7EpmVy9Y
   9xPuqQOoB3CSG32wwSO6H+jgNMv8FQmc3eaeg+UngL8cXHm2taue9ESU8
   4=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="71565777"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-41350382.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Dec 2020 09:47:43 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-41350382.us-west-2.amazon.com (Postfix) with ESMTPS id A18FAC28E8;
        Wed, 16 Dec 2020 09:47:39 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.31) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 09:47:21 +0000
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
Subject: [RFC v10 12/13] mm/damon/paddr: Separate commonly usable functions
Date:   Wed, 16 Dec 2020 10:42:20 +0100
Message-ID: <20201216094221.11898-13-sjpark@amazon.com>
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

This commit moves functions in the default physical address space
monitoring primitives that commonly usable from other use cases like
page granularity idleness monitoring to prmtv-common.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/paddr.c        | 122 ----------------------------------------
 mm/damon/prmtv-common.c | 122 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h |   4 ++
 3 files changed, 126 insertions(+), 122 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b120f672cc57..143ddc0e5917 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -19,69 +19,6 @@
  * of the primitives.
  */
 
-/*
- * Get a page by pfn if it is in the LRU list.  Otherwise, returns NULL.
- *
- * The body of this function is stollen from the 'page_idle_get_page()'.  We
- * steal rather than reuse it because the code is quite simple.
- */
-static struct page *damon_pa_get_page(unsigned long pfn)
-{
-	struct page *page = pfn_to_online_page(pfn);
-	pg_data_t *pgdat;
-
-	if (!page || !PageLRU(page) ||
-	    !get_page_unless_zero(page))
-		return NULL;
-
-	pgdat = page_pgdat(page);
-	spin_lock_irq(&pgdat->lru_lock);
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
-	}
-	spin_unlock_irq(&pgdat->lru_lock);
-	return page;
-}
-
-static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
-{
-	damon_va_mkold(vma->vm_mm, addr);
-	return true;
-}
-
-static void damon_pa_mkold(unsigned long paddr)
-{
-	struct page *page = damon_pa_get_page(PHYS_PFN(paddr));
-	struct rmap_walk_control rwc = {
-		.rmap_one = __damon_pa_mkold,
-		.anon_lock = page_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!page)
-		return;
-
-	if (!page_mapped(page) || !page_rmapping(page)) {
-		set_page_idle(page);
-		put_page(page);
-		return;
-	}
-
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page)) {
-		put_page(page);
-		return;
-	}
-
-	rmap_walk(page, &rwc);
-
-	if (need_lock)
-		unlock_page(page);
-	put_page(page);
-}
-
 static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
 					    struct damon_region *r)
 {
@@ -101,65 +38,6 @@ void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-struct damon_pa_access_chk_result {
-	unsigned long page_sz;
-	bool accessed;
-};
-
-static bool damon_pa_accessed(struct page *page, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
-{
-	struct damon_pa_access_chk_result *result = arg;
-
-	result->accessed = damon_va_young(vma->vm_mm, addr, &result->page_sz);
-
-	/* If accessed, stop walking */
-	return !result->accessed;
-}
-
-static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
-{
-	struct page *page = damon_pa_get_page(PHYS_PFN(paddr));
-	struct damon_pa_access_chk_result result = {
-		.page_sz = PAGE_SIZE,
-		.accessed = false,
-	};
-	struct rmap_walk_control rwc = {
-		.arg = &result,
-		.rmap_one = damon_pa_accessed,
-		.anon_lock = page_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!page)
-		return false;
-
-	if (!page_mapped(page) || !page_rmapping(page)) {
-		if (page_is_idle(page))
-			result.accessed = false;
-		else
-			result.accessed = true;
-		put_page(page);
-		goto out;
-	}
-
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page)) {
-		put_page(page);
-		return NULL;
-	}
-
-	rmap_walk(page, &rwc);
-
-	if (need_lock)
-		unlock_page(page);
-	put_page(page);
-
-out:
-	*page_sz = result.page_sz;
-	return result.accessed;
-}
-
 /*
  * Check whether the region was accessed after the last preparation
  *
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 6cdb96cbc9ef..6c2e760e086c 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -102,3 +102,125 @@ bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 
 	return young;
 }
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
+void damon_pa_mkold(unsigned long paddr)
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
+bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
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
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index a66a6139b4fc..fbe9452bd040 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -10,6 +10,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/random.h>
+#include <linux/rmap.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 
@@ -19,3 +20,6 @@
 void damon_va_mkold(struct mm_struct *mm, unsigned long addr);
 bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 			unsigned long *page_sz);
+
+void damon_pa_mkold(unsigned long paddr);
+bool damon_pa_young(unsigned long paddr, unsigned long *page_sz);
-- 
2.17.1

