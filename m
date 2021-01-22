Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB3300005
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbhAVKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:18:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:24498 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbhAVKJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:09:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DMZdX4QdPz9vBnH;
        Fri, 22 Jan 2021 11:05:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QsV3_9iY41fq; Fri, 22 Jan 2021 11:05:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DMZdX3g8Wz9vBml;
        Fri, 22 Jan 2021 11:05:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A8ED8B818;
        Fri, 22 Jan 2021 11:05:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9taSRjNp2N1W; Fri, 22 Jan 2021 11:05:37 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 396778B817;
        Fri, 22 Jan 2021 11:05:37 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1306366AAE; Fri, 22 Jan 2021 10:05:37 +0000 (UTC)
Message-Id: <db8509f11903afc733668a4e6b3ae8c565af1ff9.1611309841.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611309841.git.christophe.leroy@csgroup.eu>
References: <cover.1611309841.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 13/14] powerpc/32: Remove msr argument in
 EXC_XFER_TEMPLATE()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Jan 2021 10:05:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msr argument is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h  | 8 +++-----
 arch/powerpc/kernel/head_40x.S | 5 +----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 7209e63db366..98ed5b928642 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -213,7 +213,7 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
 	xfer(n, hdlr)
 
-#define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)		\
+#define EXC_XFER_TEMPLATE(hdlr, trap, tfer, ret)		\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
 	bl	tfer;						\
@@ -221,12 +221,10 @@
 	.long	ret
 
 #define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, transfer_to_handler_full,	\
-			  ret_from_except_full)
+	EXC_XFER_TEMPLATE(hdlr, n, transfer_to_handler_full, ret_from_except_full)
 
 #define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, transfer_to_handler, \
-			  ret_from_except)
+	EXC_XFER_TEMPLATE(hdlr, n + 1, transfer_to_handler, ret_from_except)
 
 .macro vmap_stack_overflow_exception
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 96ec800ebf7f..8cec630cccab 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -184,8 +184,7 @@ _ENTRY(saved_ksp_limit)
 	START_EXCEPTION(n, label);				\
 	CRITICAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  crit_transfer_to_handler, ret_from_crit_exc)
+	EXC_XFER_TEMPLATE(hdlr, n+2, crit_transfer_to_handler, ret_from_crit_exc)
 
 /*
  * 0x0100 - Critical Interrupt Exception
@@ -495,7 +494,6 @@ _ENTRY(saved_ksp_limit)
 2:	mfspr	r4,SPRN_DBSR
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
-		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 		crit_transfer_to_handler, ret_from_crit_exc)
 
 	/* Programmable Interval Timer (PIT) Exception. (from 0x1000) */
@@ -517,7 +515,6 @@ WDTException:
 	CRITICAL_EXCEPTION_PROLOG;
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	EXC_XFER_TEMPLATE(WatchdogException, 0x1020+2,
-	                  (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),
 			  crit_transfer_to_handler, ret_from_crit_exc)
 
 /* Other PowerPC processors, namely those derived from the 6xx-series
-- 
2.25.0

