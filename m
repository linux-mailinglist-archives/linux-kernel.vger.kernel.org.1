Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F01295856
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508236AbgJVG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6448 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503649AbgJVG3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBZ6kBLz9vBKf;
        Thu, 22 Oct 2020 08:29:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uUvs04MJXxVs; Thu, 22 Oct 2020 08:29:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBZ5vgNz9vBKb;
        Thu, 22 Oct 2020 08:29:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF7C58B805;
        Thu, 22 Oct 2020 08:29:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lzM74ZzbG_H7; Thu, 22 Oct 2020 08:29:27 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68EE58B769;
        Thu, 22 Oct 2020 08:29:27 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4C59E667EF; Thu, 22 Oct 2020 06:29:27 +0000 (UTC)
Message-Id: <4943775fbe91885eb3e09133b093aaf62e55c715.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 02/20] powerpc/mm: Add mask of always present MMU features
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the same principle as commit 773edeadf672 ("powerpc/mm: Add mask
of possible MMU features"), add mask for MMU features that are
always there in order to optimise out dead branches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 255a1837e9f7..7f57a9f7999f 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -201,8 +201,30 @@ enum {
 		0,
 };
 
+#ifdef CONFIG_PPC_8xx
+#define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_8xx
+#endif
+#ifdef CONFIG_40x
+#define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_40x
+#endif
+#ifdef CONFIG_PPC_47x
+#define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_47x
+#elif defined(CONFIG_44x)
+#define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_44x
+#endif
+#if defined(CONFIG_E200) || defined(CONFIG_E500)
+#define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_FSL_E
+#endif
+
+#ifndef MMU_FTRS_ALWAYS
+#define MMU_FTRS_ALWAYS		0
+#endif
+
 static inline bool early_mmu_has_feature(unsigned long feature)
 {
+	if (MMU_FTRS_ALWAYS & feature)
+		return true;
+
 	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
@@ -231,6 +253,9 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 	}
 #endif
 
+	if (MMU_FTRS_ALWAYS & feature)
+		return true;
+
 	if (!(MMU_FTRS_POSSIBLE & feature))
 		return false;
 
-- 
2.25.0

