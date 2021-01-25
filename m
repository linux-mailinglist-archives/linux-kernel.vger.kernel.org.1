Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBB3036C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbhAZGpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:45:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20936 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbhAYOtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:49:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXm85JjNz9v0Gq;
        Mon, 25 Jan 2021 15:48:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hUZgnv7Ch2pW; Mon, 25 Jan 2021 15:48:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXm844zHz9v0Gn;
        Mon, 25 Jan 2021 15:48:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DF9C8B79E;
        Mon, 25 Jan 2021 15:48:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id o-diI42oB_zm; Mon, 25 Jan 2021 15:48:14 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5F918B79B;
        Mon, 25 Jan 2021 15:48:13 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DB84566AD8; Mon, 25 Jan 2021 14:48:13 +0000 (UTC)
Message-Id: <20405972e4b90444bf762189dbda22e919f13182.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 01/23] powerpc/32s: Add missing call to kuep_lock on
 syscall entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:13 +0000 (UTC)
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
index b102b40c4988..b1e36602c013 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -351,6 +351,9 @@ trace_syscall_entry_irq_off:
 
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

