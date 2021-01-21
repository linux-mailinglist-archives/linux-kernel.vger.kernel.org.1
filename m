Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D902FE348
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbhAUG6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbhAUG5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:57:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0060E23877;
        Thu, 21 Jan 2021 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212189;
        bh=kEO4hoLLkrimkYHW8CTs8woS0jhPbINCv7+lZeSg06I=;
        h=From:To:Cc:Subject:Date:From;
        b=JpMwBMrajubJTOO4095W6ZyirdzWuq3Y0qRWgKVEwFzJavuoCjb7gpi6RmVYswtkI
         7lDhzKiIrtIXEsrjIuhUhHBjZt7XV/wJaUXGouK/tSiPLZREuA6T5sCD16XhJ9FU1R
         +XFDcReEPj1yZDCcke1HTFgaVfp1XFAke3TO8bMXeJnoURpFD5vg0Ly862M1jb/U1V
         Qq47zlnmLmZAEcSHacrFjlFsrN5fvE5DjmsFeLlSegcgK6mhqYpIbMboZkx70PRFzP
         mXXyV1gPi2aB+4isC7wcxVNRYZBYSgUNUmyA3qKH5l1HdEjl56ANQnfQX1YSpKIclO
         it5An87cXScmg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 01/29] csky: Add memory layout 2.5G(user):1.5G(kernel)
Date:   Thu, 21 Jan 2021 14:53:21 +0800
Message-Id: <20210121065349.3188251-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There are two ways for translating va to pa for csky:
 - Use TLB(Translate Lookup Buffer) and PTW (Page Table Walk)
 - Use SSEG0/1 (Simple Segment Mapping)

We use tlb mapping 0-2G and 3G-4G virtual address area and SSEG0/1
are for 2G-2.5G and 2.5G-3G translation. We could disable SSEG0
to use 2G-2.5G as TLB user mapping.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig                   | 16 ++++++++++++++++
 arch/csky/abiv1/inc/abi/ckmmu.h     |  8 ++++----
 arch/csky/abiv2/inc/abi/ckmmu.h     | 14 +++++++-------
 arch/csky/abiv2/inc/abi/entry.h     | 19 ++++++++++++++++---
 arch/csky/include/asm/memory.h      |  2 +-
 arch/csky/include/asm/mmu_context.h |  8 +-------
 arch/csky/include/asm/page.h        |  2 +-
 arch/csky/include/asm/pgalloc.h     |  2 +-
 arch/csky/include/asm/pgtable.h     |  2 +-
 arch/csky/include/asm/processor.h   |  2 +-
 arch/csky/include/asm/segment.h     |  2 +-
 arch/csky/kernel/atomic.S           |  4 ++++
 arch/csky/kernel/entry.S            | 10 ++++++++--
 arch/csky/kernel/head.S             | 10 ++++++++--
 arch/csky/kernel/setup.c            | 18 ++++++++++++++++--
 arch/csky/kernel/smp.c              |  7 +++----
 arch/csky/kernel/vmlinux.lds.S      |  2 +-
 arch/csky/mm/fault.c                |  7 +------
 arch/csky/mm/init.c                 | 29 ++++++++++++++++++++++-------
 19 files changed, 113 insertions(+), 51 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 89dd2fcf38fa..21b2ab099c8b 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -192,6 +192,22 @@ config CPU_CK860
 endchoice
 
 choice
+	prompt "PAGE OFFSET"
+	default PAGE_OFFSET_80000000
+
+config PAGE_OFFSET_80000000
+	bool "PAGE OFFSET 2G (user:kernel = 2:2)"
+
+config PAGE_OFFSET_A0000000
+	bool "PAGE OFFSET 2.5G (user:kernel = 2.5:1.5)"
+endchoice
+
+config PAGE_OFFSET
+	hex
+	default 0x80000000 if PAGE_OFFSET_80000000
+	default 0xa0000000 if PAGE_OFFSET_A0000000
+choice
+
 	prompt "C-SKY PMU type"
 	depends on PERF_EVENTS
 	depends on CPU_CK807 || CPU_CK810 || CPU_CK860
