Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15DB200E67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbgFSPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 11:07:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15598 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391519AbgFSPHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:07:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbN5PLxz9v09r;
        Fri, 19 Jun 2020 17:06:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IlWeNrq_uh2L; Fri, 19 Jun 2020 17:06:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbN4dtTz9v09j;
        Fri, 19 Jun 2020 17:06:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCB0F8B868;
        Fri, 19 Jun 2020 17:06:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UcSE2_4GBNY0; Fri, 19 Jun 2020 17:06:58 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DC558B879;
        Fri, 19 Jun 2020 17:06:58 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4F55365B16; Fri, 19 Jun 2020 15:06:58 +0000 (UTC)
Message-Id: <a98cc6787ce0fd0df8a9b01d3187b0e6f30e8755.1592578278.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592578278.git.christophe.leroy@csgroup.eu>
References: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 7/8] powerpc/32s: Kernel space starts at TASK_SIZE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel space starts at TASK_SIZE. Select kernel page table
when address is over TASK_SIZE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.S       | 12 ++++++------
 arch/powerpc/mm/book3s32/hash_low.S |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 705c042309d8..bbef6ce8322b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -474,7 +474,7 @@ InstructionTLBMiss:
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
-	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SPRG_PGDIR
@@ -484,7 +484,7 @@ InstructionTLBMiss:
 	li	r1,_PAGE_PRESENT | _PAGE_EXEC
 #endif
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
-	bge-	112f
+	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 #endif
@@ -541,7 +541,7 @@ DataLoadTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
-	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
 #ifdef CONFIG_SWAP
@@ -549,7 +549,7 @@ DataLoadTLBMiss:
 #else
 	li	r1, _PAGE_PRESENT
 #endif
-	bge-	112f
+	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
@@ -621,7 +621,7 @@ DataStoreTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
-	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
 #ifdef CONFIG_SWAP
@@ -629,7 +629,7 @@ DataStoreTLBMiss:
 #else
 	li	r1, _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT
 #endif
-	bge-	112f
+	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 923ad8f374eb..1690d369688b 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -62,7 +62,7 @@ _GLOBAL(hash_page)
 	isync
 #endif
 	/* Get PTE (linux-style) and check access */
-	lis	r0,KERNELBASE@h		/* check if kernel address */
+	lis	r0, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r4,r0
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
 	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
-- 
2.25.0

