Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2B295869
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508353AbgJVGah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:30:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503656AbgJVG3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBc0CNcz9vBKg;
        Thu, 22 Oct 2020 08:29:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bvukwrtbdk_M; Thu, 22 Oct 2020 08:29:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBb6PmQz9vBKb;
        Thu, 22 Oct 2020 08:29:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C90CA8B805;
        Thu, 22 Oct 2020 08:29:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JcQRQGpUlnlX; Thu, 22 Oct 2020 08:29:28 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7903E8B769;
        Thu, 22 Oct 2020 08:29:28 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5D2C1667EF; Thu, 22 Oct 2020 06:29:28 +0000 (UTC)
Message-Id: <4a58831da6d6ba4fe309b94aa1dd8f02982d46b2.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 03/20] powerpc/mm: Remove flush_tlb_page_nohash()
 prototype.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_tlb_page_nohash() was removed by
commit 703b41ad1a87 ("powerpc/mm: remove flush_tlb_page_nohash")

Remove stale prototype and comment.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 1 -
 arch/powerpc/include/asm/nohash/tlbflush.h    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index 068085b709fb..29e292be4f1b 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -8,7 +8,6 @@
  */
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
diff --git a/arch/powerpc/include/asm/nohash/tlbflush.h b/arch/powerpc/include/asm/nohash/tlbflush.h
index b1d8fec29169..1edb7243e515 100644
--- a/arch/powerpc/include/asm/nohash/tlbflush.h
+++ b/arch/powerpc/include/asm/nohash/tlbflush.h
@@ -10,7 +10,6 @@
  *  - local_flush_tlb_mm(mm, full) flushes the specified mm context on
  *                           the local processor
  *  - local_flush_tlb_page(vma, vmaddr) flushes one page on the local processor
- *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *
-- 
2.25.0