diff --git a/arch/csky/abiv1/inc/abi/ckmmu.h b/arch/csky/abiv1/inc/abi/ckmmu.h
index ba8eb5870835..cceb3afb4c91 100644
--- a/arch/csky/abiv1/inc/abi/ckmmu.h
+++ b/arch/csky/abiv1/inc/abi/ckmmu.h
@@ -89,13 +89,13 @@ static inline void tlb_invalid_indexed(void)
 	cpwcr("cpcr8", 0x02000000);
 }
 
-static inline void setup_pgd(unsigned long pgd, bool kernel)
+static inline void setup_pgd(pgd_t *pgd)
 {
-	cpwcr("cpcr29", pgd | BIT(0));
+	cpwcr("cpcr29", __pa(pgd) | BIT(0));
 }
 
-static inline unsigned long get_pgd(void)
+static inline pgd_t *get_pgd(void)
 {
-	return cprcr("cpcr29") & ~BIT(0);
+	return __va(cprcr("cpcr29") & ~BIT(0));
 }
 #endif /* __ASM_CSKY_CKMMUV1_H */
diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h b/arch/csky/abiv2/inc/abi/ckmmu.h
index 73ded7c72482..c39b13810550 100644
--- a/arch/csky/abiv2/inc/abi/ckmmu.h
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -100,16 +100,16 @@ static inline void tlb_invalid_indexed(void)
 	mtcr("cr<8, 15>", 0x02000000);
 }
 
-static inline void setup_pgd(unsigned long pgd, bool kernel)
+static inline void setup_pgd(pgd_t *pgd)
 {
-	if (kernel)
-		mtcr("cr<28, 15>", pgd | BIT(0));
-	else
-		mtcr("cr<29, 15>", pgd | BIT(0));
+#ifdef CONFIG_CPU_HAS_TLBI
+	mtcr("cr<28, 15>", __pa(pgd) | BIT(0));
+#endif
+	mtcr("cr<29, 15>", __pa(pgd) | BIT(0));
 }
 
-static inline unsigned long get_pgd(void)
+static inline pgd_t *get_pgd(void)
 {
-	return mfcr("cr<29, 15>") & ~BIT(0);
+	return __va(mfcr("cr<29, 15>") & ~BIT(0));
 }
 #endif /* __ASM_CSKY_CKMMUV2_H */
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index bedcc6f06bba..ab382bca73a2 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -26,6 +26,9 @@
 	stw	tls, (sp, 0)
 	stw	lr, (sp, 4)
 
+	RD_MEH	lr
+	WR_MEH	lr
+
 	mfcr	lr, epc
 	movi	tls, \epc_inc
 	add	lr, tls
@@ -231,6 +234,16 @@
 	mtcr	\rx, cr<8, 15>
 .endm
 
+#ifdef CONFIG_PAGE_OFFSET_80000000
+#define MSA_SET cr<30, 15>
+#define MSA_CLR cr<31, 15>
+#endif
+
+#ifdef CONFIG_PAGE_OFFSET_A0000000
+#define MSA_SET cr<31, 15>
+#define MSA_CLR cr<30, 15>
+#endif
+
 .macro SETUP_MMU
 	/* Init psr and enable ee */
 	lrw	r6, DEFAULT_PSR_VALUE
@@ -281,15 +294,15 @@
 	 * 31 - 29 | 28 - 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
 	 *   BA     Reserved  SH  WA  B   SO SEC  C   D   V
 	 */
-	mfcr	r6, cr<30, 15> /* Get MSA0 */
+	mfcr	r6, MSA_SET /* Get MSA */
 2:
 	lsri	r6, 29
 	lsli	r6, 29
 	addi	r6, 0x1ce
-	mtcr	r6, cr<30, 15> /* Set MSA0 */
+	mtcr	r6, MSA_SET /* Set MSA */
 
 	movi    r6, 0
-	mtcr	r6, cr<31, 15> /* Clr MSA1 */
+	mtcr	r6, MSA_CLR /* Clr MSA */
 
 	/* enable MMU */
 	mfcr    r6, cr18
