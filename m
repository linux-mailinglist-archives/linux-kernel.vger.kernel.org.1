Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D392C5F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgK0FGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:06:50 -0500
Received: from foss.arm.com ([217.140.110.172]:58190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgK0FGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:06:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915311478;
        Thu, 26 Nov 2020 21:06:49 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A2123F70D;
        Thu, 26 Nov 2020 21:06:45 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, christophe.leroy@csgroup.eu,
        gerald.schaefer@linux.ibm.com, vgupta@synopsys.com,
        paul.walmsley@sifive.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 2/2] mm/debug_vm_pgtable/basic: Iterate over entire protection_map[]
Date:   Fri, 27 Nov 2020 10:36:24 +0530
Message-Id: <1606453584-15399-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
References: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the basic tests just validate various page table transformations
after starting with vm_get_page_prot(VM_READ|VM_WRITE|VM_EXEC) protection.
Instead scan over the entire protection_map[] for better coverage. It also
makes sure that all these basic page table tranformations checks hold true
irrespective of the starting protection value for the page table entry.
There is also a slight change in the debug print format for basic tests to
capture the protection value it is being tested with. The modified output
looks something like

[pte_basic_tests          ]: Validating PTE basic ()
[pte_basic_tests          ]: Validating PTE basic (read)
[pte_basic_tests          ]: Validating PTE basic (write)
[pte_basic_tests          ]: Validating PTE basic (read|write)
[pte_basic_tests          ]: Validating PTE basic (exec)
[pte_basic_tests          ]: Validating PTE basic (read|exec)
[pte_basic_tests          ]: Validating PTE basic (write|exec)
[pte_basic_tests          ]: Validating PTE basic (read|write|exec)
[pte_basic_tests          ]: Validating PTE basic (shared)
[pte_basic_tests          ]: Validating PTE basic (read|shared)
[pte_basic_tests          ]: Validating PTE basic (write|shared)
[pte_basic_tests          ]: Validating PTE basic (read|write|shared)
[pte_basic_tests          ]: Validating PTE basic (exec|shared)
[pte_basic_tests          ]: Validating PTE basic (read|exec|shared)
[pte_basic_tests          ]: Validating PTE basic (write|exec|shared)
[pte_basic_tests          ]: Validating PTE basic (read|write|exec|shared)

This adds a missing argument 'struct mm_struct *' in pud_basic_tests() test
. This never got exposed before as PUD based THP is available only on X86
platform where mm_pmd_folded(mm) call gets macro replaced without requiring
the mm_struct i.e __is_defined(__PAGETABLE_PMD_FOLDED).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 47 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a5be11210597..92b4a53d622b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -58,11 +58,13 @@
 #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
 #define RANDOM_NZVALUE	GENMASK(7, 0)
 
-static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init pte_basic_tests(unsigned long pfn, int idx)
 {
+	pgprot_t prot = protection_map[idx];
 	pte_t pte = pfn_pte(pfn, prot);
+	unsigned long val = idx, *ptr = &val;
 
-	pr_debug("Validating PTE basic\n");
+	pr_debug("Validating PTE basic (%pGv)\n", ptr);
 	WARN_ON(!pte_same(pte, pte));
 	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
 	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
@@ -130,14 +132,16 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init pmd_basic_tests(unsigned long pfn, int idx)
 {
+	pgprot_t prot = protection_map[idx];
 	pmd_t pmd = pfn_pmd(pfn, prot);
+	unsigned long val = idx, *ptr = &val;
 
 	if (!has_transparent_hugepage())
 		return;
 
-	pr_debug("Validating PMD basic\n");
+	pr_debug("Validating PMD basic (%pGv)\n", ptr);
 	WARN_ON(!pmd_same(pmd, pmd));
 	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
 	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
@@ -251,14 +255,16 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx)
 {
+	pgprot_t prot = protection_map[idx];
 	pud_t pud = pfn_pud(pfn, prot);
+	unsigned long val = idx, *ptr = &val;
 
 	if (!has_transparent_hugepage())
 		return;
 
-	pr_debug("Validating PUD basic\n");
+	pr_debug("Validating PUD basic (%pGv)\n", ptr);
 	WARN_ON(!pud_same(pud, pud));
 	WARN_ON(!pud_young(pud_mkyoung(pud_mkold(pud))));
 	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
@@ -362,7 +368,7 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 #endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pud_t *pudp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -375,8 +381,8 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
+static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
 static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pmd_t *pmdp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -902,6 +908,7 @@ static int __init debug_vm_pgtable(void)
 	unsigned long vaddr, pte_aligned, pmd_aligned;
 	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
 	spinlock_t *ptl = NULL;
+	int idx;
 
 	pr_info("Validating architecture page table helpers\n");
 	prot = vm_get_page_prot(VMFLAGS);
@@ -966,9 +973,25 @@ static int __init debug_vm_pgtable(void)
 	saved_pmdp = pmd_offset(pudp, 0UL);
 	saved_ptep = pmd_pgtable(pmd);
 
-	pte_basic_tests(pte_aligned, prot);
-	pmd_basic_tests(pmd_aligned, prot);
-	pud_basic_tests(pud_aligned, prot);
+	/*
+	 * Iterate over the protection_map[] to make sure that all
+	 * the basic page table transformation validations just hold
+	 * true irrespective of the starting protection value for a
+	 * given page table entry.
+	 */
+	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
+		pte_basic_tests(pte_aligned, idx);
+		pmd_basic_tests(pmd_aligned, idx);
+		pud_basic_tests(mm, pud_aligned, idx);
+	}
+
+	/*
+	 * Both P4D and PGD level tests are very basic which do not
+	 * involve creating page table entries from the protection
+	 * value and the given pfn. Hence just keep them out from
+	 * the above iteration for now to save some test execution
+	 * time.
+	 */
 	p4d_basic_tests(p4d_aligned, prot);
 	pgd_basic_tests(pgd_aligned, prot);
 
-- 
2.20.1

