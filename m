Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC7282861
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgJDD0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgJDD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:26:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01FC0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 20:26:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 10DA229B00E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 08/10] x86: elf: Use e_machine to select additional_pages between x32
Date:   Sat,  3 Oct 2020 23:25:34 -0400
Message-Id: <20201004032536.1229030-9-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004032536.1229030-1-krisman@collabora.com>
References: <20201004032536.1229030-1-krisman@collabora.com>
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
setup_additional_pages in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Avoid a function-like macro in compat_setup_additional_pages (Andy)
---
 arch/x86/entry/vdso/vma.c  | 4 ++--
 arch/x86/include/asm/elf.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..50e5d3a2e70a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -413,10 +413,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
+				       int uses_interp, bool x32)
 {
 #ifdef CONFIG_X86_X32_ABI
-	if (test_thread_flag(TIF_X32)) {
+	if (x32) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso_randomized(&vdso_image_x32);
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 109697a19eb1..44a9b9940535 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -383,8 +383,10 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp);
-#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
+					      int uses_interp, bool x32);
+#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter)	\
+	compat_arch_setup_additional_pages(bprm, interpreter,		\
+					   (ex->e_machine == EM_X86_64))
 
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
-- 
2.28.0