diff --git a/arch/csky/include/asm/memory.h b/arch/csky/include/asm/memory.h
index a65c6759f537..d12179801ae3 100644
--- a/arch/csky/include/asm/memory.h
+++ b/arch/csky/include/asm/memory.h
@@ -10,7 +10,7 @@
 
 #define FIXADDR_TOP	_AC(0xffffc000, UL)
 #define PKMAP_BASE	_AC(0xff800000, UL)
-#define VMALLOC_START	_AC(0xc0008000, UL)
+#define VMALLOC_START	(PAGE_OFFSET + LOWMEM_LIMIT + (PAGE_SIZE * 8))
 #define VMALLOC_END	(PKMAP_BASE - (PAGE_SIZE * 2))
 
 #ifdef CONFIG_HAVE_TCM
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index b227d29393a8..3767dbffd02f 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -14,12 +14,6 @@
 #include <linux/sched.h>
 #include <abi/ckmmu.h>
 
-#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
-	setup_pgd(__pa(pgd), false)
-
-#define TLBMISS_HANDLER_SETUP_PGD_KERNEL(pgd) \
-	setup_pgd(__pa(pgd), true)
-
 #define ASID_MASK		((1 << CONFIG_CPU_ASID_BITS) - 1)
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
 
@@ -36,7 +30,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	if (prev != next)
 		check_and_switch_context(next, cpu);
 
-	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+	setup_pgd(next->pgd);
 	write_mmu_entryhi(next->context.asid.counter);
 
 	flush_icache_deferred(next);
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 9b98bf31d57c..3b91fc3cf36f 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -24,7 +24,7 @@
  * address region. We use them mapping kernel 1GB direct-map address area and
  * for more than 1GB of memory we use highmem.
  */
-#define PAGE_OFFSET	0x80000000
+#define PAGE_OFFSET	CONFIG_PAGE_OFFSET
 #define SSEG_SIZE	0x20000000
 #define LOWMEM_LIMIT	(SSEG_SIZE * 2)
 
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index d58d8146b729..33878c4aaa60 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -71,7 +71,7 @@ do {							\
 } while (0)
 
 extern void pagetable_init(void);
-extern void pre_mmu_init(void);
+extern void mmu_init(unsigned long min_pfn, unsigned long max_pfn);
 extern void pre_trap_init(void);
 
 #endif /* __ASM_CSKY_PGALLOC_H */
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 2002cb7f1053..6ec97af0d1ff 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -14,7 +14,7 @@
 #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
+#define USER_PTRS_PER_PGD	(PAGE_OFFSET/PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0UL
 
 /*
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 4800f6563abb..3b4be4cb2ad0 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -28,7 +28,7 @@ extern struct cpuinfo_csky cpu_data[];
  * for a 64 bit kernel expandable to 8192EB, of which the current CSKY
  * implementations will "only" be able to use 1TB ...
  */
-#define TASK_SIZE       0x7fff8000UL
+#define TASK_SIZE	(PAGE_OFFSET - (PAGE_SIZE * 8))
 
 #ifdef __KERNEL__
 #define STACK_TOP       TASK_SIZE
