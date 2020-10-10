Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384C228A1D5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbgJJW3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:29:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7888 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbgJJSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:51:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C7pQ038f7z9v1Jc;
        Sat, 10 Oct 2020 17:14:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id U2V-ulJSG59x; Sat, 10 Oct 2020 17:14:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C7pQ00q7yz9v1JX;
        Sat, 10 Oct 2020 17:14:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A14F68B77D;
        Sat, 10 Oct 2020 17:14:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SjPvFgJW9Dac; Sat, 10 Oct 2020 17:14:33 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41CD38B75B;
        Sat, 10 Oct 2020 17:14:33 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 20520663C3; Sat, 10 Oct 2020 15:14:33 +0000 (UTC)
Message-Id: <25afacaa0688695c8c5e9a253ebe77640bf13db7.1602342819.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3f2386f94fada00b541be76d6bc4b6409746a72d.1602342819.git.christophe.leroy@csgroup.eu>
References: <3f2386f94fada00b541be76d6bc4b6409746a72d.1602342819.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/4] powerpc/8xx: Fix TLB Miss exceptions with CONFIG_SWAP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 10 Oct 2020 15:14:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SWAP is set, _PAGE_ACCESSED gets ANDed with
_PAGE_PRESENT. But during several changes of _PAGE_ACCESSED value,
this operation which is based on bit rotation has been forgotten.

As of today it doesn't work.

Update to the rotation to the correct number of bits.

Fixes: 5f356497c384 ("powerpc/8xx: remove unused _PAGE_WRITETHRU")
Fixes: e0a8e0d90a9f ("powerpc/8xx: Handle PAGE_USER via APG bits")
Fixes: 5b2753fc3e8a ("powerpc/8xx: Implementation of PAGE_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 32d85387bdc5..83101c5888e3 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -239,7 +239,7 @@ InstructionTLBMiss:
 	mtspr	SPRN_MI_TWC, r11
 #endif
 #ifdef CONFIG_SWAP
-	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
+	rlwinm	r11, r10, 32-7, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
@@ -317,7 +317,7 @@ DataStoreTLBMiss:
 	 * r10 = (r10 & ~PRESENT) | r11;
 	 */
 #ifdef CONFIG_SWAP
-	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
+	rlwinm	r11, r10, 32-7, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
-- 
2.25.0

