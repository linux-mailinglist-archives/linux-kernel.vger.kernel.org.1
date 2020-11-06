Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336A62AA18E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKFXwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:52:06 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7995 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgKFXvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:51:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5e1970000>; Fri, 06 Nov 2020 15:51:51 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 23:51:48 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 23:51:48 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Thomas Hellstrom (VMware)" <thomas_os@shipmail.org>,
        Michel Lespinasse <walken@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] include/linux/huge_mm.h: remove extern keyword
Date:   Fri, 6 Nov 2020 15:51:35 -0800
Message-ID: <20201106235135.32109-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604706711; bh=jHbqVRChknUQizR8X5ifVJGo0Kkjyn9CIYYUlQANyf8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=ks72RhzUkh7oOv4MmcNFJVry6BPNlsdtmUVSdPJjEsArJbx0igB4g3rQEcX9ReLXj
         bxccjLd8/hdb/N1KyHUKFbi0IJuSm2j8iqQLIwBdd7oZCFFn6Yr8QCMTX2g8FntdDO
         o1Q7zl8PEGWxajlmrItkqfx/8/hvE5AdT1IMc1gKlAsSI4XMn+xmNoO/efnhtROVTH
         sBAFF5BRjfFnRD3Mt/8p/MfCYepTJAbFcwsopPfBJkPpfY4GYlgvJ86cS4s+EamUqR
         vBWf7Oto4zFDiCCCMDGLu+LKmBMAWSeB/tLZfznXfAx+1iZsvciHBWsfEaPuLFbdjE
         vtmQkGlfR8dGw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external function definitions don't need the "extern" keyword.
Remove them so future changes don't copy the function definition style.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This applies cleanly to linux-mm 5.10.0-rc2 and is for Andrew's tree.

 include/linux/huge_mm.h | 93 ++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 52 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0365aa97f8e7..6a19f35f836b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -7,43 +7,37 @@
=20
 #include <linux/fs.h> /* only for vma_is_dax() */
=20
-extern vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
-extern int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_m=
m,
-			 pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
-			 struct vm_area_struct *vma);
-extern void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
-extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_m=
m,
-			 pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
-			 struct vm_area_struct *vma);
+vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
+int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		  struct vm_area_struct *vma);
+void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
+int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
+		  struct vm_area_struct *vma);
=20
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
+void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_=
pud)
 {
 }
 #endif
=20
-extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd=
);
-extern struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
-					  unsigned long addr,
-					  pmd_t *pmd,
-					  unsigned int flags);
-extern bool madvise_free_huge_pmd(struct mmu_gather *tlb,
-			struct vm_area_struct *vma,
-			pmd_t *pmd, unsigned long addr, unsigned long next);
-extern int zap_huge_pmd(struct mmu_gather *tlb,
-			struct vm_area_struct *vma,
-			pmd_t *pmd, unsigned long addr);
-extern int zap_huge_pud(struct mmu_gather *tlb,
-			struct vm_area_struct *vma,
-			pud_t *pud, unsigned long addr);
-extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_ad=
dr,
-			 unsigned long new_addr,
-			 pmd_t *old_pmd, pmd_t *new_pmd);
-extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-			unsigned long addr, pgprot_t newprot,
-			unsigned long cp_flags);
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
+struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
+				   unsigned long addr, pmd_t *pmd,
+				   unsigned int flags);
+bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *=
vma,
+			   pmd_t *pmd, unsigned long addr, unsigned long next);
+int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma, pmd_t=
 *pmd,
+		 unsigned long addr);
+int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma, pud_t=
 *pud,
+		 unsigned long addr);
+bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
+		   unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd);
+int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd, unsigned long =
addr,
+		    pgprot_t newprot, unsigned long cp_flags);
 vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 				   pgprot_t pgprot, bool write);
=20
@@ -100,13 +94,13 @@ enum transparent_hugepage_flag {
 struct kobject;
 struct kobj_attribute;
=20
-extern ssize_t single_hugepage_flag_store(struct kobject *kobj,
-				 struct kobj_attribute *attr,
-				 const char *buf, size_t count,
-				 enum transparent_hugepage_flag flag);
-extern ssize_t single_hugepage_flag_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf,
-				enum transparent_hugepage_flag flag);
+ssize_t single_hugepage_flag_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count,
+				   enum transparent_hugepage_flag flag);
+ssize_t single_hugepage_flag_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf,
+				  enum transparent_hugepage_flag flag);
 extern struct kobj_attribute shmem_enabled_attr;
=20
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
@@ -179,12 +173,11 @@ static inline bool transhuge_vma_suitable(struct vm_a=
rea_struct *vma,
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
=20
-extern unsigned long thp_get_unmapped_area(struct file *filp,
-		unsigned long addr, unsigned long len, unsigned long pgoff,
-		unsigned long flags);
+unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags);
=20
-extern void prep_transhuge_page(struct page *page);
-extern void free_transhuge_page(struct page *page);
+void prep_transhuge_page(struct page *page);
+void free_transhuge_page(struct page *page);
 bool is_transparent_hugepage(struct page *page);
=20
 bool can_split_huge_page(struct page *page, int *pextra_pins);
@@ -222,16 +215,12 @@ void __split_huge_pud(struct vm_area_struct *vma, pud=
_t *pud,
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
=20
-extern int hugepage_madvise(struct vm_area_struct *vma,
-			    unsigned long *vm_flags, int advice);
-extern void vma_adjust_trans_huge(struct vm_area_struct *vma,
-				    unsigned long start,
-				    unsigned long end,
-				    long adjust_next);
-extern spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd,
-		struct vm_area_struct *vma);
-extern spinlock_t *__pud_trans_huge_lock(pud_t *pud,
-		struct vm_area_struct *vma);
+int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
+		     int advice);
+void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start=
,
+			   unsigned long end, long adjust_next);
+spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
+spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma);
=20
 static inline int is_swap_pmd(pmd_t pmd)
 {
@@ -294,7 +283,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *v=
ma, unsigned long addr,
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long a=
ddr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
=20
-extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_p=
md);
+vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
=20
 extern struct page *huge_zero_page;
=20
--=20
2.20.1

