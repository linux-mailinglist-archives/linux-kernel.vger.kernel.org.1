Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05E23036CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbhAZGr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:47:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31976 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbhAYOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:51:10 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmQ2xpZz9v0Gy;
        Mon, 25 Jan 2021 15:48:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3YKBn_9_BH9K; Mon, 25 Jan 2021 15:48:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmQ2CX7z9v0Gh;
        Mon, 25 Jan 2021 15:48:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 712048B79E;
        Mon, 25 Jan 2021 15:48:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G3FepdeeI2Zr; Mon, 25 Jan 2021 15:48:27 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CBA98B79B;
        Mon, 25 Jan 2021 15:48:27 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 419C966AD8; Mon, 25 Jan 2021 14:48:27 +0000 (UTC)
Message-Id: <5d375bea8f519924e110842f6b0d05e83cd04470.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 14/23] powerpc/syscall: Save r3 in regs->orig_r3
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save r3 in regs->orig_r3 in system_call_exception()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_64.S | 1 -
 arch/powerpc/kernel/syscall.c  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index aa1af139d947..a562a4240aa6 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -278,7 +278,6 @@ END_BTB_FLUSH_SECTION
 	std	r10,_LINK(r1)
 	std	r11,_TRAP(r1)
 	std	r12,_CCR(r1)
-	std	r3,ORIG_GPR3(r1)
 	addi	r10,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r10)		/* "regshere" marker */
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index cb415170b8f2..b66cfcbcb755 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -29,6 +29,8 @@ notrace long system_call_exception(long r3, long r4, long r5,
 {
 	syscall_fn f;
 
+	regs->orig_gpr3 = r3;
+
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
 		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
 
-- 
2.25.0

