Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB823D2A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHEUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 16:14:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19893 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgHEQVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:21:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMFqN1M0jz9vD3y;
        Wed,  5 Aug 2020 17:27:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FrQjfHC17EgI; Wed,  5 Aug 2020 17:27:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMFqN0Yv4z9vD3n;
        Wed,  5 Aug 2020 17:27:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BC418B7ED;
        Wed,  5 Aug 2020 17:27:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1ILtOrr_uo5w; Wed,  5 Aug 2020 17:27:30 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2CCD8B7EC;
        Wed,  5 Aug 2020 17:27:29 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C654A65BC2; Wed,  5 Aug 2020 15:27:29 +0000 (UTC)
Message-Id: <6eddca2d5611fd57312a88eae31278c87a8fc99d.1596641224.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Aug 2020 15:27:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On BOOK3S_32, when we have modules and strict kernel RWX, modules
are not in vmalloc space but in a dedicated segment that is
below PAGE_OFFSET.

So KASAN_SHADOW_START must take it into account.

MODULES_VADDR can't be used because it is not defined yet
in kasan.h

Fixes: 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules with STRICT_KERNEL_RWX")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index d635b96c7ea6..7355ed05e65e 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -15,11 +15,18 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/page.h>
+#include <linux/sizes.h>
 
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
+#if defined(CONFIG_PPC_BOOK3S_32) && defined(CONFIG_MODULES) && defined(CONFIG_STRICT_KERNEL_RWX)
+#define KASAN_KERN_START	ALIGN_DOWN(PAGE_OFFSET - SZ_256M, SZ_256M)
+#else
+#define KASAN_KERN_START	PAGE_OFFSET
+#endif
+
 #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
-				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
+				 (KASAN_KERN_START >> KASAN_SHADOW_SCALE_SHIFT))
 
 #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
 
-- 
2.25.0

