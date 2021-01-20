Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191452FCB90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbhATHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:34:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28937 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbhATHeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:34:50 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DLHMW4d1hz9ty4P;
        Wed, 20 Jan 2021 08:33:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UAJ6r1GAnIXX; Wed, 20 Jan 2021 08:33:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DLHMW386rz9txxS;
        Wed, 20 Jan 2021 08:33:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C5BA8B7E1;
        Wed, 20 Jan 2021 08:34:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GQhUCla9uc3E; Wed, 20 Jan 2021 08:34:00 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F01198B7DF;
        Wed, 20 Jan 2021 08:33:59 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DCECB66A64; Wed, 20 Jan 2021 07:33:59 +0000 (UTC)
Message-Id: <00e462bd8b271bed0fec62dc9b25ffd4e0ec19cf.1611128021.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/32s: Add missing call to kuep_lock on syscall
 entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Jan 2021 07:33:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace Execution protection and fast syscall entry were implemented
independently from each other and were both merged in kernel 5.2,
leading to syscall entry missing userspace execution protection.

On syscall entry, execution of user space memory must be
locked in the same way as on exception entry.

Fixes: b86fb88855ea ("powerpc/32: implement fast entry for syscalls on non BOOKE")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 1c9b0ccc2172..9bc4e7dd0bee 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -356,6 +356,9 @@ trace_syscall_entry_irq_off:
 
 	.globl	transfer_to_syscall
 transfer_to_syscall:
+#ifdef CONFIG_PPC_BOOK3S_32
+	kuep_lock r11, r12
+#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	andi.	r12,r9,MSR_EE
 	beq-	trace_syscall_entry_irq_off
-- 
2.25.0

