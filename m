Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C146A300001
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbhAVKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:16:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52997 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbhAVKJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:09:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DMZdT2JJzz9vBn9;
        Fri, 22 Jan 2021 11:05:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9XZGx_FMhi3h; Fri, 22 Jan 2021 11:05:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DMZdT1Lv3z9vBml;
        Fri, 22 Jan 2021 11:05:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AD688B818;
        Fri, 22 Jan 2021 11:05:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7yAqySCS1chN; Fri, 22 Jan 2021 11:05:34 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 166048B817;
        Fri, 22 Jan 2021 11:05:34 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E44A566AAE; Fri, 22 Jan 2021 10:05:33 +0000 (UTC)
Message-Id: <9aac66a1967b007e2f5c281549ded7d76c3557ea.1611309841.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611309841.git.christophe.leroy@csgroup.eu>
References: <cover.1611309841.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 10/14] powerpc/32: Use LOAD_REG_IMMEDIATE() to load MSR
 values
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Jan 2021 10:05:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

40x MSR value doesn't fit on 15 bits.

LOAD_REG_IMMEDIATE() in places that will be used also
with 40x in the next patch.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index a7087930a844..48c0096fecc1 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -69,7 +69,7 @@
 
 .macro EXCEPTION_PROLOG_2 handle_dar_dsisr=0
 #ifdef CONFIG_VMAP_STACK
-	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~(MSR_IR | MSR_RI)) /* can take DTLB miss */
 	mtmsr	r11
 	isync
 	mfspr	r11, SPRN_SPRG_SCRATCH2
@@ -134,7 +134,7 @@
 	lwz	r1,TASK_STACK-THREAD(r12)
 	beq-	99f
 	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
-	li	r10, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
+	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL & ~(MSR_IR | MSR_RI)) /* can take DTLB miss */
 	mtmsr	r10
 	isync
 	tovirt(r12, r12)
-- 
2.25.0

