Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF85243184
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHLXsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 19:48:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52594 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgHLXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 19:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597276120; x=1628812120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyscPrTBMPEV1pFK6H6MS2gy9j/3IWx/0KXmF4ioecg=;
  b=XoeSXu+nbAGt9wQIpDFC9Kra+cG3ACpK/w0HUYdJUhhQG1ZFczdzbJi0
   bz60H8qT/JMmK4Z5Mnzgrx6UyV/PXBedRByHgFgwJOap/iLLZI3JYNmHq
   Q/kQeqze/OQaA4vcs+WZu6K3g7+HrAT3+icHfdZf8ZpxfdiZEa0jj+ro0
   H8eT8jDqKeJ/ldwHqK+iRSzjRGBOZACYdD9fNNVZf8EM4Gqq0Jiqf8izn
   TElRCqa4K0CYbOgAbkDEnGDA8h4BflZdy8L8JwOJwZNmS5ErAHwfVpzp8
   g3N7DOw8QOkBzbqH59yMGi2B/CAcFO+x0OkRByRiEHIGq/1sm9JqUQ7Jz
   g==;
IronPort-SDR: /0xJ5DCAkxiFlgoM4OG1WRFwg47ia1pVJsocPN5QQlu0aOlfaA3zU+MLu5YUcJ57KwB+R5SnSG
 F95QNf14ANmPrBq990Ypz4nyx9iQSH2kBvWug9Jp+kAQvUK0dmCwfh/mcpEN/2H+KceiOFRORw
 Ow7V3I1EyUghIpafvfoVOKjDNdFDRzQuexNMfM5qOzHTDUteKIWqdjHG1evGpIRTII0GT8qIfp
 eGVevKbzP+yqV7DN0c0GnTvNqpg1y7jP84cJOs0vMIhnnH+eBn3KdVVf5KYbPpSOMhUozplJ4P
 S5M=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; 
   d="scan'208";a="149145682"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 07:48:40 +0800
IronPort-SDR: miPafaKhQgD0xJzd5LgmIVhzW+C5/Ff9tddWEI1lHrb0KX8qZ0fAe0sTNGZt+28ACUXN2bWRr9
 OvWMpQtXI60g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 16:35:47 -0700
IronPort-SDR: s3XIhzFKbWw99sBsAPO2dHMSpXFypcoMB0ov+sphPMbk/v9YzMU10loiJ1laDEj6xfgA5YFG+k
 oq4/SiZomxug==
WDCIronportException: Internal
Received: from usa002576.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.59])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 16:48:36 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, fwts-devel@lists.ubuntu.com,
        Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v5 8/9] RISC-V: Add EFI runtime services
Date:   Wed, 12 Aug 2020 16:47:57 -0700
Message-Id: <20200812234758.3563-9-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200812234758.3563-1-atish.patra@wdc.com>
References: <20200812234758.3563-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds EFI runtime service support for RISC-V.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig                      |   2 +
 arch/riscv/include/asm/efi.h            |  20 ++++
 arch/riscv/include/asm/mmu.h            |   2 +
 arch/riscv/include/asm/pgtable.h        |   4 +
 arch/riscv/kernel/Makefile              |   1 +
 arch/riscv/kernel/efi.c                 | 105 +++++++++++++++++
 arch/riscv/kernel/setup.c               |   7 +-
 arch/riscv/mm/init.c                    |   2 +-
 drivers/firmware/efi/Makefile           |   2 +
 drivers/firmware/efi/libstub/efi-stub.c |  11 +-
 drivers/firmware/efi/riscv-runtime.c    | 143 ++++++++++++++++++++++++
 11 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/kernel/efi.c
 create mode 100644 drivers/firmware/efi/riscv-runtime.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e11907cc7a43..b2164109483d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -412,7 +412,9 @@ config EFI
 	select EFI_PARAMS_FROM_FDT
 	select EFI_STUB
 	select EFI_GENERIC_STUB
