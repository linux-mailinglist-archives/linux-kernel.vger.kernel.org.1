Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33711D8F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 07:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgESFt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 01:49:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61897 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgESFtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:49:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4hR5WtNz9txm3;
        Tue, 19 May 2020 07:49:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9n07nKVs9_se; Tue, 19 May 2020 07:49:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4hR4c3Fz9txlx;
        Tue, 19 May 2020 07:49:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA5A58B7A7;
        Tue, 19 May 2020 07:49:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lkG67oJut-Xd; Tue, 19 May 2020 07:49:28 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 72C928B767;
        Tue, 19 May 2020 07:49:28 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4E80565A4A; Tue, 19 May 2020 05:49:28 +0000 (UTC)
Message-Id: <fd29c1718ee44d82115d0e835ced808eb4ccbf51.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 44/45] powerpc/32s: Allow mapping with BATs with
 DEBUG_PAGEALLOC
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:49:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_PAGEALLOC only manages RW data.

Text and RO data can still be mapped with BATs.

In order to map with BATs, also enforce data alignment. Set
by default to 256M which is a good compromise for keeping
enough BATs for also KASAN and IMMR.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/mm/book3s32/mmu.c | 6 ++++++
 arch/powerpc/mm/init_32.c      | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fcb0a9ae9872..752deddc9ed9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -797,6 +797,7 @@ config DATA_SHIFT
 	range 17 28 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC) && PPC_BOOK3S_32
 	range 19 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC) && PPC_8xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	default 18 if DEBUG_PAGEALLOC && PPC_BOOK3S_32
 	default 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default 23 if DEBUG_PAGEALLOC && PPC_8xx && PIN_TLB_DATA
 	default 19 if DEBUG_PAGEALLOC && PPC_8xx
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index a9b2cbc74797..a6dcc708eee3 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -170,6 +170,12 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 		pr_debug("RAM mapped without BATs\n");
 		return base;
 	}
+	if (debug_pagealloc_enabled()) {
+		if (base >= border)
+			return base;
+		if (top >= border)
+			top = border;
+	}
 
 	if (!strict_kernel_rwx_enabled() || base >= border || top <= border)
 		return __mmu_mapin_ram(base, top);
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 8977a7c2543d..36c39bd37256 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -99,10 +99,9 @@ static void __init MMU_setup(void)
 	if (IS_ENABLED(CONFIG_PPC_8xx))
 		return;
 
-	if (debug_pagealloc_enabled()) {
-		__map_without_bats = 1;
+	if (debug_pagealloc_enabled())
 		__map_without_ltlbs = 1;
-	}
+
 	if (strict_kernel_rwx_enabled())
 		__map_without_ltlbs = 1;
 }
-- 
2.25.0

