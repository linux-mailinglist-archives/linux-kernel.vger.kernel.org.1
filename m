Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D928AFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgJLIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:06:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10956 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgJLIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:06:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C8rqX1BBsz9tyP4;
        Mon, 12 Oct 2020 10:06:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QnCD79kA37fx; Mon, 12 Oct 2020 10:06:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C8rqW5mqBz9tyNJ;
        Mon, 12 Oct 2020 10:06:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE2F18B788;
        Mon, 12 Oct 2020 10:06:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GC5UHqs-Fr9V; Mon, 12 Oct 2020 10:06:52 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD55B8B783;
        Mon, 12 Oct 2020 10:06:52 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8EA6D66441; Mon, 12 Oct 2020 08:06:52 +0000 (UTC)
Message-Id: <8cc5ec2490ed584bb67fdd231b96cc65976126ab.1602489988.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: Add mask of always present MMU features
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Oct 2020 08:06:52 +0000 (UTC)
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
index d134f8f8099f..097f23c28c68 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -203,8 +203,30 @@ enum {
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
+		~0,
+};
+
 static inline bool early_mmu_has_feature(unsigned long feature)
 {
+	if (MMU_FTRS_ALWAYS & feature)
+		return true;
+
 	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
@@ -233,6 +255,9 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 	}
 #endif
 
+	if (MMU_FTRS_ALWAYS & feature)
+		return true;
+
 	if (!(MMU_FTRS_POSSIBLE & feature))
 		return false;
 
-- 
2.25.0

