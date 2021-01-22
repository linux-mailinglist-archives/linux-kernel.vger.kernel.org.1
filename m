Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA82FFD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbhAVHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:16:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23920 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbhAVHP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:15:57 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DMVrl4BvDzB09Zl;
        Fri, 22 Jan 2021 08:15:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id umH4X6JsF3-A; Fri, 22 Jan 2021 08:15:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DMVrl3G52zB09Zk;
        Fri, 22 Jan 2021 08:15:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65FCA8B813;
        Fri, 22 Jan 2021 08:15:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8r5lVdIzCkrk; Fri, 22 Jan 2021 08:15:04 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D06F8B773;
        Fri, 22 Jan 2021 08:15:04 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E01D966AB5; Fri, 22 Jan 2021 07:15:03 +0000 (UTC)
Message-Id: <69f9968f4b592fefda55227f0f7430ea612cc950.1611299687.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Use r2 in wrtspr() instead of r0
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Jan 2021 07:15:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wrtspr() is a function to write an arbitrary value in a special
register. It is used on 8xx to write to SPRN_NRI, SPRN_EID and
SPRN_EIE. Writing any value to one of those will play with MSR EE
and MSR RI regardless of that value.

r0 is used many places in the generated code and using r0 for
that creates an unnecessary dependency of this instruction with
preceding ones using r0 in a few places in vmlinux.

r2 is most likely the most stable register as it contains the
pointer to 'current'.

Using r2 instead of r0 avoids that unnecessary dependency.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e40a921d78f9..32a9020e93ab 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1392,8 +1392,7 @@ static inline void mtmsr_isync(unsigned long val)
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 #endif
-#define wrtspr(rn)	asm volatile("mtspr " __stringify(rn) ",0" : \
-				     : : "memory")
+#define wrtspr(rn)	asm volatile("mtspr " __stringify(rn) ",2" : : : "memory")
 
 static inline void wrtee(unsigned long val)
 {
-- 
2.25.0

