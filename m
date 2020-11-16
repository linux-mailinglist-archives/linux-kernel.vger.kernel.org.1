Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD72B4A03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgKPPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:53:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18584 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbgKPPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:53:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CZYWY1ht4z9vDFh;
        Mon, 16 Nov 2020 16:53:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GuQQh-CZyMar; Mon, 16 Nov 2020 16:53:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CZYWY0v6pz9vDFc;
        Mon, 16 Nov 2020 16:53:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8829C8B7A3;
        Mon, 16 Nov 2020 16:53:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QkII7FUp4hCp; Mon, 16 Nov 2020 16:53:18 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 370418B7A6;
        Mon, 16 Nov 2020 16:53:18 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D5CC266884; Mon, 16 Nov 2020 15:53:17 +0000 (UTC)
Message-Id: <cc9129bdda1dbc2f0a09cf45fece7d0b0e690784.1605541983.git.christophe.leroy@csgroup.eu>
In-Reply-To: <40ae19c2bf013e3815a6ae0d6016963fdb0f51b7.1605541983.git.christophe.leroy@csgroup.eu>
References: <40ae19c2bf013e3815a6ae0d6016963fdb0f51b7.1605541983.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/5] powerpc/mm: Don't WARN() on KUAP fault
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Nov 2020 15:53:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN() in do_page_fault() is useless the problem is not in
do_page_fault() but on the place which generated the DSI exception.

We already have a dump from the Oops, no need of a WARN() in addition
The warning emitted by bad_kernel_fault() is good enough.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: New (Partly taken from patch "powerpc/mm: Kill the task on KUAP fault")
---
 arch/powerpc/include/asm/book3s/32/kup.h       | 6 +-----
 arch/powerpc/include/asm/book3s/64/kup-radix.h | 7 ++++---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h   | 3 +--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 32fd4452e960..a0117a9d5b06 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -183,11 +183,7 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	unsigned long begin = regs->kuap & 0xf0000000;
 	unsigned long end = regs->kuap << 28;
 
-	if (!is_write)
-		return false;
-
-	return WARN(address < begin || address >= end,
-		    "Bug: write fault blocked by segment registers !");
+	return is_write && (address < begin || address >= end);
 }
 
 #endif /* CONFIG_PPC_KUAP */
diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
index 3ee1ec60be84..8bdf559a4b32 100644
--- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -161,9 +161,10 @@ static inline void restore_user_access(unsigned long flags)
 static inline bool
 bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
-	return WARN(mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
-		    (regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ)),
-		    "Bug: %s fault blocked by AMR!", is_write ? "Write" : "Read");
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return false;
+
+	return !!(regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ));
 }
 #else /* CONFIG_PPC_KUAP */
 static inline void kuap_restore_amr(struct pt_regs *regs, unsigned long amr)
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 567cdc557402..17a4a616436f 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -63,8 +63,7 @@ static inline void restore_user_access(unsigned long flags)
 static inline bool
 bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
-	return WARN(!((regs->kuap ^ MD_APG_KUAP) & 0xff000000),
-		    "Bug: fault blocked by AP register !");
+	return !((regs->kuap ^ MD_APG_KUAP) & 0xff000000);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.0

