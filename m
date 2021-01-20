Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272442FCE43
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbhATKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:19:45 -0500
Received: from foss.arm.com ([217.140.110.172]:53974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbhATKID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:08:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EEFF31B;
        Wed, 20 Jan 2021 02:07:17 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.90.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 601EF3F68F;
        Wed, 20 Jan 2021 02:07:14 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] mm/debug_vm_pgtable/basic: Iterate over entire protection_map[]
Date:   Wed, 20 Jan 2021 15:37:21 +0530
Message-Id: <1611137241-26220-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611137241-26220-1-git-send-email-anshuman.khandual@arm.com>
References: <1611137241-26220-1-git-send-email-anshuman.khandual@arm.com>
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
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [s390]
Reviewed-by: Steven Price <steven.price@arm.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 47 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1842d97522bb..a9bd6ce1ba02 100644
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
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -141,14 +143,16 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
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
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -274,14 +278,16 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
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
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -398,7 +404,7 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 #endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pud_t *pudp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -411,8 +417,8 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
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
@@ -938,6 +944,7 @@ static int __init debug_vm_pgtable(void)
 	unsigned long vaddr, pte_aligned, pmd_aligned;
 	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
 	spinlock_t *ptl = NULL;
+	int idx;
 
 	pr_info("Validating architecture page table helpers\n");
 	prot = vm_get_page_prot(VMFLAGS);
@@ -1002,9 +1009,25 @@ static int __init debug_vm_pgtable(void)
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

