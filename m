Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADF2C3170
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgKXTv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:51:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:41383 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgKXTv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:51:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgZRJ2lK7z9v0DN;
        Tue, 24 Nov 2020 20:51:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0zthhqvlE51a; Tue, 24 Nov 2020 20:51:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgZRH63W5z9v0DM;
        Tue, 24 Nov 2020 20:51:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B32088B7B7;
        Tue, 24 Nov 2020 20:51:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QBHhHxe0qopc; Tue, 24 Nov 2020 20:51:55 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7395C8B7AF;
        Tue, 24 Nov 2020 20:51:55 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4AFB66688D; Tue, 24 Nov 2020 19:51:55 +0000 (UTC)
Message-Id: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/3] powerpc/32s: Remove unused counters incremented by
 create_hpte()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 19:51:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

primary_pteg_full and htab_hash_searches are not used.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/hash_low.S | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 9a56ba4f68f2..f964fd34dad9 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -359,11 +359,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	beq+	10f			/* no PTE: go look for an empty slot */
 	tlbie	r4
 
-	lis	r4, (htab_hash_searches - PAGE_OFFSET)@ha
-	lwz	r6, (htab_hash_searches - PAGE_OFFSET)@l(r4)
-	addi	r6,r6,1			/* count how many searches we do */
-	stw	r6, (htab_hash_searches - PAGE_OFFSET)@l(r4)
-
 	/* Search the primary PTEG for a PTE whose 1st (d)word matches r5 */
 	mtctr	r0
 	addi	r4,r3,-HPTE_SIZE
@@ -393,12 +388,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
 	beq+	.Lfound_empty
 
-	/* update counter of times that the primary PTEG is full */
-	lis	r4, (primary_pteg_full - PAGE_OFFSET)@ha
-	lwz	r6, (primary_pteg_full - PAGE_OFFSET)@l(r4)
-	addi	r6,r6,1
-	stw	r6, (primary_pteg_full - PAGE_OFFSET)@l(r4)
-
 	patch_site	0f, patch__hash_page_C
 	/* Search the secondary PTEG for an empty slot */
 	ori	r5,r5,PTE_H		/* set H (secondary hash) bit */
@@ -491,10 +480,6 @@ _ASM_NOKPROBE_SYMBOL(create_hpte)
 	.align	2
 next_slot:
 	.space	4
-primary_pteg_full:
-	.space	4
-htab_hash_searches:
-	.space	4
 	.previous
 
 /*
-- 
2.25.0