diff --git a/arch/csky/include/asm/segment.h b/arch/csky/include/asm/segment.h
index 79ede9b1a646..66d5e0f4f0e0 100644
--- a/arch/csky/include/asm/segment.h
+++ b/arch/csky/include/asm/segment.h
@@ -10,7 +10,7 @@ typedef struct {
 
 #define KERNEL_DS		((mm_segment_t) { 0xFFFFFFFF })
 
-#define USER_DS			((mm_segment_t) { 0x80000000UL })
+#define USER_DS			((mm_segment_t) { PAGE_OFFSET })
 #define get_fs()		(current_thread_info()->addr_limit)
 #define set_fs(x)		(current_thread_info()->addr_limit = (x))
 #define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
index 3821ef9b7567..f03db1d8d060 100644
--- a/arch/csky/kernel/atomic.S
+++ b/arch/csky/kernel/atomic.S
@@ -14,6 +14,10 @@
  */
 ENTRY(csky_cmpxchg)
 	USPTOKSP
+
+	RD_MEH	a3
+	WR_MEH	a3
+
 	mfcr	a3, epc
 	addi	a3, TRAP0_SIZE
 
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 5a5cabd076e1..d5f6d04b21a8 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -49,6 +49,7 @@ ENTRY(csky_\name)
 
 	RD_PGDR	r6
 	RD_MEH	a3
+	WR_MEH	a3
 #ifdef CONFIG_CPU_HAS_TLBI
 	tlbi.vaas a3
 	sync.is
@@ -64,10 +65,11 @@ ENTRY(csky_\name)
 	WR_MCIR	a2
 #endif
 	bclri   r6, 0
+	lrw	a2, PAGE_OFFSET
+	add	r6, a2
 	lrw	a2, va_pa_offset
 	ld.w	a2, (a2, 0)
 	subu	r6, a2
-	bseti	r6, 31
 
 	mov     a2, a3
 	lsri    a2, _PGDIR_SHIFT
@@ -75,10 +77,11 @@ ENTRY(csky_\name)
 	addu    r6, a2
 	ldw     r6, (r6)
 
+	lrw	a2, PAGE_OFFSET
+	add	r6, a2
 	lrw	a2, va_pa_offset
 	ld.w	a2, (a2, 0)
 	subu	r6, a2
-	bseti	r6, 31
 
 	lsri    a3, PTE_INDX_SHIFT
 	lrw     a2, PTE_INDX_MSK
@@ -314,6 +317,9 @@ ENTRY(csky_trap)
 ENTRY(csky_get_tls)
 	USPTOKSP
 
+	RD_MEH	a0
+	WR_MEH	a0
+
 	/* increase epc for continue */
 	mfcr	a0, epc
 	addi	a0, TRAP0_SIZE
diff --git a/arch/csky/kernel/head.S b/arch/csky/kernel/head.S
index 17ed9d250480..7e3e4f15b052 100644
--- a/arch/csky/kernel/head.S
+++ b/arch/csky/kernel/head.S
@@ -21,10 +21,16 @@ END(_start)
 ENTRY(_start_smp_secondary)
 	SETUP_MMU
 
-	/* copy msa1 from CPU0 */
-	lrw     r6, secondary_msa1
+#ifdef CONFIG_PAGE_OFFSET_80000000
+	lrw	r6, secondary_msa1
 	ld.w	r6, (r6, 0)
 	mtcr	r6, cr<31, 15>
+#endif
+
+	lrw     r6, secondary_pgd
+	ld.w	r6, (r6, 0)
+	mtcr	r6, cr<28, 15>
+	mtcr	r6, cr<29, 15>
 
 	/* set stack point */
 	lrw     r6, secondary_stack
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index e4cab16056d6..e93bc6f74432 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -45,13 +45,17 @@ static void __init csky_memblock_init(void)
 
 	if (size >= lowmem_size) {
 		max_low_pfn = min_low_pfn + lowmem_size;
+#ifdef CONFIG_PAGE_OFFSET_80000000
 		write_mmu_msa1(read_mmu_msa0() + SSEG_SIZE);
+#endif
 	} else if (size > sseg_size) {
 		max_low_pfn = min_low_pfn + sseg_size;
 	}
 
 	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
 
+	mmu_init(min_low_pfn, max_low_pfn);
+
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfn[ZONE_HIGHMEM] = max_pfn;
 
@@ -101,16 +105,26 @@ void __init setup_arch(char **cmdline_p)
 unsigned long va_pa_offset;
 EXPORT_SYMBOL(va_pa_offset);
 
+static inline unsigned long read_mmu_msa(void)
+{
+#ifdef CONFIG_PAGE_OFFSET_80000000
+	return read_mmu_msa0();
+#endif
+
+#ifdef CONFIG_PAGE_OFFSET_A0000000
+	return read_mmu_msa1();
+#endif
+}
+
 asmlinkage __visible void __init csky_start(unsigned int unused,
 					    void *dtb_start)
 {
 	/* Clean up bss section */
 	memset(__bss_start, 0, __bss_stop - __bss_start);
 
-	va_pa_offset = read_mmu_msa0() & ~(SSEG_SIZE - 1);
+	va_pa_offset = read_mmu_msa() & ~(SSEG_SIZE - 1);
 
 	pre_trap_init();
-	pre_mmu_init();
 
 	if (dtb_start == NULL)
 		early_init_dt_scan(__dtb_start);
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 041d0de6a1b6..0f9f5eef9338 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -203,8 +203,8 @@ volatile unsigned int secondary_hint;
 volatile unsigned int secondary_hint2;
 volatile unsigned int secondary_ccr;
 volatile unsigned int secondary_stack;
-
-unsigned long secondary_msa1;
+volatile unsigned int secondary_msa1;
+volatile unsigned int secondary_pgd;
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
@@ -216,6 +216,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	secondary_hint2 = mfcr("cr<21, 1>");
 	secondary_ccr  = mfcr("cr18");
 	secondary_msa1 = read_mmu_msa1();
+	secondary_pgd = mfcr("cr<29, 15>");
 
 	/*
 	 * Because other CPUs are in reset status, we must flush data
@@ -262,8 +263,6 @@ void csky_start_secondary(void)
 
 	flush_tlb_all();
 	write_mmu_pagemask(0);
-	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
-	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
 
 #ifdef CONFIG_CPU_HAS_FPU
 	init_fpu();
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index f03033e17c29..e8b1a4a49798 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -33,6 +33,7 @@ SECTIONS
 
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
+		VBR_BASE
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
 		TEXT_TEXT
@@ -104,7 +105,6 @@ SECTIONS
 
 	EXCEPTION_TABLE(L1_CACHE_BYTES)
 	BSS_SECTION(L1_CACHE_BYTES, PAGE_SIZE, L1_CACHE_BYTES)
-	VBR_BASE
 	_end = . ;
 
 	STABS_DEBUG
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 081b178b41b1..94eac13b9c97 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -59,7 +59,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 
 	si_code = SEGV_MAPERR;
 
-#ifndef CONFIG_CPU_HAS_TLBI
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -84,10 +83,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
-		unsigned long pgd_base;
-
-		pgd_base = (unsigned long)__va(get_pgd());
-		pgd = (pgd_t *)pgd_base + offset;
+		pgd = get_pgd() + offset;
 		pgd_k = init_mm.pgd + offset;
 
 		if (!pgd_present(*pgd_k))
@@ -110,7 +106,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto no_context;
 		return;
 	}
-#endif
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	/*
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index af627128314f..7742f1441a67 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -28,9 +28,12 @@
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
 #include <asm/tlb.h>
+#include <asm/cacheflush.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
+pte_t kernel_pte_tables[(PTRS_PER_PGD - USER_PTRS_PER_PGD)*PTRS_PER_PTE] __page_aligned_bss;
+
 EXPORT_SYMBOL(invalid_pte_table);
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
@@ -130,20 +133,32 @@ void pgd_init(unsigned long *p)
 
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		p[i] = __pa(invalid_pte_table);
+
+	flush_tlb_all();
+	local_icache_inv_all(NULL);
 }
 
-void __init pre_mmu_init(void)
+void __init mmu_init(unsigned long min_pfn, unsigned long max_pfn)
 {
-	/*
-	 * Setup page-table and enable TLB-hardrefill
-	 */
+	int i;
+
+	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+		swapper_pg_dir[i].pgd = __pa(invalid_pte_table);
+
+	for (i = USER_PTRS_PER_PGD; i < PTRS_PER_PGD; i++)
+		swapper_pg_dir[i].pgd =
+			__pa(kernel_pte_tables + (PTRS_PER_PTE * (i - USER_PTRS_PER_PGD)));
+
+	for (i = min_pfn; i < max_pfn; i++)
+		set_pte(&kernel_pte_tables[i - PFN_DOWN(va_pa_offset)], pfn_pte(i, PAGE_KERNEL));
+
 	flush_tlb_all();
-	pgd_init((unsigned long *)swapper_pg_dir);
-	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
-	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
+	local_icache_inv_all(NULL);
 
 	/* Setup page mask to 4k */
 	write_mmu_pagemask(0);
+
+	setup_pgd(swapper_pg_dir);
 }
 
 void __init fixrange_init(unsigned long start, unsigned long end,
-- 
2.17.1

