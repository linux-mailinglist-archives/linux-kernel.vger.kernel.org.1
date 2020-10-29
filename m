Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5529E8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgJ2KVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgJ2KVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:21:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7119C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gP+9EBW4WYH0Q3riFZe4cnGNQ0TiUX8xEI8GXjdhsE8=; b=IN3yvG5MkkamYsxYSs+DGTZWar
        IX0jdVBm0lpRC0YRDk65I0+npkp6+Nh84Q7kf1kkBQaUEZu0C94OxqrXIOSuyOW/pBt+AAkOV3ZcQ
        peCCyPdYAQQUYpl7iLU6Po4inERjQSK6Xnpuc1XMei8s5KeOne65lJ7AhsGpO8pTQ2TZuMo8rFF9o
        RM+7EuxbJ99Vi+3o28Lb1LpjaT9QEk5+HEDbNmSKB5bWfR4i78t7my6JQWH2iolDDbxSbKzeHY7x/
        v0n4upo4j9pDvneyPSzYok/AuRxTan3DszEsaMcZ5U00cTzCZ0Uo8Il2OdhO5Sk8w+MJ/rivrhSIq
        5T3rYwwg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY53I-0004Ji-RL; Thu, 29 Oct 2020 10:21:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mm: simplify follow_pte{,pmd}
Date:   Thu, 29 Oct 2020 11:14:32 +0100
Message-Id: <20201029101432.47011-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029101432.47011-1-hch@lst.de>
References: <20201029101432.47011-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge __follow_pte_pmd, follow_pte_pmd and follow_pte into a single
follow_pte function and just pass two additional NULL arguments for
the two previous follow_pte callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c           |  9 ++++-----
 include/linux/mm.h |  6 +++---
 mm/memory.c        | 35 +++++------------------------------
 3 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1bb5..26d5dcd2d69e5c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -810,12 +810,11 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 		address = pgoff_address(index, vma);
 
 		/*
-		 * Note because we provide range to follow_pte_pmd it will
-		 * call mmu_notifier_invalidate_range_start() on our behalf
-		 * before taking any lock.
+		 * Note because we provide range to follow_pte it will call
+		 * mmu_notifier_invalidate_range_start() on our behalf before
+		 * taking any lock.
 		 */
-		if (follow_pte_pmd(vma->vm_mm, address, &range,
-				   &ptep, &pmdp, &ptl))
+		if (follow_pte(vma->vm_mm, address, &range, &ptep, &pmdp, &ptl))
 			continue;
 
 		/*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aafcf..113b0b4fd90af5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1655,9 +1655,9 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
-int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
-		   struct mmu_notifier_range *range,
-		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
+int follow_pte(struct mm_struct *mm, unsigned long address,
+		struct mmu_notifier_range *range, pte_t **ptepp, pmd_t **pmdpp,
+		spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
 int follow_phys(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index 00458e7b49fef8..fa00682f7a4312 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4696,9 +4696,9 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
-			    struct mmu_notifier_range *range,
-			    pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
+int follow_pte(struct mm_struct *mm, unsigned long address,
+	       struct mmu_notifier_range *range, pte_t **ptepp, pmd_t **pmdpp,
+	       spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4763,31 +4763,6 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 	return -EINVAL;
 }
 
-static inline int follow_pte(struct mm_struct *mm, unsigned long address,
-			     pte_t **ptepp, spinlock_t **ptlp)
-{
-	int res;
-
-	/* (void) is needed to make gcc happy */
-	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte_pmd(mm, address, NULL,
-						    ptepp, NULL, ptlp)));
-	return res;
-}
-
-int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
-		   struct mmu_notifier_range *range,
-		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
-{
-	int res;
-
-	/* (void) is needed to make gcc happy */
-	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte_pmd(mm, address, range,
-						    ptepp, pmdpp, ptlp)));
-	return res;
-}
-
 /**
  * follow_pfn - look up PFN at a user virtual address
  * @vma: memory mapping
@@ -4808,7 +4783,7 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		return ret;
 
-	ret = follow_pte(vma->vm_mm, address, &ptep, &ptl);
+	ret = follow_pte(vma->vm_mm, address, NULL, &ptep, NULL, &ptl);
 	if (ret)
 		return ret;
 	*pfn = pte_pfn(*ptep);
@@ -4829,7 +4804,7 @@ int follow_phys(struct vm_area_struct *vma,
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		goto out;
 
-	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
+	if (follow_pte(vma->vm_mm, address, NULL, &ptep, NULL, &ptl))
 		goto out;
 	pte = *ptep;
 
-- 
2.28.0

