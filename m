Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC01D279FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgI0JQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:16:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53821 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgI0JQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg4f18X6z9vCy4;
        Sun, 27 Sep 2020 11:16:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id I42O7hSbp0oY; Sun, 27 Sep 2020 11:16:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4d6tt3z9vCxw;
        Sun, 27 Sep 2020 11:16:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8624C8B771;
        Sun, 27 Sep 2020 11:16:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eWz7lnPcT7JE; Sun, 27 Sep 2020 11:16:22 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 50A648B75B;
        Sun, 27 Sep 2020 11:16:22 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 35B6F65DE8; Sun, 27 Sep 2020 09:16:22 +0000 (UTC)
Message-Id: <e58d95ab859e3cbc9bae3c9ce2959e17d2864f5d.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 05/30] powerpc/vdso: Remove NULL termination element in
 vdso_pagelist
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need of a NULL last element in pagelists, install_special_mapping()
knows how long the list is.

Remove that element.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index dfaa4be258d2..d2c08f5de587 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -743,7 +743,7 @@ static int __init vdso_init(void)
 
 #ifdef CONFIG_VDSO32
 	/* Make sure pages are in the correct state */
-	vdso32_pagelist = kcalloc(vdso32_pages + 2, sizeof(struct page *),
+	vdso32_pagelist = kcalloc(vdso32_pages + 1, sizeof(struct page *),
 				  GFP_KERNEL);
 	BUG_ON(vdso32_pagelist == NULL);
 	for (i = 0; i < vdso32_pages; i++) {
@@ -752,11 +752,10 @@ static int __init vdso_init(void)
 		vdso32_pagelist[i] = pg;
 	}
 	vdso32_pagelist[i++] = virt_to_page(vdso_data);
-	vdso32_pagelist[i] = NULL;
 #endif
 
 #ifdef CONFIG_PPC64
-	vdso64_pagelist = kcalloc(vdso64_pages + 2, sizeof(struct page *),
+	vdso64_pagelist = kcalloc(vdso64_pages + 1, sizeof(struct page *),
 				  GFP_KERNEL);
 	BUG_ON(vdso64_pagelist == NULL);
 	for (i = 0; i < vdso64_pages; i++) {
@@ -765,7 +764,6 @@ static int __init vdso_init(void)
 		vdso64_pagelist[i] = pg;
 	}
 	vdso64_pagelist[i++] = virt_to_page(vdso_data);
-	vdso64_pagelist[i] = NULL;
 #endif /* CONFIG_PPC64 */
 
 	smp_wmb();
-- 
2.25.0

