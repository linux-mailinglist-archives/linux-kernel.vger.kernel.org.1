Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0449A28A1D3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgJJW1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:27:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35265 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730344AbgJJSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:51:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C7pQ11p8sz9v1Jd;
        Sat, 10 Oct 2020 17:14:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IX5XROfM-CCd; Sat, 10 Oct 2020 17:14:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C7pQ06fYZz9v1JX;
        Sat, 10 Oct 2020 17:14:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC42D8B77D;
        Sat, 10 Oct 2020 17:14:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IWJld82XG3ox; Sat, 10 Oct 2020 17:14:34 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 499FF8B75B;
        Sat, 10 Oct 2020 17:14:34 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 27F01663C3; Sat, 10 Oct 2020 15:14:34 +0000 (UTC)
Message-Id: <3213af8764797becb36a4b47730df7bbc6e9b938.1602342819.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3f2386f94fada00b541be76d6bc4b6409746a72d.1602342819.git.christophe.leroy@csgroup.eu>
References: <3f2386f94fada00b541be76d6bc4b6409746a72d.1602342819.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/4] powerpc/8xx: Always fault when _PAGE_ACCESSED is not set
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 10 Oct 2020 15:14:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel expects pte_young() to work regardless of CONFIG_SWAP.

Make sure a minor fault is taken to set _PAGE_ACCESSED when it
is not already set, regardless of the selection of CONFIG_SWAP.

This adds at least 3 instructions to the TLB miss exception
handlers fast path. Following patch will reduce this overhead.

Fixes: d069cb4373fe ("powerpc/8xx: Don't touch ACCESSED when no SWAP.")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 83101c5888e3..6f3799a04121 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -202,9 +202,7 @@ SystemCall:
 
 InstructionTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP) || defined(CONFIG_HUGETLBFS)
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-#endif
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -238,11 +236,9 @@ InstructionTLBMiss:
 	rlwimi	r11, r10, 32 - 9, _PMD_PAGE_512K
 	mtspr	SPRN_MI_TWC, r11
 #endif
-#ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-7, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
-#endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 20 and 23 must be clear.
 	 * Software indicator bits 22, 24, 25, 26, and 27 must be
@@ -256,9 +252,7 @@ InstructionTLBMiss:
 
 	/* Restore registers */
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP) || defined(CONFIG_HUGETLBFS)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#endif
 	rfi
 	patch_site	0b, patch__itlbmiss_exit_1
 
@@ -268,9 +262,7 @@ InstructionTLBMiss:
 	addi	r10, r10, 1
 	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP) || defined(CONFIG_HUGETLBFS)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#endif
 	rfi
 #endif
 
@@ -316,11 +308,9 @@ DataStoreTLBMiss:
 	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
 	 * r10 = (r10 & ~PRESENT) | r11;
 	 */
-#ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-7, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
-#endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
-- 
2.25.0

