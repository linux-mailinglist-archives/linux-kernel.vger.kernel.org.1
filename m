Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF05428A1D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgJJW2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:28:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48803 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbgJJSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:51:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C7pPy6461z9v1JZ;
        Sat, 10 Oct 2020 17:14:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bnvnQWrj8ybE; Sat, 10 Oct 2020 17:14:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C7pPx6BCSz9v1JX;
        Sat, 10 Oct 2020 17:14:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F3668B77D;
        Sat, 10 Oct 2020 17:14:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MAVwyHm4oxjv; Sat, 10 Oct 2020 17:14:31 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 225E08B75B;
        Sat, 10 Oct 2020 17:14:31 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 005DF663C3; Sat, 10 Oct 2020 15:14:30 +0000 (UTC)
Message-Id: <a44367744de54e2315b2f1a8cbbd7f88488072e0.1602342806.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/603: Always fault when _PAGE_ACCESSED is not set
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 10 Oct 2020 15:14:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel expects pte_young() to work regardless of CONFIG_SWAP.

Make sure a minor fault is taken to set _PAGE_ACCESSED when it
is not already set, regardless of the selection of CONFIG_SWAP.

Fixes: 84de6ab0e904 ("powerpc/603: don't handle PAGE_ACCESSED in TLB miss handlers.")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 5eb9eedac920..2aa16d5368e1 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -457,11 +457,7 @@ InstructionTLBMiss:
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SPRG_PGDIR
-#ifdef CONFIG_SWAP
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
-#else
-	li	r1,_PAGE_PRESENT | _PAGE_EXEC
-#endif
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
@@ -523,11 +519,7 @@ DataLoadTLBMiss:
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
-#ifdef CONFIG_SWAP
 	li	r1, _PAGE_PRESENT | _PAGE_ACCESSED
-#else
-	li	r1, _PAGE_PRESENT
-#endif
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
@@ -603,11 +595,7 @@ DataStoreTLBMiss:
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
-#ifdef CONFIG_SWAP
 	li	r1, _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT | _PAGE_ACCESSED
-#else
-	li	r1, _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT
-#endif
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
-- 
2.25.0

