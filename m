Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5DA2E1911
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgLWGlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:41:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:27980 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgLWGlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:41:32 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D13W5272gz9v0Pj;
        Wed, 23 Dec 2020 07:40:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id g4TacWaSB2wg; Wed, 23 Dec 2020 07:40:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D13W509RSz9ttCG;
        Wed, 23 Dec 2020 07:40:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DFE518B783;
        Wed, 23 Dec 2020 07:40:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9GvY3TWZVReU; Wed, 23 Dec 2020 07:40:49 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AA848B75F;
        Wed, 23 Dec 2020 07:40:49 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4B6A266975; Wed, 23 Dec 2020 06:40:49 +0000 (UTC)
Message-Id: <8c8b1231b2db283f3aa5b405e0c10200dd352ccb.1608705560.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Fix RTAS machine check with VMAP stack - again
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 23 Dec 2020 06:40:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it is not a RTAS machine check, don't trash r1
because it is needed by prolog 1.

Fixes: 9c7422b92cb2 ("powerpc/32s: Fix RTAS machine check with VMAP stack")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Sorry Michael for this last minute fix of the fix.

 arch/powerpc/kernel/head_book3s_32.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index fbc48a500846..858fbc8b19f3 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -265,12 +265,14 @@ MachineCheck:
 	mfspr	r1, SPRN_SPRG_THREAD
 	lwz	r1, RTAS_SP(r1)
 	cmpwi	cr1, r1, 0
+	bne	cr1, 7f
+	mfspr	r1, SPRN_SPRG_SCRATCH2
 #else
 	mfspr	r11, SPRN_SPRG_THREAD
 	lwz	r11, RTAS_SP(r11)
 	cmpwi	cr1, r11, 0
-#endif
 	bne	cr1, 7f
+#endif
 #endif /* CONFIG_PPC_CHRP */
 	EXCEPTION_PROLOG_1 for_rtas=1
 7:	EXCEPTION_PROLOG_2
-- 
2.25.0

