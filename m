Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD752956F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895544AbgJVDs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:48:56 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33498 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443824AbgJVDs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:48:56 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kVRaq-0000iQ-SX; Wed, 21 Oct 2020 23:48:48 -0400
Date:   Wed, 21 Oct 2020 23:48:46 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201021234846.5cc97e62@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Signed-off-by: Rik van Riel <riel@surriel.com>
---

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..0a5b164a26d9 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
 extern void pm_restrict_gfp_mask(void);
 extern void pm_restore_gfp_mask(void);
 
+extern gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma);
+
 #ifdef CONFIG_PM_SLEEP
 extern bool pm_suspended_storage(void);
 #else
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9474dbc150ed..9b08ce5cc387 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -649,7 +649,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
+gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..d1290eb508e5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1545,8 +1545,11 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 		return NULL;
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
-	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
-			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
+	/* Limit the gfp mask according to THP configuration. */
+	gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
+	gfp &= alloc_hugepage_direct_gfpmask(&pvma);
+	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
+			       true);
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);

-- 
All rights reversed.
