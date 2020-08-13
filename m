Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9764F243D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHMQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 12:36:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52769 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMQgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:36:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BSBzP3W2pz9vCy6;
        Thu, 13 Aug 2020 18:36:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Yz5B6KTKTx1G; Thu, 13 Aug 2020 18:36:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BSBzP2bTFz9vCy4;
        Thu, 13 Aug 2020 18:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 10C3E8B7A6;
        Thu, 13 Aug 2020 18:36:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7koiQi2nqm7Y; Thu, 13 Aug 2020 18:36:35 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB9DC8B7A1;
        Thu, 13 Aug 2020 18:36:34 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A4F9865C8D; Thu, 13 Aug 2020 16:36:34 +0000 (UTC)
Message-Id: <4dde2b977228a86b40df1f6bc5cdcfe9a6631f84.1597336548.git.christophe.leroy@csgroup.eu>
In-Reply-To: <11a330af231af22874c006302a945388846f8112.1597336548.git.christophe.leroy@csgroup.eu>
References: <11a330af231af22874c006302a945388846f8112.1597336548.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/9] powerpc: Remove CONFIG_PPC601_SYNC_FIX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Aug 2020 16:36:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This config option isn't in any defconfig.

The very first versions of Powerpc 601 have a bug which
requires additional sync before and/or after some instructions.

This was more than 25 years ago and time has come to retire
those buggy versions of the 601 from the kernel.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc_asm.h |  6 ------
 arch/powerpc/platforms/Kconfig     | 15 ---------------
 2 files changed, 21 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index b4cc6608131c..0b9dc814b81c 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -382,15 +382,9 @@ GLUE(.,name):
 #endif
 
 /* various errata or part fixups */
-#ifdef CONFIG_PPC601_SYNC_FIX
-#define SYNC		sync; isync
-#define SYNC_601	sync
-#define ISYNC_601	isync
-#else
 #define	SYNC
 #define SYNC_601
 #define ISYNC_601
-#endif
 
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define MFTB(dest)			\
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fb7515b4fa9c..f377a56ecc85 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -199,21 +199,6 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
-config PPC601_SYNC_FIX
-	bool "Workarounds for PPC601 bugs"
-	depends on PPC_BOOK3S_601 && PPC_PMAC
-	default y
-	help
-	  Some versions of the PPC601 (the first PowerPC chip) have bugs which
-	  mean that extra synchronization instructions are required near
-	  certain instructions, typically those that make major changes to the
-	  CPU state.  These extra instructions reduce performance slightly.
-	  If you say N here, these extra instructions will not be included,
-	  resulting in a kernel which will run faster but may not run at all
-	  on some systems with the PPC601 chip.
-
-	  If in doubt, say Y here.
-
 config TAU
 	bool "On-chip CPU temperature sensor support"
 	depends on PPC_BOOK3S_32
-- 
2.25.0

