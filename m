Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CC279FF7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgI0JQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:16:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23034 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgI0JQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg580Kyyz9vCyG;
        Sun, 27 Sep 2020 11:16:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zQB8bIUdlbXe; Sun, 27 Sep 2020 11:16:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg576jntz9vCxw;
        Sun, 27 Sep 2020 11:16:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7ECAC8B771;
        Sun, 27 Sep 2020 11:16:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kUbUusiT4hHC; Sun, 27 Sep 2020 11:16:48 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42CE08B75B;
        Sun, 27 Sep 2020 11:16:48 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 260B765DE8; Sun, 27 Sep 2020 09:16:48 +0000 (UTC)
Message-Id: <9902590d410cd1c2afa48b83b277faf0711f07b2.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 30/30] powerpc/vdso: Cleanup vdso.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the guard define to _ASM_POWERPC_VDSO_H

And remove useless #ifdef __KERNEL__

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 2448419cb3e5..8542e9bbeead 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -1,8 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PPC64_VDSO_H__
-#define __PPC64_VDSO_H__
-
-#ifdef __KERNEL__
+#ifndef _ASM_POWERPC_VDSO_H
+#define _ASM_POWERPC_VDSO_H
 
 /* Default map addresses for 32bit vDSO */
 #define VDSO32_MBASE	0x100000
@@ -54,6 +52,4 @@ int vdso_getcpu_init(void);
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __KERNEL__ */
-
-#endif /* __PPC64_VDSO_H__ */
+#endif /* _ASM_POWERPC_VDSO_H */
-- 
2.25.0

