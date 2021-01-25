Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFB3036D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbhAZGsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:48:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:11163 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbhAYOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:51:10 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmK04nCz9v0Gw;
        Mon, 25 Jan 2021 15:48:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fp_abqPNS7eL; Mon, 25 Jan 2021 15:48:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmJ6Qjyz9v0Gh;
        Mon, 25 Jan 2021 15:48:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 699208B79E;
        Mon, 25 Jan 2021 15:48:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YYgsJyARkR8x; Mon, 25 Jan 2021 15:48:22 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A6B28B79B;
        Mon, 25 Jan 2021 15:48:22 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2005B66AD8; Mon, 25 Jan 2021 14:48:22 +0000 (UTC)
Message-Id: <ec6db54fc95360f532ba235f3f53645fa1e3c0c3.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 09/23] powerpc/irq: Rework helpers that manipulate
 MSR[EE/RI]
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting PPC32 to C syscall entry/exit,
rewrite the following helpers as static inline functions and
add support for PPC32 in them:
	__hard_irq_enable()
	__hard_irq_disable()
	__hard_EE_RI_disable()
	__hard_RI_enable()

Then use them in PPC32 version of arch_local_irq_disable()
and arch_local_irq_enable() to avoid code duplication.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/hw_irq.h | 75 +++++++++++++++++++++----------
 arch/powerpc/include/asm/reg.h    |  1 +
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index ed0c3b049dfd..4739f61e632c 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -50,6 +50,55 @@
 
 #ifndef __ASSEMBLY__
 
+static inline void __hard_irq_enable(void)
+{
+	if (IS_ENABLED(CONFIG_BOOKE) || IS_ENABLED(CONFIG_40x))
+		wrtee(MSR_EE);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_EIE);
+	else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+		__mtmsrd(MSR_EE | MSR_RI, 1);
+	else
+		mtmsr(mfmsr() | MSR_EE);
+}
+
+static inline void __hard_irq_disable(void)
+{
+	if (IS_ENABLED(CONFIG_BOOKE) || IS_ENABLED(CONFIG_40x))
+		wrtee(0);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_EID);
+	else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+		__mtmsrd(MSR_RI, 1);
+	else
+		mtmsr(mfmsr() & ~MSR_EE);
+}
+
+static inline void __hard_EE_RI_disable(void)
+{
+	if (IS_ENABLED(CONFIG_BOOKE) || IS_ENABLED(CONFIG_40x))
+		wrtee(0);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_NRI);
+	else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+		__mtmsrd(0, 1);
+	else
+		mtmsr(mfmsr() & ~(MSR_EE | MSR_RI));
+}
+
+static inline void __hard_RI_enable(void)
+{
+	if (IS_ENABLED(CONFIG_BOOKE) || IS_ENABLED(CONFIG_40x))
+		return;
+
+	if (IS_ENABLED(CONFIG_PPC_8xx))
+		wrtspr(SPRN_EID);
+	else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+		__mtmsrd(MSR_RI, 1);
+	else
+		mtmsr(mfmsr() | MSR_RI);
+}
+
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
@@ -212,18 +261,6 @@ static inline bool arch_irqs_disabled(void)
 
 #endif /* CONFIG_PPC_BOOK3S */
 
-#ifdef CONFIG_PPC_BOOK3E
-#define __hard_irq_enable()	wrtee(MSR_EE)
-#define __hard_irq_disable()	wrtee(0)
-#define __hard_EE_RI_disable()	wrtee(0)
-#define __hard_RI_enable()	do { } while (0)
-#else
-#define __hard_irq_enable()	__mtmsrd(MSR_EE|MSR_RI, 1)
-#define __hard_irq_disable()	__mtmsrd(MSR_RI, 1)
-#define __hard_EE_RI_disable()	__mtmsrd(0, 1)
-#define __hard_RI_enable()	__mtmsrd(MSR_RI, 1)
-#endif
-
 #define hard_irq_disable()	do {					\
 	unsigned long flags;						\
 	__hard_irq_disable();						\
@@ -322,22 +359,12 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline void arch_local_irq_disable(void)
 {
-	if (IS_ENABLED(CONFIG_BOOKE))
-		wrtee(0);
-	else if (IS_ENABLED(CONFIG_PPC_8xx))
-		wrtspr(SPRN_EID);
-	else
-		mtmsr(mfmsr() & ~MSR_EE);
+	__hard_irq_disable();
 }
 
 static inline void arch_local_irq_enable(void)
 {
-	if (IS_ENABLED(CONFIG_BOOKE))
-		wrtee(MSR_EE);
-	else if (IS_ENABLED(CONFIG_PPC_8xx))
-		wrtspr(SPRN_EIE);
-	else
-		mtmsr(mfmsr() | MSR_EE);
+	__hard_irq_enable();
 }
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e40a921d78f9..d05dca30604d 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1375,6 +1375,7 @@
 #define mtmsr(v)	asm volatile("mtmsr %0" : \
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
+#define __mtmsrd(v, l)	BUILD_BUG()
 #define __MTMSR		"mtmsr"
 #endif
 
-- 
2.25.0

