Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4328BC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbgJLPlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:41:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63219 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390203AbgJLPjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:39:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C92t45LYpz9v10q;
        Mon, 12 Oct 2020 17:39:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tIzJjLTsdFXn; Mon, 12 Oct 2020 17:39:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C92t447XWz9v10n;
        Mon, 12 Oct 2020 17:39:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51EFA8B793;
        Mon, 12 Oct 2020 17:39:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0doUTwML87kl; Mon, 12 Oct 2020 17:39:46 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E9718B792;
        Mon, 12 Oct 2020 17:39:46 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F0BF866440; Mon, 12 Oct 2020 15:39:45 +0000 (UTC)
Message-Id: <06bf0e094463533e7aec6900bddd435171e9f44f.1602517171.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc/mm: Add mask of always present MMU features
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Oct 2020 15:39:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the same principle as commit 773edeadf672 ("powerpc/mm: Add mask
of possible MMU features"), add mask for MMU features that are
always there in order to optimise out dead branches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Features must be anded with MMU_FTRS_POSSIBLE instead of ~0, otherwise
    MMU_FTRS_ALWAYS is ~0 when no #ifdef matches.
---
 arch/powerpc/include/asm/mmu.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 255a1837e9f7..64e7e7f7cda9 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -201,8 +201,30 @@ enum {
 		0,
 };
 
+enum {
+	MMU_FTRS_ALWAYS =
+#ifdef CONFIG_PPC_8xx
+		MMU_FTR_TYPE_8xx &
+#endif
+#ifdef CONFIG_40x
+		MMU_FTR_TYPE_40x &
+#endif
+#ifdef CONFIG_PPC_47x
+		MMU_FTR_TYPE_47x &
+#elif defined(CONFIG_44x)
+		MMU_FTR_TYPE_44x &
+#endif
+#if defined(CONFIG_E200) || defined(CONFIG_E500)
+		MMU_FTR_TYPE_FSL_E &
+#endif
+		MMU_FTRS_POSSIBLE,
+};
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

