Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13527665F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIXC2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 22:28:16 -0400
Received: from foss.arm.com ([217.140.110.172]:60382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIXC2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 22:28:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4C0113E;
        Wed, 23 Sep 2020 19:28:15 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76F763F70D;
        Wed, 23 Sep 2020 19:28:12 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, sfr@canb.auug.org.au
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/debug_vm_pgtable: Drop hugetlb_advanced_tests()
Date:   Thu, 24 Sep 2020 07:57:26 +0530
Message-Id: <1600914446-21890-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_advanced_tests() has now stopped working on i386 platform due to
some recent changes with respect to page table lock. The test never worked
on ppc64 platform, which resulted in disabling it selectively. Let's just
drop hugetlb_advanced_tests() for now and in the process free up the entire
test from the only platform specific test execution path.

https://lore.kernel.org/lkml/289c3fdb-1394-c1af-bdc4-5542907089dc@linux.ibm.com/#t

CC: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on current linux-next (20200923).

 mm/debug_vm_pgtable.c | 55 -------------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index b0edca2e2c73..c5ae822cc6bc 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -811,59 +811,8 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pte_huge(pte_mkhuge(pte)));
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 }
-
-#ifndef CONFIG_PPC_BOOK3S_64
-static void __init hugetlb_advanced_tests(struct mm_struct *mm,
-					  struct vm_area_struct *vma,
-					  pte_t *ptep, unsigned long pfn,
-					  unsigned long vaddr, pgprot_t prot)
-{
-	struct page *page = pfn_to_page(pfn);
-	pte_t pte = ptep_get(ptep);
-	unsigned long paddr = __pfn_to_phys(pfn) & PMD_MASK;
-
-	pr_debug("Validating HugeTLB advanced\n");
-	pte = pte_mkhuge(mk_pte(pfn_to_page(PHYS_PFN(paddr)), prot));
-	set_huge_pte_at(mm, vaddr, ptep, pte);
-	barrier();
-	WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
-	huge_pte_clear(mm, vaddr, ptep, PMD_SIZE);
-	pte = huge_ptep_get(ptep);
-	WARN_ON(!huge_pte_none(pte));
-
-	pte = mk_huge_pte(page, prot);
-	set_huge_pte_at(mm, vaddr, ptep, pte);
-	barrier();
-	huge_ptep_set_wrprotect(mm, vaddr, ptep);
-	pte = huge_ptep_get(ptep);
-	WARN_ON(huge_pte_write(pte));
-
-	pte = mk_huge_pte(page, prot);
-	set_huge_pte_at(mm, vaddr, ptep, pte);
-	barrier();
-	huge_ptep_get_and_clear(mm, vaddr, ptep);
-	pte = huge_ptep_get(ptep);
-	WARN_ON(!huge_pte_none(pte));
-
-	pte = mk_huge_pte(page, prot);
-	pte = huge_pte_wrprotect(pte);
-	set_huge_pte_at(mm, vaddr, ptep, pte);
-	barrier();
-	pte = huge_pte_mkwrite(pte);
-	pte = huge_pte_mkdirty(pte);
-	huge_ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
-	pte = huge_ptep_get(ptep);
-	WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
-}
-#endif
 #else  /* !CONFIG_HUGETLB_PAGE */
 static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init hugetlb_advanced_tests(struct mm_struct *mm,
-					  struct vm_area_struct *vma,
-					  pte_t *ptep, unsigned long pfn,
-					  unsigned long vaddr, pgprot_t prot)
-{
-}
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1073,10 +1022,6 @@ static int __init debug_vm_pgtable(void)
 	pud_populate_tests(mm, pudp, saved_pmdp);
 	spin_unlock(ptl);
 
-#ifndef CONFIG_PPC_BOOK3S_64
-	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
-#endif
-
 	spin_lock(&mm->page_table_lock);
 	p4d_clear_tests(mm, p4dp);
 	pgd_clear_tests(mm, pgdp);
-- 
2.20.1

