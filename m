Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6073036CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbhAZGow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:44:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13033 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbhAYOtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:49:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmC6PMdz9v0Gr;
        Mon, 25 Jan 2021 15:48:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uvQYM7EDjgEU; Mon, 25 Jan 2021 15:48:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmC5cGzz9v0Gh;
        Mon, 25 Jan 2021 15:48:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A3668B79E;
        Mon, 25 Jan 2021 15:48:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Wiqam-I718rs; Mon, 25 Jan 2021 15:48:17 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 055C28B79B;
        Mon, 25 Jan 2021 15:48:17 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EEE5566AD8; Mon, 25 Jan 2021 14:48:16 +0000 (UTC)
Message-Id: <a5a5baa72c9126fa3ab88d20e7bbbb1b45e3d03c.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 04/23] powerpc/32: Reorder instructions to avoid using CTR
 in syscall entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are using rfi instead of mtmsr to reactivate MMU, it is
possible to reorder instructions and avoid the need to use CTR for
stashing SRR0.

null_syscall on 8xx is reduced by 3 cycles (283 => 280 cycles).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 4029c51dce5d..24dc326e0d56 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -116,30 +116,28 @@
 .endm
 
 .macro SYSCALL_ENTRY trapno
-	mfspr	r12,SPRN_SPRG_THREAD
 	mfspr	r9, SPRN_SRR1
-	mfspr	r11, SPRN_SRR0
-	mtctr	r11
+	mfspr	r10, SPRN_SRR0
 	andi.	r11, r9, MSR_PR
+	beq-	99f
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL)		/* can take exceptions */
+	lis	r12, 1f@h
+	ori	r12, r12, 1f@l
+	mtspr	SPRN_SRR1, r11
+	mtspr	SPRN_SRR0, r12
+	mfspr	r12,SPRN_SPRG_THREAD
 	mr	r11, r1
 	lwz	r1,TASK_STACK-THREAD(r12)
-	beq-	99f
+	tovirt(r12, r12)
 	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
-	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL)		/* can take exceptions */
-	mtspr	SPRN_SRR1, r10
-	lis	r10, 1f@h
-	ori	r10, r10, 1f@l
-	mtspr	SPRN_SRR0, r10
 	rfi
 1:
-	tovirt(r12, r12)
 	stw	r11,GPR1(r1)
 	stw	r11,0(r1)
 	mr	r11, r1
+	stw	r10,_NIP(r11)
 	mflr	r10
 	stw	r10, _LINK(r11)
-	mfctr	r10
-	stw	r10,_NIP(r11)
 	mfcr	r10
 	rlwinm	r10,r10,0,4,2	/* Clear SO bit in CR */
 	stw	r10,_CCR(r11)		/* save registers */
-- 
2.25.0

