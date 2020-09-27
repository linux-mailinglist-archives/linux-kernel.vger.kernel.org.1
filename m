Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5D279FFE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgI0JRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:17:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46730 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgI0JQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg516rbdz9vCy4;
        Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1PkD_OUD6WZc; Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg515fF5z9vCxw;
        Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5686D8B771;
        Sun, 27 Sep 2020 11:16:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CsK6p0TCGpfP; Sun, 27 Sep 2020 11:16:42 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 138DD8B75B;
        Sun, 27 Sep 2020 11:16:42 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E230F65DE8; Sun, 27 Sep 2020 09:16:41 +0000 (UTC)
Message-Id: <b779e5b7cc0354e2f87fd407fe5b02f4a8a73825.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 24/30] powerpc/vdso: Remove symbol section information in
 struct lib32/64_elfinfo
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The members related to the symbol section in struct lib32_elfinfo and
struct lib64_elfinfo are not used anymore, removed them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 90 --------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index fa1cbddfb978..f7b477da0b8a 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -70,17 +70,11 @@ struct vdso_arch_data *vdso_data = &vdso_data_store.data;
 struct lib32_elfinfo
 {
 	Elf32_Ehdr	*hdr;		/* ptr to ELF */
-	Elf32_Sym	*dynsym;	/* ptr to .dynsym section */
-	unsigned long	dynsymsize;	/* size of .dynsym section */
-	char		*dynstr;	/* ptr to .dynstr section */
 };
 
 struct lib64_elfinfo
 {
 	Elf64_Ehdr	*hdr;
-	Elf64_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	char		*dynstr;
 };
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma,
@@ -208,59 +202,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	return rc;
 }
 
-#ifdef CONFIG_VDSO32
-static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,
-				  unsigned long *size)
-{
-	Elf32_Shdr *sechdrs;
-	unsigned int i;
-	char *secnames;
-
-	/* Grab section headers and strings so we can tell who is who */
-	sechdrs = (void *)ehdr + ehdr->e_shoff;
-	secnames = (void *)ehdr + sechdrs[ehdr->e_shstrndx].sh_offset;
-
-	/* Find the section they want */
-	for (i = 1; i < ehdr->e_shnum; i++) {
-		if (strcmp(secnames+sechdrs[i].sh_name, secname) == 0) {
-			if (size)
-				*size = sechdrs[i].sh_size;
-			return (void *)ehdr + sechdrs[i].sh_offset;
-		}
-	}
-	*size = 0;
-	return NULL;
-}
-#endif /* CONFIG_VDSO32 */
-
-
-#ifdef CONFIG_PPC64
-
-static void * __init find_section64(Elf64_Ehdr *ehdr, const char *secname,
-				  unsigned long *size)
-{
-	Elf64_Shdr *sechdrs;
-	unsigned int i;
-	char *secnames;
-
-	/* Grab section headers and strings so we can tell who is who */
-	sechdrs = (void *)ehdr + ehdr->e_shoff;
-	secnames = (void *)ehdr + sechdrs[ehdr->e_shstrndx].sh_offset;
-
-	/* Find the section they want */
-	for (i = 1; i < ehdr->e_shnum; i++) {
-		if (strcmp(secnames+sechdrs[i].sh_name, secname) == 0) {
-			if (size)
-				*size = sechdrs[i].sh_size;
-			return (void *)ehdr + sechdrs[i].sh_offset;
-		}
-	}
-	if (size)
-		*size = 0;
-	return NULL;
-}
-#endif /* CONFIG_PPC64 */
-
 #define VDSO_DO_FIXUPS(type, value, bits, sec) do {					\
 	void *__start = (void *)VDSO##bits##_SYMBOL(&vdso##bits##_start, sec##_start);	\
 	void *__end = (void *)VDSO##bits##_SYMBOL(&vdso##bits##_start, sec##_end);	\
@@ -268,34 +209,6 @@ static void * __init find_section64(Elf64_Ehdr *ehdr, const char *secname,
 	do_##type##_fixups((value), __start, __end);					\
 } while (0)
 
-static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
-					struct lib64_elfinfo *v64)
-{
-	/*
-	 * Locate symbol tables & text section
-	 */
-
-#ifdef CONFIG_VDSO32
-	v32->dynsym = find_section32(v32->hdr, ".dynsym", &v32->dynsymsize);
-	v32->dynstr = find_section32(v32->hdr, ".dynstr", NULL);
-	if (v32->dynsym == NULL || v32->dynstr == NULL) {
-		printk(KERN_ERR "vDSO32: required symbol section not found\n");
-		return -1;
-	}
-#endif
-
-#ifdef CONFIG_PPC64
-	v64->dynsym = find_section64(v64->hdr, ".dynsym", &v64->dynsymsize);
-	v64->dynstr = find_section64(v64->hdr, ".dynstr", NULL);
-	if (v64->dynsym == NULL || v64->dynstr == NULL) {
-		printk(KERN_ERR "vDSO64: required symbol section not found\n");
-		return -1;
-	}
-#endif /* CONFIG_PPC64 */
-
-	return 0;
-}
-
 static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				      struct lib64_elfinfo *v64)
 {
@@ -325,9 +238,6 @@ static __init int vdso_setup(void)
 
 	v32.hdr = vdso32_kbase;
 	v64.hdr = vdso64_kbase;
-	if (vdso_do_find_sections(&v32, &v64))
-		return -1;
-
 	if (vdso_fixup_features(&v32, &v64))
 		return -1;
 
-- 
2.25.0

