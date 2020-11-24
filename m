Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3752C1A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgKXAaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgKXA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:59 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A239C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:59 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so20596288wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pDJ7pd5MTY5se/U9q9yZ6vbvjmdW3H9LRPXfLDRC2Lo=;
        b=BuTIUs8lqVSsrSwI7KMP6DJ9TMh4clmU6QAHM98jks3yI1/HP+/ODJTlTjjl61R2zi
         gzmWYi4i3+gFhidO2UycgeQTkVRj2bTVpmEFqeygDyw6f6QEzRiou4zXS9nrBuZx/BGJ
         eMR+0G4j6sJBIJdW3k+DkM664hOPfWmLWmDkFrDRr8XOCUw2xEOBx7PZQOlrL6xqnQf9
         4FGyaiNeXbtqGXvfwLZzFaHO/LgFIsdPB9KdQtUKwVM5PH+5WMiK37+xdi3GEF9QVOMN
         XIiApfF9vWhouoCSif6MrCbFUgaBCN7HtZchOeeEmi8UIWGXOZw+ERX/belznuOZqX2j
         xA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pDJ7pd5MTY5se/U9q9yZ6vbvjmdW3H9LRPXfLDRC2Lo=;
        b=BNPa8eVpzxUPXWyPX2ZAeLwN/X6MAtLQWmqJcCRer19hxDtCW7YF6BOSh9Dr1Eun8h
         4jLqgt+uZIC0HImUL7o4/ERm6DXFhO5z9O04aILbNP6UlvwQlhawoNnyQS7En3HEe+x6
         1p512zaqZiQWJsTs7tK9C7ddDupkx37J0I/JDoJIRw19zr2HPKER6nnBCaIX8US0KJLs
         EjoDRnc+q8he7kvSiQVypJEyzLTSPHCl3atvZu0o2bijrh+RREKgiiYYVUsW+IzFl4zf
         i37zOsxyVF+rgRu5zjnvlk98pfDBC+n5LPQLaKqFGeTmNTXicshxsQ6n9G/UJzPz9ekb
         mIeA==
X-Gm-Message-State: AOAM530JkH0NIyLAZtpcQqIsf+ul6EDcCGePh1xHEf9OYQ3DvNdWEkSK
        lkIMj8zaasf/iSdfqjs+mNpZuqIc/4Cs6lWE
X-Google-Smtp-Source: ABdhPJyNIFFXcZ5cNLNhwaFjLBrkc8DTb8+Mh7RytUiLZI8l8dmQlMT3GW33Q5h19NW3WR1EfksLVg==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr2157547wrs.89.1606177797581;
        Mon, 23 Nov 2020 16:29:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:57 -0800 (PST)
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
Subject: [PATCH v2 15/19] x86/vdso: Migrate to generic vdso_base
Date:   Tue, 24 Nov 2020 00:29:28 +0000
Message-Id: <20201124002932.1220517-16-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the landing vma area.
As a bonus, after unmapping vdso, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso ?= 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/Kconfig              | 1 +
 arch/x86/entry/common.c       | 2 +-
 arch/x86/entry/vdso/extable.c | 4 ++--
 arch/x86/entry/vdso/vma.c     | 9 ++++-----
 arch/x86/ia32/ia32_signal.c   | 4 ++--
 arch/x86/include/asm/mmu.h    | 1 -
 arch/x86/include/asm/vdso.h   | 2 +-
 arch/x86/kernel/signal.c      | 4 ++--
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d676e0bad1f1..4f06760f849e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d9ab58cc765b..655b7d8fe734 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -151,7 +151,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-	landing_pad = (unsigned long)current->mm->context.vdso +
+	landing_pad = (unsigned long)current->mm->vdso_base +
 					vdso_image_32.sym_int80_landing_pad;
 
 	/*
diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..16688c2d032c 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -25,10 +25,10 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 	if (trapnr == X86_TRAP_DB || trapnr == X86_TRAP_BP)
 		return false;
 
-	if (!current->mm->context.vdso)
+	if (current->mm->vdso_base == (void *)UNMAPPED_VDSO_BASE)
 		return false;
 
-	base =  (unsigned long)current->mm->context.vdso + image->extable_base;
+	base = (unsigned long)current->mm->vdso_base + image->extable_base;
 	nr_entries = image->extable_len / (sizeof(*extable));
 	extable = image->extable;
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 65780a0164e3..29a795face9d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -77,7 +77,7 @@ static void vdso_fix_landing(const struct vdso_image *image,
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long vdso_land = image->sym_int80_landing_pad;
 		unsigned long old_land_addr = vdso_land +
-			(unsigned long)current->mm->context.vdso;
+			(unsigned long)current->mm->vdso_base;
 
 		/* Fixing userspace landing - look at do_fast_syscall_32 */
 		if (regs->ip == old_land_addr)
@@ -92,7 +92,6 @@ static void vdso_mremap(const struct vm_special_mapping *sm,
 	const struct vdso_image *image = current->mm->context.vdso_image;
 
 	vdso_fix_landing(image, new_vma);
-	current->mm->context.vdso = (void __user *)new_vma->vm_start;
 }
 
 #ifdef CONFIG_TIME_NS
@@ -287,7 +286,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr,
 		ret = PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
 	} else {
-		current->mm->context.vdso = (void __user *)text_start;
+		current->mm->vdso_base = (void __user *)text_start;
 		current->mm->context.vdso_image = image;
 		*sysinfo_ehdr = text_start;
 	}
@@ -362,8 +361,8 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	 * Check if we have already mapped vdso blob - fail to prevent
 	 * abusing from userspace install_speciall_mapping, which may
 	 * not do accounting and rlimit right.
-	 * We could search vma near context.vdso, but it's a slowpath,
-	 * so let's explicitly check all VMAs to be completely sure.
+	 * It's a slowpath, let's explicitly check all VMAs to be
+	 * completely sure.
 	 */
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index f87ed1d53938..67204b1eeea0 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -256,7 +256,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	} else {
 		/* Return stub is in 32bit vsyscall page */
 		if (current_has_vdso_image_32())
-			restorer = current->mm->context.vdso +
+			restorer = current->mm->vdso_base +
 				vdso_image_32.sym___kernel_sigreturn;
 		else
 			restorer = &frame->retcode;
@@ -337,7 +337,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso_image_32())
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->vdso_base +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
 		restorer = &frame->retcode;
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..7bd10e6b8386 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -43,7 +43,6 @@ typedef struct {
 #endif
 
 	struct mutex lock;
-	void __user *vdso;			/* vdso base address */
 	const struct vdso_image *vdso_image;	/* vdso image in use */
 
 	atomic_t perf_rdpmc_allowed;	/* nonzero if rdpmc is allowed */
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index e3829c3a6149..31b5695eded4 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -44,7 +44,7 @@ extern const struct vdso_image vdso_image_32;
 
 #define current_has_vdso_image_32()					\
 	likely(current->mm->context.vdso_image == &vdso_image_32 &&	\
-		!!current->mm->context.vdso)
+	(unsigned long)current->mm->vdso_base != UNMAPPED_VDSO_BASE)
 #endif
 
 extern void __init init_vdso_image(const struct vdso_image *image);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 6fed2e523e0a..85161df044f2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -320,7 +320,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso_image_32())
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->vdso_base +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
 		restorer = &frame->retcode;
@@ -382,7 +382,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso_image_32())
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->vdso_base +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
 		restorer = &frame->retcode;
-- 
2.29.2

