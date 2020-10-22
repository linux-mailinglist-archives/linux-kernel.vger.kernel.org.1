Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49BB295857
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508259AbgJVG3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3323 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503649AbgJVG3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBh0PxMz9vBKr;
        Thu, 22 Oct 2020 08:29:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id glfOELAvm8NC; Thu, 22 Oct 2020 08:29:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBg6dcRz9vBKl;
        Thu, 22 Oct 2020 08:29:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D2D4A8B805;
        Thu, 22 Oct 2020 08:29:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8wfWyKXbXtXV; Thu, 22 Oct 2020 08:29:32 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E6058B769;
        Thu, 22 Oct 2020 08:29:32 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 824C2667EF; Thu, 22 Oct 2020 06:29:32 +0000 (UTC)
Message-Id: <3878ea30706839fcff9196790ff3f99c128c3f6a.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 07/20] powerpc/32s: Declare Hash related vars as __initdata
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash related vars are used at init only.

Declare them in __initdata.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index c0c0f2a50f86..be1211293bc1 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -33,10 +33,10 @@
 
 u8 __initdata early_hash[SZ_256K] __aligned(SZ_256K) = {0};
 
-static struct hash_pte *Hash = (struct hash_pte *)early_hash;
-static unsigned long Hash_size, Hash_mask;
-unsigned long _SDR1;
-static unsigned int hash_mb, hash_mb2;
+static struct hash_pte __initdata *Hash = (struct hash_pte *)early_hash;
+static unsigned long __initdata Hash_size, Hash_mask;
+static unsigned int __initdata hash_mb, hash_mb2;
+unsigned long __initdata _SDR1;
 
 struct ppc_bat BATS[8][2];	/* 8 pairs of IBAT, DBAT */
 
-- 
2.25.0

