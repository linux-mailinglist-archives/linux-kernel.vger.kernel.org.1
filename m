Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF62DA1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503241AbgLNU0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502885AbgLNU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B55C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:25 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tSc9CIX7kEW4rRuUrQR4G7Hk/GCAUX1+tagngHsSSNo=;
        b=H99QpYo2pmCLkgf/R1AM2K8B71JwRoJ9j+RcroEJGJfeJDkTTxde/67qk0Jmz5rjmhB/CQ
        Yrsq3TRJxMbarUX4bpVz3gVMd+MzqCd7vIbUJOOgCSl3COECEMssFGx4AKu99lifgoDPuj
        CIn4s7ePaddVio7rCV/w3kKmXu6YkcN1IB/w7OVkZ/67gJEWWY8hjadZA+plE4TCXT1lxS
        fSfSgOyeFs19n8il92GDX8Yf23bwtl2NAEORSZyBRfKc8xu+wgjY25PV/Erm/UhtPhocma
        3JlhnOmvhQXgJxEBACdWogeUvHuO8vsMW8ZyZHt0CtA+1X1LsSY/AZe7isivmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tSc9CIX7kEW4rRuUrQR4G7Hk/GCAUX1+tagngHsSSNo=;
        b=THmpn9wFZOBzQ6+3bRK4u8nFGZv5mZbr4Yt4w+RlUF0AkKvdlX4Xxa9yu4XqvMNHe3wPnY
        gHNYJJ8H1LWhQGAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] efi/core for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797733182.10793.8402797805442982544.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-12-14

up to:  54649911f31b: efi: stub: get rid of efi_get_max_fdt_addr()


EFI updates collected by Ard Biesheuvel:

 - Don't move BSS section around pointlessly in the x86 decompressor
 - Refactor helper for discovering the EFI secure boot mode
 - Wire up EFI secure boot to IMA for arm64
 - Some fixes for the capsule loader
 - Expose the RT_PROP table via the EFI test module
 - Relax DT and kernel placement restrictions on ARM

Thanks,

	tglx

------------------>
Ard Biesheuvel (5):
      efi: x86/xen: switch to efi_get_secureboot_mode helper
      efi: capsule: use atomic kmap for transient sglist mappings
      efi: capsule: clean scatter-gather entries from the D-cache
      efi: arm: reduce minimum alignment of uncompressed kernel
      efi: stub: get rid of efi_get_max_fdt_addr()

Arvind Sankar (1):
      efi/x86: Only copy the compressed kernel image in efi_relocate_kernel()

Chester Lin (3):
      efi: generalize efi_get_secureboot
      ima: generalize x86/EFI arch glue for other EFI architectures
      arm64/ima: add ima_arch support

Geert Uytterhoeven (1):
      efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes

Heinrich Schuchardt (2):
      efi/libstub/x86: simplify efi_is_native()
      efi/efi_test: read RuntimeServicesSupported


 arch/arm/include/asm/efi.h                         | 24 ++++++------
 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/include/asm/efi.h                       | 11 +++---
 arch/riscv/include/asm/efi.h                       |  6 ---
 arch/x86/boot/compressed/Makefile                  |  2 +-
 arch/x86/include/asm/efi.h                         |  5 ++-
 arch/x86/kernel/Makefile                           |  2 -
 arch/x86/xen/efi.c                                 | 37 +++++-------------
 drivers/firmware/efi/Kconfig                       |  2 +-
 drivers/firmware/efi/capsule.c                     | 16 +++++++-
 drivers/firmware/efi/libstub/efi-stub.c            |  1 -
 drivers/firmware/efi/libstub/efistub.h             |  3 +-
 drivers/firmware/efi/libstub/fdt.c                 |  3 +-
 drivers/firmware/efi/libstub/secureboot.c          | 44 ++++++++-------------
 drivers/firmware/efi/libstub/x86-stub.c            |  5 ++-
 drivers/firmware/efi/test/efi_test.c               | 16 ++++++++
 drivers/firmware/efi/test/efi_test.h               |  3 ++
 include/linux/efi.h                                | 23 ++++++++++-
 security/integrity/ima/Makefile                    |  4 ++
 .../ima_arch.c => security/integrity/ima/ima_efi.c | 45 ++++++----------------
 20 files changed, 124 insertions(+), 129 deletions(-)
 rename arch/x86/kernel/ima_arch.c => security/integrity/ima/ima_efi.c (60%)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 3ee4f4381985..abae071a02e1 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -66,24 +66,17 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 #define MAX_UNCOMP_KERNEL_SIZE	SZ_32M
 
 /*
- * phys-to-virt patching requires that the physical to virtual offset fits
- * into the immediate field of an add/sub instruction, which comes down to the
- * 24 least significant bits being zero, and so the offset should be a multiple
- * of 16 MB. Since PAGE_OFFSET itself is a multiple of 16 MB, the physical
- * base should be aligned to 16 MB as well.
+ * phys-to-virt patching requires that the physical to virtual offset is a
+ * multiple of 2 MiB. However, using an alignment smaller than TEXT_OFFSET
+ * here throws off the memory allocation logic, so let's use the lowest power
+ * of two greater than 2 MiB and greater than TEXT_OFFSET.
  */
