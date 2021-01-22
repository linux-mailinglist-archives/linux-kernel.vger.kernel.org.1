Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD82FFFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhAVKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:12:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25181 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbhAVKG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:06:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DMZdK51Mgz9vBmp;
        Fri, 22 Jan 2021 11:05:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id c-VIz2ukEKYh; Fri, 22 Jan 2021 11:05:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DMZdK45B1z9vBml;
        Fri, 22 Jan 2021 11:05:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD2AB8B817;
        Fri, 22 Jan 2021 11:05:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UFV1Kc2LQUO5; Fri, 22 Jan 2021 11:05:26 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C60F8B818;
        Fri, 22 Jan 2021 11:05:26 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4648E66AAE; Fri, 22 Jan 2021 10:05:26 +0000 (UTC)
Message-Id: <274f7b5d850b98f9f265c9094590ef371df46941.1611309841.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611309841.git.christophe.leroy@csgroup.eu>
References: <cover.1611309841.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 03/14] powerpc/40x: Don't use SPRN_SPRG_SCRATCH0/1 in TLB
 miss handlers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Jan 2021 10:05:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPRN_SPRG_SCRATCH5 is used to save SPRN_PID.
SPRN_SPRG_SCRATCH6 is already available.

SPRN_PID is only 8 bits. We have r12 that contains CR.
We only need to preserve CR0, so we have space available in r12
to save PID.

Keep PID in r12 and free up SPRN_SPRG_SCRATCH5.

Then In TLB miss handlers, instead of using SPRN_SPRG_SCRATCH0 and
SPRN_SPRG_SCRATCH1, use SPRN_SPRG_SCRATCH5 and SPRN_SPRG_SCRATCH6
to avoid future conflicts with normal exception prologs.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S | 39 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 3c5577ac4dc8..283ea6fcfb81 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -249,13 +249,13 @@ _ENTRY(saved_ksp_limit)
  * load TLB entries from the page table if they exist.
  */
 	START_EXCEPTION(0x1100,	DTLBMiss)
-	mtspr	SPRN_SPRG_SCRATCH0, r10 /* Save some working registers */
-	mtspr	SPRN_SPRG_SCRATCH1, r11
+	mtspr	SPRN_SPRG_SCRATCH5, r10 /* Save some working registers */
+	mtspr	SPRN_SPRG_SCRATCH6, r11
 	mtspr	SPRN_SPRG_SCRATCH3, r12
 	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r12
 	mfspr	r9, SPRN_PID
-	mtspr	SPRN_SPRG_SCRATCH5, r9
+	rlwimi	r12, r9, 0, 0xff
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -316,13 +316,12 @@ _ENTRY(saved_ksp_limit)
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r9, SPRN_SPRG_SCRATCH5
-	mtspr	SPRN_PID, r9
-	mtcr	r12
+	mtspr	SPRN_PID, r12
+	mtcrf	0x80, r12
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH6
+	mfspr	r10, SPRN_SPRG_SCRATCH5
 	b	DataStorage
 
 /* 0x1200 - Instruction TLB Miss Exception
@@ -330,13 +329,13 @@ _ENTRY(saved_ksp_limit)
  * registers and bailout to a different point.
  */
 	START_EXCEPTION(0x1200,	ITLBMiss)
-	mtspr	SPRN_SPRG_SCRATCH0, r10	 /* Save some working registers */
-	mtspr	SPRN_SPRG_SCRATCH1, r11
+	mtspr	SPRN_SPRG_SCRATCH5, r10	 /* Save some working registers */
+	mtspr	SPRN_SPRG_SCRATCH6, r11
 	mtspr	SPRN_SPRG_SCRATCH3, r12
 	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r12
 	mfspr	r9, SPRN_PID
-	mtspr	SPRN_SPRG_SCRATCH5, r9
+	rlwimi	r12, r9, 0, 0xff
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -397,13 +396,12 @@ _ENTRY(saved_ksp_limit)
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r9, SPRN_SPRG_SCRATCH5
-	mtspr	SPRN_PID, r9
-	mtcr	r12
+	mtspr	SPRN_PID, r12
+	mtcrf	0x80, r12
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH6
+	mfspr	r10, SPRN_SPRG_SCRATCH5
 	b	InstructionAccess
 
 	EXCEPTION(0x1300, Trap_13, unknown_exception, EXC_XFER_STD)
@@ -542,13 +540,12 @@ finish_tlb_load:
 
 	/* Done...restore registers and get out of here.
 	*/
-	mfspr	r9, SPRN_SPRG_SCRATCH5
-	mtspr	SPRN_PID, r9
-	mtcr	r12
+	mtspr	SPRN_PID, r12
+	mtcrf	0x80, r12
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH6
+	mfspr	r10, SPRN_SPRG_SCRATCH5
 	rfi			/* Should sync shadow TLBs */
 	b	.		/* prevent prefetch past rfi */
 
-- 
2.25.0

