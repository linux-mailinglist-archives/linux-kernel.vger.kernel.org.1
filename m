Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642432C5F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgK0FGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:06:46 -0500
Received: from foss.arm.com ([217.140.110.172]:58174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgK0FGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:06:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E301516;
        Thu, 26 Nov 2020 21:06:45 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0288A3F70D;
        Thu, 26 Nov 2020 21:06:41 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, christophe.leroy@csgroup.eu,
        gerald.schaefer@linux.ibm.com, vgupta@synopsys.com,
        paul.walmsley@sifive.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 1/2] mm/debug_vm_pgtable/basic: Add validation for dirtiness after write protect
Date:   Fri, 27 Nov 2020 10:36:23 +0530
Message-Id: <1606453584-15399-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
References: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds validation tests for dirtiness after write protect conversion for
each page table level. This is important for platforms such as arm64 that
removes the hardware dirty bit while making it an write protected one. This
also fixes pxx_wrprotect() related typos in the documentation file.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/vm/arch_pgtable_helpers.rst | 8 ++++----
 mm/debug_vm_pgtable.c                     | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index c05d9dcf7891..a5be11210597 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -70,6 +70,7 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
 	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
 	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
+	WARN_ON(pte_dirty(pte_wrprotect(pte)));
 }
 
 static void __init pte_advanced_tests(struct mm_struct *mm,
@@ -144,6 +145,7 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
 	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
 	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
+	WARN_ON(pmd_dirty(pmd_wrprotect(pmd)));
 	/*
 	 * A huge page does not point to next level page table
 	 * entry. Hence this must qualify as pmd_bad().
@@ -262,6 +264,7 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
 	WARN_ON(pud_write(pud_wrprotect(pud_mkwrite(pud))));
 	WARN_ON(pud_young(pud_mkold(pud_mkyoung(pud))));
+	WARN_ON(pud_dirty(pud_wrprotect(pud)));
 
 	if (mm_pmd_folded(mm))
 		return;
-- 
2.20.1

