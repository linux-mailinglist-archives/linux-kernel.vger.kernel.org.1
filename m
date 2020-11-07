Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9386D2AA424
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgKGJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 04:07:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30510 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgKGJHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 04:07:44 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CSrxm2xC5z9v6vC;
        Sat,  7 Nov 2020 10:07:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SBU23wXPkMUB; Sat,  7 Nov 2020 10:07:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CSrxm1HNrz9v6vB;
        Sat,  7 Nov 2020 10:07:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A6128B776;
        Sat,  7 Nov 2020 10:07:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id k0GTKzkPiJkJ; Sat,  7 Nov 2020 10:07:41 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDE1D8B75B;
        Sat,  7 Nov 2020 10:07:40 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AFC2B66868; Sat,  7 Nov 2020 09:07:40 +0000 (UTC)
Message-Id: <9e225a856a8b22e0e77587ee22ab7a2f5bca8753.1604740029.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Use relocation offset when setting early hash
 table
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        schwab@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  7 Nov 2020 09:07:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling early_hash_table(), the kernel hasn't been yet
relocated to its linking address, so data must be addressed
with relocation offset.

Add relocation offset to write into Hash in early_hash_table().

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Fixes: 69a1593abdbc ("powerpc/32s: Setup the early hash table at all time.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 5eb9eedac920..8aa7eb11754e 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -156,6 +156,7 @@ __after_mmu_off:
 	bl	initial_bats
 	bl	load_segment_registers
 BEGIN_MMU_FTR_SECTION
+	bl	reloc_offset
 	bl	early_hash_table
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 #if defined(CONFIG_BOOTX_TEXT)
@@ -932,7 +933,7 @@ early_hash_table:
 	ori	r6, r6, 3	/* 256kB table */
 	mtspr	SPRN_SDR1, r6
 	lis	r6, early_hash@h
-	lis	r3, Hash@ha
+	addis	r3, r3, Hash@ha
 	stw	r6, Hash@l(r3)
 	blr
 
-- 
2.25.0

