Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BEE27FF5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgJAMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:42:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5784 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbgJAMmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:42:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C2CSw6Lrnz9tx8X;
        Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DG2Gqi6lg23E; Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C2CSw5338z9twnv;
        Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CFC08B97A;
        Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0LHxUKLwaS-p; Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 333398B903;
        Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2E63365ED8; Thu,  1 Oct 2020 12:42:41 +0000 (UTC)
Message-Id: <41573406a4eab98838decaa91649086fef1e6119.1601556145.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/6] powerpc/time: Avoid using get_tbl() and get_tbu()
 internally
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 12:42:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_tbl() is confusing as it returns the content of TBL register
on PPC32 but the concatenation of TBL and TBU on PPC64.

Use mftb() instead.

Do the same with get_tbu() for consistency allthough it's name
is less confusing.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/delay.h | 2 +-
 arch/powerpc/include/asm/time.h  | 8 ++++----
 arch/powerpc/kernel/time.c       | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index 66963f7d3e64..51bb8c1476c7 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -54,7 +54,7 @@ extern void udelay(unsigned long usecs);
 ({                                                                             \
 	typeof(condition) __ret;                                               \
 	unsigned long __loops = tb_ticks_per_usec * timeout;                   \
-	unsigned long __start = get_tbl();                                     \
+	unsigned long __start = mftb();                                     \
                                                                                \
 	if (delay) {                                                           \
 		while (!(__ret = (condition)) &&                               \
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index b0fb8456305f..3ef0f4b3299e 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -97,9 +97,9 @@ static inline u64 get_tb(void)
 	unsigned int tbhi, tblo, tbhi2;
 
 	do {
-		tbhi = get_tbu();
-		tblo = get_tbl();
-		tbhi2 = get_tbu();
+		tbhi = mftbu();
+		tblo = mftb();
+		tbhi2 = mftbu();
 	} while (tbhi != tbhi2);
 
 	return ((u64)tbhi << 32) | tblo;
@@ -153,7 +153,7 @@ static inline unsigned long tb_ticks_since(unsigned long tstamp)
 		int delta = get_rtcl() - (unsigned int) tstamp;
 		return delta < 0 ? delta + 1000000000 : delta;
 	}
-	return get_tbl() - tstamp;
+	return mftb() - tstamp;
 }
 
 #define mulhwu(x,y) \
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f85539ebb513..a9cbd5a61585 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -467,8 +467,8 @@ void __delay(unsigned long loops)
 		 */
 		spin_cpu_relax();
 	} else {
-		start = get_tbl();
-		while (get_tbl() - start < loops)
+		start = mftb();
+		while (mftb() - start < loops)
 			spin_cpu_relax();
 	}
 	spin_end();
-- 
2.25.0

