Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB4279FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgI0JRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:17:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19734 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgI0JQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg505c7lz9vCy3;
        Sun, 27 Sep 2020 11:16:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ycrO_zL4KMmK; Sun, 27 Sep 2020 11:16:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg504sqjz9vCxw;
        Sun, 27 Sep 2020 11:16:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 399028B771;
        Sun, 27 Sep 2020 11:16:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ydxZ6QZJN0_M; Sun, 27 Sep 2020 11:16:41 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 03E2C8B75B;
        Sun, 27 Sep 2020 11:16:41 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DB91F65DE8; Sun, 27 Sep 2020 09:16:40 +0000 (UTC)
Message-Id: <f53dcc9bb1946a7854d15b34d03d3d2e2003848c.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 23/30] powerpc/vdso: Remove unused text member in struct
 lib32/64_elfinfo
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The text member in struct lib32_elfinfo and struct lib64_elfinfo
is not used, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 5e4e3546f034..fa1cbddfb978 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -73,7 +73,6 @@ struct lib32_elfinfo
 	Elf32_Sym	*dynsym;	/* ptr to .dynsym section */
 	unsigned long	dynsymsize;	/* size of .dynsym section */
 	char		*dynstr;	/* ptr to .dynstr section */
-	unsigned long	text;		/* offset of .text section in .so */
 };
 
 struct lib64_elfinfo
@@ -82,7 +81,6 @@ struct lib64_elfinfo
 	Elf64_Sym	*dynsym;
 	unsigned long	dynsymsize;
 	char		*dynstr;
-	unsigned long	text;
 };
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma,
@@ -273,8 +271,6 @@ static void * __init find_section64(Elf64_Ehdr *ehdr, const char *secname,
 static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 					struct lib64_elfinfo *v64)
 {
-	void *sect;
-
 	/*
 	 * Locate symbol tables & text section
 	 */
@@ -286,12 +282,6 @@ static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 		printk(KERN_ERR "vDSO32: required symbol section not found\n");
 		return -1;
 	}
-	sect = find_section32(v32->hdr, ".text", NULL);
-	if (sect == NULL) {
-		printk(KERN_ERR "vDSO32: the .text section was not found\n");
-		return -1;
-	}
-	v32->text = sect - vdso32_kbase;
 #endif
 
 #ifdef CONFIG_PPC64
@@ -301,12 +291,6 @@ static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 		printk(KERN_ERR "vDSO64: required symbol section not found\n");
 		return -1;
 	}
-	sect = find_section64(v64->hdr, ".text", NULL);
-	if (sect == NULL) {
-		printk(KERN_ERR "vDSO64: the .text section was not found\n");
-		return -1;
-	}
-	v64->text = sect - vdso64_kbase;
 #endif /* CONFIG_PPC64 */
 
 	return 0;
-- 
2.25.0

