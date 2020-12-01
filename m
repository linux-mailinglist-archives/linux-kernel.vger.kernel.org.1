Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12DE2CA28E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgLAMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:20:54 -0500
Received: from foss.arm.com ([217.140.110.172]:41922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgLAMUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:20:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EAF21063;
        Tue,  1 Dec 2020 04:20:08 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.85.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C7813F718;
        Tue,  1 Dec 2020 04:20:02 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, christophe.leroy@csgroup.eu,
        gerald.schaefer@linux.ibm.com, vgupta@synopsys.com,
        paul.walmsley@sifive.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V2 1/2] mm/debug_vm_pgtable/basic: Add validation for dirtiness after write protect
Date:   Tue,  1 Dec 2020 17:49:28 +0530
Message-Id: <1606825169-5229-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606825169-5229-1-git-send-email-anshuman.khandual@arm.com>
References: <1606825169-5229-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds validation tests for dirtiness after write protect conversion for
each page table level. There are two new separate test types involved here.

The first test ensures that a given page table entry does not become dirty
after pxx_wrprotect(). This is important for platforms like arm64 which
transfers and drops the hardware dirty bit (!PTE_RDONLY) to the software
dirty bit while making it an write protected one. This test ensures that
no fresh page table entry could be created with hardware dirty bit set.
The second test ensures that a given page table entry always preserve the
dirty information across pxx_wrprotect().

This adds two previously missing PUD level basic tests and while here fixes
pxx_wrprotect() related typos in the documentation file.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/vm/arch_pgtable_helpers.rst |  8 ++---
 mm/debug_vm_pgtable.c                     | 42 +++++++++++++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index f3591ee3aaa8..552567d863b8 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -50,7 +50,7 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mkwrite               | Creates a writable PTE                           |
 +---------------------------+--------------------------------------------------+
-| pte_mkwrprotect           | Creates a write protected PTE                    |
+| pte_wrprotect             | Creates a write protected PTE                    |
 +---------------------------+--------------------------------------------------+
 | pte_mkspecial             | Creates a special PTE                            |
 +---------------------------+--------------------------------------------------+
@@ -120,7 +120,7 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_mkwrite               | Creates a writable PMD                           |
 +---------------------------+--------------------------------------------------+
-| pmd_mkwrprotect           | Creates a write protected PMD                    |
+| pmd_wrprotect             | Creates a write protected PMD                    |
 +---------------------------+--------------------------------------------------+
 | pmd_mkspecial             | Creates a special PMD                            |
 +---------------------------+--------------------------------------------------+
@@ -186,7 +186,7 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_mkwrite               | Creates a writable PUD                           |
 +---------------------------+--------------------------------------------------+
-| pud_mkwrprotect           | Creates a write protected PUD                    |
+| pud_wrprotect             | Creates a write protected PUD                    |
 +---------------------------+--------------------------------------------------+
 | pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
 +---------------------------+--------------------------------------------------+
@@ -224,7 +224,7 @@ HugeTLB Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | huge_pte_mkwrite          | Creates a writable HugeTLB                       |
 +---------------------------+--------------------------------------------------+
-| huge_pte_mkwrprotect      | Creates a write protected HugeTLB                |
+| huge_pte_wrprotect        | Creates a write protected HugeTLB                |
 +---------------------------+--------------------------------------------------+
 | huge_ptep_get_and_clear   | Clears a HugeTLB                                 |
 +---------------------------+--------------------------------------------------+
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c05d9dcf7891..c6fffea54522 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -63,6 +63,17 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
 	pte_t pte = pfn_pte(pfn, prot);
 
 	pr_debug("Validating PTE basic\n");
+
+	/*
+	 * This test needs to execute right after the given page
+	 * table entry is created with pfn_pte() to make sure that
+	 * protection_map[idx] does not have the dirty bit enabled
+	 * from the beginning. This is particularly important for
+	 * platforms like arm64 where (!PTE_RDONLY) indicate dirty
+	 * bit being set.
+	 */
+	WARN_ON(pte_dirty(pte_wrprotect(pte)));
+
 	WARN_ON(!pte_same(pte, pte));
 	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
 	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
@@ -70,6 +81,8 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
 	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
 	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
+	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
+	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
 }
 
 static void __init pte_advanced_tests(struct mm_struct *mm,
@@ -137,6 +150,18 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD basic\n");
+
+	/*
+	 * This test needs to execute right after the given page
+	 * table entry is created with pfn_pmd() to make sure that
+	 * protection_map[idx] does not have the dirty bit enabled
+	 * from the beginning. This is particularly important for
+	 * platforms like arm64 where (!PTE_RDONLY) indicate dirty
+	 * bit being set.
+	 */
+	WARN_ON(pmd_dirty(pmd_wrprotect(pmd)));
+
+
 	WARN_ON(!pmd_same(pmd, pmd));
 	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
 	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
@@ -144,6 +169,8 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
 	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
 	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
+	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
+	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
 	/*
 	 * A huge page does not point to next level page table
 	 * entry. Hence this must qualify as pmd_bad().
@@ -257,11 +284,26 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD basic\n");
+
+	/*
+	 * This test needs to execute right after the given page
+	 * table entry is created with pfn_pud() to make sure that
+	 * protection_map[idx] does not have the dirty bit enabled
+	 * from the beginning. This is particularly important for
+	 * platforms like arm64 where (!PTE_RDONLY) indicate dirty
+	 * bit being set.
+	 */
+	WARN_ON(pud_dirty(pud_wrprotect(pud)));
+
 	WARN_ON(!pud_same(pud, pud));
 	WARN_ON(!pud_young(pud_mkyoung(pud_mkold(pud))));
+	WARN_ON(!pud_dirty(pud_mkdirty(pud_mkclean(pud))));
+	WARN_ON(pud_dirty(pud_mkclean(pud_mkdirty(pud))));
 	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
 	WARN_ON(pud_write(pud_wrprotect(pud_mkwrite(pud))));
 	WARN_ON(pud_young(pud_mkold(pud_mkyoung(pud))));
+	WARN_ON(pud_dirty(pud_wrprotect(pud_mkclean(pud))));
+	WARN_ON(!pud_dirty(pud_wrprotect(pud_mkdirty(pud))));
 
 	if (mm_pmd_folded(mm))
 		return;
-- 
2.20.1

