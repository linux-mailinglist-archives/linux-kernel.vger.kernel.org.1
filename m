Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625582C2B31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389672AbgKXPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:25:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59034 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388999AbgKXPY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:24:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgSWC2zfnz9v0dB;
        Tue, 24 Nov 2020 16:24:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5jnjuQhZjD_K; Tue, 24 Nov 2020 16:24:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSWC0sfsz9v0d5;
        Tue, 24 Nov 2020 16:24:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B14288B7B3;
        Tue, 24 Nov 2020 16:24:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YM0h5sBoTXhZ; Tue, 24 Nov 2020 16:24:56 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 769F68B7AF;
        Tue, 24 Nov 2020 16:24:56 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 56608668E2; Tue, 24 Nov 2020 15:24:56 +0000 (UTC)
Message-Id: <bdafd651b4ac3a851fd09249f5f3699c50da29f2.1606231483.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/6] powerpc/8xx: Simplify INVALIDATE_ADJACENT_PAGES_CPU15
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 15:24:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have r11 available as a scratch register so
INVALIDATE_ADJACENT_PAGES_CPU15() can be simplified.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 775b4f4d011e..558c8e615ef9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -180,14 +180,13 @@ SystemCall:
  */
 
 #ifdef CONFIG_8xx_CPU15
-#define INVALIDATE_ADJACENT_PAGES_CPU15(addr)	\
-	addi	addr, addr, PAGE_SIZE;	\
-	tlbie	addr;			\
-	addi	addr, addr, -(PAGE_SIZE << 1);	\
-	tlbie	addr;			\
-	addi	addr, addr, PAGE_SIZE
+#define INVALIDATE_ADJACENT_PAGES_CPU15(addr, tmp)	\
+	addi	tmp, addr, PAGE_SIZE;	\
+	tlbie	tmp;			\
+	addi	tmp, addr, -PAGE_SIZE;	\
+	tlbie	tmp
 #else
-#define INVALIDATE_ADJACENT_PAGES_CPU15(addr)
+#define INVALIDATE_ADJACENT_PAGES_CPU15(addr, tmp)
 #endif
 
 InstructionTLBMiss:
@@ -198,7 +197,7 @@ InstructionTLBMiss:
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r10)
+	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
 	mtspr	SPRN_MD_EPN, r10
 #ifdef CONFIG_MODULES
 	mfcr	r11
-- 
2.25.0

