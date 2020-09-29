Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206D727B84F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgI1Xgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:36:36 -0400
Received: from z5.mailgun.us ([104.130.96.5]:46867 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgI1Xgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:36:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601336194; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=nxDPBbgplCnSOWnlqMgvvD6fp10YHS89qZYCye0em5o=; b=UMde0nqhGkdRFHF6zBbL7ObGpFaO4CHummoxDvkGACr8wIvHGQ59dx/BSMA/14t5HLDnnbWc
 HpqAtYQ8dInZFwBVLIeiX3GT07PQFOSDIWTNqZSfa0oXV9Ab/McC/jes8rOfnWtTa/VgCc5u
 1Xhx6xyntUQLwnouD9v1Fikk5E4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f727382809bd33014727e24 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 23:36:34
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28399C433C8; Mon, 28 Sep 2020 23:36:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D4D5C433F1;
        Mon, 28 Sep 2020 23:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D4D5C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org, minchan@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org, pdaly@codeaurora.org,
        sudaraja@codeaurora.org, iamjoonsoo.kim@lge.com, david@redhat.com,
        vinmenon@codeaurora.org, minchan.kim@gmail.com
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v5] mm: cma: indefinitely retry allocations in cma_alloc
Date:   Mon, 28 Sep 2020 16:36:22 -0700
Message-Id: <8bb42e0f91cd8bf8d1c468273d94c3da2786fb9c.1601336054.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1601336054.git.cgoldswo@codeaurora.org>
References: <cover.1601336054.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1601336054.git.cgoldswo@codeaurora.org>
References: <cover.1601336054.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMA allocations will fail if 'pinned' pages are in a CMA area, since we
cannot migrate pinned pages. The _refcount of a struct page being greater
than _mapcount for that page can cause pinning for anonymous pages.  This
is because try_to_unmap(), which (1) is called in the CMA allocation path,
and (2) decrements both _refcount and _mapcount for a page, will stop
unmapping a page from VMAs once the _mapcount for a page reaches 0.  This
implies that after try_to_unmap() has finished successfully for a page
where _recount > _mapcount, that _refcount will be greater than 0.  Later
in the CMA allocation path in migrate_page_move_mapping(), we will have one
more reference count than intended for anonymous pages, meaning the
allocation will fail for that page.

If a process ends up causing _refcount > _mapcount for a page (by either
incrementing _recount or decrementing _mapcount), such that the process is
context switched out after modifying one refcount but before modifying the
other, the page will be temporarily pinned.

One example of where _refcount can be greater than _mapcount is inside of
zap_pte_range(), which is called for all the entries of a PMD when a
process is exiting, to unmap the process's memory.  Inside of
zap_pte_range(), after unammping a page with page_remove_rmap(), we have
that _recount > _mapcount.  _refcount can only be decremented after a TLB
flush is performed for the page - this doesn't occur until enough pages
have been batched together for flushing.  The flush can either occur inside
of zap_pte_range() (during the same invocation or a later one), or if there
aren't enough pages collected by the time we unmap all of the pages in a
process, the flush will occur in tlb_finish_mmu() in exit_mmap().  After
the flush has occurred, tlb_batch_pages_flush() will decrement the
references on the flushed pages.

Another such example like the above is inside of copy_one_pte(), which is
called during a fork. For PTEs for which pte_present(pte) == true,
copy_one_pte() will increment the _refcount field followed by the
_mapcount field of a page.

So, inside of cma_alloc(), add the option of letting users pass in
__GFP_NOFAIL to indicate that we should retry CMA allocations indefinitely,
in the event that alloc_contig_range() returns -EBUSY after having scanned
a whole CMA-region bitmap.

Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Co-developed-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
---
 arch/powerpc/kvm/book3s_hv_builtin.c       |  2 +-
 drivers/dma-buf/heaps/cma_heap.c           |  2 +-
 drivers/s390/char/vmcp.c                   |  2 +-
 drivers/staging/android/ion/ion_cma_heap.c |  2 +-
 include/linux/cma.h                        |  2 +-
 kernel/dma/contiguous.c                    |  4 +--
 mm/cma.c                                   | 39 +++++++++++++++++++++++++-----
 mm/cma_debug.c                             |  2 +-
 mm/hugetlb.c                               |  4 +--
 9 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 073617c..21c3f6a 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -74,7 +74,7 @@ struct page *kvm_alloc_hpt_cma(unsigned long nr_pages)
 	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
 
 	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES),
