Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33E22E0AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgLVNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:30:09 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55670 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgLVNaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:30:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D0cc52Yqqz9v15g;
        Tue, 22 Dec 2020 14:28:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ULguZ_gMn2dh; Tue, 22 Dec 2020 14:28:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D0cc51m1Tz9v15W;
        Tue, 22 Dec 2020 14:28:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EAAC8B81B;
        Tue, 22 Dec 2020 14:28:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kcSMPVTbeq48; Tue, 22 Dec 2020 14:28:38 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BBEC8B812;
        Tue, 22 Dec 2020 14:28:38 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EE51366969; Tue, 22 Dec 2020 13:28:37 +0000 (UTC)
Message-Id: <bcafba5b80aee844feb72bb3acd02db9a2f3f3e2.1608641533.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1608641532.git.christophe.leroy@csgroup.eu>
References: <cover.1608641532.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 15/15] powerpc/32: Use r11 to store DSISR in prolog
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Dec 2020 13:28:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have r11 available. Use it to avoid reloading DSISR
from the stack when needed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_6xx_8xx.h   | 4 ++--
 arch/powerpc/kernel/head_8xx.S       | 3 +--
 arch/powerpc/kernel/head_book3s_32.S | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_6xx_8xx.h b/arch/powerpc/kernel/head_6xx_8xx.h
index 5a90bafee536..7116162dae9d 100644
--- a/arch/powerpc/kernel/head_6xx_8xx.h
+++ b/arch/powerpc/kernel/head_6xx_8xx.h
@@ -72,9 +72,9 @@
 	tovirt(r12, r12)
 	.if	\handle_dar_dsisr
 	lwz	r10, DAR(r12)
+	lwz	r11, DSISR(r12)
 	stw	r10, _DAR(r1)
-	lwz	r10, DSISR(r12)
-	stw	r10, _DSISR(r1)
+	stw	r11, _DSISR(r1)
 	.endif
 	lwz	r9, SRR1(r12)
 	lwz	r12, SRR0(r12)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 7a078b26d24c..7e9cbd64efd9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -335,9 +335,8 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	mtspr	SPRN_DAR, r11	/* Tag DAR, to be used in DTLB Error */
 	EXCEPTION_PROLOG_1
 	EXCEPTION_PROLOG_2 handle_dar_dsisr=1
+	andis.	r10,r11,DSISR_NOHPTE@h
 	lwz	r4, _DAR(r1)
-	lwz	r5, _DSISR(r1)
-	andis.	r10,r5,DSISR_NOHPTE@h
 	beq+	.Ldtlbie
 	tlbie	r4
 .Ldtlbie:
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 40ee63af84f2..c0db295734f5 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -653,8 +653,7 @@ alignment_exception_tramp:
 
 handle_page_fault_tramp_1:
 	EXCEPTION_PROLOG_2 handle_dar_dsisr=1
-	lwz	r5, _DSISR(r1)
-	andis.	r0, r5, DSISR_DABRMATCH@h
+	andis.	r0, r11, DSISR_DABRMATCH@h
 	bne-	1f
 	EXC_XFER_LITE(0x300, handle_page_fault)
 1:	EXC_XFER_STD(0x300, do_break)
-- 
2.25.0

