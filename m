Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AEC21229F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgGBLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 07:52:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2105 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgGBLwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:52:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49yGfT2v0Sz9v2nB;
        Thu,  2 Jul 2020 13:52:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xtqwurSz25b4; Thu,  2 Jul 2020 13:52:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49yGfT1kTxz9v2n9;
        Thu,  2 Jul 2020 13:52:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0ECF18B99A;
        Thu,  2 Jul 2020 13:52:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6epQhKbCo4iF; Thu,  2 Jul 2020 13:52:02 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [10.25.210.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA4138B98D;
        Thu,  2 Jul 2020 13:52:02 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B0F7C652C1; Thu,  2 Jul 2020 11:52:02 +0000 (UTC)
Message-Id: <3667deb0911affbf999b99f87c31c77d5e870cd2.1593690707.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] Revert "powerpc/kasan: Fix shadow pages allocation
 failure"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  2 Jul 2020 11:52:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d2a91cef9bbdeb87b7449fdab1a6be6000930210.

This commit moved too much work in kasan_init(). The allocation
of shadow pages has to be moved for the reason explained in that
patch, but the allocation of page tables still need to be done
before switching to the final hash table.

First revert the incorrect commit, following patch redoes it
properly.

Reported-by: Erhard F. <erhard_f@mailbox.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208181
Fixes: d2a91cef9bbd ("powerpc/kasan: Fix shadow pages allocation failure")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h      | 2 ++
 arch/powerpc/mm/init_32.c             | 2 ++
 arch/powerpc/mm/kasan/kasan_init_32.c | 4 +---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index be85c7005fb1..d635b96c7ea6 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -27,10 +27,12 @@
 
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
+void kasan_mmu_init(void);
 void kasan_init(void);
 void kasan_late_init(void);
 #else
 static inline void kasan_init(void) { }
+static inline void kasan_mmu_init(void) { }
 static inline void kasan_late_init(void) { }
 #endif
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 5a5469eb3174..bf1717f8d5f4 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -171,6 +171,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	kasan_mmu_init();
+
 	setup_kup();
 
 	/* Shortly after that, the entire linear mapping will be available */
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 0760e1e754e4..4813c6d50889 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -117,7 +117,7 @@ static void __init kasan_unmap_early_shadow_vmalloc(void)
 	kasan_update_early_region(k_start, k_end, __pte(0));
 }
 
-static void __init kasan_mmu_init(void)
+void __init kasan_mmu_init(void)
 {
 	int ret;
 	struct memblock_region *reg;
@@ -146,8 +146,6 @@ static void __init kasan_mmu_init(void)
 
 void __init kasan_init(void)
 {
-	kasan_mmu_init();
-
 	kasan_remap_early_shadow_ro();
 
 	clear_page(kasan_early_shadow_page);
-- 
2.25.0

