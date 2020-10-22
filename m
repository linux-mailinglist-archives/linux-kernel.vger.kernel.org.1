Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C50729585F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895667AbgJVGaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:30:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32167 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508278AbgJVG3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBs2Sm0z9vCyg;
        Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3PlS1H7JMURf; Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBs1j9xz9vCy4;
        Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 213A98B769;
        Thu, 22 Oct 2020 08:29:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id l7aQG5nXjsU0; Thu, 22 Oct 2020 08:29:42 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC6CB8B808;
        Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C1413667EF; Thu, 22 Oct 2020 06:29:41 +0000 (UTC)
Message-Id: <e51b5e2fe6bca623b33116403043d3a1b5eaf826.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 16/20] powerpc/32s: Move early_mmu_init() into mmu.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_mmu_init() is independent of MMU type and not
directly linked to tlb handling.

In a following patch, tlb.c will be restricted to HASH mmu.

Move early_mmu_init() into mmu.c which is common.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c | 4 ++++
 arch/powerpc/mm/book3s32/tlb.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index e7ff1ec73499..e58f48b07b46 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -473,3 +473,7 @@ void __init setup_kuap(bool disabled)
 		pr_warn("KUAP cannot be disabled yet on 6xx when compiled in\n");
 }
 #endif
+
+void __init early_init_mmu(void)
+{
+}
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 0d412953fe58..19f0ef950d77 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -104,7 +104,3 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 }
 EXPORT_SYMBOL(hash__flush_tlb_page);
-
-void __init early_init_mmu(void)
-{
-}
-- 
2.25.0

