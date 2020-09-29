Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F8927BCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgI2GJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:09:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59036 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgI2GJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:09:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C0pqx58Ztz9tyYy;
        Tue, 29 Sep 2020 08:09:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TYSrhexQ_hrB; Tue, 29 Sep 2020 08:09:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C0pqx44jfz9tyYp;
        Tue, 29 Sep 2020 08:09:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A71878B7A0;
        Tue, 29 Sep 2020 08:09:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fSZn5-T1aOM1; Tue, 29 Sep 2020 08:09:18 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A9E18B79F;
        Tue, 29 Sep 2020 08:09:18 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 25A3665E8A; Tue, 29 Sep 2020 06:09:17 +0000 (UTC)
Message-Id: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601359702.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/7] powerpc: Remove SYNC on non 6xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Sep 2020 06:09:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYNC is usefull for Powerpc 601 only. On everything else,
SYNC is empty.

Remove it from code that is not made to run on 6xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S   | 1 -
 arch/powerpc/kernel/head_booke.h | 1 -
 arch/powerpc/kernel/misc_64.S    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 5b282d9965a5..44c9018aed1b 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -72,7 +72,6 @@ turn_on_mmu:
 	lis	r0,start_here@h
 	ori	r0,r0,start_here@l
 	mtspr	SPRN_SRR0,r0
-	SYNC
 	rfi				/* enables MMU */
 	b	.			/* prevent prefetch past rfi */
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 18f87bf9e32b..71c359d438b5 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -176,7 +176,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 #endif
 	mtspr	SPRN_SRR1,r10
 	mtspr	SPRN_SRR0,r11
-	SYNC
 	RFI				/* jump to handler, enable MMU */
 99:	b	ret_from_kernel_syscall
 .endm
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 7bb46ad98207..070465825c21 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -365,7 +365,6 @@ _GLOBAL(kexec_smp_wait)
 
 	li	r4,KEXEC_STATE_REAL_MODE
 	stb	r4,PACAKEXECSTATE(r13)
-	SYNC
 
 	b	kexec_wait
 
-- 
2.25.0

