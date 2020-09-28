Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9D27B3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgI1SBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:33 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:47367 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgI1SBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4FE36DC1;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=w/1WxE4McpQMz
        BhtMir9tigfs64TiTil/gzau/IBjZc=; b=LOFJw9rUKw1rJet+DC4SH5AJH+qbW
        NPxNI1wfb7w13IUaiuXwQBBNeXpmPJExLyLJ90loi0iXCGTd9DlZPnxXYG7T2jfT
        jl+yX4JYUmeRNLuZHuAoj9VAHvq+hq3B/Ivwg7le5rR88C3fy1qfax3OHdT5GJeL
        LnYlJIluJKrBEb2paKpobPidKDTKP7w5gPNuOUhR3i8EbYxSP3Mc3LasZ1Cxo/IX
        4si1kPwAcIAMedYt9YlqCCGQEEVn5LBk1V/qQMSggZzaOfRYB5XJxuAtop6TkX6P
        EcQxco72ICuayjwoEMZjKxwmnSaGs2uInUeKuK+sUcBZuQXqV0Ki86/AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=w/1WxE4McpQMzBhtMir9tigfs64TiTil/gzau/IBjZc=; b=sVIAkHpV
        9/w8lGuEIODa8ppVtq20qjoutZMmeONKiKrmd1rxGiE7OMd4N+jwtoKByAkzPP4Y
        MvNE8aewHoM1JEuxVmvpPdIfP7lY9uCdlKYFTxonZg/0xKcQfeDaL9j2XxclnfB+
        Gg65LHF1WJyHhEL/tz0e+6iQ17pyjB4OQPTsOvYTGhzaA72mnI2ws1V8f+2kX/Z2
        WvtNXuZZy6jeKoCI7XZ0Fly32FQpVi+DW+Txjgq1HBvgzBb8MZ1gkwyMrR83xVwn
        dozvk8A4HhuSVMaqy9GQpbj1BVoQpCT/RMxhPNXzv7K/oxvNMaUb9noSmhAqdKmB
        R4dNlcAUH1NvhA==
X-ME-Sender: <xms:iCNyXxofiQQsy8-4Ioq-ltNyQQahtUKy6_gwnVWn3fo0BUJhN3s1jg>
    <xme:iCNyXzq2QaCFiZNDuHChvD6E_aXNEEmb8SHoljUpnduoXaOtGYIqdCYBTJsTwr_p5
    kcZh03ucPWp3qYUbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iCNyX-MKi4Z310bNv1rK3LgXXNfnt2oyYnbWygJZa4ak49UAnj9etg>
    <xmx:iCNyX84AI1197tIpN3tDNakF29E6RZZfacwQE3zfwX9mEsUHBV6X3w>
    <xmx:iCNyXw4wzLj7O_BKET3GHfWuPnBTJz6AsPoBibe82CrvTboi0MY6rA>
    <xmx:iCNyX_RGOFigtFjoO73JANGRQ7wU58VPmtjTqx1gdFiqyIGFJOoby557HUo>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 665A8306468E;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
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
Subject: [RFC PATCH v2 07/30] mm: thp: add anonymous PUD THP page fault support without enabling it.
Date:   Mon, 28 Sep 2020 13:54:05 -0400
Message-Id: <20200928175428.4110504-8-zi.yan@sent.com>
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

This adds PUD THP support for anonymous pages. Applications will be
able to get PUD pages during page faults when their VMAs are larger than
PUD page size after the page fault path is enabled.

No shared zero PUD THP is created and shared by all read-only zero PUD
THPs, different zero read-only PMD THPs. We do not want to reserve so
much physical memory for this use, assuming the case will be rare.

New PUD THP related events are added too.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgtable.h |   2 +
 drivers/base/node.c            |   3 +
 fs/proc/meminfo.c              |   2 +
 include/linux/huge_mm.h        |   6 ++
 include/linux/mmzone.h         |   1 +
 include/linux/vm_event_item.h  |   3 +
 mm/huge_memory.c               | 105 +++++++++++++++++++++++++++++++++
 mm/page_alloc.c                |   3 +-
 mm/rmap.c                      |  24 ++++++--
 mm/vmstat.c                    |   4 ++
 10 files changed, 147 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..199de6be2f6d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1141,6 +1141,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long
 	return native_pmdp_get_and_clear(pmdp);
 }
 
