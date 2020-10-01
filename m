Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF927FF61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgJAMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:42:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24732 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbgJAMms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:42:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C2CSz1CQXz9tx8c;
        Thu,  1 Oct 2020 14:42:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uOcDbj9V1s3a; Thu,  1 Oct 2020 14:42:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C2CSz01zQz9tx8Z;
        Thu,  1 Oct 2020 14:42:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A62F28B96F;
        Thu,  1 Oct 2020 14:42:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wOjr1tl4dqOk; Thu,  1 Oct 2020 14:42:44 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E1BA8B903;
        Thu,  1 Oct 2020 14:42:44 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5423265ED8; Thu,  1 Oct 2020 12:42:44 +0000 (UTC)
Message-Id: <47e49717d2643169ffcbe5d507f184cf49f0fe95.1601556145.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 6/6] powerpc/time: Make get_tb() common to PPC32 and PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 12:42:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mftbu() is always defined now, so the #ifdef can be removed
and replaced by an IS_ENABLED(CONFIG_PPC64) inside the
PPC32 version of get_tb().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/time.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 01b054b9766f..418edaba8bd0 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -74,16 +74,13 @@ static inline u64 get_vtb(void)
 	return 0;
 }
 
-#ifdef CONFIG_PPC64
-static inline u64 get_tb(void)
-{
-	return mftb();
-}
-#else /* CONFIG_PPC64 */
 static inline u64 get_tb(void)
 {
 	unsigned int tbhi, tblo, tbhi2;
 
+	if (IS_ENABLED(CONFIG_PPC64))
+		return mftb();
+
 	do {
 		tbhi = mftbu();
 		tblo = mftb();
@@ -92,7 +89,6 @@ static inline u64 get_tb(void)
 
 	return ((u64)tbhi << 32) | tblo;
 }
-#endif /* !CONFIG_PPC64 */
 
 static inline u64 get_tb_or_rtc(void)
 {
-- 
2.25.0

