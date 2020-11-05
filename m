Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03E2A86DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgKETPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:15:24 -0500
Received: from shelob.surriel.com ([96.67.55.147]:60572 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:15:22 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kakj1-00048T-Di; Thu, 05 Nov 2020 14:15:11 -0500
From:   Rik van Riel <riel@surriel.com>
To:     hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, vbabka@suse.cz, mhocko@suse.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/2] mm,thp,shmem: limit shmem THP alloc gfp_mask
Date:   Thu,  5 Nov 2020 14:15:07 -0500
Message-Id: <20201105191508.1961686-2-riel@surriel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201105191508.1961686-1-riel@surriel.com>
References: <20201105191508.1961686-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation flags of anonymous transparent huge pages can be controlled
through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
help the system from getting bogged down in the page reclaim and compaction
code when many THPs are getting allocated simultaneously.

However, the gfp_mask for shmem THP allocations were not limited by those
configuration settings, and some workloads ended up with all CPUs stuck
on the LRU lock in the page reclaim code, trying to allocate dozens of
THPs simultaneously.

This patch applies the same configurated limitation of THPs to shmem
hugepage allocations, to prevent that from happening.

This way a THP defrag setting of "never" or "defer+madvise" will result
in quick allocation failures without direct reclaim when no 2MB free
pages are available.

With this patch applied, THP allocations for tmpfs will be a little
more aggressive than today for files mmapped with MADV_HUGEPAGE,
and a little less aggressive for files that are not mmapped or
mapped without that flag.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/gfp.h | 2 ++
 mm/huge_memory.c    | 6 +++---
 mm/shmem.c          | 8 +++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..c7615c9ba03c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
 extern void pm_restrict_gfp_mask(void);
 extern void pm_restore_gfp_mask(void);
 
+extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
+
 #ifdef CONFIG_PM_SLEEP
 extern bool pm_suspended_storage(void);
 #else
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9474dbc150ed..c5d03b2f2f2f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -649,9 +649,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
+gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
 {
-	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
+	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
@@ -744,7 +744,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			pte_free(vma->vm_mm, pgtable);
 		return ret;
 	}
-	gfp = alloc_hugepage_direct_gfpmask(vma);
+	gfp = vma_thp_gfp_mask(vma);
 	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
 	if (unlikely(!page)) {
 		count_vm_event(THP_FAULT_FALLBACK);
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..6c3cb192a88d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1545,8 +1545,8 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 		return NULL;
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
-	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
-			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
+	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
+			       true);
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);
@@ -1802,6 +1802,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	struct page *page;
 	enum sgp_type sgp_huge = sgp;
 	pgoff_t hindex = index;
+	gfp_t huge_gfp;
 	int error;
 	int once = 0;
 	int alloced = 0;
@@ -1887,7 +1888,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 alloc_huge:
-	page = shmem_alloc_and_acct_page(gfp, inode, index, true);
+	huge_gfp = vma_thp_gfp_mask(vma);
+	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
 	if (IS_ERR(page)) {
 alloc_nohuge:
 		page = shmem_alloc_and_acct_page(gfp, inode,
-- 
2.25.4

