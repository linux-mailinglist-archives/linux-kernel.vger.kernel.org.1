Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7A2E1A93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgLWJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:39:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40884 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgLWJj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:39:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D17SQ6PxSz9v1yV;
        Wed, 23 Dec 2020 10:38:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H0J8Dj7hS6k7; Wed, 23 Dec 2020 10:38:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D17SQ5HZ2z9v1yS;
        Wed, 23 Dec 2020 10:38:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6DE58B81D;
        Wed, 23 Dec 2020 10:38:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9za7q6GQnWfD; Wed, 23 Dec 2020 10:38:47 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8280F8B75F;
        Wed, 23 Dec 2020 10:38:47 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 5EE6B6696F; Wed, 23 Dec 2020 09:38:47 +0000 (UTC)
Message-Id: <3d10a274516e9be8c4b0dc679a2840cdc1588872.1608716197.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e4471bf81089252470efb3eed735d71a5b32adbd.1608716197.git.christophe.leroy@csgroup.eu>
References: <e4471bf81089252470efb3eed735d71a5b32adbd.1608716197.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/xmon: Select CONSOLE_POLL for the 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 23 Dec 2020 09:38:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerpc 8xx requires CONSOLE_POLL to get udbg_putc() and
udbg_getc() in CPM uart driver.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index b88900f4832f..ae084357994e 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -88,6 +88,7 @@ config PPC_IRQ_SOFT_MASK_DEBUG
 config XMON
 	bool "Include xmon kernel debugger"
 	depends on DEBUG_KERNEL
+	select CONSOLE_POLL if SERIAL_CPM_CONSOLE
 	help
 	  Include in-kernel hooks for the xmon kernel monitor/debugger.
 	  Unless you are intending to debug the kernel, say N here.
-- 
2.25.0

