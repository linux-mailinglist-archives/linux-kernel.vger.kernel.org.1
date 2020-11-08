Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662C92AA924
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgKHFRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgKHFRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:37 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269EDC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:37 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so3818897wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xf9PBV2g/ExX9Lpm+tkxbrAygS47VnLTW7V7iEvc0X0=;
        b=gr4T5QuT+jpiXgewfWjkhtkjmwLhSOGKh6uZJ7IvRaJ1vRa7MwSZSgQPzibLWUPcbU
         LP8i/8yuZgeICfKSE3Y34h1dmTLkJo70RtN4HZFkN2LhUq0XpKye+pcd/tuTncZ+ICVC
         KQSZG907V1hbHLuPZgHPSWebfP6YtnR9TQFHlWGfiFwH9sGKjfXfd2NBbg8INTOUki5o
         2oxs4fc6AqTpg3id6eWfX0KY7QwJCTcCW9f9y5n9QXOIcuhUaR1qDhhV6LaEcFXYhON1
         6nYu+McY22prMUXHelNC2SLiiKg20bTBmN9220nltFXsRQWcofP+x+EIpiT/tzjo4JCa
         e8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xf9PBV2g/ExX9Lpm+tkxbrAygS47VnLTW7V7iEvc0X0=;
        b=e/Pf4AkGw7VhAAqJxFzGGUIafy0BQacYEBvxXTxaO7sGlMovcbvn5OqYOOAxXumIIR
         9tVKxOnIzgvSUebOwy7lzqXYkoCe+h/kKQwkK20LAdQA7h5ped4x/8nnkBbT/u8VqbM4
         04ACSbociWwHMfOhySpe6Z55ywA47pg6xBfEcafxXALbYfqpcZl17AeHNf343cFeNr+k
         pPgdd0g2ALJ+kI1aIB3rD5YJEKu1tNAWEwZpWJjkosKCT6/Btb4aP1HZeYRJFp4jMuDa
         rOtBoi6xdpWO0hvkRdSPUHwRQNWjLdgRqwsyxNh1etITfDnh2Oc8k246T5Ztfs5h+yrG
         CMNw==
X-Gm-Message-State: AOAM532y74a/tAkdQvccJORjouGRXXKnDR/I07NVCKLR6tO6V3UskXeE
        YPeg/0U+D5NX1iao8oF1bG3Tn7sQmhVWXwMr
