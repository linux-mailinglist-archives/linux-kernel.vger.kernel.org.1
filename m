Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4C2F68C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbhANSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbhANSCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A48823B6C;
        Thu, 14 Jan 2021 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647260;
        bh=r2dnf6YJ6jHN3sgi1lAaFR0PxcBHrSSoP2vcEunw2q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHpuBt+ZSEWydfP0zrlGDema7Yty0qclZojoA5QoOfsk9ntce62qkJg+1tS8oFSwP
         9dN52fvrKOqhJvThDOwL93iqa6Ov4Vfto8bLJZlt9H58N0W9j9diJ0dO0CLbqqJ45I
         0Dk2Jt4vR0VmN34vUqH8gi/qTV3dywa96e3kk9aSRh6wvthdYaN5zZxJgHqF5ruOuT
         jrkOifK+3AQqBUuA00RyfLHtKa9tsKpnIt6BkPiiNhwwdocLPzmLUBJVh3ZK5l7oym
         LWNQ+lkWxnXcOgN5V6wtVEAJV3+Qg1IHJ2hqzBBxGKXREFnjHuCj7fZdiduXFjWjnW
         HOZeUu95TiVQg==
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
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [RFC PATCH 6/8] mm: Avoid modifying vmf.info.address in __collapse_huge_page_swapin()
Date:   Thu, 14 Jan 2021 17:59:32 +0000
Message-Id: <20210114175934.13070-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114175934.13070-1-will@kernel.org>
References: <20210114175934.13070-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for const-ifying the 'info' field of 'struct vm_fault',
rework __collapse_huge_page_swapin() to avoid continously updating
vmf.info.address and instead populate a new 'struct vm_fault' on the
stack for each page being processed.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/khugepaged.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4494c90075fb..86c51a5d92d2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -991,40 +991,43 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 					struct vm_area_struct *vma,
-					unsigned long address, pmd_t *pmd,
+					unsigned long haddr, pmd_t *pmd,
 					int referenced)
 {
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
-	struct vm_fault vmf = {
-		.info = {
-			.vma = vma,
-			.address = address,
-			.pgoff = linear_page_index(vma, address),
-		},
-		.flags = FAULT_FLAG_ALLOW_RETRY,
-		.pmd = pmd,
-	};
-
-	vmf.pte = pte_offset_map(pmd, address);
-	for (; vmf.info.address < address + HPAGE_PMD_NR*PAGE_SIZE;
-			vmf.pte++, vmf.info.address += PAGE_SIZE) {
+	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
+
+	for (address = haddr; address < end; address += PAGE_SIZE) {
+		struct vm_fault vmf = {
+			.info = {
+				.vma = vma,
+				.address = address,
+				.pgoff = linear_page_index(vma, haddr),
+			},
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
-			if (hugepage_vma_revalidate(mm, address, &vmf.info.vma)) {
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
@@ -1033,11 +1036,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 			return false;
 		}
-		/* pte is unmapped now, we need to map it */
-		vmf.pte = pte_offset_map(pmd, vmf.info.address);
 	}
-	vmf.pte--;
-	pte_unmap(vmf.pte);
 
 	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
 	if (swapped_in)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

