Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65372C19F8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgKXA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKXA3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:38 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x13so926846wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/g0i6l5f7deTxKjj2ce6ZAbAca3ZTjd4anBrFGXxM7g=;
        b=pJ/EBdlrgrQR2z7PSQFy+kQp2YtWBjrmmLjA7JoJ3fJU/24hvEl+fRzoduiHCou7NC
         GrWvA329qC2wAGUdbsCnR9Bk+Iex/b+DlXyjPsHaPOIiSxjjxa6oHzpUBO8s6S7GiNCy
         t3rhsnEbhLkfJ3liFVOGH/G4N67BhV0iE5CC+yKXr++KvwMIb0UJQf5gSIyHgvHfD7IA
         0C03Rjz2PONepWUMm92fMpB0cWbTMQrf+QR6lIy7cvhR1W0JKOodrwLcZr57YRRXIW2H
         iPdX8b9GouWUyOBmkKeIrLq+tdV6lQOn+q7jOORWxomK6d/x6940q3v+eitmxaSlYzeq
         YZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/g0i6l5f7deTxKjj2ce6ZAbAca3ZTjd4anBrFGXxM7g=;
        b=Gpj2jSQG7gPm+PXck/zzbWo3QEkqHCduVPqQKAK10A64pzpUNfwhIk43UVNQ4vPvin
         nFZKFJSV/1VGcuLSJV+upUH3vb9SbHihI9si9BVjvXBGm4nQ+U2bnYCs0vg+5LoIRsFj
         WoThNP+OsfQwCPJ40otAlqKl4DzmuHlNFU+vxE0KQ324hIyfzQbVKgWfrbTeuvuLBlUl
         0IsxDj2gTs6L48IVXMqytOI47x57EYdP2xgQFXYfXsLne+H4/dTnECoR8qrHiQvPbeSk
         2mHnBUkCIMFY6xZH3mFGgvjs0D5Wkv+U2KRHh+jaVLzfdMcGlhL4zbH2US5w5ALUeMKM
         dqJA==
X-Gm-Message-State: AOAM531KO3G7SmzC66h6h8heJnBpw6QbmgAsEpbJUGR0+6K4FtPP5fEw
        ovzr2I7hRM1/bVyoAS+7J2fHznc9dsF2NbTz
X-Google-Smtp-Source: ABdhPJw9n5SyKKHCM2BUBPF3tz20NOaQ7hnd2+FmFdkHbN6pmjgk6G5LH3ygxrP8AEkfOMwVMgH2vg==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr1475334wme.168.1606177775779;
        Mon, 23 Nov 2020 16:29:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:35 -0800 (PST)
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
Subject: [PATCH v2 01/19] x86/elf: Check in_x32_syscall() in compat_arch_setup_additional_pages()
Date:   Tue, 24 Nov 2020 00:29:14 +0000
Message-Id: <20201124002932.1220517-2-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partly revert commit 3316ec8ccd34 ("x86/elf: Use e_machine to check for
x32/ia32 in setup_additional_pages()") and commit 9a29a671902c ("elf:
Expose ELF header on arch_setup_additional_pages()".
Both patches did a good thing: removed usage of TIF_X32, but with
a price of additional macros ARCH_SETUP_ADDITIONAL_PAGES() and ifdeffs.

Instead, use in_x32_syscall() - the first thing load_elf_binary() does
after parsing and checking new ELF binary. It's done that early after
exec() that way also allows to use it in mmap() code straight away,
which needs it to know which mmap_base to use (see arch_pick_mmap_layout()).
Add comments that describe how it works.

Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c     |  4 ++--
 arch/x86/include/asm/compat.h |  6 ++++++
 arch/x86/include/asm/elf.h    |  6 ++----
 fs/binfmt_elf.c               | 10 +++++++---
 fs/compat_binfmt_elf.c        | 11 +++--------
 include/linux/elf.h           |  5 -----
 6 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 44de75b21fab..4eea508e9b10 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -396,10 +396,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp, bool x32)
+				       int uses_interp)
 {
 #ifdef CONFIG_X86_X32_ABI
-	if (x32) {
+	if (in_x32_syscall()) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso_randomized(&vdso_image_x32);
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index f145e3326c6d..4489bd60640b 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -197,6 +197,12 @@ static inline bool in_x32_syscall(void)
 	return false;
 }
 
+/*
+ * Valid all time on the context of process that performs a syscall.
+ * Just born process has __X32_SYSCALL_BIT or TS_COMPAT set very
+ * early in load_binary() on setting personality and flags.
+ * See also set_personality_ia32().
+ */
 static inline bool in_32bit_syscall(void)
 {
 	return in_ia32_syscall() || in_x32_syscall();
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 44a9b9940535..109697a19eb1 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -383,10 +383,8 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp, bool x32);
-#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter)	\
-	compat_arch_setup_additional_pages(bprm, interpreter,		\
-					   (ex->e_machine == EM_X86_64))
+					      int uses_interp);
+#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ac0b5fc30ea6..3de72c0e0406 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -999,8 +999,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval)
 		goto out_free_dentry;
 
-	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
-	   may depend on the personality.  */
+	/*
+	 * Do this immediately, since STACK_TOP as used in setup_arg_pages
+	 * may depend on the personality. At this moment we start
+	 * pretending that we are in a context of compat syscall for
+	 * compatible applications on x86, in_compat_syscall() starts working.
+	 */
 	SET_PERSONALITY2(*elf_ex, &arch_state);
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
@@ -1246,7 +1250,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
+	retval = arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 2c557229696a..12b991368f0a 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -115,16 +115,11 @@
 #define START_THREAD		COMPAT_START_THREAD
 #endif
 
-#ifdef compat_arch_setup_additional_pages
-#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
-	compat_arch_setup_additional_pages(bprm, interpreter)
-#endif
-
-#ifdef	COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
+#ifdef	compat_arch_setup_additional_pages
 #undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-#undef	ARCH_SETUP_ADDITIONAL_PAGES
-#define	ARCH_SETUP_ADDITIONAL_PAGES COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
+#undef	arch_setup_additional_pages
+#define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
 #ifdef	compat_elf_read_implies_exec
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..6dbcfe7a3fd7 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -27,11 +27,6 @@
 	start_thread(regs, elf_entry, start_stack)
 #endif
 
-#if defined(ARCH_HAS_SETUP_ADDITIONAL_PAGES) && !defined(ARCH_SETUP_ADDITIONAL_PAGES)
-#define ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
-	arch_setup_additional_pages(bprm, interpreter)
-#endif
-
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 
-- 
2.29.2

