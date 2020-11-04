Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B652F2A7156
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgKDXUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbgKDXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a12so367718ybc.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m6NkS/JV603XKUISQAf2uBeN8qEKz+oBJzmJFbJbenA=;
        b=mjriG4C8574Aned+d7tRCxJHquPU91P3o4RudihgRFeR17dAoEVMhxq05FLNYkOMT1
         vW+ClCkmI3k/taoxRt4ARV9gxLesimT+SOnh3HMpXW5seVIDg0pWm3q03nGfNeZ/Bkrg
         GiGpFOwVIaWW5CBbAfjnwEnJ92ITnpodfh9ju346K1iXxKbUTx2h3vW8y32rwjmITVKy
         9jdxg0APYcWHeY7vttRpcI3ByE4lbWGUMaWGVgUSPRuATqn/iEQ1YeSDuuo53n+lEacl
         /ifFzPzu5IO8rCCiYmib+ynaTAF+R71MZolr2Yu9nkiI3qkIifTMbaNY6af9My7XgTx+
         WoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m6NkS/JV603XKUISQAf2uBeN8qEKz+oBJzmJFbJbenA=;
        b=RwsUw6jiIQsq1taRUqy7jKJsgpFL7W6GGCsTRmcYKgc3mWTaFu91dnOPsg2FvaSTKS
         4dU9WqsI56udegZZbP5hSrnN3S/h1c6S3/k0FxTMJ0/zoA4XRFuepp2vbPHyywz2cIOr
         fTw5JS0IxpqKHvvDsncgU/Y8kq5HfKmpvRue3jUKbdaJdS/Pcr91F5XVHhlxsKD93tw+
         6KiEJvHpS/qUrfCGVX5sGqUt563YA2Sh54n1RhlMhfkhRZKzNnNT1F0YxRdmtYN4OneY
         pG8ax9pjq6GfxNF+ijP6y2g1Yrs4gvkwBTNpMWn+hUlxxhkU98l+5Jkubg9Kj7LiiNcZ
         dZgg==
X-Gm-Message-State: AOAM533kEHn7N2dFwtaUYnO/fWHsyakeuIDpIi13THwu1V+18WNgqnmI
        IOx5XrNd3avwzR/maLRcUA+QqJicZZb9DkBl
X-Google-Smtp-Source: ABdhPJx1yfyIhbtM0BQJ/FHiVt3rjyoFmvsTRGczISLDZGIMa52r6KldqLMMeRpmwoi59PqcONHL4T6m9wl0tljR
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a25:7e82:: with SMTP id
 z124mr287964ybc.388.1604532035849; Wed, 04 Nov 2020 15:20:35 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:52 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <12faf1f7dc2d3f672f856e141dd9542e8a7cc7c1.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 37/43] kasan, arm64: expand CONFIG_KASAN checks
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some #ifdef CONFIG_KASAN checks are only relevant for software KASAN
modes (either related to shadow memory or compiler instrumentation).
Expand those into CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I91e661e2c1627783cb845d877c6371dfc8779505
---
 arch/arm64/Kconfig                 |  2 +-
 arch/arm64/Makefile                |  2 +-
 arch/arm64/include/asm/assembler.h |  2 +-
 arch/arm64/include/asm/memory.h    |  2 +-
 arch/arm64/include/asm/string.h    |  5 +++--
 arch/arm64/kernel/head.S           |  2 +-
 arch/arm64/kernel/image-vars.h     |  2 +-
 arch/arm64/kernel/kaslr.c          |  3 ++-
 arch/arm64/kernel/module.c         |  6 ++++--
 arch/arm64/mm/ptdump.c             |  6 +++---
 include/linux/kasan-checks.h       |  2 +-
 include/linux/kasan.h              |  7 ++++---
 include/linux/moduleloader.h       |  3 ++-
 include/linux/string.h             |  2 +-
 mm/ptdump.c                        | 13 ++++++++-----
 scripts/Makefile.lib               |  2 ++
 16 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cebbd07ba27c..43702780f28c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -330,7 +330,7 @@ config BROKEN_GAS_INST
 
 config KASAN_SHADOW_OFFSET
 	hex
