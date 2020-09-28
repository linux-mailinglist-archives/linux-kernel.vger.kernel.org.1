Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C927B3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1SCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:30 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38975 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B2291E89;
        Mon, 28 Sep 2020 13:55:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=+Ag2KegvStddb
        FvKA1aftsfAEt1esGFTwgcceSEwVTE=; b=Q+wV/JzLi/GVQYAkHGoDt99oT6+cl
        GVYZQnorxiSP0T5OVC/u6BAy7DuyFrlyCxeWC80/C+6EvSuvCidfq+hoCz2DthP7
        W49p2Y9LC6W+VM/X5g3+WnIh91BlyZthXT7/ahA7yLYDNXyZfeldfAEz6NSl4pwo
        zMaPb3hssAJ9xMJ1gZz0Ycm6fPyAx5Vg02YzWsi5Z3ZkerGR0Ch73rXxa5hrFIjl
        l8S2b/QiNBjEJUlSVbdeq9adboFVDjx+ADO+0F4ascZsjli5QhxHy0xhYoW9j+OA
        394bwxfpf9Y64bzqpcc/VhyiSfVNq7W/3BXEzP7IMMSIEcUL7H7E6sHjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+Ag2KegvStddbFvKA1aftsfAEt1esGFTwgcceSEwVTE=; b=PYYNaM47
        1SA6hG7pzXIwayd5OpM+ea3rDYKYEOOVD+IQLxRhmJC90dkkLY4wZMHCM+QNTsA4
        yjGyLGnYFzj+H+RLt16wBb0KULdoJquhc8hfjW6CSMFvGc4/xtbtsw6DGS11giAW
        XCxd9n6ZbzIOX8GnXXISgPg/DzLHD1MDlxuTKsdiLvi1/yWRZ0wHFUqwLS/SrRlK
        ojFiqulMf5zAUZHBhr3kVpGw/bq/BQBXRa2cgAcKWion2e3HrjsP5oni2Mc3/duc
        pxX7T5nKzupgFP9J47GcB2o5LCwBDzaLZdArjmAbIwA5FnriGGs4K8aYV6eq5AMN
        KMBJ4lisrf+QeA==
X-ME-Sender: <xms:jSNyXw-DmCVNGehI0cjSKGyS_0Z9b2db9m3pT-JHn2BUnkQYFISAhQ>
    <xme:jSNyX4tjeSOxpZp6vTKjl9tPcFE3MNQR1tLVpT6WA4pgwbQhnzzN0-i-F38uGA4lG
    dEYSwVNQ1dU58rOxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jSNyX2Ccom83mJ24UBkDyKLINQWjsJvCNnXe4dqiKxwAp-tEdqq6_Q>
    <xmx:jSNyXwdBHk6NVlUkvxpE68FXwFkaEAb2OqQ1JzB73pLc7tIvesBHMQ>
    <xmx:jSNyX1O-BbJBfwAXkP0F2d-EeYou6dyy0TGmPXgapSVPjxpJ5cwcrQ>
    <xmx:jSNyX8nj1KGiocP18k9PEa_Mgb-wDKg0N9f2kk9CCJeP2lPHZjxbhz2YH1U>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD5B1306468B;
        Mon, 28 Sep 2020 13:55:24 -0400 (EDT)
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
Subject: [RFC PATCH v2 19/30] mm: stats: make smap stats understand PUD THPs.
Date:   Mon, 28 Sep 2020 13:54:17 -0400
Message-Id: <20200928175428.4110504-20-zi.yan@sent.com>
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

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 68 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a21484b1414d..077196182288 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -430,10 +430,9 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 }
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
-		bool compound, bool young, bool dirty, bool locked)
+		unsigned long size, bool young, bool dirty, bool locked)
 {
-	int i, nr = compound ? compound_nr(page) : 1;
-	unsigned long size = nr * PAGE_SIZE;
+	int i, nr = size / PAGE_SIZE;
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
@@ -530,7 +529,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte), locked);
+	smaps_account(mss, page, PAGE_SIZE, pte_young(*pte), pte_dirty(*pte), locked);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -561,8 +560,44 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		/* pass */;
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
+	smaps_account(mss, page, HPAGE_PMD_SIZE, pmd_young(*pmd),
+		      pmd_dirty(*pmd), locked);
 }
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static void smaps_pud_entry(pud_t *pud, unsigned long addr,
+		struct mm_walk *walk)
+{
+	struct mem_size_stats *mss = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
+	struct page *page = NULL;
+
+	if (pud_present(*pud)) {
+		/* FOLL_DUMP will return -EFAULT on huge zero page */
+		page = follow_trans_huge_pud(vma, addr, pud, FOLL_DUMP);
+	}
+	if (IS_ERR_OR_NULL(page))
+		return;
+	if (PageAnon(page))
+		mss->anonymous_thp += HPAGE_PUD_SIZE;
+	else if (PageSwapBacked(page))
+		mss->shmem_thp += HPAGE_PUD_SIZE;
+	else if (is_zone_device_page(page))
+		/* pass */;
+	else
+		mss->file_thp += HPAGE_PUD_SIZE;
+	smaps_account(mss, page, HPAGE_PUD_SIZE, pud_young(*pud),
+		      pud_dirty(*pud), locked);
+}
+#else
+static void smaps_pud_entry(pud_t *pud, unsigned long addr,
+		struct mm_walk *walk)
+{
+}
+#endif
+
+
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		struct mm_walk *walk)
@@ -570,6 +605,28 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 #endif
 
+static int smaps_pud_range(pud_t pud, pud_t *pudp, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	spinlock_t *ptl;
+
+	ptl = pud_trans_huge_lock(pudp, vma);
+	if (ptl) {
+		if (memcmp(pudp, &pud, sizeof(pud)) != 0) {
+			walk->action = ACTION_AGAIN;
+			spin_unlock(ptl);
+			return 0;
+		}
+		smaps_pud_entry(pudp, addr, walk);
+		spin_unlock(ptl);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	cond_resched();
+	return 0;
+}
+
 static int smaps_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
 {
@@ -712,6 +769,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 #endif /* HUGETLB_PAGE */
 
 static const struct mm_walk_ops smaps_walk_ops = {
+	.pud_entry		= smaps_pud_range,
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 };
-- 
2.28.0

