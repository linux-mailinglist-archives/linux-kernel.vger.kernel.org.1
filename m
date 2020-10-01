Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37062808EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbgJAU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05714C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:59:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 76F8229D106
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 6/9] x86: elf: Use e_machine to select setup_additional_pages for x32
Date:   Thu,  1 Oct 2020 16:58:16 -0400
Message-Id: <20201001205819.27879-7-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since TIF_X32 is going away, avoid using it to find the ELF type when
choosing which additional pages to set up.

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when executing
start_thread in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/entry/vdso/vma.c  | 21 ++++++++++++---------
 arch/x86/include/asm/elf.h | 11 ++++++++---
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..7a3cda8294a3 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -412,22 +412,25 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 }
 
 #ifdef CONFIG_COMPAT
-int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
+int compat_arch_setup_additional_pages_ia32(struct linux_binprm *bprm,
+					    int uses_interp)
 {
-#ifdef CONFIG_X86_X32_ABI
-	if (test_thread_flag(TIF_X32)) {
-		if (!vdso64_enabled)
-			return 0;
-		return map_vdso_randomized(&vdso_image_x32);
-	}
-#endif
 #ifdef CONFIG_IA32_EMULATION
 	return load_vdso32();
 #else
 	return 0;
 #endif
 }
+
+int compat_arch_setup_additional_pages_x32(struct linux_binprm *bprm,
+					   int uses_interp)
+{
+#ifdef CONFIG_X86_X32_ABI
+	if (vdso64_enabled)
+		return map_vdso_randomized(&vdso_image_x32);
+#endif
+	return 0;
+}
 #endif
 #else
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 33c1c9be2e07..4d91f5b1079f 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -388,9 +388,14 @@ struct linux_binprm;
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
-extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp);
-#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
+extern int compat_arch_setup_additional_pages_ia32(struct linux_binprm *bprm,
+						   int uses_interp);
+extern int compat_arch_setup_additional_pages_x32(struct linux_binprm *bprm,
+						  int uses_interp);
+
+#define compat_arch_setup_additional_pages				\
+	((elf_ex->e_machine == EM_X86_64) ?				\
+	 compat_arch_setup_additional_pages_x32 : compat_arch_setup_additional_pages_ia32)
 
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
-- 
2.28.0

