Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD542C39CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKYHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:10:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:26866 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbgKYHKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:10:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgsVd59Mxz9tyqR;
        Wed, 25 Nov 2020 08:10:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id P0Px5AYjklJa; Wed, 25 Nov 2020 08:10:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgsVd4MNyz9tyqP;
        Wed, 25 Nov 2020 08:10:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 86B388B7B7;
        Wed, 25 Nov 2020 08:10:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id K41o-R1pltbj; Wed, 25 Nov 2020 08:10:50 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41F788B7C2;
        Wed, 25 Nov 2020 08:10:50 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 235E0668BA; Wed, 25 Nov 2020 07:10:50 +0000 (UTC)
Message-Id: <7370574b49d8476878ce5480726197993cb76108.1606285014.git.christophe.leroy@csgroup.eu>
In-Reply-To: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
References: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 5/8] powerpc/603: Use SPRN_SDR1 to store the pgdir phys
 address
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 25 Nov 2020 07:10:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the 603, SDR1 is not used.

In order to free SPRN_SPRG2, use SPRN_SDR1 to store the pgdir
phys addr.

But only some bits of SDR1 can be used (0xffff01ff).
As the pgdir is 4k aligned, rotate it by 4 bits to the left.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h       |  1 -
 arch/powerpc/kernel/head_book3s_32.S | 31 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f877a576b338..a37ce826f6f6 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1203,7 +1203,6 @@
 #ifdef CONFIG_PPC_BOOK3S_32
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
-#define SPRN_SPRG_PGDIR		SPRN_SPRG2
 #define SPRN_SPRG_603_LRU	SPRN_SPRG4
 #endif
 
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 236a95d163be..51eef7b82f9c 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -457,8 +457,9 @@ InstructionTLBMiss:
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 #endif
-	mfspr	r2, SPRN_SPRG_PGDIR
+	mfspr	r2, SPRN_SDR1
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
+	rlwinm	r2, r2, 28, 0xfffff000
 #ifdef CONFIG_MODULES
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
@@ -519,8 +520,9 @@ DataLoadTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2, SPRN_SPRG_PGDIR
+	mfspr	r2, SPRN_SDR1
 	li	r1, _PAGE_PRESENT | _PAGE_ACCESSED
+	rlwinm	r2, r2, 28, 0xfffff000
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
@@ -595,8 +597,9 @@ DataStoreTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2, SPRN_SPRG_PGDIR
+	mfspr	r2, SPRN_SDR1
 	li	r1, _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT | _PAGE_ACCESSED
+	rlwinm	r2, r2, 28, 0xfffff000
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
@@ -889,9 +892,12 @@ __secondary_start:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* phys address of our thread_struct */
 	mtspr	SPRN_SPRG_THREAD,r4
+BEGIN_MMU_FTR_SECTION
 	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
 	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
-	mtspr	SPRN_SPRG_PGDIR, r4
+	rlwinm	r4, r4, 4, 0xffff01ff
+	mtspr	SPRN_SDR1, r4
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_HPTE_TABLE)
 
 	/* enable MMU and jump to start_secondary */
 	li	r4,MSR_KERNEL
@@ -931,11 +937,13 @@ load_up_mmu:
 	tlbia			/* Clear all TLB entries */
 	sync			/* wait for tlbia/tlbie to finish */
 	TLBSYNC			/* ... on all CPUs */
+BEGIN_MMU_FTR_SECTION
 	/* Load the SDR1 register (hash table base & size) */
 	lis	r6,_SDR1@ha
 	tophys(r6,r6)
 	lwz	r6,_SDR1@l(r6)
 	mtspr	SPRN_SDR1,r6
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 
 /* Load the BAT registers with the values set up by MMU_init. */
 	lis	r3,BATS@ha
@@ -991,9 +999,12 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
+BEGIN_MMU_FTR_SECTION
 	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
 	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
-	mtspr	SPRN_SPRG_PGDIR, r4
+	rlwinm	r4, r4, 4, 0xffff01ff
+	mtspr	SPRN_SDR1, r4
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_HPTE_TABLE)
 
 	/* stack */
 	lis	r1,init_thread_union@ha
@@ -1073,16 +1084,22 @@ _ENTRY(switch_mmu_context)
 	li	r0,NUM_USER_SEGMENTS
 	mtctr	r0
 
-	lwz	r4, MM_PGD(r4)
 #ifdef CONFIG_BDI_SWITCH
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is passed as second argument.
 	 */
+	lwz	r4, MM_PGD(r4)
 	lis	r5, abatron_pteptrs@ha
 	stw	r4, abatron_pteptrs@l + 0x4(r5)
+#endif
+BEGIN_MMU_FTR_SECTION
+#ifndef CONFIG_BDI_SWITCH
+	lwz	r4, MM_PGD(r4)
 #endif
 	tophys(r4, r4)
-	mtspr	SPRN_SPRG_PGDIR, r4
+	rlwinm	r4, r4, 4, 0xffff01ff
+	mtspr	SPRN_SDR1, r4
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_HPTE_TABLE)
 	li	r4,0
 	isync
 3:
-- 
2.25.0

