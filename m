Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC5295858
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508269AbgJVG3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20796 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508239AbgJVG3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBg00nxz9vBKq;
        Thu, 22 Oct 2020 08:29:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OEctDQ2GCC3Y; Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBf681Hz9vBKl;
        Thu, 22 Oct 2020 08:29:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C02DC8B805;
        Thu, 22 Oct 2020 08:29:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vSlVrgO5QCNW; Thu, 22 Oct 2020 08:29:31 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 880AC8B769;
        Thu, 22 Oct 2020 08:29:31 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6C915667EF; Thu, 22 Oct 2020 06:29:31 +0000 (UTC)
Message-Id: <786c82a89cdfdaabb32b72a44f7c312fa81d192b.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 06/20] powerpc/32s: Make Hash var static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash var is used only locally in mmu.c now.

No need to set it in head_32.S anymore.

Make it static and initialises it to the early hash table.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 5 -----
 arch/powerpc/mm/book3s32/mmu.c       | 2 +-
 arch/powerpc/mm/mmu_decl.h           | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 5eb9eedac920..620af1dda70c 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -155,9 +155,7 @@ __after_mmu_off:
 
 	bl	initial_bats
 	bl	load_segment_registers
-BEGIN_MMU_FTR_SECTION
 	bl	early_hash_table
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 #if defined(CONFIG_BOOTX_TEXT)
 	bl	setup_disp_bat
 #endif
@@ -931,9 +929,6 @@ early_hash_table:
 	lis	r6, early_hash - PAGE_OFFSET@h
 	ori	r6, r6, 3	/* 256kB table */
 	mtspr	SPRN_SDR1, r6
-	lis	r6, early_hash@h
-	lis	r3, Hash@ha
-	stw	r6, Hash@l(r3)
 	blr
 
 load_up_mmu:
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 6612d2a9a1ff..c0c0f2a50f86 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -33,7 +33,7 @@
 
 u8 __initdata early_hash[SZ_256K] __aligned(SZ_256K) = {0};
 
-struct hash_pte *Hash;
+static struct hash_pte *Hash = (struct hash_pte *)early_hash;
 static unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 static unsigned int hash_mb, hash_mb2;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 1b6d39e9baed..900da3ae03db 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -101,7 +101,6 @@ extern int __map_without_bats;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
-extern struct hash_pte *Hash;
 extern u8 early_hash[];
 
 #endif /* CONFIG_PPC32 */
-- 
2.25.0