+	select EFI_RUNTIME_WRAPPERS
 	select RISCV_ISA_C
+	depends on MMU
 	default y
 	help
 	  This option provides support for runtime services provided
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 86da231909bb..93c305a638f4 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -5,11 +5,28 @@
 #ifndef _ASM_EFI_H
 #define _ASM_EFI_H
 
+#include <asm/csr.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_EFI
+extern void efi_init(void);
+#else
+#define efi_init()
+#endif
+
+int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
+int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
+
+#define arch_efi_call_virt_setup()      efi_virtmap_load()
+#define arch_efi_call_virt_teardown()   efi_virtmap_unload()
+
+#define arch_efi_call_virt(p, f, args...) p->f(args)
+
+#define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
+
 /* on RISC-V, the FDT may be located anywhere in system RAM */
 static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
 {
@@ -33,4 +50,7 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 {
 }
 
+void efi_virtmap_load(void);
+void efi_virtmap_unload(void);
+
 #endif /* _ASM_EFI_H */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 967eacb01ab5..dabcf2cfb3dc 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -20,6 +20,8 @@ typedef struct {
 #endif
 } mm_context_t;
 
+void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
+			       phys_addr_t sz, pgprot_t prot);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 815f8c959dd4..183f1f4b2ae6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -100,6 +100,10 @@
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
+#define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
+#define PAGE_KERNEL_READ_EXEC	__pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
+					 | _PAGE_EXEC)
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index eabec4dce50b..0b48059cc9da 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -36,6 +36,7 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
+obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
new file mode 100644
index 000000000000..d7a723b446c3
--- /dev/null
+++ b/arch/riscv/kernel/efi.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ * Adapted from arch/arm64/kernel/efi.c
+ */
+
+#include <linux/efi.h>
+#include <linux/init.h>
+
+#include <asm/efi.h>
+#include <asm/pgtable.h>
+#include <asm/pgtable-bits.h>
+
+/*
+ * Only regions of type EFI_RUNTIME_SERVICES_CODE need to be
+ * executable, everything else can be mapped with the XN bits
+ * set. Also take the new (optional) RO/XP bits into account.
+ */
+static __init pgprot_t efimem_to_pgprot_map(efi_memory_desc_t *md)
+{
+	u64 attr = md->attribute;
+	u32 type = md->type;
+
+	if (type == EFI_MEMORY_MAPPED_IO)
+		return PAGE_KERNEL;
+
+	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
+		      "UEFI Runtime regions are not aligned to page size -- buggy firmware?"))
+		/*
+		 * If the region is not aligned to the page size of the OS, we
+		 * can not use strict permissions, since that would also affect
+		 * the mapping attributes of the adjacent regions.
+		 */
+		return PAGE_EXEC;
+
+	/* R-- */
+	if ((attr & (EFI_MEMORY_XP | EFI_MEMORY_RO)) ==
+	    (EFI_MEMORY_XP | EFI_MEMORY_RO))
+		return PAGE_KERNEL_READ;
+
+	/* R-X */
+	if (attr & EFI_MEMORY_RO)
+		return PAGE_KERNEL_READ_EXEC;
+
+	/* RW- */
+	if (((attr & (EFI_MEMORY_RP | EFI_MEMORY_WP | EFI_MEMORY_XP)) ==
+	     EFI_MEMORY_XP) ||
+	    type != EFI_RUNTIME_SERVICES_CODE)
+		return PAGE_KERNEL;
+
+	/* RWX */
+	return PAGE_KERNEL_EXEC;
+}
+
+int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
+{
+	pgprot_t prot = __pgprot(pgprot_val(efimem_to_pgprot_map(md)) &
+				~(_PAGE_GLOBAL));
+	int i;
+
+	/* RISC-V maps one page at a time */
+	for (i = 0; i < md->num_pages; i++)
+		create_pgd_mapping(mm->pgd, md->virt_addr + i * PAGE_SIZE,
+				   md->phys_addr + i * PAGE_SIZE,
+				   PAGE_SIZE, prot);
+	return 0;
+}
+
+static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
+{
+	efi_memory_desc_t *md = data;
+	pte_t pte = READ_ONCE(*ptep);
+	unsigned long val;
+
+	if (md->attribute & EFI_MEMORY_RO) {
+		val = pte_val(pte) & ~_PAGE_WRITE;
+		val = pte_val(pte) | _PAGE_READ;
+		pte = __pte(val);
+	}
+	if (md->attribute & EFI_MEMORY_XP) {
+		val = pte_val(pte) & ~_PAGE_EXEC;
+		pte = __pte(val);
+	}
+	set_pte(ptep, pte);
+
+	return 0;
+}
+
+int __init efi_set_mapping_permissions(struct mm_struct *mm,
+				       efi_memory_desc_t *md)
+{
+	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
+	       md->type != EFI_RUNTIME_SERVICES_DATA);
+
+	/*
+	 * Calling apply_to_page_range() is only safe on regions that are
+	 * guaranteed to be mapped down to pages. Since we are only called
+	 * for regions that have been mapped using efi_create_mapping() above
+	 * (and this is checked by the generic Memory Attributes table parsing
+	 * routines), there is no need to check that again here.
+	 */
+	return apply_to_page_range(mm, md->virt_addr,
+				   md->num_pages << EFI_PAGE_SHIFT,
+				   set_permissions, md);
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index c71788e6aff4..7f2a0d6dca7d 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
+#include <linux/efi.h>
 
 #include <asm/clint.h>
 #include <asm/cpu_ops.h>
