Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0666028CC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgJMLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:11:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56452 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgJMLLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:11:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C9Xt02x12z9tyJ3;
        Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ALEcuMxR2Q8j; Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C9Xt01hJGz9tyJ1;
        Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A88D8B7B1;
        Tue, 13 Oct 2020 13:11:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3wQvfOfgTPh7; Tue, 13 Oct 2020 13:11:21 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D06C68B7A7;
        Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9E91966446; Tue, 13 Oct 2020 11:11:20 +0000 (UTC)
Message-Id: <4fc9e30b2b09933c8dfd7a50924dfbdf9ea6a80f.1602587470.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/2] powerpc/feature: Fix CPU_FTRS_ALWAYS by removing
 CPU_FTRS_GENERIC_32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Oct 2020 11:11:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8xx, we get the following features:

[    0.000000] cpu_features      = 0x0000000000000100
[    0.000000]   possible        = 0x0000000000000120
[    0.000000]   always          = 0x0000000000000000

This is not correct. As CONFIG_PPC_8xx is mutually exclusive with all
other configurations, the three lines should be equal.

The problem is due to CPU_FTRS_GENERIC_32 which is taken when
CONFIG_BOOK3S_32 is NOT selected. This CPU_FTRS_GENERIC_32 is
pointless because there is no generic configuration supporting
all 32 bits but book3s/32.

Remove this pointless generic features definition to unbreak the
calculation of 'possible' features and 'always' features.

Fixes: 76bc080ef5a3 ("[POWERPC] Make default cputable entries reflect selected CPU family")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cputable.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 93bc70d4c9a1..c596bab134e2 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -409,7 +409,6 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT)
-#define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
 #define CPU_FTRS_PPC970	(CPU_FTR_LWSYNC | \
@@ -520,8 +519,6 @@ enum {
 	    CPU_FTRS_7447 | CPU_FTRS_7447A | CPU_FTRS_82XX |
 	    CPU_FTRS_G2_LE | CPU_FTRS_E300 | CPU_FTRS_E300C2 |
 	    CPU_FTRS_CLASSIC32 |
-#else
-	    CPU_FTRS_GENERIC_32 |
 #endif
 #ifdef CONFIG_PPC_8xx
 	    CPU_FTRS_8XX |
@@ -596,8 +593,6 @@ enum {
 	    CPU_FTRS_7447 & CPU_FTRS_7447A & CPU_FTRS_82XX &
 	    CPU_FTRS_G2_LE & CPU_FTRS_E300 & CPU_FTRS_E300C2 &
 	    CPU_FTRS_CLASSIC32 &
-#else
-	    CPU_FTRS_GENERIC_32 &
 #endif
 #ifdef CONFIG_PPC_8xx
 	    CPU_FTRS_8XX &
-- 
2.25.0

