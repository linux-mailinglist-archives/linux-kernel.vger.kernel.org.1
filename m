Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE8295863
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508227AbgJVG3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24684 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508245AbgJVG3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBj1cnRz9vBKt;
        Thu, 22 Oct 2020 08:29:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id POdrSbyBr-Zx; Thu, 22 Oct 2020 08:29:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBj056yz9vBKl;
        Thu, 22 Oct 2020 08:29:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EFC7B8B805;
        Thu, 22 Oct 2020 08:29:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HtPNMI8EHmlo; Thu, 22 Oct 2020 08:29:33 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A460E8B769;
        Thu, 22 Oct 2020 08:29:33 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 88852667EF; Thu, 22 Oct 2020 06:29:33 +0000 (UTC)
Message-Id: <867587af929973ad65f8ef6972f2474a80c1737a.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 08/20] powerpc/32s: Move _tlbie() and _tlbia() prototypes
 to tlbflush.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use _tlbie() and _tlbia() directly
from asm/book3s/32/tlbflush.h, move their prototypes
from mm/mm_decl.h to there.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 4 ++++
 arch/powerpc/mm/mmu_decl.h                    | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index 29e292be4f1b..3043e7af70aa 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -11,6 +11,10 @@ extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+
+void _tlbie(unsigned long address);
+void _tlbia(void);
+
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 					unsigned long vmaddr)
 {
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 900da3ae03db..fb7c2a67bc99 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -82,9 +82,6 @@ static inline void print_system_hash_info(void) {}
 
 #else /* CONFIG_PPC_MMU_NOHASH */
 
-extern void _tlbie(unsigned long address);
-extern void _tlbia(void);
-
 void print_system_hash_info(void);
 
 #endif /* CONFIG_PPC_MMU_NOHASH */
-- 
2.25.0

