Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC902881BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgJIFhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 01:37:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48642 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgJIFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:37:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C6xf20sQfzB09bJ;
        Fri,  9 Oct 2020 07:36:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Xegd8rSQVMv5; Fri,  9 Oct 2020 07:36:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C6xf201WBzB09bG;
        Fri,  9 Oct 2020 07:36:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3B418B86F;
        Fri,  9 Oct 2020 07:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P_C4BzXRRlQv; Fri,  9 Oct 2020 07:36:57 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 761D58B76C;
        Fri,  9 Oct 2020 07:36:57 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 02EA1663BB; Fri,  9 Oct 2020 05:36:57 +0000 (UTC)
Message-Id: <a584afe92c886cbf5ba8664a600afd0282a0a59c.1602221789.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/8xx: Fix instruction TLB miss exception with perf
 enabled
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  9 Oct 2020 05:36:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf is enabled, r11 must also be restored when CONFIG_HUGETLBFS
is selected.

Fixes: a891c43b97d3 ("powerpc/8xx: Prepare handlers for _PAGE_HUGE for 512k pages.")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9f359d3fba74..32d85387bdc5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -268,7 +268,7 @@ InstructionTLBMiss:
 	addi	r10, r10, 1
 	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP) || defined(CONFIG_HUGETLBFS)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 #endif
 	rfi
-- 
2.25.0

