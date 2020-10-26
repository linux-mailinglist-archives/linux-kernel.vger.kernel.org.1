Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606592991C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784742AbgJZQEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784725AbgJZQEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:04:00 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4DB22404;
        Mon, 26 Oct 2020 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728239;
        bh=PbuVK46Su8Y2IN8OSWTg9G6iLuVj+1s0ldPwLWqHqC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4mA1qyL810vk+6qn3OWEQqNxmv2+CDM1wcp5tLhXQSCwvNogsL1S7/px7MskpMz4
         ycJVviQwB0FG48wBDWu+y0918F+gHjCydFHtAwp3u46pdn1zXR8AaqJQcNOVsvIZir
         WLOADKGhG2WD/Z+IU0SIgXw/vpE/8RLVUNSK/rSA=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: hide more compat_vdso code
Date:   Mon, 26 Oct 2020 17:03:29 +0100
Message-Id: <20201026160342.3705327-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026160342.3705327-1-arnd@kernel.org>
References: <20201026160342.3705327-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_COMPAT_VDSO is disabled, we get a warning
about a potential out-of-bounds access:

arch/arm64/kernel/vdso.c: In function 'aarch32_vdso_mremap':
arch/arm64/kernel/vdso.c:86:37: warning: array subscript 1 is above array bounds of 'struct vdso_abi_info[1]' [-Warray-bounds]
   86 |  unsigned long vdso_size = vdso_info[abi].vdso_code_end -
      |                            ~~~~~~~~~^~~~~

This is all in dead code however that the compiler is unable to
eliminate by itself.

Change the array to individual local variables that can be
dropped in dead code elimination to let the compiler understand
this better.

Fixes: 0cbc2659123e ("arm64: vdso32: Remove a bunch of #ifdef CONFIG_COMPAT_VDSO guards")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/vdso.c | 56 ++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index debb8995d57f..0b69d2894742 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -286,36 +286,9 @@ static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
 	return __vdso_remap(VDSO_ABI_AA32, sm, new_vma);
 }
 
-enum aarch32_map {
-	AA32_MAP_VECTORS, /* kuser helpers */
-	AA32_MAP_SIGPAGE,
-	AA32_MAP_VVAR,
-	AA32_MAP_VDSO,
-};
-
 static struct page *aarch32_vectors_page __ro_after_init;
 static struct page *aarch32_sig_page __ro_after_init;
 
-static struct vm_special_mapping aarch32_vdso_maps[] = {
-	[AA32_MAP_VECTORS] = {
-		.name	= "[vectors]", /* ABI */
-		.pages	= &aarch32_vectors_page,
-	},
-	[AA32_MAP_SIGPAGE] = {
-		.name	= "[sigpage]", /* ABI */
-		.pages	= &aarch32_sig_page,
-	},
-	[AA32_MAP_VVAR] = {
-		.name = "[vvar]",
-		.fault = vvar_fault,
-		.mremap = vvar_mremap,
-	},
-	[AA32_MAP_VDSO] = {
-		.name = "[vdso]",
-		.mremap = aarch32_vdso_mremap,
-	},
-};
-
 static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
@@ -352,14 +325,25 @@ static int aarch32_alloc_sigpage(void)
 	return 0;
 }
 
+static struct vm_special_mapping aarch32_vdso_map_vvar = {
+	.name = "[vvar]",
+	.fault = vvar_fault,
+	.mremap = vvar_mremap,
+};
+
+static struct vm_special_mapping aarch32_vdso_map_vdso = {
+	.name = "[vdso]",
+	.mremap = aarch32_vdso_mremap,
+};
+
 static int __aarch32_alloc_vdso_pages(void)
 {
 
 	if (!IS_ENABLED(CONFIG_COMPAT_VDSO))
 		return 0;
 
-	vdso_info[VDSO_ABI_AA32].dm = &aarch32_vdso_maps[AA32_MAP_VVAR];
-	vdso_info[VDSO_ABI_AA32].cm = &aarch32_vdso_maps[AA32_MAP_VDSO];
+	vdso_info[VDSO_ABI_AA32].dm = &aarch32_vdso_map_vvar;
+	vdso_info[VDSO_ABI_AA32].cm = &aarch32_vdso_map_vdso;
 
 	return __vdso_init(VDSO_ABI_AA32);
 }
@@ -380,6 +364,11 @@ static int __init aarch32_alloc_vdso_pages(void)
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
+static struct vm_special_mapping aarch32_vdso_map_vectors = {
+	.name	= "[vectors]", /* ABI */
+	.pages	= &aarch32_vectors_page,
+};
+
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
@@ -394,11 +383,16 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
 				       VM_READ | VM_EXEC |
 				       VM_MAYREAD | VM_MAYEXEC,
-				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
+				       &aarch32_vdso_map_vectors);
 
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+static struct vm_special_mapping aarch32_vdso_map_sigpage = {
+	.name	= "[sigpage]", /* ABI */
+	.pages	= &aarch32_sig_page,
+};
+
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -417,7 +411,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
 				       VM_MAYWRITE | VM_MAYEXEC,
-				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
+				       &aarch32_vdso_map_sigpage);
 	if (IS_ERR(ret))
 		goto out;
 
-- 
2.27.0

