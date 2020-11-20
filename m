Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864182BABFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgKTOgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgKTOgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:36:15 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CCEB2237B;
        Fri, 20 Nov 2020 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605882974;
        bh=Ee4dHPlm9Xtf0uOlgveF1NWM2zzjVroNVw3kT3+i2IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNtrw4KIsx5ciCK6WLPTjUp8aE7IPVNFvghiWSSah0DnFIQwNnZQ/LdP0EwuNax4T
         A55M+EnVXDrPZXG1Gw57bUGVT/GghFB57TIauZ2nuQaIiI4wHrSoGXob5xLjuA/l/C
         j1U6xOsKzYOmZCl5KHq2KPMRO4gRXBdHk9rdYPpM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty page state
Date:   Fri, 20 Nov 2020 14:35:55 +0000
Message-Id: <20201120143557.6715-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120143557.6715-1-will@kernel.org>
References: <20201120143557.6715-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
via the tlb_remove_*() functions. Consequently, the page-table modifications
performed by clear_refs_write() in response to a write to
/proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
fine when simply aging the ptes, in the case of clearing the "soft-dirty"
state we can end up with entries where pte_write() is false, yet a
writable mapping remains in the TLB.

Fix this by calling tlb_remove_tlb_entry() for each entry being
write-protected when cleating soft-dirty.

Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/proc/task_mmu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cd03ab9087b0..3308292ee5c5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1032,11 +1032,12 @@ enum clear_refs_types {
 
 struct clear_refs_private {
 	enum clear_refs_types type;
+	struct mmu_gather *tlb;
 };
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+		unsigned long addr, pte_t *pte, struct mmu_gather *tlb)
 {
 	/*
 	 * The soft-dirty tracker uses #PF-s to catch writes
@@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
+		tlb_remove_tlb_entry(tlb, pte, addr);
 	} else if (is_swap_pte(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
@@ -1060,14 +1062,14 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 }
 #else
 static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+		unsigned long addr, pte_t *pte, struct mmu_gather *tlb)
 {
 }
 #endif
 
 #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
+		unsigned long addr, pmd_t *pmdp, struct mmu_gather *tlb)
 {
 	pmd_t old, pmd = *pmdp;
 
@@ -1081,6 +1083,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 
 		pmd = pmd_wrprotect(pmd);
 		pmd = pmd_clear_soft_dirty(pmd);
+		tlb_remove_pmd_tlb_entry(tlb, pmdp, addr);
 
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
@@ -1090,7 +1093,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 }
 #else
 static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
+		unsigned long addr, pmd_t *pmdp, struct mmu_gather *tlb)
 {
 }
 #endif
@@ -1107,7 +1110,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty_pmd(vma, addr, pmd);
+			clear_soft_dirty_pmd(vma, addr, pmd, cp->tlb);
 			goto out;
 		}
 
@@ -1133,7 +1136,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ptent = *pte;
 
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
-			clear_soft_dirty(vma, addr, pte);
+			clear_soft_dirty(vma, addr, pte, cp->tlb);
 			continue;
 		}
 
@@ -1212,7 +1215,8 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	if (mm) {
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp = {
-			.type = type,
+			.type	= type,
+			.tlb	= &tlb,
 		};
 
 		if (type == CLEAR_REFS_MM_HIWATER_RSS) {
-- 
2.29.2.454.gaff20da3a2-goog

