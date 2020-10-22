Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46CF29585A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895635AbgJVG3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65132 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508258AbgJVG3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBl2F3Hz9vBKw;
        Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id x5BBfHgpQsuj; Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBl1QjRz9vBKl;
        Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 117DC8B805;
        Thu, 22 Oct 2020 08:29:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Wuswz-biF6yB; Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B37218B769;
        Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 97885667EF; Thu, 22 Oct 2020 06:29:35 +0000 (UTC)
Message-Id: <9a265b1b17a64153463d361280cb4b43eb1266a4.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 10/20] powerpc/32s: Move _tlbie() and _tlbia() in a new
 file
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_tlbie() and _tlbia() are used only on 603 cores while the
other functions are used only on cores having a hash table.

Move them into a new file named nohash_low.S

Add mmu_hash_lock var is used by both, it needs to go
in a common file.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/Makefile     |  2 +-
 arch/powerpc/mm/book3s32/hash_low.S   | 78 --------------------------
 arch/powerpc/mm/book3s32/mmu.c        |  4 ++
 arch/powerpc/mm/book3s32/nohash_low.S | 80 +++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 79 deletions(-)
 create mode 100644 arch/powerpc/mm/book3s32/nohash_low.S

diff --git a/arch/powerpc/mm/book3s32/Makefile b/arch/powerpc/mm/book3s32/Makefile
index 1732eaa740a9..3f972db17761 100644
--- a/arch/powerpc/mm/book3s32/Makefile
+++ b/arch/powerpc/mm/book3s32/Makefile
@@ -6,4 +6,4 @@ ifdef CONFIG_KASAN
 CFLAGS_mmu.o  		+= -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y += mmu.o hash_low.o mmu_context.o tlb.o
+obj-y += mmu.o hash_low.o mmu_context.o tlb.o nohash_low.o
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 006e9a452bde..9859b011d731 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -26,13 +26,6 @@
 #include <asm/feature-fixups.h>
 #include <asm/code-patching-asm.h>
 
-#ifdef CONFIG_SMP
-	.section .bss
-	.align	2
-mmu_hash_lock:
-	.space	4
-#endif /* CONFIG_SMP */
-
 /*
  * Load a PTE into the hash table, if possible.
  * The address is in r4, and r3 contains an access flag:
@@ -633,74 +626,3 @@ _GLOBAL(flush_hash_pages)
 	.previous
 EXPORT_SYMBOL(flush_hash_pages)
 _ASM_NOKPROBE_SYMBOL(flush_hash_pages)
-
-/*
- * Flush an entry from the TLB
- */
-#ifdef CONFIG_SMP
-_GLOBAL(_tlbie)
-	lwz	r8,TASK_CPU(r2)
-	oris	r8,r8,11
-	mfmsr	r10
-	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
-	rlwinm	r0,r0,0,28,26		/* clear DR */
-	mtmsr	r0
-	isync
-	lis	r9,mmu_hash_lock@h
-	ori	r9,r9,mmu_hash_lock@l
-	tophys(r9,r9)
-10:	lwarx	r7,0,r9
-	cmpwi	0,r7,0
-	bne-	10b
-	stwcx.	r8,0,r9
-	bne-	10b
-	eieio
-	tlbie	r3
-	sync
-	TLBSYNC
-	li	r0,0
-	stw	r0,0(r9)		/* clear mmu_hash_lock */
-	mtmsr	r10
-	isync
-	blr
-_ASM_NOKPROBE_SYMBOL(_tlbie)
-#endif /* CONFIG_SMP */
-
-/*
- * Flush the entire TLB. 603/603e only
- */
-_GLOBAL(_tlbia)
-#if defined(CONFIG_SMP)
-	lwz	r8,TASK_CPU(r2)
-	oris	r8,r8,10
-	mfmsr	r10
-	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
-	rlwinm	r0,r0,0,28,26		/* clear DR */
-	mtmsr	r0
-	isync
-	lis	r9,mmu_hash_lock@h
-	ori	r9,r9,mmu_hash_lock@l
-	tophys(r9,r9)
-10:	lwarx	r7,0,r9
-	cmpwi	0,r7,0
-	bne-	10b
-	stwcx.	r8,0,r9
-	bne-	10b
-#endif /* CONFIG_SMP */
-	li	r5, 32
-	lis	r4, KERNELBASE@h
-	mtctr	r5
-	sync
-0:	tlbie	r4
-	addi	r4, r4, 0x1000
-	bdnz	0b
-	sync
-#ifdef CONFIG_SMP
-	TLBSYNC
-	li	r0,0
-	stw	r0,0(r9)		/* clear mmu_hash_lock */
-	mtmsr	r10
-	isync
-#endif /* CONFIG_SMP */
-	blr
-_ASM_NOKPROBE_SYMBOL(_tlbia)
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index be1211293bc1..e7ff1ec73499 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -46,6 +46,10 @@ static struct batrange {	/* stores address ranges mapped by BATs */
 	phys_addr_t phys;
 } bat_addrs[8];
 
