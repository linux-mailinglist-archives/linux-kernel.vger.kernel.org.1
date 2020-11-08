Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA572AA923
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgKHFRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgKHFRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:35 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EAC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so4954847wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frH4iIqxOYWs2ecBaSbb41F2zNKPcuUj9dO09+FWUEo=;
        b=NpJ+tLWyrFlya2qdgodGFTs6rfMwinAL0QtIB/GiBZ9IJ2IIEve/3wM9tpW3Yoi7TF
         SPurfKcgKE2jVo7KQ2w1vcV4q7De/abjUXGiBEwEvF4MSa1ZGOthva5AZkfBm5co15XT
         Kobq2MEoJj7Cn8uPXLFWaYDtuOXDJQlN+8ucvUkm5Ns5lJTgektCCy++cvDkPsWmGaLN
         zTLNNvEu1vJzgF0flcNPtbRVEyhHbWPN1PNv90vOzbt7daTR34YrAJ8EJtdmNjssE7V4
         vvHXCFR9DnwWhFrPPMaQVOzpHUxd4VbCkciTfrW7y9cYxCgbU0SsrqeSiwGjHdIVHlAu
         nppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frH4iIqxOYWs2ecBaSbb41F2zNKPcuUj9dO09+FWUEo=;
        b=nd0NcTShkKJxFhiRSsDnAxGsjpQ4Ro+w9NH3VkLrg7RPJu1BjY3vb2rt9HBTW6h2kx
         Auyo+7geEd+QVhzHT6RLOSgN+XLmj9J3N+C9yBZcZrIv0O4VwHbmSg7E+QFuGAK9zjL9
         hrVkHghG2Z3eqlCPb55tQM93/35lOivqJgyQozntAyAUBcd0KcXy9C6HrK0w9WYMbXFG
         k1PoicQ5KOGtbY4mDOHqB2QMo7NA5YwoVNH2uyhWS5/4btYAKqX3GU9RyBofTPmS39Tw
         Ml8fGSgc5zkATe75Z2MD9zg3TKZvRj+2CB3GUQnsaRZcsi6I+VecWFuqnqRYGqq3cFTn
         NDnw==
X-Gm-Message-State: AOAM532Sjd/MNSZI+kW4dOAYu4hiqhCrYILSTXjkWU4/mHZDkRwB+NP3
        zC862NtRy2o+lM0g+DFmxgljQnfiouZ7wuxQ
X-Google-Smtp-Source: ABdhPJx0yqN/SutIIPNb72iMyMyq53T0FwYFr6AxLzqiTp1lzQ8A/ctcBARTqjHvdgI2A/CbT157xw==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr7723155wmb.22.1604812653953;
        Sat, 07 Nov 2020 21:17:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:33 -0800 (PST)
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
Subject: [PATCH 01/19] x86/elf: Check in_x32_syscall() in compat_arch_setup_additional_pages()
Date:   Sun,  8 Nov 2020 05:17:11 +0000
Message-Id: <20201108051730.2042693-2-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
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
after parsing and checking new ELF binary. It's done that early which
also allows to use it in mmap() code straight away, which needs it
to know which mmap_base to use (see arch_pick_mmap_layout()).
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
2.28.0