-	depends on KASAN
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	default 0xdfffa00000000000 if (ARM64_VA_BITS_48 || ARM64_VA_BITS_52) && !KASAN_SW_TAGS
 	default 0xdfffd00000000000 if ARM64_VA_BITS_47 && !KASAN_SW_TAGS
 	default 0xdffffe8000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 50ad9cbccb51..0b31a3f06f15 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -141,7 +141,7 @@ head-y		:= arch/arm64/kernel/head.o
 
 ifeq ($(CONFIG_KASAN_SW_TAGS), y)
 KASAN_SHADOW_SCALE_SHIFT := 4
-else
+else ifeq ($(CONFIG_KASAN_GENERIC), y)
 KASAN_SHADOW_SCALE_SHIFT := 3
 endif
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ddbe6bf00e33..bf125c591116 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -473,7 +473,7 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #define NOKPROBE(x)
 #endif
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define EXPORT_SYMBOL_NOKASAN(name)
 #else
 #define EXPORT_SYMBOL_NOKASAN(name)	EXPORT_SYMBOL(name)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 580d6ef17079..507012ed24f4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -72,7 +72,7 @@
  * address space for the shadow region respectively. They can bloat the stack
  * significantly, so double the (minimum) stack size when they are in use.
  */
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 #define KASAN_SHADOW_END	((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
 					+ KASAN_SHADOW_OFFSET)
diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index b31e8e87a0db..3a3264ff47b9 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
-#ifndef CONFIG_KASAN
+#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -48,7 +48,8 @@ extern void *__memset(void *, int, __kernel_size_t);
 void memcpy_flushcache(void *dst, const void *src, size_t cnt);
 #endif
 
-#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	!defined(__SANITIZE_ADDRESS__)
 
 /*
  * For files that are not instrumented (e.g. mm/slub.c) we
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d8d9caf02834..fdcb99d7ba23 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -448,7 +448,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
 #ifdef CONFIG_RANDOMIZE_BASE
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c615b285ff5b..4282edd2fe81 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -37,7 +37,7 @@ __efistub_strncmp		= __pi_strncmp;
 __efistub_strrchr		= __pi_strrchr;
 __efistub___clean_dcache_area_poc = __pi___clean_dcache_area_poc;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 __efistub___memcpy		= __pi_memcpy;
 __efistub___memmove		= __pi_memmove;
 __efistub___memset		= __pi_memset;
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b181e0544b79..e8e17e91aa02 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -151,7 +151,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
 
-	if (IS_ENABLED(CONFIG_KASAN))
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
 		/*
 		 * KASAN does not expect the module region to intersect the
 		 * vmalloc region, since shadow memory is allocated for each
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 2a1ad95d9b2c..fe21e0f06492 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -30,7 +30,8 @@ void *module_alloc(unsigned long size)
 	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
 		gfp_mask |= __GFP_NOWARN;
 
-	if (IS_ENABLED(CONFIG_KASAN))
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
 		/* don't exceed the static module region - see below */
 		module_alloc_end = MODULES_END;
 
@@ -39,7 +40,8 @@ void *module_alloc(unsigned long size)
 				NUMA_NO_NODE, __builtin_return_address(0));
 
 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
-	    !IS_ENABLED(CONFIG_KASAN))
+	    !IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+	    !IS_ENABLED(CONFIG_KASAN_SW_TAGS))
 		/*
 		 * KASAN can only deal with module allocations being served
 		 * from the reserved module region, since the remainder of
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 807dc634bbd2..04137a8f3d2d 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -29,7 +29,7 @@
 enum address_markers_idx {
 	PAGE_OFFSET_NR = 0,
 	PAGE_END_NR,
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	KASAN_START_NR,
 #endif
 };
@@ -37,7 +37,7 @@ enum address_markers_idx {
 static struct addr_marker address_markers[] = {
 	{ PAGE_OFFSET,			"Linear Mapping start" },
 	{ 0 /* PAGE_END */,		"Linear Mapping end" },
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
 #endif
