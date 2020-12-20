Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1A2DF671
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgLTSTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:19:15 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:65398 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgLTSTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:19:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CzW7M2DRFzB09ZG;
        Sun, 20 Dec 2020 19:18:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id i3fE8xTfQqI2; Sun, 20 Dec 2020 19:18:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CzW7M0dKgzB09ZF;
        Sun, 20 Dec 2020 19:18:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF8898B77F;
        Sun, 20 Dec 2020 19:18:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xmZ34ytWz3je; Sun, 20 Dec 2020 19:18:26 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EBEC8B75B;
        Sun, 20 Dec 2020 19:18:26 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5F76866945; Sun, 20 Dec 2020 18:18:26 +0000 (UTC)
Message-Id: <df05d53eed1210cf1aa76d1fb44aa0fab29c018e.1608488286.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/time: Force inlining of get_tb()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 20 Dec 2020 18:18:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force inlining of get_tb() in order to avoid getting
following function in vdso32, leading to suboptimal
performance in clock_gettime()

00000688 <.get_tb>:
 688:	7c 6d 42 a6 	mftbu   r3
 68c:	7c 8c 42 a6 	mftb    r4
 690:	7d 2d 42 a6 	mftbu   r9
 694:	7c 03 48 40 	cmplw   r3,r9
 698:	40 e2 ff f0 	bne+    688 <.get_tb>
 69c:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/timebase.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vdso/timebase.h b/arch/powerpc/include/asm/vdso/timebase.h
index b558b07959ce..881f655caa0a 100644
--- a/arch/powerpc/include/asm/vdso/timebase.h
+++ b/arch/powerpc/include/asm/vdso/timebase.h
@@ -49,7 +49,7 @@ static inline unsigned long get_tbl(void)
 	return mftb();
 }
 
-static inline u64 get_tb(void)
+static __always_inline u64 get_tb(void)
 {
 	unsigned int tbhi, tblo, tbhi2;
 
-- 
2.25.0

