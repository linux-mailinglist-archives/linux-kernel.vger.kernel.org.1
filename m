Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B92CEBE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgLDKMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:12:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61389 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbgLDKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:12:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CnT524VMDz9v9xH;
        Fri,  4 Dec 2020 11:11:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q1aCUZxw5Ing; Fri,  4 Dec 2020 11:11:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CnT523dhPz9v9xF;
        Fri,  4 Dec 2020 11:11:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B11C18B7FF;
        Fri,  4 Dec 2020 11:11:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DMQ1PCotY_Z6; Fri,  4 Dec 2020 11:11:35 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B4188B75E;
        Fri,  4 Dec 2020 11:11:35 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DB8A866914; Fri,  4 Dec 2020 10:11:34 +0000 (UTC)
Message-Id: <b2f71f39eca543f1e4ec06596f09a8b12235c701.1607076683.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/8xx: Fix early debug when SMC1 is relocated
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Dec 2020 10:11:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SMC1 is relocated and early debug is selected, the
board hangs is ppc_md.setup_arch(). This is because ones
the microcode has been loaded and SMC1 relocated, early
debug writes in the weed.

To allow smooth continuation, the SMC1 parameter RAM set up
by the bootloader have to be copied into the new location.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 43db76f41824 ("powerpc/8xx: Add microcode patch to move SMC parameter RAM.")
Cc: stable@vger.kernel.org
---
 arch/powerpc/include/asm/cpm1.h         |  1 +
 arch/powerpc/platforms/8xx/micropatch.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/cpm1.h b/arch/powerpc/include/asm/cpm1.h
index a116fe931789..3bdd74739cb8 100644
--- a/arch/powerpc/include/asm/cpm1.h
+++ b/arch/powerpc/include/asm/cpm1.h
@@ -68,6 +68,7 @@ extern void cpm_reset(void);
 #define PROFF_SPI	((uint)0x0180)
 #define PROFF_SCC3	((uint)0x0200)
 #define PROFF_SMC1	((uint)0x0280)
+#define PROFF_DSP1	((uint)0x02c0)
 #define PROFF_SCC4	((uint)0x0300)
 #define PROFF_SMC2	((uint)0x0380)
 
diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index aed4bc75f352..aef179fcbd4f 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -360,6 +360,17 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	if (IS_ENABLED(CONFIG_SMC_UCODE_PATCH)) {
 		smc_uart_t *smp;
 
+		if (IS_ENABLED(CONFIG_PPC_EARLY_DEBUG_CPM)) {
+			int i;
+
+			for (i = 0; i < sizeof(*smp); i += 4) {
+				u32 __iomem *src = (u32 __iomem *)&cp->cp_dparam[PROFF_SMC1 + i];
+				u32 __iomem *dst = (u32 __iomem *)&cp->cp_dparam[PROFF_DSP1 + i];
+
+				out_be32(dst, in_be32(src));
+			}
+		}
+
 		smp = (smc_uart_t *)&cp->cp_dparam[PROFF_SMC1];
 		out_be16(&smp->smc_rpbase, 0x1ec0);
 		smp = (smc_uart_t *)&cp->cp_dparam[PROFF_SMC2];
-- 
2.25.0

