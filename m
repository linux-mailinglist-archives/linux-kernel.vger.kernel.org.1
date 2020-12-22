Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD42E06A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgLVHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:12:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:56006 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgLVHMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:12:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D0SDk6DQcz9tx3y;
        Tue, 22 Dec 2020 08:11:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WKpCFi-AX3-2; Tue, 22 Dec 2020 08:11:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D0SDk4CqMz9tx3x;
        Tue, 22 Dec 2020 08:11:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 614998B7DC;
        Tue, 22 Dec 2020 08:11:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Fq3QTDTMuInt; Tue, 22 Dec 2020 08:11:19 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 049928B75E;
        Tue, 22 Dec 2020 08:11:19 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id C22E366969; Tue, 22 Dec 2020 07:11:18 +0000 (UTC)
Message-Id: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Fix RTAS machine check with VMAP stack
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Dec 2020 07:11:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have VMAP stack, exception prolog 1 sets r1, not r11.

Fixes: da7bb43ab9da ("powerpc/32: Fix vmap stack - Properly set r1 before activating MMU")
Fixes: d2e006036082 ("powerpc/32: Use SPRN_SPRG_SCRATCH2 in exception prologs")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 349bf3f0c3af..fbc48a500846 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -260,9 +260,16 @@ __secondary_hold_acknowledge:
 MachineCheck:
 	EXCEPTION_PROLOG_0
 #ifdef CONFIG_PPC_CHRP
+#ifdef CONFIG_VMAP_STACK
+	mtspr	SPRN_SPRG_SCRATCH2,r1
+	mfspr	r1, SPRN_SPRG_THREAD
+	lwz	r1, RTAS_SP(r1)
+	cmpwi	cr1, r1, 0
+#else
 	mfspr	r11, SPRN_SPRG_THREAD
 	lwz	r11, RTAS_SP(r11)
 	cmpwi	cr1, r11, 0
+#endif
 	bne	cr1, 7f
 #endif /* CONFIG_PPC_CHRP */
 	EXCEPTION_PROLOG_1 for_rtas=1
-- 
2.25.0

