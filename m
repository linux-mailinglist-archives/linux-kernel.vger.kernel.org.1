Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22F28AF97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgJLIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:04:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31387 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgJLIE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:04:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C8rmh0Xlpz9typT;
        Mon, 12 Oct 2020 10:04:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ry--GPNevYkn; Mon, 12 Oct 2020 10:04:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C8rmg6mw4z9typR;
        Mon, 12 Oct 2020 10:04:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12D5C8B783;
        Mon, 12 Oct 2020 10:04:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id daA5CPWgaEmW; Mon, 12 Oct 2020 10:04:25 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACFCF8B787;
        Mon, 12 Oct 2020 10:04:24 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8E0F466441; Mon, 12 Oct 2020 08:04:24 +0000 (UTC)
Message-Id: <829ae1aed1d2fc6b5fc5818362e573dee5d6ecde.1602489852.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: Desintegrate MMU_FTR_PPCAS_ARCH_V2
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Oct 2020 08:04:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU_FTR_PPCAS_ARCH_V2 is defined in cpu_table.h
as MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE.

MMU_FTR_TLBIEL and MMU_FTR_16M_PAGE are defined in mmu.h

MMU_FTR_PPCAS_ARCH_V2 is used only in mmu.h and it is used only once.

Remove MMU_FTR_PPCAS_ARCH_V2 and use
directly MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cputable.h | 2 --
 arch/powerpc/include/asm/mmu.h      | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index accdc1286f37..d88bcb79f16d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -220,8 +220,6 @@ static inline void cpu_feature_keys_init(void) { }
 
 #define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE)
 
-#define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE)
-
 /* We only set the altivec features if the kernel was compiled with altivec
  * support
  */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 255a1837e9f7..b4367fd0b477 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -126,8 +126,7 @@
 #define MMU_FTR_RADIX_KUAP		ASM_CONST(0x80000000)
 
 /* MMU feature bit sets for various CPUs */
-#define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
-	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
+#define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	(MMU_FTR_HPTE_TABLE | MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE)
 #define MMU_FTRS_POWER		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
 #define MMU_FTRS_PPC970		MMU_FTRS_POWER | MMU_FTR_TLBIE_CROP_VA
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER | MMU_FTR_LOCKLESS_TLBIE
-- 
2.25.0

