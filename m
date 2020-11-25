Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7307D2C39C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKYHKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:10:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57918 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbgKYHKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:10:52 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgsVd1b6Fz9typm;
        Wed, 25 Nov 2020 08:10:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7vg6gIYlPopL; Wed, 25 Nov 2020 08:10:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgsVd0V1jz9tynD;
        Wed, 25 Nov 2020 08:10:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D931F8B7B7;
        Wed, 25 Nov 2020 08:10:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id I5zEMI5S4Eu7; Wed, 25 Nov 2020 08:10:49 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DA358B7C2;
        Wed, 25 Nov 2020 08:10:49 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 1CCD0668BA; Wed, 25 Nov 2020 07:10:49 +0000 (UTC)
Message-Id: <4adca19b7120cdf619956768ed09e74fc6a558f3.1606285014.git.christophe.leroy@csgroup.eu>
In-Reply-To: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
References: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/8] powerpc/32s: Don't use SPRN_SPRG_PGDIR in hash_page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 25 Nov 2020 07:10:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPRN_SPRG_PGDIR is there mainly to speedup SW TLB miss handlers
for powerpc 603.

We need to free SPRN_SPRG2 to reduce the mess with CONFIG_VMAP_STACK.

In hash_page(), reading PGDIR from thread_struct will be in the noise
performance wise.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/hash_low.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 48415c857d80..aca353d1c5f4 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -65,13 +65,14 @@ _GLOBAL(hash_page)
 	/* Get PTE (linux-style) and check access */
 	lis	r0, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r4,r0
+	mfspr	r8,SPRN_SPRG_THREAD	/* current task's THREAD (phys) */
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
-	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
+	lwz	r5,PGDIR(r8)		/* virt page-table root */
 	blt+	112f			/* assume user more likely */
-	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
-	addi	r5 ,r5 ,(swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
+	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
+	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
 	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
-112:
+112:	tophys(r5, r5)
 #ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
 	lwz	r8,0(r5)		/* get pmd entry */
-- 
2.25.0

