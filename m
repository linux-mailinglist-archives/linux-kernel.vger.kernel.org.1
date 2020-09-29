Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEC27BCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgI2GJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:09:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26914 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgI2GJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:09:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C0pr24Nxyz9v05c;
        Tue, 29 Sep 2020 08:09:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VQOIDrb1u-JH; Tue, 29 Sep 2020 08:09:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C0pr23ZWsz9v05Z;
        Tue, 29 Sep 2020 08:09:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79C3A8B79F;
        Tue, 29 Sep 2020 08:09:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nHmh5vlI_i4h; Tue, 29 Sep 2020 08:09:23 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4090C8B76C;
        Tue, 29 Sep 2020 08:09:23 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 24F9065E8A; Tue, 29 Sep 2020 06:09:23 +0000 (UTC)
Message-Id: <31c4cd093963f22831bf388449056ee045533d3b.1601359702.git.christophe.leroy@csgroup.eu>
In-Reply-To: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601359702.git.christophe.leroy@csgroup.eu>
References: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601359702.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 6/7] powerpc: Tidy up a bit after removal of PowerPC 601.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Sep 2020 06:09:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of the 601 left some standalone blocks from
former if/else. Drop the { } and re-indent.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/btext.c    | 11 +++------
 arch/powerpc/mm/book3s32/mmu.c | 45 +++++++++++++++-------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index b609fb39dba8..c22a8e0dbc93 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -95,13 +95,10 @@ void __init btext_prepare_BAT(void)
 		boot_text_mapped = 0;
 		return;
 	}
-	{
-		/* 603, 604, G3, G4, ... */
-		lowbits = addr & ~0xFF000000UL;
-		addr &= 0xFF000000UL;
-		disp_BAT[0] = vaddr | (BL_16M<<2) | 2;
-		disp_BAT[1] = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | BPP_RW);	
-	}
+	lowbits = addr & ~0xFF000000UL;
+	addr &= 0xFF000000UL;
+	disp_BAT[0] = vaddr | (BL_16M<<2) | 2;
+	disp_BAT[1] = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | BPP_RW);
 	logicalDisplayBase = (void *) (vaddr + lowbits);
 }
 #endif
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 771d607f1a3d..741e4fc990c7 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -73,16 +73,13 @@ unsigned long p_block_mapped(phys_addr_t pa)
 static int find_free_bat(void)
 {
 	int b;
+	int n = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
 
-	{
-		int n = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
+	for (b = 0; b < n; b++) {
+		struct ppc_bat *bat = BATS[b];
 
-		for (b = 0; b < n; b++) {
-			struct ppc_bat *bat = BATS[b];
-
-			if (!(bat[1].batu & 3))
-				return b;
-		}
+		if (!(bat[1].batu & 3))
+			return b;
 	}
 	return -1;
 }
@@ -280,24 +277,22 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		flags &= ~_PAGE_COHERENT;
 
 	bl = (size >> 17) - 1;
-	{
-		/* Do DBAT first */
-		wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
-				   | _PAGE_COHERENT | _PAGE_GUARDED);
-		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
-		bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
-		bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
-		if (flags & _PAGE_USER)
-			bat[1].batu |= 1; 	/* Vp = 1 */
-		if (flags & _PAGE_GUARDED) {
-			/* G bit must be zero in IBATs */
-			flags &= ~_PAGE_EXEC;
-		}
-		if (flags & _PAGE_EXEC)
-			bat[0] = bat[1];
-		else
-			bat[0].batu = bat[0].batl = 0;
+	/* Do DBAT first */
+	wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
+			   | _PAGE_COHERENT | _PAGE_GUARDED);
+	wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
+	bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
+	bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
+	if (flags & _PAGE_USER)
+		bat[1].batu |= 1; 	/* Vp = 1 */
+	if (flags & _PAGE_GUARDED) {
+		/* G bit must be zero in IBATs */
+		flags &= ~_PAGE_EXEC;
 	}
+	if (flags & _PAGE_EXEC)
+		bat[0] = bat[1];
+	else
+		bat[0].batu = bat[0].batl = 0;
 
 	bat_addrs[index].start = virt;
 	bat_addrs[index].limit = virt + ((bl + 1) << 17) - 1;
-- 
2.25.0