-			 false);
+			 0);
 }
 EXPORT_SYMBOL_GPL(kvm_alloc_hpt_cma);
 
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 626cf7f..7657359 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -66,7 +66,7 @@ static int cma_heap_allocate(struct dma_heap *heap,
 	helper_buffer->heap = heap;
 	helper_buffer->size = len;
 
-	cma_pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
+	cma_pages = cma_alloc(cma_heap->cma, nr_pages, align, 0);
 	if (!cma_pages)
 		goto free_buf;
 
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 9e06628..11c4e3b 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -70,7 +70,7 @@ static void vmcp_response_alloc(struct vmcp_session *session)
 	 * anymore the system won't work anyway.
 	 */
 	if (order > 2)
-		page = cma_alloc(vmcp_cma, nr_pages, 0, false);
+		page = cma_alloc(vmcp_cma, nr_pages, 0, 0);
 	if (page) {
 		session->response = (char *)page_to_phys(page);
 		session->cma_alloc = 1;
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
index bf65e67..128d3a5 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -39,7 +39,7 @@ static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
+	pages = cma_alloc(cma_heap->cma, nr_pages, align, 0);
 	if (!pages)
 		return -ENOMEM;
 
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 6ff79fe..2bd8544 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -43,7 +43,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					const char *name,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
-			      bool no_warn);
+			      gfp_t gfp_mask);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index cff7e60..55c62b2 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -196,7 +196,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn ? __GFP_NOWARN : 0);
 }
 
 /**
@@ -219,7 +219,7 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
 {
 	unsigned int align = min(get_order(size), CONFIG_CMA_ALIGNMENT);
 
-	return cma_alloc(cma, size >> PAGE_SHIFT, align, gfp & __GFP_NOWARN);
+	return cma_alloc(cma, size >> PAGE_SHIFT, align, gfp);
 }
 
 /**
diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7..ea6464b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -32,6 +32,8 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <trace/events/cma.h>
 
 #include "cma.h"
@@ -403,13 +405,15 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
  * @cma:   Contiguous memory region for which the allocation is performed.
  * @count: Requested number of pages.
  * @align: Requested alignment of pages (in PAGE_SIZE order).
- * @no_warn: Avoid printing message about failed allocation
+ * @gfp_mask: If __GFP_NOWARN is passed, suppress messages about failed
+ *	      allocations. If __GFP_NOFAIL is passed, try doing the CMA
+ *	      allocation indefinitely until the allocation succeeds.
  *
  * This function allocates part of contiguous memory on specific
  * contiguous memory area.
  */
 struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
-		       bool no_warn)
+		       gfp_t gfp_mask)
 {
 	unsigned long mask, offset;
 	unsigned long pfn = -1;
@@ -442,8 +446,31 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
 		if (bitmap_no >= bitmap_maxno) {
-			mutex_unlock(&cma->lock);
-			break;
+			if (ret == -EBUSY && gfp_mask & __GFP_NOFAIL) {
+				mutex_unlock(&cma->lock);
+
+				if (fatal_signal_pending(current))
+					break;
+
+				/*
+				 * Page may be momentarily pinned by some other
+				 * process which has been scheduled out, e.g.
+				 * in exit path, during unmap call, or process
+				 * fork and so cannot be freed there. Sleep
+				 * for 100 ms and retry the allocation.
+				 */
+				start = 0;
+				ret = -ENOMEM;
+				schedule_timeout_killable(msecs_to_jiffies(100));
+				continue;
+			} else {
+				/*
+				 * ret == -ENOMEM - all bits in cma->bitmap are
+				 * set, so we break accordingly.
+				 */
+				mutex_unlock(&cma->lock);
+				break;
+			}
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
 		/*
@@ -456,7 +483,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
-				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
+				     GFP_KERNEL | (gfp_mask & __GFP_NOWARN));
 		mutex_unlock(&cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
@@ -485,7 +512,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 			page_kasan_tag_reset(page + i);
 	}
 
-	if (ret && !no_warn) {
+	if (ret && !(gfp_mask & __GFP_NOWARN)) {
 		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
 			__func__, count, ret);
 		cma_debug_show_areas(cma);
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index d5bf8aa..76aea84 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -137,7 +137,7 @@ static int cma_alloc_mem(struct cma *cma, int count)
 	if (!mem)
 		return -ENOMEM;
 
-	p = cma_alloc(cma, count, 0, false);
+	p = cma_alloc(cma, count, 0, 0);
 	if (!p) {
 		kfree(mem);
 		return -ENOMEM;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67fc6383..97bdba9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1260,7 +1260,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 
 		if (hugetlb_cma[nid]) {
 			page = cma_alloc(hugetlb_cma[nid], nr_pages,
-					huge_page_order(h), true);
+					huge_page_order(h), __GFP_NOWARN);
 			if (page)
 				return page;
 		}
@@ -1271,7 +1271,7 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 					continue;
 
 				page = cma_alloc(hugetlb_cma[node], nr_pages,
-						huge_page_order(h), true);
+						huge_page_order(h), __GFP_NOWARN);
 				if (page)
 					return page;
 			}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