+#define mk_pud(page, pgprot)   pfn_pud(page_to_pfn(page), (pgprot))
+
 #define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
 static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 					unsigned long addr, pud_t *pudp)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9426b0f1f660..fe809c914be0 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d SUnreclaim:     %8lu kB\n"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		       "Node %d AnonHugePages:  %8lu kB\n"
+		       "Node %d AnonHugePUDPages: %8lu kB\n"
 		       "Node %d ShmemHugePages: %8lu kB\n"
 		       "Node %d ShmemPmdMapped: %8lu kB\n"
 		       "Node %d FileHugePages: %8lu kB\n"
@@ -457,6 +458,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       ,
 		       nid, K(node_page_state(pgdat, NR_ANON_THPS) *
 				       HPAGE_PMD_NR),
+			   nid, K(node_page_state(pgdat, NR_ANON_THPS_PUD) *
+				       HPAGE_PUD_NR),
 		       nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				       HPAGE_PMD_NR),
 		       nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 887a5532e449..b60e0c241015 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -130,6 +130,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
 		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
+	show_val_kb(m, "AnonHugePUDPages:  ",
+			global_node_page_state(NR_ANON_THPS_PUD) * HPAGE_PUD_NR);
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index addd206150e2..7528652400e4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -18,10 +18,15 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
+extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
 }
+extern int do_huge_pud_anonymous_page(struct vm_fault *vmf)
+{
+	return VM_FAULT_FALLBACK;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
@@ -323,6 +328,7 @@ struct page *mm_get_huge_zero_page(struct mm_struct *mm);
 void mm_put_huge_zero_page(struct mm_struct *mm);
 
 #define mk_huge_pmd(page, prot) pmd_mkhuge(mk_pmd(page, prot))
+#define mk_huge_pud(page, prot) pud_mkhuge(mk_pud(page, prot))
 
 static inline bool thp_migration_supported(void)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7e0ea3fe95ca..cbc768d364fd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -196,6 +196,7 @@ enum node_stat_item {
 	NR_FILE_THPS,
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	NR_ANON_THPS_PUD,
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 18e75974d4e3..416d9966fa3f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -93,6 +93,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_DEFERRED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+		THP_FAULT_ALLOC_PUD,
+		THP_FAULT_FALLBACK_PUD,
+		THP_FAULT_FALLBACK_PUD_CHARGE,
 		THP_SPLIT_PUD,
 #endif
 		THP_ZERO_PAGE_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b1c7dc8a6f96..20a3d393d451 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -933,6 +933,111 @@ vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud_prot);
+
+static int __do_huge_pud_anonymous_page(struct vm_fault *vmf, struct page *page,
+		gfp_t gfp)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pmd_t *pmd_pgtable;
+	unsigned long haddr = vmf->address & HPAGE_PUD_MASK;
+	int ret = 0;
+
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+
+	if (mem_cgroup_charge(page, vma->vm_mm, gfp)) {
+		put_page(page);
+		count_vm_event(THP_FAULT_FALLBACK_PUD);
+		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
+		return VM_FAULT_FALLBACK;
+	}
+	cgroup_throttle_swaprate(page, gfp);
+
+	pmd_pgtable = pmd_alloc_one_page_with_ptes(vma->vm_mm, haddr);
+	if (unlikely(!pmd_pgtable)) {
+		ret = VM_FAULT_OOM;
+		goto release;
+	}
+
+	clear_huge_page(page, vmf->address, HPAGE_PUD_NR);
+	/*
+	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * clear_huge_page writes become visible before the set_pmd_at()
+	 * write.
+	 */
+	__SetPageUptodate(page);
+
+	vmf->ptl = pud_lock(vma->vm_mm, vmf->pud);
+	if (unlikely(!pud_none(*vmf->pud))) {
+		goto unlock_release;
+	} else {
+		pud_t entry;
+		int i;
+
+		ret = check_stable_address_space(vma->vm_mm);
+		if (ret)
+			goto unlock_release;
+
+		/* Deliver the page fault to userland */
+		if (userfaultfd_missing(vma)) {
+			vm_fault_t ret2;
+
+			spin_unlock(vmf->ptl);
+			put_page(page);
+			pmd_free_page_with_ptes(vma->vm_mm, pmd_pgtable);
+			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
+			VM_BUG_ON(ret2 & VM_FAULT_FALLBACK);
+			return ret2;
+		}
+
+		entry = mk_huge_pud(page, vma->vm_page_prot);
+		entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+		page_add_new_anon_rmap(page, vma, haddr, true);
+		lru_cache_add_inactive_or_unevictable(page, vma);
+		pgtable_trans_huge_pud_deposit(vma->vm_mm, vmf->pud,
+				virt_to_page(pmd_pgtable));
+		set_pud_at(vma->vm_mm, haddr, vmf->pud, entry);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PUD_NR);
+		mm_inc_nr_pmds(vma->vm_mm);
+		for (i = 0; i < (1<<(HPAGE_PUD_ORDER - HPAGE_PMD_ORDER)); i++)
+			mm_inc_nr_ptes(vma->vm_mm);
+		spin_unlock(vmf->ptl);
+		count_vm_event(THP_FAULT_ALLOC_PUD);
+	}
+
+	return 0;
+unlock_release:
+	spin_unlock(vmf->ptl);
+release:
+	if (pmd_pgtable)
+		pmd_free_page_with_ptes(vma->vm_mm, pmd_pgtable);
+	put_page(page);
+	return ret;
+
+}
+
+int do_huge_pud_anonymous_page(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	gfp_t gfp;
+	struct page *page;
+	unsigned long haddr = vmf->address & HPAGE_PUD_MASK;
+
+	if (haddr < vma->vm_start || haddr + HPAGE_PUD_SIZE > vma->vm_end)
+		return VM_FAULT_FALLBACK;
+	if (unlikely(anon_vma_prepare(vma)))
+		return VM_FAULT_OOM;
+	/* no khugepaged_enter, since PUD THP is not supported by khugepaged */
+
+	gfp = alloc_hugepage_direct_gfpmask(vma);
+	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PUD_ORDER);
+	if (unlikely(!page)) {
+		count_vm_event(THP_FAULT_FALLBACK_PUD);
+		return VM_FAULT_FALLBACK;
+	}
+	prep_transhuge_page(page);
+	return __do_huge_pud_anonymous_page(vmf, page, gfp);
+}
+
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6b1b4a331792..29abeff09fcc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5434,7 +5434,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
-			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR +
+			  node_page_state(pgdat, NR_ANON_THPS_PUD) * HPAGE_PUD_NR),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
diff --git a/mm/rmap.c b/mm/rmap.c
index 1b84945d655c..5683f367a792 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -726,6 +726,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
+	pud_t pude;
 	pmd_t *pmd = NULL;
 	pmd_t pmde;
 
