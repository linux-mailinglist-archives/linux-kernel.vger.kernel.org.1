Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF22DBDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgLPJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:45:54 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59058 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLPJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608111952; x=1639647952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Lj6+I9XWmZiqjVkd1Bor2fLoWLXqVAIP/n4Y2agFqYw=;
  b=atRK9mOnWORakP4Go+AYUzvczOZW1Pb5cTR//Wb858Tcet/YyKuMHTfQ
   D2Y1V9hvoYXaZ2k97fGQAoarzXfMSkfWvYw7z+cMSsAQaQkKXNlrC+0Bq
   oB45eCOOtl8/8ULiGUrN8wKL+V5/9NRGo33U0apJUOJIhRKMQ1O65g0a6
   8=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="69443702"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 16 Dec 2020 09:45:07 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id DF141A1EBF;
        Wed, 16 Dec 2020 09:44:55 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.31) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 09:44:36 +0000
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
Subject: [RFC v10 06/13] mm/damon/vaddr: Separate commonly usable functions
Date:   Wed, 16 Dec 2020 10:42:14 +0100
Message-ID: <20201216094221.11898-7-sjpark@amazon.com>
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

This commit moves functions in the default virtual address spaces
monitoring primitives that commonly usable from other address spaces
like physical address space into a header file.  Those will be reused by
the physical address space monitoring primitives in the following
commit.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/Makefile       |   2 +-
 mm/damon/prmtv-common.c | 104 ++++++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h |  21 ++++++++
 mm/damon/vaddr.c        | 108 +---------------------------------------
 4 files changed, 128 insertions(+), 107 deletions(-)
 create mode 100644 mm/damon/prmtv-common.c
 create mode 100644 mm/damon/prmtv-common.h

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index fed4be3bace3..99b1bfe01ff5 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DAMON)		:= core.o
-obj-$(CONFIG_DAMON_VADDR)	+= vaddr.o
+obj-$(CONFIG_DAMON_VADDR)	+= prmtv-common.o vaddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
new file mode 100644
index 000000000000..6cdb96cbc9ef
--- /dev/null
+++ b/mm/damon/prmtv-common.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Primitives for Data Access Monitoring
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#include "prmtv-common.h"
+
+static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+			     unsigned long addr)
+{
+	bool referenced = false;
+	struct page *page = pte_page(*pte);
+
+	if (pte_young(*pte)) {
+		referenced = true;
+		*pte = pte_mkold(*pte);
+	}
+
+#ifdef CONFIG_MMU_NOTIFIER
+	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
+		referenced = true;
+#endif /* CONFIG_MMU_NOTIFIER */
+
+	if (referenced)
+		set_page_young(page);
+
+	set_page_idle(page);
+}
+
+static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
+			     unsigned long addr)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	bool referenced = false;
+	struct page *page = pmd_page(*pmd);
+
+	if (pmd_young(*pmd)) {
+		referenced = true;
+		*pmd = pmd_mkold(*pmd);
+	}
+
+#ifdef CONFIG_MMU_NOTIFIER
+	if (mmu_notifier_clear_young(mm, addr,
+				addr + ((1UL) << HPAGE_PMD_SHIFT)))
+		referenced = true;
+#endif /* CONFIG_MMU_NOTIFIER */
+
+	if (referenced)
+		set_page_young(page);
+
+	set_page_idle(page);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+}
+
+void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+{
+	pte_t *pte = NULL;
+	pmd_t *pmd = NULL;
+	spinlock_t *ptl;
+
+	if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
+		return;
+
+	if (pte) {
+		damon_ptep_mkold(pte, mm, addr);
+		pte_unmap_unlock(pte, ptl);
+	} else {
+		damon_pmdp_mkold(pmd, mm, addr);
+		spin_unlock(ptl);
+	}
+}
+
+bool damon_va_young(struct mm_struct *mm, unsigned long addr,
+			unsigned long *page_sz)
+{
+	pte_t *pte = NULL;
+	pmd_t *pmd = NULL;
+	spinlock_t *ptl;
+	bool young = false;
+
+	if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
+		return false;
+
+	*page_sz = PAGE_SIZE;
+	if (pte) {
+		young = pte_young(*pte);
+		if (!young)
+			young = !page_is_idle(pte_page(*pte));
+		pte_unmap_unlock(pte, ptl);
+		return young;
+	}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	young = pmd_young(*pmd);
+	if (!young)
+		young = !page_is_idle(pmd_page(*pmd));
+	spin_unlock(ptl);
+	*page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+
+	return young;
+}
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
new file mode 100644
index 000000000000..a66a6139b4fc
--- /dev/null
+++ b/mm/damon/prmtv-common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common Primitives for Data Access Monitoring
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#include <linux/damon.h>
+#include <linux/mm.h>
+#include <linux/mmu_notifier.h>
+#include <linux/page_idle.h>
+#include <linux/random.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+
+void damon_va_mkold(struct mm_struct *mm, unsigned long addr);
+bool damon_va_young(struct mm_struct *mm, unsigned long addr,
+			unsigned long *page_sz);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2075f07f728b..915b12329c6e 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -8,22 +8,14 @@
 #define pr_fmt(fmt) "damon-va: " fmt
 
 #include <asm-generic/mman-common.h>
