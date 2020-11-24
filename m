Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AA12C19FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKXA3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKXA3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:43 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:42 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so1201004wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYHZHfsy1eVQs5SGBa+srbDvkh0atAgXvqMJTcx0sEw=;
        b=cF/bVVjxTAnwtIlatFU62B/lLP0CS7+YabtNNnx52keZ+CoWQP+AaVKF6WSqfSOiYS
         BvkwPNYpS/FMiia6solTrnIvzFLdUL6VhRE8lL61wh68PK6QYMNWMMpubcK/hViP9Flg
         fUHrFrnMqZSORsEtcz0PWxOIu1f1emIb5C+34dBKiI538iomLvi+8mT7w1dEx51bwq+w
         jjdFGl5O0RwBta30i9Ht8tdtpeIXcw6DFtBd0vpgjG8dRR2bz9qBBB4rIaJwfRHl6e4S
         yKmI6OOZKcKVjyNsQN1e3ODDnGukUKo1Th/9x5sZO/aJYtsHQw8iwBSqkPSCiVoyrm7D
         YMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYHZHfsy1eVQs5SGBa+srbDvkh0atAgXvqMJTcx0sEw=;
        b=DuYLxwaTkvlfo+ES6Mlh3rhOMkUrS9OqOMkWDmiLjVl3Txy2Jb1qKZYQBMG2Yk18Cc
         G3NnW0SfSd0hK7Y1QVXXqyAIEM2sTf0CyvOdOi3kPfVO1Mi0eH+Ijb/fucX0ykkrdpb8
         1qpqKvqJNHxB9Xapd+njBUdQEbu1kFTwB9xZOgeqv/24IvIZW8wk4X1uzhuyqDoxMvba
         wD5Kb46ZXBwUon9lXiI/x9JLzrBENnHUmnmSdbSDJ0wTGUDguhy4EwwKkMhTqkdyWvT2
         G0OrARiPy0vd1NPsptiXJwv0BuFk2U74rheFiMSvMDkq8DV27DI2wX801uUPACzlXPT3
         cV4Q==
X-Gm-Message-State: AOAM531h8goTW/jlYUrR+EutxJi7lyDsI75KsZ4IgzjvVgUisAAnsIaO
        7OtpEWvJIavCYxR5SQ8dKanb/aECZJ3ChbhX
X-Google-Smtp-Source: ABdhPJz2nDtHoQW82jlJ+jbgLD+Ouugjcj/IH/uvOLrtwZng2myEGLHKnhb82K8wYpLH2mufEJSUOQ==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr1454337wma.48.1606177780404;
        Mon, 23 Nov 2020 16:29:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:39 -0800 (PST)
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
Subject: [PATCH v2 04/19] x86: Remove compat_arch_setup_additional_pages()
Date:   Tue, 24 Nov 2020 00:29:17 +0000
Message-Id: <20201124002932.1220517-5-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same as for x32 task, detect ia32 task by in_ia32_syscall().
It's valid as execed task is pretending to be in a syscall of
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
2.29.2

