Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F982E0AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgLVN3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:29:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:46103 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgLVN3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:29:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D0cc217Wtz9v15d;
        Tue, 22 Dec 2020 14:28:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iixZzDL3wcdx; Tue, 22 Dec 2020 14:28:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D0cc202Gjz9v15c;
        Tue, 22 Dec 2020 14:28:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 562728B81B;
        Tue, 22 Dec 2020 14:28:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mAu6oID8eh2Q; Tue, 22 Dec 2020 14:28:35 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 094398B812;
        Tue, 22 Dec 2020 14:28:35 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DCCAF66969; Tue, 22 Dec 2020 13:28:34 +0000 (UTC)
Message-Id: <7d896a74e638f60dde8fd6d29ed928149b8c121f.1608641533.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1608641532.git.christophe.leroy@csgroup.eu>
References: <cover.1608641532.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 12/15] powerpc/32: Remove msr argument in
 EXC_XFER_TEMPLATE() on 6xx/8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Dec 2020 13:28:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only MSR_KERNEL is used as msr in EXC_XFER_TEMPLATE(), no need
to make it an argument.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_6xx_8xx.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_6xx_8xx.h b/arch/powerpc/kernel/head_6xx_8xx.h
index 2536f0a660af..11b608b6f4b7 100644
--- a/arch/powerpc/kernel/head_6xx_8xx.h
+++ b/arch/powerpc/kernel/head_6xx_8xx.h
@@ -194,21 +194,19 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
 	xfer(n, hdlr)
 
-#define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)		\
+#define EXC_XFER_TEMPLATE(hdlr, trap, tfer, ret)		\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	LOAD_REG_IMMEDIATE(r10, msr);				\
+	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL);			\
 	bl	tfer;						\
 	.long	hdlr;						\
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
-- 
2.25.0

