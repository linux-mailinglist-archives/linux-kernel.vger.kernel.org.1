Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF71C76F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgEFQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:48:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2785 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbgEFQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwQ0Hkrz9tybj;
        Wed,  6 May 2020 18:48:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3HTx1EqzAKdt; Wed,  6 May 2020 18:48:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwP6T2Mz9txk0;
        Wed,  6 May 2020 18:48:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC0638B7C5;
        Wed,  6 May 2020 18:48:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id j45Xcg18OEBK; Wed,  6 May 2020 18:48:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FAFA8B7C3;
        Wed,  6 May 2020 18:48:07 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 00C0F65911; Wed,  6 May 2020 16:48:06 +0000 (UTC)
Message-Id: <2be05185972e755ffc830073c4d3e01447d68118.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 02/45] powerpc/kasan: Fix issues by lowering
 KASAN_SHADOW_END
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, KASAN_SHADOW_END is 0x100000000, which
is 0 in 32 bits representation.

This leads to a couple of issues:
- kasan_remap_early_shadow_ro() does nothing because the comparison
k_cur < k_end is always false.
- In ptdump, address comparison for markers display fails and the
marker's name is printed at the start of the KASAN area instead of
being printed at the end.

However, there is no need to shadow the KASAN shadow area itself,
so the KASAN shadow area can stop shadowing memory at the start
of itself.

With a PAGE_OFFSET set to 0xc0000000, KASAN shadow area is then going
from 0xf8000000 to 0xff000000.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: cbd18991e24f ("powerpc/mm: Fix an Oops in kasan_mmu_init()")
Cc: stable@vger.kernel.org
---
 arch/powerpc/include/asm/kasan.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index fbff9ff9032e..fc900937f653 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -23,9 +23,7 @@
 
 #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
 
-#define KASAN_SHADOW_END	0UL
-
-#define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
+#define KASAN_SHADOW_END	(-(-KASAN_SHADOW_START >> KASAN_SHADOW_SCALE_SHIFT))
 
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
-- 
2.25.0

