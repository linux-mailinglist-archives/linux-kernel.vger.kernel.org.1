Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D929C2C39CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgKYHKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:10:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57918 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbgKYHKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:10:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgsVg5Stcz9tyTJ;
        Wed, 25 Nov 2020 08:10:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DNPOUnhlDBEY; Wed, 25 Nov 2020 08:10:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgsVg4dRsz9v0Dd;
        Wed, 25 Nov 2020 08:10:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82C4E8B7C2;
        Wed, 25 Nov 2020 08:10:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Sb08Kzt0gnqP; Wed, 25 Nov 2020 08:10:52 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 525338B7B7;
        Wed, 25 Nov 2020 08:10:52 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 325EC668BA; Wed, 25 Nov 2020 07:10:52 +0000 (UTC)
Message-Id: <f9f8df2a2be93568768ef1ac793639f7914cf103.1606285014.git.christophe.leroy@csgroup.eu>
In-Reply-To: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
References: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 7/8] powerpc/32s: Use SPRN_SPRG_SCRATCH2 in DSI prolog
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 25 Nov 2020 07:10:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPRN_SPRG_SCRATCH2 as an alternative scratch register in
the early part of DSI prolog in order to avoid clobbering
SPRN_SPRG_SCRATCH0/1 used by other prologs.

The 603 doesn't like a jump from DataLoadTLBMiss to the 10 nops
that are now in the beginning of DSI exception as a result of
the feature section. To workaround this, add a jump as alternative.
It also avoids fetching 10 nops for nothing.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h       |  1 +
 arch/powerpc/kernel/head_book3s_32.S | 24 ++++++++----------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a37ce826f6f6..acd334ee3936 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1203,6 +1203,7 @@
 #ifdef CONFIG_PPC_BOOK3S_32
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
+#define SPRN_SPRG_SCRATCH2	SPRN_SPRG2
 #define SPRN_SPRG_603_LRU	SPRN_SPRG4
 #endif
 
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 51eef7b82f9c..22d670263222 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -288,9 +288,9 @@ MachineCheck:
 	DO_KVM  0x300
 DataAccess:
 #ifdef CONFIG_VMAP_STACK
-	mtspr	SPRN_SPRG_SCRATCH0,r10
-	mfspr	r10, SPRN_SPRG_THREAD
 BEGIN_MMU_FTR_SECTION
+	mtspr	SPRN_SPRG_SCRATCH2,r10
+	mfspr	r10, SPRN_SPRG_THREAD
 	stw	r11, THR11(r10)
 	mfspr	r10, SPRN_DSISR
 	mfcr	r11
@@ -304,19 +304,11 @@ BEGIN_MMU_FTR_SECTION
 .Lhash_page_dsi_cont:
 	mtcr	r11
 	lwz	r11, THR11(r10)
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
-	mtspr	SPRN_SPRG_SCRATCH1,r11
-	mfspr	r11, SPRN_DAR
-	stw	r11, DAR(r10)
-	mfspr	r11, SPRN_DSISR
-	stw	r11, DSISR(r10)
-	mfspr	r11, SPRN_SRR0
-	stw	r11, SRR0(r10)
-	mfspr	r11, SPRN_SRR1		/* check whether user or kernel */
-	stw	r11, SRR1(r10)
-	mfcr	r10
-	andi.	r11, r11, MSR_PR
-
+	mfspr	r10, SPRN_SPRG_SCRATCH2
+MMU_FTR_SECTION_ELSE
+	b	1f
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
+1:	EXCEPTION_PROLOG_0 handle_dar_dsisr=1
 	EXCEPTION_PROLOG_1
 	b	handle_page_fault_tramp_1
 #else	/* CONFIG_VMAP_STACK */
@@ -760,7 +752,7 @@ fast_hash_page_return:
 	/* DSI */
 	mtcr	r11
 	lwz	r11, THR11(r10)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r10, SPRN_SPRG_SCRATCH2
 	RFI
 
 1:	/* ISI */
-- 
2.25.0

