Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177D027BCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgI2GJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:09:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64518 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgI2GJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:09:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C0pr03x9mz9v05Y;
        Tue, 29 Sep 2020 08:09:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nPyNa_czBTXl; Tue, 29 Sep 2020 08:09:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C0pr035mMz9tyfn;
        Tue, 29 Sep 2020 08:09:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FC418B76C;
        Tue, 29 Sep 2020 08:09:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ap-11Ri8gkx1; Tue, 29 Sep 2020 08:09:21 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2ACB38B79F;
        Tue, 29 Sep 2020 08:09:21 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0B53A65E8A; Tue, 29 Sep 2020 06:09:21 +0000 (UTC)
Message-Id: <00a6948d659e017f8ca63437d1384222c3aede57.1601359702.git.christophe.leroy@csgroup.eu>
In-Reply-To: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601359702.git.christophe.leroy@csgroup.eu>
References: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601359702.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/7] powerpc: Remove PowerPC 601
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Sep 2020 06:09:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerpc 601 is 25 years old.

It is not selected by any defconfig.

It requires a lot of special handling as it deviates from the
standard 6xx.

Retire it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/cputable.c         | 15 ---------------
 arch/powerpc/platforms/Kconfig.cputype | 11 ++---------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2aa89c6b2896..1f7c3492f2ec 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -608,21 +608,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif	/* CONFIG_PPC_BOOK3S_64 */
 
 #ifdef CONFIG_PPC32
-#ifdef CONFIG_PPC_BOOK3S_601
-	{	/* 601 */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00010000,
-		.cpu_name		= "601",
-		.cpu_features		= CPU_FTRS_PPC601,
-		.cpu_user_features	= COMMON_USER | PPC_FEATURE_601_INSTR |
-			PPC_FEATURE_UNIFIED_CACHE | PPC_FEATURE_NO_TB,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 32,
-		.dcache_bsize		= 32,
-		.machine_check		= machine_check_generic,
-		.platform		= "ppc601",
-	},
-#endif /* CONFIG_PPC_BOOK3S_601 */
 #ifdef CONFIG_PPC_BOOK3S_6xx
 	{	/* 603 */
 		.pvr_mask		= 0xffff0000,
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e74ec220b5d6..c194c4ae8bc7 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -20,7 +20,7 @@ choice
 	depends on PPC32
 	help
 	  There are five families of 32 bit PowerPC chips supported.
-	  The most common ones are the desktop and server CPUs (601, 603,
+	  The most common ones are the desktop and server CPUs (603,
 	  604, 740, 750, 74xx) CPUs from Freescale and IBM, with their
 	  embedded 512x/52xx/82xx/83xx/86xx counterparts.
 	  The other embedded parts, namely 4xx, 8xx, e200 (55xx) and e500
@@ -30,7 +30,7 @@ choice
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
 config PPC_BOOK3S_6xx
-	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx except 601"
+	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_BOOK3S_32
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
@@ -38,13 +38,6 @@ config PPC_BOOK3S_6xx
 	select PPC_HAVE_KUAP
 	select HAVE_ARCH_VMAP_STACK if !ADB_PMU
 
-config PPC_BOOK3S_601
-	bool "PowerPC 601"
-	select PPC_BOOK3S_32
-	select PPC_FPU
-	select PPC_HAVE_KUAP
-	select HAVE_ARCH_VMAP_STACK
-
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
-- 
2.25.0

