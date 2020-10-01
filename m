Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E027FF5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgJAMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:42:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63809 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732028AbgJAMmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:42:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C2CSt1kgDz9twnx;
        Thu,  1 Oct 2020 14:42:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Uze5SQgXDq8H; Thu,  1 Oct 2020 14:42:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C2CSt0dCxz9twnv;
        Thu,  1 Oct 2020 14:42:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D85B98B96F;
        Thu,  1 Oct 2020 14:42:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zzfhcmh3VLXJ; Thu,  1 Oct 2020 14:42:39 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E6E58B903;
        Thu,  1 Oct 2020 14:42:39 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2295D65ED8; Thu,  1 Oct 2020 12:42:39 +0000 (UTC)
Message-Id: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/6] powerpc/time: Rename mftbl() to mftb()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 12:42:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC64, we have mftb().
On PPC32, we have mftbl() and an #define mftb() mftbl().

mftb() and mftbl() are equivalent, their purpose is to read the
content of SPRN_TRBL, as returned by 'mftb' simplified instruction.

binutils seems to define 'mftbl' instruction as an equivalent
of 'mftb'.

However in both 32 bits and 64 bits documentation, only 'mftb' is
defined, and when performing a disassembly with objdump, the displayed
instruction is 'mftb'

No need to have two ways to do the same thing with different
names, rename mftbl() to have only mftb().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h  | 5 ++---
 arch/powerpc/include/asm/time.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 788058af1d44..c66dcdb47c44 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1439,19 +1439,18 @@ static inline void msr_check_and_clear(unsigned long bits)
 #else /* __powerpc64__ */
 
 #if defined(CONFIG_PPC_8xx)
-#define mftbl()		({unsigned long rval;	\
+#define mftb()		({unsigned long rval;	\
 			asm volatile("mftbl %0" : "=r" (rval)); rval;})
 #define mftbu()		({unsigned long rval;	\
 			asm volatile("mftbu %0" : "=r" (rval)); rval;})
 #else
-#define mftbl()		({unsigned long rval;	\
+#define mftb()		({unsigned long rval;	\
 			asm volatile("mfspr %0, %1" : "=r" (rval) : \
 				"i" (SPRN_TBRL)); rval;})
 #define mftbu()		({unsigned long rval;	\
 			asm volatile("mfspr %0, %1" : "=r" (rval) : \
 				"i" (SPRN_TBRU)); rval;})
 #endif
-#define mftb()		mftbl()
 #endif /* !__powerpc64__ */
 
 #define mttbl(v)	asm volatile("mttbl %0":: "r"(v))
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index a80abf64c8a5..b0fb8456305f 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -50,7 +50,7 @@ struct div_result {
 
 static inline unsigned long get_tbl(void)
 {
-	return mftbl();
+	return mftb();
 }
 
 static inline unsigned int get_tbu(void)
-- 
2.25.0

