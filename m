Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7713026B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbhAYPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:04:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:11163 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbhAYOvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:51:40 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmX4r61z9v0Hr;
        Mon, 25 Jan 2021 15:48:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1SMbAHnHO53s; Mon, 25 Jan 2021 15:48:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmX450Yz9v0Hk;
        Mon, 25 Jan 2021 15:48:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 111F18B79F;
        Mon, 25 Jan 2021 15:48:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C3W8oAuRvqbX; Mon, 25 Jan 2021 15:48:33 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8374B8B79E;
        Mon, 25 Jan 2021 15:48:33 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7749B66AD8; Mon, 25 Jan 2021 14:48:33 +0000 (UTC)
Message-Id: <f02af988a86f7e83b6492df7c4fa1b53bcd1919b.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 20/23] powerpc/syscall: Do not check unsupported scv vector
 on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only PPC64 has scv. No need to check the 0x7ff0 trap on PPC32.

And ignore the scv parameter in syscall_exit_prepare (Save 14 cycles
346 => 332 cycles)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 1 -
 arch/powerpc/kernel/syscall.c  | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9922a04650f7..6ae9c7bcb06c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -343,7 +343,6 @@ transfer_to_syscall:
 
 ret_from_syscall:
 	addi    r4,r1,STACK_FRAME_OVERHEAD
-	li	r5,0
 	bl	syscall_exit_prepare
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* If the process has its own DBCR0 value, load it up.  The internal
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 476909b11051..30f8a397a522 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -86,7 +86,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	local_irq_enable();
 
 	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
-		if (unlikely(regs->trap == 0x7ff0)) {
+		if (IS_ENABLED(CONFIG_PPC64) && unlikely(regs->trap == 0x7ff0)) {
 			/* Unsupported scv vector */
 			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 			return regs->gpr[3];
@@ -109,7 +109,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 		r8 = regs->gpr[8];
 
 	} else if (unlikely(r0 >= NR_syscalls)) {
-		if (unlikely(regs->trap == 0x7ff0)) {
+		if (IS_ENABLED(CONFIG_PPC64) && unlikely(regs->trap == 0x7ff0)) {
 			/* Unsupported scv vector */
 			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 			return regs->gpr[3];
@@ -187,6 +187,9 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	unsigned long ti_flags;
 	unsigned long ret = 0;
 
+	if (IS_ENABLED(CONFIG_PPC32))
+		scv = 0;
+
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
 	kuap_check();
-- 
2.25.0