-#define EFI_PHYS_ALIGN		SZ_16M
-
-/* on ARM, the FDT should be located in a lowmem region */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
-}
+#define EFI_PHYS_ALIGN		max(SZ_2M, roundup_pow_of_two(TEXT_OFFSET))
 
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
-	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
+	return round_down(image_addr, SZ_4M) + SZ_512M;
 }
 
 struct efi_arm_entry_state {
@@ -93,4 +86,9 @@ struct efi_arm_entry_state {
 	u32	sctlr_after_ebs;
 };
 
+static inline void efi_capsule_flush_cache_range(void *addr, int size)
+{
+	__cpuc_flush_dcache_area(addr, size);
+}
+
 #endif /* _ASM_ARM_EFI_H */
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f858c352f72a..04e78a367c2c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1849,6 +1849,7 @@ config EFI
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
 	select EFI_GENERIC_STUB
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	default y
 	help
 	  This option provides support for runtime services provided
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 973b14415271..3578aba9c608 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -64,12 +64,6 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 #define EFI_KIMG_ALIGN	\
 	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
 
-/* on arm64, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return ULONG_MAX;
-}
-
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
  * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
@@ -141,4 +135,9 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
+static inline void efi_capsule_flush_cache_range(void *addr, int size)
+{
+	__flush_dcache_area(addr, size);
+}
+
 #endif /* _ASM_EFI_H */
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 7542282f1141..6d98cd999680 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -27,12 +27,6 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
 
-/* on RISC-V, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
-{
-	return ULONG_MAX;
-}
-
 /* Load initrd at enough distance from DRAM start */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index ee249088cbfe..8d358a6fe6ec 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -35,7 +35,7 @@ cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
-KBUILD_CFLAGS += -ffreestanding
+KBUILD_CFLAGS += -ffreestanding -fshort-wchar
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758ef292e..c98f78330b09 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -213,8 +213,6 @@ static inline bool efi_is_64bit(void)
 
 static inline bool efi_is_native(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_64))
-		return true;
 	return efi_is_64bit();
 }
 
@@ -382,4 +380,7 @@ static inline void efi_fake_memmap_early(void)
 }
 #endif
 
