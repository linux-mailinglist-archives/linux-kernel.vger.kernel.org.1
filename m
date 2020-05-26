Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D21CD82F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgEKL0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:26:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39938 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbgEKL0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXV4qNRz9ty3h;
        Mon, 11 May 2020 13:26:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id G3ii9-cSBPzZ; Mon, 11 May 2020 13:26:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXV41rVz9ty3g;
        Mon, 11 May 2020 13:26:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 340C38B7AE;
        Mon, 11 May 2020 13:26:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zDxdI3GCsjiY; Mon, 11 May 2020 13:26:09 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5AE6C8B7AD;
        Mon, 11 May 2020 13:26:08 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3CB6965A09; Mon, 11 May 2020 11:26:08 +0000 (UTC)
Message-Id: <15da12f0c2baddde2bf32faed886f5df60008f93.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 41/45] powerpc/8xx: Allow STRICT_KERNEL_RwX with pinned TLB
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:26:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinned TLB are 8M. Now that there is no strict boundary anymore
between text and RO data, it is possible to use 8M pinned executable
TLB that covers both text and RO data.

When PIN_TLB_DATA or PIN_TLB_TEXT is selected, enforce 8M RW data
alignment and allow STRICT_KERNEL_RWX.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use the new function that sets all pinned TLBs at once.
---
 arch/powerpc/Kconfig               | 8 +++++---
 arch/powerpc/mm/nohash/8xx.c       | 9 +++++++--
 arch/powerpc/platforms/8xx/Kconfig | 2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 970a5802850f..edbe39140da0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -778,9 +778,10 @@ config THREAD_SHIFT
 	  want. Only change this if you know what you are doing.
 
 config DATA_SHIFT_BOOL
-	bool "Set custom data alignment" if STRICT_KERNEL_RWX && \
-					    (PPC_BOOK3S_32 || PPC_8xx)
+	bool "Set custom data alignment"
 	depends on ADVANCED_OPTIONS
+	depends on STRICT_KERNEL_RWX
+	depends on PPC_BOOK3S_32 || (PPC_8xx && !PIN_TLB_DATA && !PIN_TLB_TEXT)
 	help
 	  This option allows you to set the kernel data alignment. When
 	  RAM is mapped by blocks, the alignment needs to fit the size and
@@ -802,7 +803,8 @@ config DATA_SHIFT
 
 	  On 8xx, large pages (512kb or 8M) are used to map kernel linear
 	  memory. Aligning to 8M reduces TLB misses as only 8M pages are used
-	  in that case.
+	  in that case. If PIN_TLB is selected, it must be aligned to 8M as
+	  8M pages will be pinned.
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index c62cab996d4d..35796ce81695 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -126,8 +126,8 @@ void __init mmu_mapin_immr(void)
 				    PAGE_KERNEL_NCG, MMU_PAGE_512K, true);
 }
 
-static void __init mmu_mapin_ram_chunk(unsigned long offset, unsigned long top,
-				       pgprot_t prot, bool new)
+static void mmu_mapin_ram_chunk(unsigned long offset, unsigned long top,
+				pgprot_t prot, bool new)
 {
 	unsigned long v = PAGE_OFFSET + offset;
 	unsigned long p = offset;
@@ -180,6 +180,9 @@ void mmu_mark_initmem_nx(void)
 
 	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
 	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
+
+	if (IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+		mmu_pin_tlb(block_mapped_ram, false);
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
@@ -188,6 +191,8 @@ void mmu_mark_rodata_ro(void)
 	unsigned long sinittext = __pa(_sinittext);
 
 	mmu_mapin_ram_chunk(0, sinittext, PAGE_KERNEL_ROX, false);
+	if (IS_ENABLED(CONFIG_PIN_TLB_DATA))
+		mmu_pin_tlb(block_mapped_ram, true);
 }
 #endif
 
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 04ea1a8a0bdc..05669f2fadce 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -167,7 +167,7 @@ menu "8xx advanced setup"
 
 config PIN_TLB
 	bool "Pinned Kernel TLBs"
-	depends on ADVANCED_OPTIONS && !DEBUG_PAGEALLOC && !STRICT_KERNEL_RWX
+	depends on ADVANCED_OPTIONS && !DEBUG_PAGEALLOC
 	help
 	  On the 8xx, we have 32 instruction TLBs and 32 data TLBs. In each
 	  table 4 TLBs can be pinned.
-- 
2.25.0

