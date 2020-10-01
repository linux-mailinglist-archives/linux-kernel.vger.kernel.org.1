Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06A127FDF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgJAK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:59:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3119 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbgJAK7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:59:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C299h2c1qz9vCy8;
        Thu,  1 Oct 2020 12:59:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4NcroDXAJwLL; Thu,  1 Oct 2020 12:59:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C299h1Lblz9vCyC;
        Thu,  1 Oct 2020 12:59:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA4E68B903;
        Thu,  1 Oct 2020 12:59:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hzS0rJlOZJcq; Thu,  1 Oct 2020 12:59:21 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C8F68B975;
        Thu,  1 Oct 2020 12:59:21 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EFEA165ED8; Thu,  1 Oct 2020 10:59:20 +0000 (UTC)
Message-Id: <a0fc81cd85121407726bcf480fc9a0d8e7617fce.1601549933.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/time: Remove ifdef in get_vtb()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 10:59:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPRN_VTB and CPU_FTR_ARCH_207S are always defined,
no need of an ifdef.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/time.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index cb326720a8a1..6c663a382a75 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -80,10 +80,9 @@ static inline u64 get_rtc(void)
 
 static inline u64 get_vtb(void)
 {
-#ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		return mfspr(SPRN_VTB);
-#endif
+
 	return 0;
 }
 
-- 
2.25.0

