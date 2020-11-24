Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCA92C2B32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbgKXPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:25:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55509 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389429AbgKXPZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:25:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgSWD2v3wz9v0dL;
        Tue, 24 Nov 2020 16:24:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Pe1d7pY7tGvq; Tue, 24 Nov 2020 16:24:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSWD16ZDz9v0d5;
        Tue, 24 Nov 2020 16:24:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B55918B7B3;
        Tue, 24 Nov 2020 16:24:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Tx8D97hzSxG6; Tue, 24 Nov 2020 16:24:57 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8417C8B7AF;
        Tue, 24 Nov 2020 16:24:57 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5D4B3668E2; Tue, 24 Nov 2020 15:24:57 +0000 (UTC)
Message-Id: <abc78e8e9577d473691ebb9996c6413b37bfd9ca.1606231483.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/6] powerpc/8xx: Use SPRN_SPRG_SCRATCH2 in ITLB miss
 exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 15:24:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to re-enable MMU earlier, ensure ITLB miss exception
cannot clobber SPRN_SPRG_SCRATCH0 and SPRN_SPRG_SCRATCH1.
Do so by using SPRN_SPRG_SCRATCH2 and SPRN_M_TW instead, like
the DTLB miss exception.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 12 ++++++------
 arch/powerpc/perf/8xx-pmu.c    |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 558c8e615ef9..45239b06b6ce 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -190,8 +190,8 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
+	mtspr	SPRN_SPRG_SCRATCH2, r10
+	mtspr	SPRN_M_TW, r11
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
@@ -230,8 +230,8 @@ InstructionTLBMiss:
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
+0:	mfspr	r10, SPRN_SPRG_SCRATCH2
+	mfspr	r11, SPRN_M_TW
 	rfi
 	patch_site	0b, patch__itlbmiss_exit_1
 
@@ -240,8 +240,8 @@ InstructionTLBMiss:
 0:	lwz	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	addi	r10, r10, 1
 	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_SPRG_SCRATCH2
+	mfspr	r11, SPRN_M_TW
 	rfi
 #endif
 
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index e53c3c161257..02db58c7427a 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -165,9 +165,9 @@ static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 		break;
 	case PERF_8xx_ID_ITLB_LOAD_MISS:
 		if (atomic_dec_return(&itlb_miss_ref) == 0) {
-			/* mfspr r10, SPRN_SPRG_SCRATCH0 */
+			/* mfspr r10, SPRN_SPRG_SCRATCH2 */
 			struct ppc_inst insn = ppc_inst(PPC_INST_MFSPR | __PPC_RS(R10) |
-					    __PPC_SPR(SPRN_SPRG_SCRATCH0));
+					    __PPC_SPR(SPRN_SPRG_SCRATCH2));
 
 			patch_instruction_site(&patch__itlbmiss_exit_1, insn);
 		}
-- 
2.25.0

