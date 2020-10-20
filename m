Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1328AF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgJLIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:05:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22518 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgJLIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:05:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C8rpK1PySz9tyNJ;
        Mon, 12 Oct 2020 10:05:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W8I7jqvhoL4U; Mon, 12 Oct 2020 10:05:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C8rpK0hsWz9txP0;
        Mon, 12 Oct 2020 10:05:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36CE08B788;
        Mon, 12 Oct 2020 10:05:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v7DS3HJyqhkd; Mon, 12 Oct 2020 10:05:50 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E7D78B783;
        Mon, 12 Oct 2020 10:05:50 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D315966441; Mon, 12 Oct 2020 08:05:49 +0000 (UTC)
Message-Id: <d01d7613664fafa43de1f1ae89924075bc24241c.1602489931.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: MMU_FTR_NEED_DTLB_SW_LRU is only possible with
 CONFIG_PPC_83xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Oct 2020 08:05:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only mpc83xx will set MMU_FTR_NEED_DTLB_SW_LRU and its
definition is enclosed in #ifdef CONFIG_PPC_83xx.

Make MMU_FTR_NEED_DTLB_SW_LRU possible only when
CONFIG_PPC_83xx is set.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index b4367fd0b477..d134f8f8099f 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -172,7 +172,10 @@ enum {
 		MMU_FTR_TYPE_47x | MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL |
 #endif
 #ifdef CONFIG_PPC_BOOK3S_32
-		MMU_FTR_USE_HIGH_BATS | MMU_FTR_NEED_DTLB_SW_LRU |
+		MMU_FTR_USE_HIGH_BATS |
+#endif
+#ifdef CONFIG_PPC_83xx
+		MMU_FTR_NEED_DTLB_SW_LRU |
 #endif
 #ifdef CONFIG_PPC_BOOK3E_64
 		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
-- 
2.25.0

