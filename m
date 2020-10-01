Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631E627FF60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbgJAMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:42:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46020 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732028AbgJAMmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:42:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C2CSw6PJrz9tx8Y;
        Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KDCRpuSA3p-u; Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C2CSw55bgz9vBKm;
        Thu,  1 Oct 2020 14:42:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E7358B97D;
        Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9IEdtMjbzLEN; Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5301D8B96F;
        Thu,  1 Oct 2020 14:42:42 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 35AD465ED9; Thu,  1 Oct 2020 12:42:42 +0000 (UTC)
Message-Id: <1746e2d11ea90c3f45877e1fcc6c79ce96cf6b98.1601556145.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4/6] powerpc/time: Remove get_tbu()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  1 Oct 2020 12:42:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_tbu() is redundant with mftbu() and is not used anymore.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/time.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 3ef0f4b3299e..c4ea81c966b0 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -52,11 +52,6 @@ static inline unsigned long get_tbl(void)
 {
 	return mftb();
 }
-
-static inline unsigned int get_tbu(void)
-{
-	return mftbu();
-}
 #endif /* !CONFIG_PPC64 */
 
 static inline unsigned int get_rtcl(void)
-- 
2.25.0

