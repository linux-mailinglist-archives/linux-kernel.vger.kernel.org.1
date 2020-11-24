Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBB2C2B34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbgKXPZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:25:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:27052 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389434AbgKXPZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:25:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgSWH4YJWz9v0d5;
        Tue, 24 Nov 2020 16:24:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nPEsL3BkWtmw; Tue, 24 Nov 2020 16:24:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSWH2jy7z9v0dP;
        Tue, 24 Nov 2020 16:24:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 567BB8B7B5;
        Tue, 24 Nov 2020 16:25:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rLBehuRkZu7T; Tue, 24 Nov 2020 16:25:00 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9487A8B7B3;
        Tue, 24 Nov 2020 16:24:59 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6FC72668E2; Tue, 24 Nov 2020 15:24:59 +0000 (UTC)
Message-Id: <e281e3a611eead8817c49cf06a60072a021af823.1606231483.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 6/6] powerpc/ppc-opcode: Add PPC_RAW_MFSPR()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 15:24:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PPC_RAW_MFSPR() to replace open coding done in 8xx-pmu.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 3 ++-
 arch/powerpc/perf/8xx-pmu.c           | 5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index a6e3700c4566..da6f300e9788 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -230,7 +230,6 @@
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_RFEBB			0x4c000124
 #define PPC_INST_RFID			0x4c000024
-#define PPC_INST_MFSPR			0x7c0002a6
 #define PPC_INST_MFSPR_DSCR		0x7c1102a6
 #define PPC_INST_MFSPR_DSCR_MASK	0xfc1ffffe
 #define PPC_INST_MTSPR_DSCR		0x7c1103a6
@@ -507,6 +506,8 @@
 
 #define PPC_RAW_NEG(d, a)		(0x7c0000d0 | ___PPC_RT(d) | ___PPC_RA(a))
 
+#define PPC_RAW_MFSPR(d, spr)		(0x7c0002a6 | ___PPC_RT(d) | __PPC_SPR(spr))
+
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_BCCTR_FLUSH		stringify_in_c(.long PPC_INST_BCCTR_FLUSH)
 #define	PPC_CP_ABORT		stringify_in_c(.long PPC_RAW_CP_ABORT)
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 93004ee586a1..f970d1510d3d 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -153,10 +153,7 @@ static void mpc8xx_pmu_read(struct perf_event *event)
 
 static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 {
-	struct ppc_inst insn;
-
-	/* mfspr r10, SPRN_SPRG_SCRATCH2 */
-	insn = ppc_inst(PPC_INST_MFSPR | __PPC_RS(R10) | __PPC_SPR(SPRN_SPRG_SCRATCH2));
+	struct ppc_inst insn = ppc_inst(PPC_RAW_MFSPR(10, SPRN_SPRG_SCRATCH2));
 
 	mpc8xx_pmu_read(event);
 
-- 
2.25.0