@@ -26,11 +27,12 @@
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
+#include <asm/efi.h>
 
 #include "head.h"
 
-#ifdef CONFIG_DUMMY_CONSOLE
-struct screen_info screen_info = {
+#if defined(CONFIG_DUMMY_CONSOLE) || defined(CONFIG_EFI)
+struct screen_info screen_info __section(.data) = {
 	.orig_video_lines	= 30,
 	.orig_video_cols	= 80,
 	.orig_video_mode	= 0,
@@ -75,6 +77,7 @@ void __init setup_arch(char **cmdline_p)
 	early_ioremap_setup();
 	parse_early_param();
 
+	efi_init();
 	setup_bootmem();
 	paging_init();
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d238cdc501ee..9fb2fe2f4a3e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -390,7 +390,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 #define fixmap_pgd_next		fixmap_pte
 #endif
 
-static void __init create_pgd_mapping(pgd_t *pgdp,
+void __init create_pgd_mapping(pgd_t *pgdp,
 				      uintptr_t va, phys_addr_t pa,
 				      phys_addr_t sz, pgprot_t prot)
 {
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 61fd1e8b26fb..4d628081bb2f 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -35,6 +35,8 @@ fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
 arm-obj-$(CONFIG_EFI)			:= efi-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
+riscv-obj-$(CONFIG_EFI)			:= efi-init.o riscv-runtime.o
+obj-$(CONFIG_RISCV)			+= $(riscv-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index a5a405d8ab44..5c26725d8fd0 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -17,7 +17,10 @@
 
 /*
  * This is the base address at which to start allocating virtual memory ranges
- * for UEFI Runtime Services. This is in the low TTBR0 range so that we can use
+ * for UEFI Runtime Services.
+ *
+ * For ARM/ARM64:
+ * This is in the low TTBR0 range so that we can use
  * any allocation we choose, and eliminate the risk of a conflict after kexec.
  * The value chosen is the largest non-zero power of 2 suitable for this purpose
  * both on 32-bit and 64-bit ARM CPUs, to maximize the likelihood that it can
@@ -25,6 +28,12 @@
  * Since 32-bit ARM could potentially execute with a 1G/3G user/kernel split,
  * map everything below 1 GB. (512 MB is a reasonable upper bound for the
  * entire footprint of the UEFI runtime services memory regions)
+ *
+ * For RISC-V:
+ * There is no specific reason for which, this address (512MB) can't be used
+ * EFI runtime virtual address for RISC-V. It also helps to use EFI runtime
+ * services on both RV32/RV64. Keep the same runtime virtual address for RISC-V
+ * as well to minimize the code churn.
  */
 #define EFI_RT_VIRTUAL_BASE	SZ_512M
 #define EFI_RT_VIRTUAL_SIZE	SZ_512M
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
new file mode 100644
index 000000000000..d28e715d2bcc
--- /dev/null
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Extensible Firmware Interface
+ *
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ *
+ * Based on Extensible Firmware Interface Specification version 2.4
+ * Adapted from drivers/firmware/efi/arm-runtime.c
+ *
+ */
+
+#include <linux/dmi.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/mm_types.h>
+#include <linux/preempt.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/pgtable.h>
+
+#include <asm/cacheflush.h>
+#include <asm/efi.h>
+#include <asm/mmu.h>
+#include <asm/pgalloc.h>
+
+static bool __init efi_virtmap_init(void)
+{
+	efi_memory_desc_t *md;
+
+	efi_mm.pgd = pgd_alloc(&efi_mm);
+	mm_init_cpumask(&efi_mm);
+	init_new_context(NULL, &efi_mm);
+
+	for_each_efi_memory_desc(md) {
+		phys_addr_t phys = md->phys_addr;
+		int ret;
+
+		if (!(md->attribute & EFI_MEMORY_RUNTIME))
+			continue;
+		if (md->virt_addr == 0)
+			return false;
+
+		ret = efi_create_mapping(&efi_mm, md);
+		if (ret) {
+			pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
+				&phys, ret);
+			return false;
+		}
+	}
+
+	if (efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions))
+		return false;
+
+	return true;
+}
+
+/*
+ * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
+ * non-early mapping of the UEFI system table and virtual mappings for all
+ * EFI_MEMORY_RUNTIME regions.
+ */
+static int __init riscv_enable_runtime_services(void)
+{
+	u64 mapsize;
+
+	if (!efi_enabled(EFI_BOOT)) {
+		pr_info("EFI services will not be available.\n");
+		return 0;
+	}
+
+	efi_memmap_unmap();
+
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
+	if (efi_soft_reserve_enabled()) {
+		efi_memory_desc_t *md;
+
+		for_each_efi_memory_desc(md) {
+			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			struct resource *res;
+
+			if (!(md->attribute & EFI_MEMORY_SP))
+				continue;
+
+			res = kzalloc(sizeof(*res), GFP_KERNEL);
+			if (WARN_ON(!res))
+				break;
+
+			res->start	= md->phys_addr;
+			res->end	= md->phys_addr + md_size - 1;
+			res->name	= "Soft Reserved";
+			res->flags	= IORESOURCE_MEM;
+			res->desc	= IORES_DESC_SOFT_RESERVED;
+
+			insert_resource(&iomem_resource, res);
+		}
+	}
+
+	if (efi_runtime_disabled()) {
+		pr_info("EFI runtime services will be disabled.\n");
+		return 0;
+	}
+
+	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_info("EFI runtime services access via paravirt.\n");
+		return 0;
+	}
+
+	pr_info("Remapping and enabling EFI services.\n");
+
+	if (!efi_virtmap_init()) {
+		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
+		return -ENOMEM;
+	}
+
+	/* Set up runtime services function pointers */
+	efi_native_runtime_setup();
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+
+	return 0;
+}
+early_initcall(riscv_enable_runtime_services);
+
+void efi_virtmap_load(void)
+{
+	preempt_disable();
+	switch_mm(current->active_mm, &efi_mm, NULL);
+}
+
+void efi_virtmap_unload(void)
+{
+	switch_mm(&efi_mm, current->active_mm, NULL);
+	preempt_enable();
+}
-- 
2.24.0