@@ -738,7 +739,10 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address)
 		goto out;
 
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+
+	pude = *pud;
+	barrier();
+	if (!pud_present(pude) || pud_trans_huge(pude))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
@@ -1137,8 +1141,12 @@ void do_page_add_anon_rmap(struct page *page,
 		 * pte lock(a spinlock) is held, which implies preemption
 		 * disabled.
 		 */
-		if (compound)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
+		if (compound) {
+			if (nr == HPAGE_PMD_NR)
+				__inc_lruvec_page_state(page, NR_ANON_THPS);
+			else
+				__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
+		}
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1180,7 +1188,10 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		__inc_lruvec_page_state(page, NR_ANON_THPS);
+		if (nr == HPAGE_PMD_NR)
+			__inc_lruvec_page_state(page, NR_ANON_THPS);
+		else
+			__inc_lruvec_page_state(page, NR_ANON_THPS_PUD);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1286,7 +1297,10 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__dec_lruvec_page_state(page, NR_ANON_THPS);
+	if (thp_nr_pages(page) == HPAGE_PMD_NR)
+		__dec_lruvec_page_state(page, NR_ANON_THPS);
+	else
+		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
 
 	if (TestClearPageDoubleMap(page)) {
 		/*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 79e5cd0abd0e..a9e50ef6a40d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1209,6 +1209,7 @@ const char * const vmstat_text[] = {
 	"nr_file_hugepages",
 	"nr_file_pmdmapped",
 	"nr_anon_transparent_hugepages",
+	"nr_anon_transparent_pud_hugepages",
 	"nr_vmscan_write",
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
@@ -1326,6 +1327,9 @@ const char * const vmstat_text[] = {
 	"thp_deferred_split_page",
 	"thp_split_pmd",
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	"thp_fault_alloc_pud",
+	"thp_fault_fallback_pud",
+	"thp_fault_fallback_pud_charge",
 	"thp_split_pud",
 #endif
 	"thp_zero_page_alloc",
-- 
2.28.0

