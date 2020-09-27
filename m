Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675B279FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgI0JQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:16:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13131 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgI0JQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg4m3M9vz9vCxy;
        Sun, 27 Sep 2020 11:16:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VP_C3gmyHNxg; Sun, 27 Sep 2020 11:16:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4m1Gdhz9vCxw;
        Sun, 27 Sep 2020 11:16:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB2238B771;
        Sun, 27 Sep 2020 11:16:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pbywM_hnMrAZ; Sun, 27 Sep 2020 11:16:28 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 855F18B75B;
        Sun, 27 Sep 2020 11:16:28 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6AED065DE8; Sun, 27 Sep 2020 09:16:28 +0000 (UTC)
Message-Id: <373c66f768fa9cc8890f3b55462209a98c522326.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 11/30] powerpc/vdso: Provide vdso_remap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide vdso_remap() through _install_special_mapping() and
drop arch_remap().

This adds a test of the size and returns -EINVAL if the size
is not correct.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mm-arch-hooks.h | 25 ------------------------
 arch/powerpc/kernel/vdso.c               | 24 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 25 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/mm-arch-hooks.h

diff --git a/arch/powerpc/include/asm/mm-arch-hooks.h b/arch/powerpc/include/asm/mm-arch-hooks.h
deleted file mode 100644
index dce274be824a..000000000000
--- a/arch/powerpc/include/asm/mm-arch-hooks.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Architecture specific mm hooks
- *
- * Copyright (C) 2015, IBM Corporation
- * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
- */
-
-#ifndef _ASM_POWERPC_MM_ARCH_HOOKS_H
-#define _ASM_POWERPC_MM_ARCH_HOOKS_H
-
-static inline void arch_remap(struct mm_struct *mm,
-			      unsigned long old_start, unsigned long old_end,
-			      unsigned long new_start, unsigned long new_end)
-{
-	/*
-	 * mremap() doesn't allow moving multiple vmas so we can limit the
-	 * check to old_start == vdso_base.
-	 */
-	if (old_start == mm->context.vdso_base)
-		mm->context.vdso_base = new_start;
-}
-#define arch_remap arch_remap
-
-#endif /* _ASM_POWERPC_MM_ARCH_HOOKS_H */
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 9b2c91a963a6..971764d5b85b 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -115,13 +115,37 @@ struct lib64_elfinfo
 	unsigned long	text;
 };
 
+static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma,
+		       unsigned long text_size)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+
+	if (new_size != text_size + PAGE_SIZE)
+		return -EINVAL;
+
+	current->mm->context.vdso_base = new_vma->vm_start;
+
+	return 0;
+}
+
+static int vdso32_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return vdso_mremap(sm, new_vma, &vdso32_end - &vdso32_start);
+}
+
+static int vdso64_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
+}
 
 static struct vm_special_mapping vdso32_spec __ro_after_init = {
 	.name = "[vdso]",
+	.mremap = vdso32_mremap,
 };
 
 static struct vm_special_mapping vdso64_spec __ro_after_init = {
 	.name = "[vdso]",
+	.mremap = vdso64_mremap,
 };
 
 /*
-- 
2.25.0

