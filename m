Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C228A28D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390610AbgJJW6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:58:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14003 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbgJJTvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:51:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C7sRQ6nGwzB09ZY;
        Sat, 10 Oct 2020 19:30:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id M0OXNRI91eu1; Sat, 10 Oct 2020 19:30:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C7sRQ3vnkzB09ZX;
        Sat, 10 Oct 2020 19:30:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75A7F8B77D;
        Sat, 10 Oct 2020 19:31:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QlNDzOYQ_dmU; Sat, 10 Oct 2020 19:31:00 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FF4F8B75B;
        Sat, 10 Oct 2020 19:31:00 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F3B5C663C6; Sat, 10 Oct 2020 17:30:59 +0000 (UTC)
Message-Id: <ceede82fadf37f3b8275e61fcf8cf29a3e2ec7fe.1602351011.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: Fix verification of MMU_FTR_TYPE_44x
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alastair D'Silva <alastair@d-silva.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 10 Oct 2020 17:30:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU_FTR_TYPE_44x cannot be checked by cpu_has_feature()

Use mmu_has_feature() instead

Fixes: 23eb7f560a2a ("powerpc: Convert flush_icache_range & friends to C")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index ddc32cc1b6cf..b7586d8c835b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -530,7 +530,7 @@ void __flush_dcache_icache(void *p)
 	 * space occurs, before returning to user space.
 	 */
 
-	if (cpu_has_feature(MMU_FTR_TYPE_44x))
+	if (mmu_has_feature(MMU_FTR_TYPE_44x))
 		return;
 
 	invalidate_icache_range(addr, addr + PAGE_SIZE);
-- 
2.25.0