+#ifdef CONFIG_SMP
+unsigned long mmu_hash_lock;
+#endif
+
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
  */
diff --git a/arch/powerpc/mm/book3s32/nohash_low.S b/arch/powerpc/mm/book3s32/nohash_low.S
new file mode 100644
index 000000000000..19f418b0ed2d
--- /dev/null
+++ b/arch/powerpc/mm/book3s32/nohash_low.S
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  This file contains low-level assembler routines for managing
+ *  the PowerPC 603 tlb invalidation.
+ */
+
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+/*
+ * Flush an entry from the TLB
+ */
+#ifdef CONFIG_SMP
+_GLOBAL(_tlbie)
+	lwz	r8,TASK_CPU(r2)
+	oris	r8,r8,11
+	mfmsr	r10
+	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
+	rlwinm	r0,r0,0,28,26		/* clear DR */
+	mtmsr	r0
+	isync
+	lis	r9,mmu_hash_lock@h
+	ori	r9,r9,mmu_hash_lock@l
+	tophys(r9,r9)
+10:	lwarx	r7,0,r9
+	cmpwi	0,r7,0
+	bne-	10b
+	stwcx.	r8,0,r9
+	bne-	10b
+	eieio
+	tlbie	r3
+	sync
+	TLBSYNC
+	li	r0,0
+	stw	r0,0(r9)		/* clear mmu_hash_lock */
+	mtmsr	r10
+	isync
+	blr
+_ASM_NOKPROBE_SYMBOL(_tlbie)
+#endif /* CONFIG_SMP */
+
+/*
+ * Flush the entire TLB. 603/603e only
+ */
+_GLOBAL(_tlbia)
+#if defined(CONFIG_SMP)
+	lwz	r8,TASK_CPU(r2)
+	oris	r8,r8,10
+	mfmsr	r10
+	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
+	rlwinm	r0,r0,0,28,26		/* clear DR */
+	mtmsr	r0
+	isync
+	lis	r9,mmu_hash_lock@h
+	ori	r9,r9,mmu_hash_lock@l
+	tophys(r9,r9)
+10:	lwarx	r7,0,r9
+	cmpwi	0,r7,0
+	bne-	10b
+	stwcx.	r8,0,r9
+	bne-	10b
+#endif /* CONFIG_SMP */
+	li	r5, 32
+	lis	r4, KERNELBASE@h
+	mtctr	r5
+	sync
+0:	tlbie	r4
+	addi	r4, r4, 0x1000
+	bdnz	0b
+	sync
+#ifdef CONFIG_SMP
+	TLBSYNC
+	li	r0,0
+	stw	r0,0(r9)		/* clear mmu_hash_lock */
+	mtmsr	r10
+	isync
+#endif /* CONFIG_SMP */
+	blr
+_ASM_NOKPROBE_SYMBOL(_tlbia)
-- 
2.25.0

