Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6127A001
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgI0JRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:17:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11931 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgI0JQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg4x5rCxz9vCxy;
        Sun, 27 Sep 2020 11:16:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id APsk_Z7i4VV2; Sun, 27 Sep 2020 11:16:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4x5589z9vCxw;
        Sun, 27 Sep 2020 11:16:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 482C38B771;
        Sun, 27 Sep 2020 11:16:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MOK71eOw7Q0I; Sun, 27 Sep 2020 11:16:38 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D84AF8B75B;
        Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BB88865DE8; Sun, 27 Sep 2020 09:16:37 +0000 (UTC)
Message-Id: <ddb5c746bec4e1a026d7c85243213a1876ef844f.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 20/30] powerpc/vdso: Remove __kernel_datapage_offset
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kernel_datapage_offset is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c              | 39 -------------------------
 arch/powerpc/kernel/vdso32/datapage.S   |  3 --
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  5 ----
 arch/powerpc/kernel/vdso64/datapage.S   |  3 --
 arch/powerpc/kernel/vdso64/vdso64.lds.S |  5 ----
 5 files changed, 55 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index e732776bac0a..611977010e2d 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -494,42 +494,6 @@ static __init void vdso_setup_trampolines(struct lib32_elfinfo *v32,
 	vdso32_rt_sigtramp = find_function32(v32, "__kernel_sigtramp_rt32");
 }
 
-static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
-				       struct lib64_elfinfo *v64)
-{
-#ifdef CONFIG_VDSO32
-	Elf32_Sym *sym32;
-#endif
-#ifdef CONFIG_PPC64
-	Elf64_Sym *sym64;
-
-       	sym64 = find_symbol64(v64, "__kernel_datapage_offset");
-	if (sym64 == NULL) {
-		printk(KERN_ERR "vDSO64: Can't find symbol "
-		       "__kernel_datapage_offset !\n");
-		return -1;
-	}
-	*((int *)(vdso64_kbase + sym64->st_value - VDSO64_LBASE)) =
-		-PAGE_SIZE -
-		(sym64->st_value - VDSO64_LBASE);
-#endif /* CONFIG_PPC64 */
-
-#ifdef CONFIG_VDSO32
-	sym32 = find_symbol32(v32, "__kernel_datapage_offset");
-	if (sym32 == NULL) {
-		printk(KERN_ERR "vDSO32: Can't find symbol "
-		       "__kernel_datapage_offset !\n");
-		return -1;
-	}
-	*((int *)(vdso32_kbase + (sym32->st_value - VDSO32_LBASE))) =
-		-PAGE_SIZE -
-		(sym32->st_value - VDSO32_LBASE);
-#endif
-
-	return 0;
-}
-
-
 static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				      struct lib64_elfinfo *v64)
 {
@@ -595,9 +559,6 @@ static __init int vdso_setup(void)
 	if (vdso_do_find_sections(&v32, &v64))
 		return -1;
 
-	if (vdso_fixup_datapage(&v32, &v64))
-		return -1;
-
 	if (vdso_fixup_features(&v32, &v64))
 		return -1;
 
diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 91a153b34714..0513a2eabec8 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -13,9 +13,6 @@
 #include <asm/vdso_datapage.h>
 
 	.text
-	.global	__kernel_datapage_offset;
-__kernel_datapage_offset:
-	.long	0
 
 /*
  * void *__kernel_get_syscall_map(unsigned int *syscall_count) ;
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index c70f5dac8c98..7b476a6f2dba 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -148,11 +148,6 @@ VERSION
 {
 	VDSO_VERSION_STRING {
 	global:
-		/*
-		 * Has to be there for the kernel to find
-		 */
-		__kernel_datapage_offset;
-
 		__kernel_get_syscall_map;
 #ifndef CONFIG_PPC_BOOK3S_601
 		__kernel_gettimeofday;
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 941b735df069..00760dc69d68 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -13,9 +13,6 @@
 #include <asm/vdso_datapage.h>
 
 	.text
-.global	__kernel_datapage_offset;
-__kernel_datapage_offset:
-	.long	0
 
 /*
  * void *__kernel_get_syscall_map(unsigned int *syscall_count) ;
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index a049000eacfe..a543826cd857 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -148,11 +148,6 @@ VERSION
 {
 	VDSO_VERSION_STRING {
 	global:
-		/*
-		 * Has to be there for the kernel to find
-		 */
-		__kernel_datapage_offset;
-
 		__kernel_get_syscall_map;
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
-- 
2.25.0

