Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF49295868
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508249AbgJVG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48566 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508231AbgJVG3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBf0kRwz9vBKk;
        Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1ig85L5yVpG2; Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBd5ySXz9vBKb;
        Thu, 22 Oct 2020 08:29:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C36DB8B805;
        Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XD9yY0SUI2oL; Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 81FAF8B769;
        Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 65E57667EF; Thu, 22 Oct 2020 06:29:30 +0000 (UTC)
Message-Id: <f1766631a9e014b6433f1a3c12c726ddfce34220.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 05/20] powerpc/32s: Use mmu_has_feature(MMU_FTR_HPTE_TABLE)
 instead of checking Hash var
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have an early hash table on hash MMU, so no need to check
Hash var to know if the Hash table is set of not.

Use mmu_has_feature(MMU_FTR_HPTE_TABLE) instead. This will allow
optimisation via jump_label.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c |  2 +-
 arch/powerpc/mm/book3s32/tlb.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index eceb55c12fe9..6612d2a9a1ff 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -308,7 +308,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea)
 {
 	pmd_t *pmd;
 
-	if (!Hash)
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
 		return;
 	pmd = pmd_off(mm, ea);
 	if (!pmd_none(*pmd))
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index b6c7427daa6f..ae5dbba95805 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -36,7 +36,7 @@ void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
 {
 	unsigned long ptephys;
 
-	if (Hash) {
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		ptephys = __pa(ptep) & PAGE_MASK;
 		flush_hash_pages(mm->context.id, addr, ptephys, 1);
 	}
@@ -49,7 +49,7 @@ EXPORT_SYMBOL(flush_hash_entry);
  */
 void tlb_flush(struct mmu_gather *tlb)
 {
-	if (!Hash) {
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		/*
 		 * 603 needs to flush the whole TLB here since
 		 * it doesn't use a hash table.
@@ -80,7 +80,7 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
 	unsigned int ctx = mm->context.id;
 
 	start &= PAGE_MASK;
-	if (!Hash) {
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		if (end - start <= PAGE_SIZE)
 			_tlbie(start);
 		else
@@ -122,7 +122,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
 
-	if (!Hash) {
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		_tlbia();
 		return;
 	}
@@ -143,7 +143,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 	struct mm_struct *mm;
 	pmd_t *pmd;
 
-	if (!Hash) {
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		_tlbie(vmaddr);
 		return;
 	}
-- 
2.25.0

