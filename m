Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D32FD75B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbhATRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbhATRiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:38:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DADD2333E;
        Wed, 20 Jan 2021 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164198;
        bh=mPVcvqnnFczBTmevUq2gNa8hUAqbH91DT9UsrPws3+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPZmHgq6EOYiaoMTHwKnopMYJLLjBf+KUh7gFxWGU6C6ZsFy8Fw59t8JWVzuKxMks
         IHr208S00Re726/ukSpL9sUdOnyxksN9bEL65lnbXKYooL4MUXmsokpx9GqjnSFELN
         xejVA5rh5/IVjWljgThf4JfJwS0fyPtRUGs0+FwYduyBEhC7mV9Hhfg6jLpsZXrkPL
         aSfhGTwDfpO7rYmQ2cmH15i063QV5R2hRT1j+cTbiSZBkaVFNnaVwtM4swaArGolDn
         i79B4d4fBH0/xGiIVBx93yWErYA3GW7Wu/AvVigqmGB2X1AeLGSdtwajpRte6QK0Zu
         aPbipWs4q5i8Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: [PATCH v4 6/8] mm: Avoid modifying vmf.address in __collapse_huge_page_swapin()
Date:   Wed, 20 Jan 2021 17:36:10 +0000
Message-Id: <20210120173612.20913-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
References: <20210120173612.20913-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for const-ifying the anonymous struct field of
'struct vm_fault', rework __collapse_huge_page_swapin() to avoid
continuously updating vmf.address and instead populate a new
'struct vm_fault' on the stack for each page being processed.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/khugepaged.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 67ab391a5373..fb0fdaec34d5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -991,38 +991,41 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 					struct vm_area_struct *vma,
-					unsigned long address, pmd_t *pmd,
+					unsigned long haddr, pmd_t *pmd,
 					int referenced)
 {
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
-	struct vm_fault vmf = {
-		.vma = vma,
-		.address = address,
-		.flags = FAULT_FLAG_ALLOW_RETRY,
-		.pmd = pmd,
-		.pgoff = linear_page_index(vma, address),
-	};
-
-	vmf.pte = pte_offset_map(pmd, address);
-	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
-			vmf.pte++, vmf.address += PAGE_SIZE) {
+	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
+
+	for (address = haddr; address < end; address += PAGE_SIZE) {
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = address,
+			.pgoff = linear_page_index(vma, haddr),
+			.flags = FAULT_FLAG_ALLOW_RETRY,
+			.pmd = pmd,
+		};
+
+		vmf.pte = pte_offset_map(pmd, address);
 		vmf.orig_pte = *vmf.pte;
-		if (!is_swap_pte(vmf.orig_pte))
+		if (!is_swap_pte(vmf.orig_pte)) {
+			pte_unmap(vmf.pte);
 			continue;
+		}
 		swapped_in++;
 		ret = do_swap_page(&vmf);
 
 		/* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
 		if (ret & VM_FAULT_RETRY) {
 			mmap_read_lock(mm);
-			if (hugepage_vma_revalidate(mm, address, &vmf.vma)) {
+			if (hugepage_vma_revalidate(mm, haddr, &vma)) {
 				/* vma is no longer available, don't continue to swapin */
 				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 				return false;
 			}
 			/* check if the pmd is still valid */
-			if (mm_find_pmd(mm, address) != pmd) {
+			if (mm_find_pmd(mm, haddr) != pmd) {
 				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 				return false;
 			}
@@ -1031,11 +1034,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 			return false;
 		}
-		/* pte is unmapped now, we need to map it */
-		vmf.pte = pte_offset_map(pmd, vmf.address);
 	}
-	vmf.pte--;
-	pte_unmap(vmf.pte);
 
 	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
 	if (swapped_in)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

