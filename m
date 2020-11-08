Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440D42AA92E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgKHFSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKHFR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2CC0617A7
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so5341783wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBL188vkiayO3VIBgbN+Ii9TM86j5vNl1BGzj2vUwqc=;
        b=PVI6MSZpXxnLZWJI4lDn/LyVHxFO2Zyi64Y1ld1+ILDvmM7lwv2qb+9kJV+UESJlbL
         Eb0AsAmtACwOCRWl+nhAeGBOsdbU1jbbiagqjMtcYeeseUxYmwtH1giDcWn2FCTu/+RV
         HMP6Q+OsXSN/XCWQ0fHxfSVijdlVZ9RP2AJKEANqWrCHEjbrkuS9Pt7OMXExQEuAE/+2
         nN2pzfCH2SpBg0EzqtTb5ZXnB8oxpwHMdq6ZoWaTjO7GZcgLhoxQFfDTf9AFe7t7LyNd
         5mgHdd/6q4mlJyoDrYS4A4Zbvaql2TH3v354/lPLxQLM3JRmY/rBZeDZ+fhcMINOIT6P
         ZIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBL188vkiayO3VIBgbN+Ii9TM86j5vNl1BGzj2vUwqc=;
        b=YU/kWXc1CSoNChiob8kUsSs6it1HEg8uKuDMFY6F1d4p7ucbCjb6gj7znpWbycezK8
         gS5LNuu+ZD+d1foAoc2WQcuUuugU4NLZ0fcVcUcPbTrQ6MrvZakUU6x7pXrecfIDWIlj
         2lpoqvAeT4qJtaEdACFjx3JpjfecPGRqv7JbHbeRj4DGB8dH6MbVE7X8PsrUJOsJlGOp
         KOxAHCAd27PgMDHvS+AyMuKFlk9kA0q6QMx9axisdBdv+rFHYPzhUfgwY1H98/onoRkD
         8aHqUKSGq6tQp0Dko6IEHUNmduV578YpQJOkjyzQn/uyDAPZy4eMVyQeltn0EQSQisnZ
         i4hw==
X-Gm-Message-State: AOAM5306AruP4ETU53OHPW0HFkUF3uaW6R3MDDx0qA/hj5SpImNF6w3A
        qGnElqWEl6aNLhwCBqoXXIP+edkcRTX15IRG
X-Google-Smtp-Source: ABdhPJzs19ieFd4H3IWh+l6ae3ehpGTNk34g1y/g0qPAO16wTEnq3JSuqinEVqqe8Gl99IOx8/ImgQ==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr11326036wra.54.1604812673142;
        Sat, 07 Nov 2020 21:17:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:52 -0800 (PST)
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
Subject: [PATCH 15/19] x86/vdso: Migrate to user_landing
Date:   Sun,  8 Nov 2020 05:17:25 +0000
Message-Id: <20201108051730.2042693-16-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
As a bonus, after unmapping vdso, kernel won't try to land on its
previous position.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/Kconfig            | 1 +
 arch/x86/entry/common.c     | 3 ++-
 arch/x86/entry/vdso/vma.c   | 9 ++++-----
 arch/x86/ia32/ia32_signal.c | 4 ++--
 arch/x86/include/asm/mmu.h  | 1 -
 arch/x86/include/asm/vdso.h | 2 +-
 arch/x86/kernel/signal.c    | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b068f949d2e4..2449844ef0e9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -84,6 +84,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_USER_LANDING
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 1be1bdbe55d4..1a3f795af331 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -151,9 +151,10 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-	landing_pad = (unsigned long)current->mm->context.vdso +
+	landing_pad = (unsigned long)current->mm->user_landing +
 					vdso_image_32.sym_int80_landing_pad;
 
+
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 65780a0164e3..2c426997a7a4 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -77,7 +77,7 @@ static void vdso_fix_landing(const struct vdso_image *image,
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long vdso_land = image->sym_int80_landing_pad;
 		unsigned long old_land_addr = vdso_land +
-			(unsigned long)current->mm->context.vdso;
+			(unsigned long)current->mm->user_landing;
 
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
+		current->mm->user_landing = (void __user *)text_start;
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
index f87ed1d53938..fb84c0fcdc4e 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -256,7 +256,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	} else {
 		/* Return stub is in 32bit vsyscall page */
 		if (current_has_vdso_image_32())
-			restorer = current->mm->context.vdso +
+			restorer = current->mm->user_landing +
 				vdso_image_32.sym___kernel_sigreturn;
 		else
 			restorer = &frame->retcode;
@@ -337,7 +337,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso_image_32())
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->user_landing +
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
index a19e0a7bae2d..735ad9e563e1 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -42,7 +42,7 @@ extern const struct vdso_image vdso_image_32;
 
 #define current_has_vdso_image_32()					\
 	likely(current->mm->context.vdso_image == &vdso_image_32 &&	\
-		!!current->mm->context.vdso)
+	(unsigned long)current->mm->user_landing != UNMAPPED_USER_LANDING)
 #endif
 
 extern void __init init_vdso_image(const struct vdso_image *image);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 6fed2e523e0a..b18e6dd0a574 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -320,7 +320,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso_image_32())
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->user_landing +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
 		restorer = &frame->retcode;
@@ -382,7 +382,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso_image_32())
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->user_landing +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
 		restorer = &frame->retcode;
-- 
2.28.0