@@ -383,7 +383,7 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	address_markers[PAGE_END_NR].start_address = PAGE_END;
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
 #endif
 	ptdump_initialize();
diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index ac6aba632f2d..ca5e89fb10d3 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -9,7 +9,7 @@
  * even in compilation units that selectively disable KASAN, but must use KASAN
  * to validate access to an address.   Never use these in header files!
  */
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 bool __kasan_check_read(const volatile void *p, unsigned int size);
 bool __kasan_check_write(const volatile void *p, unsigned int size);
 #else
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 32b9d283e0a0..beb699e90e55 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -235,7 +235,8 @@ static inline void kasan_release_vmalloc(unsigned long start,
 
 #endif /* CONFIG_KASAN_VMALLOC */
 
-#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+		!defined(CONFIG_KASAN_VMALLOC)
 
 /*
  * These functions provide a special case to support backing module
@@ -245,12 +246,12 @@ static inline void kasan_release_vmalloc(unsigned long start,
 int kasan_module_alloc(void *addr, size_t size);
 void kasan_free_shadow(const struct vm_struct *vm);
 
-#else /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
+#else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
 static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
 static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
-#endif /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
+#endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
 #ifdef CONFIG_KASAN_INLINE
 void kasan_non_canonical_hook(unsigned long addr);
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 4fa67a8b2265..9e09d11ffe5b 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -96,7 +96,8 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
-#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+		!defined(CONFIG_KASAN_VMALLOC)
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
 #else
diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..016a157e2251 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -266,7 +266,7 @@ void __write_overflow(void) __compiletime_error("detected write beyond size of o
 
 #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
 extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
 extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
diff --git a/mm/ptdump.c b/mm/ptdump.c
index ba88ec43ff21..4354c1422d57 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -4,7 +4,7 @@
 #include <linux/ptdump.h>
 #include <linux/kasan.h>
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
  * This is an optimization for KASAN=y case. Since all kasan page tables
  * eventually point to the kasan_early_shadow_page we could call note_page()
@@ -31,7 +31,8 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pgd_t val = READ_ONCE(*pgd);
 
-#if CONFIG_PGTABLE_LEVELS > 4 && defined(CONFIG_KASAN)
+#if CONFIG_PGTABLE_LEVELS > 4 && \
+		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 	if (pgd_page(val) == virt_to_page(lm_alias(kasan_early_shadow_p4d)))
 		return note_kasan_page_table(walk, addr);
 #endif
@@ -51,7 +52,8 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	p4d_t val = READ_ONCE(*p4d);
 
-#if CONFIG_PGTABLE_LEVELS > 3 && defined(CONFIG_KASAN)
+#if CONFIG_PGTABLE_LEVELS > 3 && \
+		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 	if (p4d_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pud)))
 		return note_kasan_page_table(walk, addr);
 #endif
@@ -71,7 +73,8 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pud_t val = READ_ONCE(*pud);
 
-#if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_KASAN)
+#if CONFIG_PGTABLE_LEVELS > 2 && \
+		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
 	if (pud_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pmd)))
 		return note_kasan_page_table(walk, addr);
 #endif
@@ -91,7 +94,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct ptdump_state *st = walk->private;
 	pmd_t val = READ_ONCE(*pmd);
 
-#if defined(CONFIG_KASAN)
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (pmd_page(val) == virt_to_page(lm_alias(kasan_early_shadow_pte)))
 		return note_kasan_page_table(walk, addr);
 #endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 94133708889d..213677a5ed33 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -148,10 +148,12 @@ endif
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
 #
 ifeq ($(CONFIG_KASAN),y)
+ifneq ($(CONFIG_KASAN_HW_TAGS),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
 		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
 endif
+endif
 
 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-- 
2.29.1.341.ge80a0c044ae-goog