-#include <linux/damon.h>
-#include <linux/mm.h>
-#include <linux/mmu_notifier.h>
-#include <linux/page_idle.h>
-#include <linux/random.h>
-#include <linux/sched/mm.h>
-#include <linux/slab.h>
+
+#include "prmtv-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
 #undef DAMON_MIN_REGION
 #define DAMON_MIN_REGION 1
 #endif
 
-/* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))
-
 /*
  * 't->id' should be the pointer to the relevant 'struct pid' having reference
  * count.  Caller must put the returned task, unless it is NULL.
@@ -370,71 +362,6 @@ void damon_va_update_regions(struct damon_ctx *ctx)
 	}
 }
 
-static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
-			     unsigned long addr)
-{
-	bool referenced = false;
-	struct page *page = pte_page(*pte);
-
-	if (pte_young(*pte)) {
-		referenced = true;
-		*pte = pte_mkold(*pte);
-	}
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
-		set_page_young(page);
-
-	set_page_idle(page);
-}
-
-static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
-			     unsigned long addr)
-{
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool referenced = false;
-	struct page *page = pmd_page(*pmd);
-
-	if (pmd_young(*pmd)) {
-		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
-				addr + ((1UL) << HPAGE_PMD_SHIFT)))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
-		set_page_young(page);
-
-	set_page_idle(page);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-}
-
-static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
-{
-	pte_t *pte = NULL;
-	pmd_t *pmd = NULL;
-	spinlock_t *ptl;
-
-	if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
-		return;
-
-	if (pte) {
-		damon_ptep_mkold(pte, mm, addr);
-		pte_unmap_unlock(pte, ptl);
-	} else {
-		damon_pmdp_mkold(pmd, mm, addr);
-		spin_unlock(ptl);
-	}
-}
-
 /*
  * Functions for the access checking of the regions
  */
@@ -463,37 +390,6 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-			unsigned long *page_sz)
-{
-	pte_t *pte = NULL;
-	pmd_t *pmd = NULL;
-	spinlock_t *ptl;
-	bool young = false;
-
-	if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
-		return false;
-
-	*page_sz = PAGE_SIZE;
-	if (pte) {
-		young = pte_young(*pte);
-		if (!young)
-			young = !page_is_idle(pte_page(*pte));
-		pte_unmap_unlock(pte, ptl);
-		return young;
-	}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	young = pmd_young(*pmd);
-	if (!young)
-		young = !page_is_idle(pmd_page(*pmd));
-	spin_unlock(ptl);
-	*page_sz = ((1UL) << HPAGE_PMD_SHIFT);
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
-
-	return young;
-}
-
 /*
  * Check whether the region was accessed after the last preparation
  *
-- 
2.17.1

