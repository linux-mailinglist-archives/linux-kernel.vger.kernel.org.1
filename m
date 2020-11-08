Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473D2AAC5C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgKHQ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:57:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23334 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHQ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:57:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CTgKS3v2Jz9tyqS;
        Sun,  8 Nov 2020 17:57:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pzxtFaeNsvgG; Sun,  8 Nov 2020 17:57:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CTgKS2z3vz9tyqR;
        Sun,  8 Nov 2020 17:57:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 257688B77F;
        Sun,  8 Nov 2020 17:57:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cHCClJdZFpd2; Sun,  8 Nov 2020 17:57:36 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E50FE8B75B;
        Sun,  8 Nov 2020 17:57:35 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AB0C766855; Sun,  8 Nov 2020 16:57:35 +0000 (UTC)
Message-Id: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/3] powerpc/64s: Replace RFI by RFI_TO_KERNEL and remove
 RFI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  8 Nov 2020 16:57:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In head_64.S, we have two places using RFI to return to
kernel. Use RFI_TO_KERNEL instead.

They are the two only places using RFI on book3s/64, so
the RFI macro can go away.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc_asm.h | 1 -
 arch/powerpc/kernel/head_64.S      | 9 +++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 511786f0e40d..bedf3eb52ebc 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -495,7 +495,6 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
-#define RFI		rfid
 #define MTMSRD(r)	mtmsrd	r
 #define MTMSR_EERI(reg)	mtmsrd	reg,1
 #else
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1510b2a56669..ecf9a88988ff 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -41,6 +41,11 @@
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
 #include <asm/feature-fixups.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/exception-64s.h>
+#else
+#include <asm/exception-64e.h>
+#endif
 
 /* The physical memory is laid out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
@@ -829,7 +834,7 @@ __secondary_start:
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	RFI
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 /* 
@@ -966,7 +971,7 @@ start_here_multiplatform:
 	ld	r4,PACAKMSR(r13)
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	RFI
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 	/* This is where all platforms converge execution */
-- 
2.25.0

