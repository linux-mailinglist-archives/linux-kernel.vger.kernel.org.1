Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03127B3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgI1SBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:51 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41425 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 649DFE18;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=QhvUEUtDR8jg5
        JOpmkKTRwuFRtglZQ/vY1xqC3rzo+Y=; b=ZgLtXxPqBSqSPdR91hgiV4VdcPIak
        W87Aw2siDPBTbHNiXO18yOYzE1RbU1uc8OYHYPxIjWxD5WChdgM25aFx8WiHwpS4
        qzjlvUS4RuUSly9HXsy4pslpdCnFbTrtER5iKZIY/AdfNA+ri6kR0pgg3DQIEjZg
        lMx0wJFwQ0tZF579l2ruxjSpPnS3RyUqKquReI5LAXTqsKwatxC1ZSDGJJaj2TJm
        Cht3OMROuJy1fgS8G5/qtIjztysadd8YHQ7upTmk/BkAZPBBgKCA3piyapqaOdGq
        HJByAdj0u8QyCB4d3gbReby/vDvMVd5wCfjlqwT7rOCjp9aZix914+qFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QhvUEUtDR8jg5JOpmkKTRwuFRtglZQ/vY1xqC3rzo+Y=; b=MSjto/Lp
        Ks6w7QJ9GuVIUQYhEw0TMaGr/QnEqDbAo3Ag3ZwXgo5UXMVAoH8aqEnFLSv+hHx6
        8c15DQqdjRr+zFgWszHu3hhd6BHbsSVar+1zxiOGo97DK8YnAryMCxhMGJ6KSGO2
        rKK9Xx1ISsw0oHBXiJzr4yoIcjeBPlPkEtJx7X+KSpeuJbp7DhLa9pIhxugi08gB
        SiTxoBC1pNAQNKHsnJt9qKiTwTlpld9Ha7EXWJg0p5hu5MC72dMuOyyFPGdlz+5a
        sVq0SQdIiuV8Q4+Vu0A5ZRqZiSnigkNI68Aj1wHpo9SeBPk+M7FG/f4F7llmZGps
        z/qJ7q+9neDCOg==
X-ME-Sender: <xms:hyNyX2M5lkzQHmlVimLKAZOIrluHIs_DUBzFboZKU6myUIMZ-i0HgQ>
    <xme:hyNyX099v5zZhwnM3MLsSINNSRnY8W4obq6MX0yfVizUqSFmhCvFkAADvpAxp72Xj
    t0ZH_Y8TZ4mPJbOLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:hyNyX9SsUcZjbG25SwEVe9NAm91JLQOl6tFPfCoQqK5WtXzVwcwQaQ>
    <xmx:hyNyX2t6YEIDMJvyokEz2Wy4qjXfwWrLlL4Ka5jlzCWQterWubrA9A>
    <xmx:hyNyX-cF-NHrkxMtmzCvC4jSP6m5knYn_my0pPHF1EKUjt3-gMPjHQ>
    <xmx:iCNyX51tAAbEdgY7yifPmZOQwDzsacJW8k_-wng7wBmO-krq6GGlsDmaAXY>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFBE63064683;
        Mon, 28 Sep 2020 13:55:18 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 03/30] mm: thp: use single linked list for THP page table page deposit.
Date:   Mon, 28 Sep 2020 13:54:01 -0400
Message-Id: <20200928175428.4110504-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

The old design uses the double linked list page->lru to chain all
deposited page table pages when creating a THP and page->pmd_huge_pte
to point to the first page of the list. As the second pointer in
page->lru overlaps with page->pmd_huge_pte, the design prevents
multi-level page table page deposit, which is useful for PUD and higher
level THPs.

The new design uses single linked list, where deposit_head points to
a single linked list of deposited pages and deposit_node can be used to
deposit the page itself to another list. For example, this allows us to
have one PUD page points to a list of PMD pages, each of which points
a list of PTE pages to support PUD level THP.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h       |  9 +++++----
 include/linux/mm_types.h |  8 +++++---
 kernel/fork.c            |  4 ++--
 mm/pgtable-generic.c     | 15 +++++----------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17e712207d74..01b62da34794 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -10,6 +10,7 @@
 #include <linux/gfp.h>
 #include <linux/bug.h>
 #include <linux/list.h>
+#include <linux/llist.h>
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
 #include <linux/atomic.h>
@@ -2249,7 +2250,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 static inline bool pmd_ptlock_init(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	init_llist_head(&page->deposit_head);
 #endif
 	return ptlock_init(page);
 }
@@ -2257,12 +2258,12 @@ static inline bool pmd_ptlock_init(struct page *page)
 static inline void pmd_ptlock_free(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+	VM_BUG_ON_PAGE(!llist_empty(&page->deposit_head), page);
 #endif
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_to_page(pmd)->pmd_huge_pte)
+#define huge_pmd_deposit_head(mm, pmd) (pmd_to_page(pmd)->deposit_head)
 
 #else
 
@@ -2274,7 +2275,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 static inline bool pmd_ptlock_init(struct page *page) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
-#define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
+#define huge_pmd_deposit_head(mm, pmd) ((mm)->deposit_head_pmd)
 
 #endif
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..be842926577a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -6,6 +6,7 @@
 
 #include <linux/auxvec.h>
 #include <linux/list.h>
+#include <linux/llist.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/rwsem.h>
@@ -143,8 +144,8 @@ struct page {
 			struct list_head deferred_list;
 		};
 		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
+			struct llist_head deposit_head; /* pgtable deposit list head */
+			struct llist_node deposit_node; /* pgtable deposit list node */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
@@ -511,7 +512,8 @@ struct mm_struct {
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
+		/* pgtable deposit list head, protected by page_table_lock */
+		struct llist_head deposit_head_pmd;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 		/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 138cd6ca50da..9c8e880538de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -661,7 +661,7 @@ static void check_mm(struct mm_struct *mm)
 				mm_pgtables_bytes(mm));
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
+	VM_BUG_ON_MM(!llist_empty(&mm->deposit_head_pmd), mm);
 #endif
 }
 
@@ -1022,7 +1022,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-	mm->pmd_huge_pte = NULL;
+	init_llist_head(&mm->deposit_head_pmd);
 #endif
 	mm_init_uprobes_state(mm);
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 9578db83e312..dbb0154165f1 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -164,11 +164,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
 	/* FIFO */
-	if (!pmd_huge_pte(mm, pmdp))
-		INIT_LIST_HEAD(&pgtable->lru);
-	else
-		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->lru);
-	pmd_huge_pte(mm, pmdp) = pgtable;
+	llist_add(&pgtable->deposit_node, &huge_pmd_deposit_head(mm, pmdp));
 }
 #endif
 
@@ -180,12 +176,11 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
+	/* only withdraw from a non empty list */
+	VM_BUG_ON(llist_empty(&huge_pmd_deposit_head(mm, pmdp)));
 	/* FIFO */
-	pgtable = pmd_huge_pte(mm, pmdp);
-	pmd_huge_pte(mm, pmdp) = list_first_entry_or_null(&pgtable->lru,
-							  struct page, lru);
-	if (pmd_huge_pte(mm, pmdp))
-		list_del(&pgtable->lru);
+	pgtable = llist_entry(llist_del_first(&huge_pmd_deposit_head(mm, pmdp)),
+			struct page, deposit_node);
 	return pgtable;
 }
 #endif
-- 
2.28.0

