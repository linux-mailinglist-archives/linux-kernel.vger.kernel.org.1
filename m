Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9227FDF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbgJAK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:59:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbgJAK70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:59:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C299h13Mwz9vCyB;
        Thu,  1 Oct 2020 12:59:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Co65YBxgPr1k; Thu,  1 Oct 2020 12:59:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C299g6XMPz9vCy8;
        Thu,  1 Oct 2020 12:59:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 350968B96E;
        Thu,  1 Oct 2020 12:59:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PG5kqvtdEvLr; Thu,  1 Oct 2020 12:59:21 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BAE18B903;
        Thu,  1 Oct 2020 12:59:20 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EF92D65ED7; Thu,  1 Oct 2020 10:59:19 +0000 (UTC)
Message-Id: <3c9a6eb0fc040868ac59be66f338d08fd017668d.1601549945.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/time: Remove ifdef in get_dec() and set_dec()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 10:59:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SPRN_PIT definition in reg.h.

This allows to remove ifdef in get_dec() and set_dec() and
makes them more readable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h       |  2 ++
 arch/powerpc/include/asm/reg_booke.h |  1 -
 arch/powerpc/include/asm/time.h      | 23 ++++++++++-------------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d25c357a873c..788058af1d44 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -521,6 +521,8 @@
 #define SPRN_TSCR	0x399	/* Thread Switch Control Register */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
+#define SPRN_PIT	0x3DB		/* Programmable Interval Timer (40x/BOOKE) */
+
 #define SPRN_DER	0x095		/* Debug Enable Register */
 #define DER_RSTE	0x40000000	/* Reset Interrupt */
 #define DER_CHSTPE	0x20000000	/* Check Stop */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index ff30f1076162..29a948e0c0f2 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -174,7 +174,6 @@
 #define SPRN_L1CSR1	0x3F3	/* L1 Cache Control and Status Register 1 */
 #define SPRN_MMUCSR0	0x3F4	/* MMU Control and Status Register 0 */
 #define SPRN_MMUCFG	0x3F7	/* MMU Configuration Register */
-#define SPRN_PIT	0x3DB	/* Programmable Interval Timer */
 #define SPRN_BUCSR	0x3F5	/* Branch Unit Control and Status */
 #define SPRN_L2CSR0	0x3F9	/* L2 Data Cache Control and Status Register 0 */
 #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status Register 1 */
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 6c663a382a75..a80abf64c8a5 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -126,11 +126,10 @@ static inline void set_tb(unsigned int upper, unsigned int lower)
  */
 static inline u64 get_dec(void)
 {
-#if defined(CONFIG_40x)
-	return (mfspr(SPRN_PIT));
-#else
-	return (mfspr(SPRN_DEC));
-#endif
+	if (IS_ENABLED(CONFIG_40x))
+		return mfspr(SPRN_PIT);
+
+	return mfspr(SPRN_DEC);
 }
 
 /*
@@ -140,14 +139,12 @@ static inline u64 get_dec(void)
  */
 static inline void set_dec(u64 val)
 {
-#if defined(CONFIG_40x)
-	mtspr(SPRN_PIT, (u32) val);
-#else
-#ifndef CONFIG_BOOKE
-	--val;
-#endif
-	mtspr(SPRN_DEC, val);
-#endif /* not 40x */
+	if (IS_ENABLED(CONFIG_40x))
+		mtspr(SPRN_PIT, (u32)val);
+	else if (IS_ENABLED(CONFIG_BOOKE))
+		mtspr(SPRN_DEC, val);
+	else
+		mtspr(SPRN_DEC, val - 1);
 }
 
 static inline unsigned long tb_ticks_since(unsigned long tstamp)
-- 
2.25.0