+#define arch_ima_efi_boot_mode	\
+	({ extern struct boot_params boot_params; boot_params.secure_boot; })
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 68608bd892c0..5eeb808eb024 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -161,5 +161,3 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
-
-obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 205a9bc981b0..7d7ffb9c826a 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -93,37 +93,22 @@ static efi_system_table_t __init *xen_efi_probe(void)
 
 /*
  * Determine whether we're in secure boot mode.
- *
- * Please keep the logic in sync with
- * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
  */
 static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 {
-	static efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 	static efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
+	enum efi_secureboot_mode mode;
 	efi_status_t status;
-	u8 moksbstate, secboot, setupmode;
+	u8 moksbstate;
 	unsigned long size;
 
-	size = sizeof(secboot);
-	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
-
-	if (status == EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
-
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	size = sizeof(setupmode);
-	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
-
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	if (secboot == 0 || setupmode == 1)
-		return efi_secureboot_mode_disabled;
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_unknown) {
+		pr_err("Could not determine UEFI Secure Boot status.\n");
+		return efi_secureboot_mode_unknown;
+	}
+	if (mode != efi_secureboot_mode_enabled)
+		return mode;
 
 	/* See if a user has put the shim into insecure mode. */
 	size = sizeof(moksbstate);
@@ -140,10 +125,6 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
  secure_boot_enabled:
 	pr_info("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
-
- out_efi_err:
-	pr_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
 }
 
 void __init xen_efi_init(struct boot_params *boot_params)
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 36ec1f718893..b452cfa2100b 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -122,7 +122,7 @@ config EFI_ARMSTUB_DTB_LOADER
 config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 	bool "Enable the command line initrd loader" if !X86
 	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
-	default y
+	default y if X86
 	depends on !RISCV
 	help
 	  Select this config option to add support for the initrd= command
diff --git a/drivers/firmware/efi/capsule.c b/drivers/firmware/efi/capsule.c
index 598b7800d14e..768430293669 100644
--- a/drivers/firmware/efi/capsule.c
+++ b/drivers/firmware/efi/capsule.c
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <linux/efi.h>
 #include <linux/vmalloc.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 
 typedef struct {
@@ -244,7 +245,7 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 	for (i = 0; i < sg_count; i++) {
 		efi_capsule_block_desc_t *sglist;
 
-		sglist = kmap(sg_pages[i]);
+		sglist = kmap_atomic(sg_pages[i]);
 
 		for (j = 0; j < SGLIST_PER_PAGE && count > 0; j++) {
 			u64 sz = min_t(u64, imagesize,
@@ -265,7 +266,18 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 		else
 			sglist[j].data = page_to_phys(sg_pages[i + 1]);
 
-		kunmap(sg_pages[i]);
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+		/*
+		 * At runtime, the firmware has no way to find out where the
+		 * sglist elements are mapped, if they are mapped in the first
+		 * place. Therefore, on architectures that can only perform
+		 * cache maintenance by virtual address, the firmware is unable
+		 * to perform this maintenance, and so it is up to the OS to do
+		 * it instead.
+		 */
+		efi_capsule_flush_cache_range(sglist, PAGE_SIZE);
+#endif
+		kunmap_atomic(sglist);
 	}
 
 	mutex_lock(&capsule_mutex);
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 914a343c7785..ec2f3985bef3 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -273,7 +273,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	install_memreserve_table();
 
 	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
-						efi_get_max_fdt_addr(image_addr),
 						initrd_addr, initrd_size,
 						cmdline_ptr, fdt_addr, fdt_size);
 	if (status != EFI_SUCCESS)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2d7abcd99de9..b50a6c67d9bd 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -750,7 +750,6 @@ efi_status_t efi_exit_boot_services(void *handle,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
@@ -848,4 +847,6 @@ asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
 
 void efi_handle_post_ebs_state(void);
 
+enum efi_secureboot_mode efi_get_secureboot(void);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 368cd60000ee..365c3a43a198 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -238,7 +238,6 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 
 efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
 					    u64 initrd_addr, u64 initrd_size,
 					    char *cmdline_ptr,
 					    unsigned long fdt_addr,
@@ -275,7 +274,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	efi_info("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
-	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, max_addr);
+	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_err("Unable to allocate memory for new device tree.\n");
 		goto fail;
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 5efc524b14be..8a18930f3eb6 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -12,44 +12,34 @@
 
 #include "efistub.h"
 
-/* BIOS variables */
-static const efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-static const efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
-static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
-
 /* SHIM variables */
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
 static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 
+static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+			    unsigned long *data_size, void *data)
+{
+	return get_efi_var(name, vendor, attr, data_size, data);
+}
+
 /*
  * Determine whether we're in secure boot mode.
- *
- * Please keep the logic in sync with
- * arch/x86/xen/efi.c:xen_efi_get_secureboot().
  */
 enum efi_secureboot_mode efi_get_secureboot(void)
 {
 	u32 attr;
-	u8 secboot, setupmode, moksbstate;
 	unsigned long size;
+	enum efi_secureboot_mode mode;
 	efi_status_t status;
+	u8 moksbstate;
 
-	size = sizeof(secboot);
-	status = get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
-			     NULL, &size, &secboot);
-	if (status == EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	size = sizeof(setupmode);
-	status = get_efi_var(efi_SetupMode_name, &efi_variable_guid,
-			     NULL, &size, &setupmode);
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	if (secboot == 0 || setupmode == 1)
-		return efi_secureboot_mode_disabled;
+	mode = efi_get_secureboot_mode(get_var);
+	if (mode == efi_secureboot_mode_unknown) {
+		efi_err("Could not determine UEFI Secure Boot status.\n");
+		return efi_secureboot_mode_unknown;
+	}
+	if (mode != efi_secureboot_mode_enabled)
+		return mode;
 
 	/*
 	 * See if a user has put the shim into insecure mode. If so, and if the
@@ -69,8 +59,4 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 secure_boot_enabled:
 	efi_info("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
-
-out_efi_err:
-	efi_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3672539cb96e..f14c4ff5839f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -715,8 +715,11 @@ unsigned long efi_main(efi_handle_t handle,
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
 	    (image_offset == 0)) {
+		extern char _bss[];
+
 		status = efi_relocate_kernel(&bzimage_addr,
-					     hdr->init_size, hdr->init_size,
+					     (unsigned long)_bss - bzimage_addr,
+					     hdr->init_size,
 					     hdr->pref_address,
 					     hdr->kernel_alignment,
 					     LOAD_PHYSICAL_ADDR);
diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index ddf9eae396fe..47d67bb0a516 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned long arg)
 	return rv;
 }
 
+static long efi_runtime_get_supported_mask(unsigned long arg)
+{
+	unsigned int __user *supported_mask;
+	int rv = 0;
+
+	supported_mask = (unsigned int *)arg;
+
+	if (put_user(efi.runtime_supported_mask, supported_mask))
+		rv = -EFAULT;
+
+	return rv;
+}
+
 static long efi_test_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 
 	case EFI_RUNTIME_RESET_SYSTEM:
 		return efi_runtime_reset_system(arg);
+
+	case EFI_RUNTIME_GET_SUPPORTED_MASK:
+		return efi_runtime_get_supported_mask(arg);
 	}
 
 	return -ENOTTY;
diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/test/efi_test.h
index f2446aa1c2e3..117349e57993 100644
--- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -118,4 +118,7 @@ struct efi_resetsystem {
 #define EFI_RUNTIME_RESET_SYSTEM \
 	_IOW('p', 0x0B, struct efi_resetsystem)
 
+#define EFI_RUNTIME_GET_SUPPORTED_MASK \
+	_IOR('p', 0x0C, unsigned int)
+
 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d7c0e73af2b9..1cd5d91d8ca1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1089,7 +1089,28 @@ enum efi_secureboot_mode {
 	efi_secureboot_mode_disabled,
 	efi_secureboot_mode_enabled,
 };
-enum efi_secureboot_mode efi_get_secureboot(void);
+
+static inline
+enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
+{
+	u8 secboot, setupmode = 0;
+	efi_status_t status;
+	unsigned long size;
+
+	size = sizeof(secboot);
+	status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
+			 &secboot);
+	if (status == EFI_NOT_FOUND)
+		return efi_secureboot_mode_disabled;
+	if (status != EFI_SUCCESS)
+		return efi_secureboot_mode_unknown;
+
+	size = sizeof(setupmode);
+	get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
+	if (secboot == 0 || setupmode == 1)
+		return efi_secureboot_mode_disabled;
+	return efi_secureboot_mode_enabled;
+}
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
 void efi_enable_reset_attack_mitigation(void);
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..2499f2485c04 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,3 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+
+ifeq ($(CONFIG_EFI),y)
+ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
+endif
diff --git a/arch/x86/kernel/ima_arch.c b/security/integrity/ima/ima_efi.c
similarity index 60%
rename from arch/x86/kernel/ima_arch.c
rename to security/integrity/ima/ima_efi.c
index 7dfb1e808928..71786d01946f 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/security/integrity/ima/ima_efi.c
@@ -5,50 +5,29 @@
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ima.h>
+#include <asm/efi.h>
 
-extern struct boot_params boot_params;
+#ifndef arch_ima_efi_boot_mode
+#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
+#endif
 
 static enum efi_secureboot_mode get_sb_mode(void)
 {
-	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-	efi_status_t status;
-	unsigned long size;
-	u8 secboot, setupmode;
-
-	size = sizeof(secboot);
+	enum efi_secureboot_mode mode;
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
 		pr_info("ima: secureboot mode unknown, no efi\n");
 		return efi_secureboot_mode_unknown;
 	}
 
-	/* Get variable contents into buffer */
-	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
-	if (status == EFI_NOT_FOUND) {
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_disabled)
 		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	if (status != EFI_SUCCESS) {
+	else if (mode == efi_secureboot_mode_unknown)
 		pr_info("ima: secureboot mode unknown\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	size = sizeof(setupmode);
-	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
-
-	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
-		setupmode = 0;
-
-	if (secboot == 0 || setupmode == 1) {
-		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	pr_info("ima: secureboot mode enabled\n");
-	return efi_secureboot_mode_enabled;
+	else
+		pr_info("ima: secureboot mode enabled\n");
+	return mode;
 }
 
 bool arch_ima_get_secureboot(void)
@@ -57,7 +36,7 @@ bool arch_ima_get_secureboot(void)
 	static bool initialized;
 
 	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode = boot_params.secure_boot;
+		sb_mode = arch_ima_efi_boot_mode;
 
 		if (sb_mode == efi_secureboot_mode_unset)
 			sb_mode = get_sb_mode();

