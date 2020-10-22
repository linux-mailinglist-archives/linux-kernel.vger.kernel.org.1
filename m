Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3E29585E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895656AbgJVG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30370 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508281AbgJVG3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBt1hnSz9vCyd;
        Thu, 22 Oct 2020 08:29:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OmQvs7ZZmlGP; Thu, 22 Oct 2020 08:29:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBt0wvZz9vCy4;
        Thu, 22 Oct 2020 08:29:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DEBB8B805;
        Thu, 22 Oct 2020 08:29:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p6B1J1JZwaJo; Thu, 22 Oct 2020 08:29:43 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E31E08B769;
        Thu, 22 Oct 2020 08:29:42 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C7F91667EF; Thu, 22 Oct 2020 06:29:42 +0000 (UTC)
Message-Id: <f18c16af37f6f77b577bed8d9e12831b695617ae.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 17/20] powerpc/32s: Remove CONFIG_PPC_BOOK3S_6xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 601 is gone, CONFIG_PPC_BOO3S_6xx and CONFIG_PPC_BOOK3S_32
are dedundant.

Remove CONFIG_PPC_BOOK3S_6xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/cputable.c         | 4 ++--
 arch/powerpc/platforms/Kconfig.cputype | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 492c0b36aff6..0828a7756595 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -609,7 +609,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif	/* CONFIG_PPC_BOOK3S_64 */
 
 #ifdef CONFIG_PPC32
-#ifdef CONFIG_PPC_BOOK3S_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 	{	/* 603 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00030000,
@@ -1239,7 +1239,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
-#endif /* CONFIG_PPC_BOOK3S_6xx */
+#endif /* CONFIG_PPC_BOOK3S_32 */
 #ifdef CONFIG_PPC_8xx
 	{	/* 8xx */
 		.pvr_mask		= 0xffff0000,
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c194c4ae8bc7..818a41c9e274 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -11,9 +11,6 @@ config PPC64
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
 
-config PPC_BOOK3S_32
-	bool
-
 menu "Processor support"
 choice
 	prompt "Processor Type"
@@ -29,9 +26,8 @@ choice
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
-config PPC_BOOK3S_6xx
+config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
-	select PPC_BOOK3S_32
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select PPC_HAVE_KUEP
-- 
2.25.0

