Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98C31A7698
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437147AbgDNIvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:51:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12857 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437071AbgDNIu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:50:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 491dgf2XY8z9tydY;
        Tue, 14 Apr 2020 10:19:26 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WuvBJBwA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jJzYB_7bVD7s; Tue, 14 Apr 2020 10:19:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 491dgf1WfRz9tydT;
        Tue, 14 Apr 2020 10:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586852366; bh=/lgZ5be7C2dgr3D45vmCyTrMsZNvNgzVwY0/UD2Mr1Q=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=WuvBJBwAtNigJ0spyZIqTfQQ8MxeFPcB6rFlU2zphe+D+ZcjnBp+CalvTTB++XaKO
         EEuurExXhk5X1vbpuL6QiphIbSevR1Rwh/n2preXtieBSFWvibK6r4cf3ktbcoIkrv
         cxrJy7rEjKLzViNsZtH/abjrmP/zyo0FJz3SVFMA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F7098B798;
        Tue, 14 Apr 2020 10:19:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 77CbdN7KhNxV; Tue, 14 Apr 2020 10:19:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01F6F8B796;
        Tue, 14 Apr 2020 10:19:27 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id C85436578A; Tue, 14 Apr 2020 08:19:26 +0000 (UTC)
Message-Id: <7fe0c14129cc47a5ed48f8fa6b683538e9bfbe01.1586852082.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1586852082.git.christophe.leroy@c-s.fr>
References: <cover.1586852082.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 10/13] powerpc/40x: Remove IBM405 Erratum #51
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Apr 2020 08:19:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This erratum was for IBM 403GCX, 405EP and STB03xxx which are
now gone.

Remove this erratum.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S     | 6 ------
 arch/powerpc/platforms/40x/Kconfig | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b62b6ab769fc..faeea5b56525 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -425,13 +425,7 @@ _ENTRY(saved_ksp_limit)
 	EXCEPTION(0x1400, Trap_14, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_STD)
-#ifdef CONFIG_IBM405_ERR51
-	/* 405GP errata 51 */
-	START_EXCEPTION(0x1700, Trap_17)
-	b DTLBMiss
-#else
 	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_STD)
-#endif
 	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_STD)
 	EXCEPTION(0x1A00, Trap_1A, unknown_exception, EXC_XFER_STD)
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 253c047fe6fe..ebe283476461 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -75,10 +75,6 @@ config PPC4xx_GPIO
 config IBM405_ERR77
 	bool
 
-# All 40x-based cores, up until the 405GPR and 405EP have this errata.
-config IBM405_ERR51
-	bool
-
 config APM8018X
 	bool "APM8018X"
 	depends on 40x
-- 
2.25.0

