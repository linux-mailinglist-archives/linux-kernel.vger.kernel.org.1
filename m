Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72E251A44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHYNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 09:55:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7857 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHYNyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:54:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbVpQ5K1Bz9txld;
        Tue, 25 Aug 2020 15:54:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 11YNHnfDj_8o; Tue, 25 Aug 2020 15:54:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbVpQ4VM2z9txlY;
        Tue, 25 Aug 2020 15:54:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A11BB8B822;
        Tue, 25 Aug 2020 15:54:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aA1TfT6MAWn9; Tue, 25 Aug 2020 15:54:07 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66A868B823;
        Tue, 25 Aug 2020 15:54:02 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4123065D3F; Tue, 25 Aug 2020 13:54:02 +0000 (UTC)
Message-Id: <834f362626e18bc36226f46ed4113c461a3ad032.1598363608.git.christophe.leroy@csgroup.eu>
In-Reply-To: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu>
References: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/9] powerpc/vdso: Remove unnecessary ifdefs in
 vdso_pagelist initialization
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Aug 2020 13:54:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need of all those #ifdefs around the pagelist initialisation,
use IS_ENABLED(), GCC will kick out unused static variables.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 57 +++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index daef14a284a3..bbb69832fd46 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -51,15 +51,13 @@ static struct page **vdso32_pagelist;
 unsigned long vdso32_sigtramp;
 unsigned long vdso32_rt_sigtramp;
 
-#ifdef CONFIG_VDSO32
 extern char vdso32_start, vdso32_end;
-#endif
 
-#ifdef CONFIG_PPC64
 extern char vdso64_start, vdso64_end;
 static void *vdso64_kbase = &vdso64_start;
 static unsigned int vdso64_pages;
 static struct page **vdso64_pagelist;
+#ifdef CONFIG_PPC64
 unsigned long vdso64_rt_sigtramp;
 #endif /* CONFIG_PPC64 */
 
@@ -134,7 +132,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (!vdso_ready)
 		return 0;
 
-#ifdef CONFIG_PPC64
 	if (is_32bit_task()) {
 		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
@@ -149,11 +146,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		 */
 		vdso_base = 0;
 	}
-#else
-	vdso_pagelist = vdso32_pagelist;
-	vdso_pages = vdso32_pages;
-	vdso_base = VDSO32_MBASE;
-#endif
 
 	current->mm->context.vdso_base = 0;
 
@@ -718,16 +710,14 @@ static int __init vdso_init(void)
 	vdso_data->icache_block_size = ppc64_caches.l1i.block_size;
 	vdso_data->dcache_log_block_size = ppc64_caches.l1d.log_block_size;
 	vdso_data->icache_log_block_size = ppc64_caches.l1i.log_block_size;
+#endif /* CONFIG_PPC64 */
 
 	/*
 	 * Calculate the size of the 64 bits vDSO
 	 */
 	vdso64_pages = (&vdso64_end - &vdso64_start) >> PAGE_SHIFT;
 	DBG("vdso64_kbase: %p, 0x%x pages\n", vdso64_kbase, vdso64_pages);
-#endif /* CONFIG_PPC64 */
 
-
-#ifdef CONFIG_VDSO32
 	vdso32_kbase = &vdso32_start;
 
 	/*
@@ -735,8 +725,6 @@ static int __init vdso_init(void)
 	 */
 	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
 	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
-#endif
-
 
 	/*
 	 * Setup the syscall map in the vDOS
@@ -750,30 +738,30 @@ static int __init vdso_init(void)
 	if (vdso_setup())
 		goto setup_failed;
 
-#ifdef CONFIG_VDSO32
-	/* Make sure pages are in the correct state */
-	vdso32_pagelist = kcalloc(vdso32_pages + 1, sizeof(struct page *),
-				  GFP_KERNEL);
-	if (!vdso32_pagelist)
-		goto alloc_failed;
+	if (IS_ENABLED(CONFIG_VDSO32)) {
+		/* Make sure pages are in the correct state */
+		vdso32_pagelist = kcalloc(vdso32_pages + 1, sizeof(struct page *),
+					  GFP_KERNEL);
+		if (!vdso32_pagelist)
+			goto alloc_failed;
 
-	for (i = 0; i < vdso32_pages; i++)
-		vdso32_pagelist[i] = virt_to_page(vdso32_kbase + i * PAGE_SIZE);
+		for (i = 0; i < vdso32_pages; i++)
+			vdso32_pagelist[i] = virt_to_page(vdso32_kbase + i * PAGE_SIZE);
 
-	vdso32_pagelist[i] = virt_to_page(vdso_data);
-#endif
+		vdso32_pagelist[i] = virt_to_page(vdso_data);
+	}
 
-#ifdef CONFIG_PPC64
-	vdso64_pagelist = kcalloc(vdso64_pages + 1, sizeof(struct page *),
-				  GFP_KERNEL);
-	if (!vdso64_pagelist)
-		goto alloc_failed;
+	if (IS_ENABLED(CONFIG_PPC64)) {
+		vdso64_pagelist = kcalloc(vdso64_pages + 1, sizeof(struct page *),
+					  GFP_KERNEL);
+		if (!vdso64_pagelist)
+			goto alloc_failed;
 
-	for (i = 0; i < vdso64_pages; i++)
-		vdso64_pagelist[i] = virt_to_page(vdso64_kbase + i * PAGE_SIZE);
+		for (i = 0; i < vdso64_pages; i++)
+			vdso64_pagelist[i] = virt_to_page(vdso64_kbase + i * PAGE_SIZE);
 
-	vdso64_pagelist[i] = virt_to_page(vdso_data);
-#endif /* CONFIG_PPC64 */
+		vdso64_pagelist[i] = virt_to_page(vdso_data);
+	}
 
 	smp_wmb();
 	vdso_ready = 1;
@@ -784,9 +772,8 @@ static int __init vdso_init(void)
 	pr_err("vDSO setup failure, not enabled !\n");
 alloc_failed:
 	vdso32_pages = 0;
-#ifdef CONFIG_PPC64
 	vdso64_pages = 0;
-#endif
+
 	return 0;
 }
 arch_initcall(vdso_init);
-- 
2.25.0