X-Google-Smtp-Source: ABdhPJyQufaWVdIbOnkR0N7elZuXy/Y3LlkhA0s45la4J6AB3oB+EB1Y0e8Nj+gurKLBKK7q4YxJag==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr10738502wro.373.1604812655445;
        Sat, 07 Nov 2020 21:17:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:34 -0800 (PST)
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
Subject: [PATCH 02/19] elf: Move arch_setup_additional_pages() to generic elf.h
Date:   Sun,  8 Nov 2020 05:17:12 +0000
Message-Id: <20201108051730.2042693-3-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ifdef the function in the header, not in the code.
Following kernel style, move it to Kconfig.
All it makes it easier to follow when the option is enabled/disabled.
Remove re-definition from compat_binfmt_elf, as it's always defined
under compat_arch_setup_additional_pages (to be reworked).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/Kconfig                |  1 +
 arch/arm/include/asm/elf.h      |  5 -----
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/elf.h    |  6 +-----
 arch/csky/Kconfig               |  1 +
 arch/csky/include/asm/elf.h     |  4 ----
 arch/hexagon/Kconfig            |  1 +
 arch/hexagon/include/asm/elf.h  |  6 ------
 arch/mips/Kconfig               |  1 +
 arch/mips/include/asm/elf.h     |  5 -----
 arch/nds32/Kconfig              |  1 +
 arch/nds32/include/asm/elf.h    |  3 ---
 arch/nios2/Kconfig              |  1 +
 arch/nios2/include/asm/elf.h    |  4 ----
 arch/powerpc/Kconfig            |  1 +
 arch/powerpc/include/asm/elf.h  |  5 -----
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/elf.h    |  5 -----
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/elf.h     |  5 -----
 arch/sh/Kconfig                 |  1 +
 arch/sh/include/asm/elf.h       |  6 ------
 arch/sparc/Kconfig              |  1 +
 arch/sparc/include/asm/elf_64.h |  6 ------
 arch/x86/Kconfig                |  1 +
 arch/x86/include/asm/elf.h      |  4 ----
 arch/x86/um/asm/elf.h           |  5 -----
 fs/Kconfig.binfmt               |  3 +++
 fs/binfmt_elf.c                 |  2 --
 fs/binfmt_elf_fdpic.c           |  3 +--
 fs/compat_binfmt_elf.c          |  2 --
 include/linux/elf.h             | 12 ++++++++++++
 32 files changed, 30 insertions(+), 74 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb700e471332..bece41f3b3b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if MMU
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 61941f369861..1f4b91a17a91 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -132,7 +132,6 @@ extern int arm_elf_read_implies_exec(int);
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
-#ifdef CONFIG_MMU
 #ifdef CONFIG_VDSO
 #define ARCH_DLINFO						\
 do {								\
@@ -140,9 +139,5 @@ do {								\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
 #endif
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-int arch_setup_additional_pages(struct linux_binprm *, int);
-#endif
 
 #endif
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d1b81221c6a9..7111cf335ede 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -26,6 +26,7 @@ config ARM64
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..d1073ffa7f24 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -181,11 +181,6 @@ do {									\
 		NEW_AUX_ENT(AT_IGNORE, 0);				\
 } while (0)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
 /* 1GB of VA */
 #ifdef CONFIG_COMPAT
 #define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
@@ -242,6 +237,7 @@ do {									\
 #else
 #define COMPAT_ARCH_DLINFO
 #endif
+struct linux_binprm;
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8fec85ab5da6..00e7b063f6ca 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -4,6 +4,7 @@ config CSKY
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
index eb2cc5a673b5..8ec675f8d0d9 100644
--- a/arch/csky/include/asm/elf.h
+++ b/arch/csky/include/asm/elf.h
@@ -84,8 +84,4 @@ extern int dump_task_regs(struct task_struct *tsk, elf_gregset_t *elf_regs);
 #define ELF_PLATFORM		(NULL)
 #define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
 #endif /* __ASM_CSKY_ELF_H */
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 6e00c16a36b5..74bc280523e4 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,6 +5,7 @@ comment "Linux Kernel Configuration for Hexagon"
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	select HAVE_OPROFILE
diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/elf.h
index 5bfdd9b147fd..eba4131610aa 100644
--- a/arch/hexagon/include/asm/elf.h
+++ b/arch/hexagon/include/asm/elf.h
@@ -207,10 +207,4 @@ do {					\
  */
 #define ELF_PLATFORM  (NULL)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
-
 #endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 077c4ae09550..5e696ab80df4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,6 +7,7 @@ config MIPS
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_UPROBES
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 71c7622025d1..6665cf7870b3 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -480,11 +480,6 @@ do {									\
 		    (unsigned long)current->mm->context.vdso);		\
 } while (0)
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
 struct arch_elf_state {
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 62313902d75d..02afe5ebdfff 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -8,6 +8,7 @@ config NDS32
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 1853dc89b8ac..36cec4ae5a84 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -173,8 +173,5 @@ do {								\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-int arch_setup_additional_pages(struct linux_binprm *, int);
 
 #endif
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index c24955c81c92..8159123a995e 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -3,6 +3,7 @@ config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
diff --git a/arch/nios2/include/asm/elf.h b/arch/nios2/include/asm/elf.h
index 984dd6de17c2..4f8baaef843f 100644
--- a/arch/nios2/include/asm/elf.h
+++ b/arch/nios2/include/asm/elf.h
@@ -28,10 +28,6 @@
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES	1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
 #define ELF_CORE_COPY_REGS(pr_reg, regs)				\
 { do {									\
 	/* Bleech. */							\
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0d29c264ba0c..61198a087b6c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 53ed2ca40151..ba0e1e331088 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -111,11 +111,6 @@ extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
 
-/* vDSO has arch_setup_additional_pages */
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
 #define VDSO_AUX_ENT(a,b) NEW_AUX_ENT(a,b)
 
 /* 1GB for 64bit, 8MB for 32bit */
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 880c2b3b65d0..d8489724ddbf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -26,6 +26,7 @@ config RISCV
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 5c725e1df58b..628444d3bbab 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -75,10 +75,5 @@ do {								\
 	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			\
 		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	\
 } while (0)
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
-#endif /* CONFIG_MMU */
 
 #endif /* _ASM_RISCV_ELF_H */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c3e4cbebcf0b..a02c99016acd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -67,6 +67,7 @@ config S390
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 5775fc22f410..f6ce9df8a996 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -276,9 +276,4 @@ do {									    \
 			    (unsigned long)current->mm->context.vdso_base); \
 } while (0)
 
-struct linux_binprm;
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-int arch_setup_additional_pages(struct linux_binprm *, int);
-
 #endif
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5fa580219a86..c0bae180d8b8 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -8,6 +8,7 @@ config SUPERH
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if VSYSCALL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/sh/include/asm/elf.h b/arch/sh/include/asm/elf.h
index 2862d6d1cb64..9b3e22e771a1 100644
--- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -164,12 +164,6 @@ do {									\
 	set_personality(PER_LINUX_32BIT | (current->personality & (~PER_MASK)))
 
 #ifdef CONFIG_VSYSCALL
-/* vDSO has arch_setup_additional_pages */
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
-
 extern unsigned int vdso_enabled;
 extern void __kernel_vsyscall;
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e4aad12b9c47..9d5cc6be8974 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES if SPARC64
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 8fb09eec8c3e..63a622c36df3 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -223,10 +223,4 @@ do {									\
 	NEW_AUX_ENT(AT_ADI_NBITS, adi_state.caps.nbits);		\
 	NEW_AUX_ENT(AT_ADI_UEONADI, adi_state.caps.ue_on_adi);		\
 } while (0)
-
-struct linux_binprm;
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES	1
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-					int uses_interp);
 #endif /* !(__ASM_SPARC64_ELF_H) */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 34d5fb82f674..b068f949d2e4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -78,6 +78,7 @@ config X86
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
+	select ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 109697a19eb1..d00b723eea2d 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -378,10 +378,6 @@ else									\
 	 vdso_image_32.sym___kernel_vsyscall)
 
 struct linux_binprm;
-
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index c907b20d4993..7bc1d9d94d66 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -181,11 +181,6 @@ do {								\
 #define FIXADDR_USER_START      0
 #define FIXADDR_USER_END        0
 
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-extern int arch_setup_additional_pages(struct linux_binprm *bprm,
-	int uses_interp);
-
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
 #define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 885da6d983b4..4ed2ab0a1565 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -39,6 +39,9 @@ config ARCH_BINFMT_ELF_STATE
 config ARCH_HAVE_ELF_PROT
 	bool
 
+config ARCH_HAS_SETUP_ADDITIONAL_PAGES
+	bool
+
 config ARCH_USE_GNU_PROPERTY
 	bool
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3de72c0e0406..b9adbeb59101 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1249,11 +1249,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
-#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
 		goto out;
-#endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
 	retval = create_elf_tables(bprm, elf_ex,
 			  load_addr, interp_load_addr, e_entry);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index be4062b8ba75..b9a6d1b2b5bb 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -374,11 +374,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto error;
-#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
+
 	retval = arch_setup_additional_pages(bprm, !!interpreter_name);
 	if (retval < 0)
 		goto error;
-#endif
 #endif
 
 	/* load the executable and interpreter into memory */
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 12b991368f0a..3606dd3a32f5 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -116,8 +116,6 @@
 #endif
 
 #ifdef	compat_arch_setup_additional_pages
-#undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 #undef	arch_setup_additional_pages
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 6dbcfe7a3fd7..95bf7a1abaef 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -104,4 +104,16 @@ static inline int arch_elf_adjust_prot(int prot,
 }
 #endif
 
+struct linux_binprm;
+#ifdef CONFIG_ARCH_HAS_SETUP_ADDITIONAL_PAGES
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp);
+#else
+static inline int arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_ELF_H */
-- 
2.28.0

