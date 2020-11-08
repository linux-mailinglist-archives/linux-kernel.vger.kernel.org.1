Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450402AA926
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgKHFRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgKHFRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D89C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id t67so601929wmt.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WHLpcykIsrds4UgqFFWlVA4TctWnk+5lHUD15tJI+w=;
        b=B/5tyvYr8H3L8z/xppTySZZ5FXidhsgr6XysK6KGhiOH94mt9YSBMAaGDxbdF7efjj
         SbqrT10pB8AnC9otIXliEJdsq0pVHdpkP6bfNzgLxYgdcSxra8EMvsyY+ejJivKekRsr
         DzvM5asvdhHqrgqXhPv5ExkkyW/lo1us4WKYXX2y3FJOLKjyNEuIOrjn9/v2UNDyEbog
         LnZj5LghsMYdLAkPRDBi8Qn+xU7PtjsPTv1EjkBhsOogzsJJyHBJEhAf2o+GHakngRf+
         aIrG8cHXQ8NpdBT6Fxmyp7c6E0T6soQUg3D8El+hTpr06VJ1B6lmfBTi9zVCUjuURuWw
         mWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WHLpcykIsrds4UgqFFWlVA4TctWnk+5lHUD15tJI+w=;
        b=WBNPA6HINJpsbhdVeysX+mxgfcLqJCtj5w+cK5Y6r2dKbrjuaB7IyDP0Bieqg7WZt7
         FTmfARGKqkVUthAF8CowBbNK+NLCBh86hT0wAl/DkMdhFW0F6IEWeJ7me6WT0ZtO506h
         efi2vW/9/NWFTp57t0JNflDSiR13sOMdKQC1+YcyN++z6d1aR8rL3ZF1qdw0jYi5CBif
         9V0A11SyUjWPSN43+gKJFJMSM+2TwoRnBifFWFz6L9846TAa6EvHuR0e5GuQRI8ns3w3
         wdj4cLhBBVYArn0u5G1GuwphJep5mpviiVcY2MaKevxx5OhvmtfgPazpITC0g330RHQE
         Q26g==
X-Gm-Message-State: AOAM5301c3oxqMSZgxEE0VT3m/+rTeh5x+Zv3vzmSCiMSJph9vizaJSP
        CA4keomfsgppGJXOMz590YUYBruyLnwrHfL3
X-Google-Smtp-Source: ABdhPJx/vKqhFEHSrW5hicbBqtbtJagDhiZQuzkINWoGfoTh9wWdC11AWDE8UvGyLUZNnEtRgblQUQ==
X-Received: by 2002:a7b:cc05:: with SMTP id f5mr7704630wmh.123.1604812658265;
        Sat, 07 Nov 2020 21:17:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:37 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH 04/19] x86: Remove compat_arch_setup_additional_pages()
Date:   Sun,  8 Nov 2020 05:17:14 +0000
Message-Id: <20201108051730.2042693-5-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same as for x32 task, detect ia32 task by in_ia32_syscall().
It's valid as new-execed task is pretending to be in a syscall of
relevant bitness/ABI, see the comment near in_32bit_syscall().

Removing compat_arch_setup_additional_pages() provides single point of
entry - arch_setup_additional_pages(), makes ifdeffery easier to read,
aligns the code with powerpc and sparc (mips also has single vdso setup
function, but instead of taking bitness from mm.context, takes vdso
image pointer there).
Together with arm64 code align to use in_compat_task(), it makes
possible to remove compat_arch_setup_additional_pages() macro
re-definition from compat elf code (another redefined marco less).

Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c  | 41 +++++++++++++++++++-------------------
 arch/x86/include/asm/elf.h |  5 -----
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 4eea508e9b10..aace862ed9a1 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -376,48 +376,49 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 }
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static int load_vdso32(void)
+static int load_vdso_ia32(void)
 {
 	if (vdso32_enabled != 1)  /* Other values all mean "disabled" */
 		return 0;
 
 	return map_vdso(&vdso_image_32, 0);
 }
+#else
+static int load_vdso_ia32(void)
+{
+	WARN_ON_ONCE(1);
+	return -ENODATA;
+}
 #endif
 
 #ifdef CONFIG_X86_64
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+static int load_vdso_64(void)
 {
 	if (!vdso64_enabled)
 		return 0;
 
-	return map_vdso_randomized(&vdso_image_64);
-}
-
-#ifdef CONFIG_COMPAT
-int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
-{
 #ifdef CONFIG_X86_X32_ABI
-	if (in_x32_syscall()) {
-		if (!vdso64_enabled)
-			return 0;
+	if (in_x32_syscall())
 		return map_vdso_randomized(&vdso_image_x32);
-	}
 #endif
-#ifdef CONFIG_IA32_EMULATION
-	return load_vdso32();
+
+	return map_vdso_randomized(&vdso_image_64);
+}
 #else
-	return 0;
-#endif
+static int load_vdso_64(void)
+{
+	WARN_ON_ONCE(1);
+	return -ENODATA;
 }
 #endif
-#else
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
-	return load_vdso32();
+	if (in_ia32_syscall())
+		return load_vdso_ia32();
+
+	return load_vdso_64();
 }
-#endif
 
 #ifdef CONFIG_X86_64
 static __init int vdso_setup(char *s)
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index d00b723eea2d..51a08f6b18e5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -377,11 +377,6 @@ else									\
 	((unsigned long)current->mm->context.vdso +			\
 	 vdso_image_32.sym___kernel_vsyscall)
 
-struct linux_binprm;
-extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp);
-#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
-
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
 	ALIGN_VA_32	= BIT(0),
-- 
2.28.0

