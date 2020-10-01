Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4408E27FF5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgJAMmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:42:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46312 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbgJAMmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:42:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C2CSt5lgqz9twyY;
        Thu,  1 Oct 2020 14:42:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ee-S4nOmSyib; Thu,  1 Oct 2020 14:42:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C2CSt4ZHCz9twnv;
        Thu,  1 Oct 2020 14:42:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 852758B97A;
        Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XmSyWz3tLv_U; Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 434E28B903;
        Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 283A765ED8; Thu,  1 Oct 2020 12:42:40 +0000 (UTC)
Message-Id: <6bf23ec744aab4ba63506a011f6a145ea35d620d.1601556145.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/6] powerpc/time: Make mftb() common to PPC32 and PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 12:42:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to have two versions that are identical.

CONFIG_PPC_CELL is only selected by PPC64 targets.
CONFIG_E500 is the only PPC64 target selecting CONFIG_FSL_BOOK3E.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c66dcdb47c44..f877a576b338 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1419,8 +1419,7 @@ static inline void msr_check_and_clear(unsigned long bits)
 		__msr_check_and_clear(bits);
 }
 
-#ifdef __powerpc64__
-#if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
+#if defined(CONFIG_PPC_CELL) || defined(CONFIG_E500)
 #define mftb()		({unsigned long rval;				\
 			asm volatile(					\
 				"90:	mfspr %0, %2;\n"		\
@@ -1430,28 +1429,23 @@ static inline void msr_check_and_clear(unsigned long bits)
 			: "=r" (rval) \
 			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL) : "cr0"); \
 			rval;})
+#elif defined(CONFIG_PPC_8xx)
+#define mftb()		({unsigned long rval;	\
+			asm volatile("mftbl %0" : "=r" (rval)); rval;})
 #else
 #define mftb()		({unsigned long rval;	\
 			asm volatile("mfspr %0, %1" : \
 				     "=r" (rval) : "i" (SPRN_TBRL)); rval;})
 #endif /* !CONFIG_PPC_CELL */
 
-#else /* __powerpc64__ */
-
 #if defined(CONFIG_PPC_8xx)
-#define mftb()		({unsigned long rval;	\
-			asm volatile("mftbl %0" : "=r" (rval)); rval;})
 #define mftbu()		({unsigned long rval;	\
 			asm volatile("mftbu %0" : "=r" (rval)); rval;})
 #else
-#define mftb()		({unsigned long rval;	\
-			asm volatile("mfspr %0, %1" : "=r" (rval) : \
-				"i" (SPRN_TBRL)); rval;})
 #define mftbu()		({unsigned long rval;	\
 			asm volatile("mfspr %0, %1" : "=r" (rval) : \
 				"i" (SPRN_TBRU)); rval;})
 #endif
-#endif /* !__powerpc64__ */
 
 #define mttbl(v)	asm volatile("mttbl %0":: "r"(v))
 #define mttbu(v)	asm volatile("mttbu %0":: "r"(v))
-- 
2.25.0

