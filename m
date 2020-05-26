Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB141ADCC5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgDQL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 07:58:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3537 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbgDQL6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:58:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 493ZP83Y0lz9txqB;
        Fri, 17 Apr 2020 13:58:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jfPpSOV7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wfRM3Xf0C7Jq; Fri, 17 Apr 2020 13:58:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 493ZP82Tp4z9txq9;
        Fri, 17 Apr 2020 13:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587124716; bh=+6aCIvAjXcrudQUn/2M34iLi4CXsZ4oDJBUUcikxFjw=;
        h=From:Subject:To:Cc:Date:From;
        b=jfPpSOV7hWuqb8Yk/0+ksMs1N5K1NC948+vstNM2JYatw/u5nLYB30h/bIcG6AiSk
         qVkErlb8yiSGYtYNT2VEiItmaor9wtDSZNc53QgtQvG647ScRENCKupXFW46UN6xvE
         FxqjRyn0hBWTxxNhmsUgwh9um2ZTDCdXr4jfV8YU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F7538BB69;
        Fri, 17 Apr 2020 13:58:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T6GIoqH92K4h; Fri, 17 Apr 2020 13:58:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 47F068BB4C;
        Fri, 17 Apr 2020 13:58:37 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 05E3B657A3; Fri, 17 Apr 2020 11:58:36 +0000 (UTC)
Message-Id: <540242f7d4573f7cdf1b3bf46bb35f743b2cd68f.1587124651.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix CONFIG_PPC_KUAP_DEBUG on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 17 Apr 2020 11:58:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PPC_KUAP_DEBUG is not selectable because it depends on PPC_32
which doesn't exists.

Fixing it leads to a deadlock due to a vital register getting
clobbered in _switch().

Change dependency to PPC32 and use r0 instead of r4 in _switch()

Fixes: e2fb9f544431 ("powerpc/32: Prepare for Kernel Userspace Access Protection")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S         | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index a6371fb8f761..8420abd4ea1c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -732,7 +732,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 	stw	r10,_CCR(r1)
 	stw	r1,KSP(r3)	/* Set old stack pointer */
 
-	kuap_check r2, r4
+	kuap_check r2, r0
 #ifdef CONFIG_SMP
 	/* We need a sync somewhere here to make sure that if the
 	 * previous task gets rescheduled on another CPU, it sees all
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 11412078e732..9fffe99b343d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -397,7 +397,7 @@ config PPC_KUAP
 
 config PPC_KUAP_DEBUG
 	bool "Extra debugging for Kernel Userspace Access Protection"
-	depends on PPC_KUAP && (PPC_RADIX_MMU || PPC_32)
+	depends on PPC_KUAP && (PPC_RADIX_MMU || PPC32)
 	help
 	  Add extra debugging for Kernel Userspace Access Protection (KUAP)
 	  If you're unsure, say N.
-- 
2.25.0

