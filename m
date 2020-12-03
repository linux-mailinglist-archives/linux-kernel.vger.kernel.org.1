Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A82CDA91
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgLCP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:59:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63010 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgLCP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:59:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8ECEFB02F;
        Thu,  3 Dec 2020 10:59:07 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=bmF6+nQRI7JgJD4LON1RGivJciI=; b=EWjmWW
        K3eb+ImBWtyGuo5BO2kmjSXsc7m7OGr6ixQpPoDudCNtxCuzF3GC796l+H7C22ke
        bC/ccjizymuMvyPpyiM99+Iyx2cXLOf8SEeFTM4sgzN/sU28TZYUHfwieSrDFRx9
        zRIrgui1Mvw3p3XsYy5SQbZcLGqtUhcRPqTtg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0B38FB02E;
        Thu,  3 Dec 2020 10:59:07 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=l/Yl1QzjvzbDmb7zDLACK13UEIMXK3JSFLkvQxbRPME=; b=wy/8ghbW3YUdfqWR+X+lQGN+74OlgzEWyIQ5b49zTW4OJqxHNOATK6hj3X+RK+svFhvT/WMHmbiOU66+M2K+EeZMZeHNx0aVA5Q3LsonibGLLxzFqQcdRVNYvCM4Vu5q5xIoZVevNwhScTcLuNeEvYll7AFI00519ncMK0iEuw4=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 661FCFB02C;
        Thu,  3 Dec 2020 10:59:04 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id A961D2DA0B35;
        Thu,  3 Dec 2020 10:59:02 -0500 (EST)
Date:   Thu, 3 Dec 2020 10:59:02 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v2] RISC-V: enable XIP
In-Reply-To: <20201203123854.11679-1-vitaly.wool@konsulko.com>
Message-ID: <ss5n352s-4r72-po1n-21oq-41r818q22560@syhkavp.arg>
References: <20201203123854.11679-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 77A5697C-3580-11EB-AD5A-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020, Vitaly Wool wrote:

> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> It allows code to be executed directly from non-volatile storage
> directly addressable by the CPU, such as QSPI NOR flash which can
> be found on many RISC-V platforms. This makes way for significant
> optimization of RAM footprint. The XIP kernel is not compressed
> since it has to run directly from flash, so it will occupy more
> space on the non-volatile storage to The physical flash address
> used to link the kernel object files and for storing it has to
> be known at compile time and is represented by a Kconfig option.
> 
> XIP on RISC-V will currently only work on MMU-enabled kernels.
> 
> Changed in v2:
> - dedicated macro for XIP address fixup when MMU is not enabled yet
>   o both for 32-bit and 64-bit RISC-V
> - SP is explicitly set to a safe place in RAM before __copy_data call
> - removed redundant alignment requirements in vmlinux-xip.lds.S
> - changed long -> uintptr_t typecast in __XIP_FIXUP macro.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>

Looks fine to me, at least for those parts I'm familiar with (I can't 
really comment on rv asm styling and page setup).

Acked-by: Nicolas Pitre <nico@fluxnic.net>

If you have a chance to test cramfs' user space XIP support that would 
be nice. So far it was tested only on ARM. See 
Documentation/filesystems/cramfs.rst for instructions.



> ---
>  arch/riscv/Kconfig                  |  40 ++++++++-
>  arch/riscv/Makefile                 |   8 +-
>  arch/riscv/boot/Makefile            |  14 ++-
>  arch/riscv/include/asm/pgtable.h    |  54 ++++++++++--
>  arch/riscv/kernel/head.S            |  54 +++++++++++-
>  arch/riscv/kernel/head.h            |   3 +
>  arch/riscv/kernel/setup.c           |   2 +-
>  arch/riscv/kernel/vmlinux-xip.lds.S | 132 ++++++++++++++++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S     |   6 ++
>  arch/riscv/mm/init.c                | 132 ++++++++++++++++++++++++++--
>  10 files changed, 423 insertions(+), 22 deletions(-)
>  create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 44377fd7860e..c9bef841c884 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -395,7 +395,7 @@ config EFI_STUB
>  
>  config EFI
>  	bool "UEFI runtime support"
> -	depends on OF
> +	depends on OF && !XIP_KERNEL
>  	select LIBFDT
>  	select UCS2_STRING
>  	select EFI_PARAMS_FROM_FDT
> @@ -412,6 +412,44 @@ config EFI
>  	  allow the kernel to be booted as an EFI application. This
>  	  is only useful on systems that have UEFI firmware.
>  
> +config XIP_KERNEL
> +	bool "Kernel Execute-In-Place from ROM"
> +	depends on MMU
> +	help
> +	  Execute-In-Place allows the kernel to run from non-volatile storage
> +	  directly addressable by the CPU, such as NOR flash. This saves RAM
> +	  space since the text section of the kernel is not loaded from flash
> +	  to RAM.  Read-write sections, such as the data section and stack,
> +	  are still copied to RAM.  The XIP kernel is not compressed since
> +	  it has to run directly from flash, so it will take more space to
> +	  store it.  The flash address used to link the kernel object files,
> +	  and for storing it, is configuration dependent. Therefore, if you
> +	  say Y here, you must know the proper physical address where to
> +	  store the kernel image depending on your own flash memory usage.
> +
> +	  Also note that the make target becomes "make xipImage" rather than
> +	  "make zImage" or "make Image".  The final kernel binary to put in
> +	  ROM memory will be arch/riscv/boot/xipImage.
> +
> +	  If unsure, say N.
> +
> +config XIP_PHYS_ADDR
> +	hex "XIP Kernel Physical Location"
> +	depends on XIP_KERNEL
> +	default "0x21000000"
> +	help
> +	  This is the physical address in your flash memory the kernel will
> +	  be linked for and stored to.  This address is dependent on your
> +	  own flash usage.
> +
> +config XIP_PHYS_RAM_BASE
> +	hex "Platform Physical RAM address"
> +	depends on XIP_KERNEL
> +	default "0x80000000"
> +	help
> +	  This is the physical address of RAM in the system. It has to be
> +	  explicitly specified to run early relocations of read-write data
> +	  from flash to RAM.
>  endmenu
>  
>  config BUILTIN_DTB
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0289a97325d1..387afe973530 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -70,7 +70,11 @@ CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
>  
>  # Default target when executing plain make
>  boot		:= arch/riscv/boot
> +ifeq ($(CONFIG_XIP_KERNEL),y)
> +KBUILD_IMAGE := $(boot)/xipImage
> +else
>  KBUILD_IMAGE	:= $(boot)/Image.gz
> +endif
>  
>  head-y := arch/riscv/kernel/head.o
>  
> @@ -83,12 +87,14 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>  
> +ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_KENDRYTE),yy)
>  KBUILD_IMAGE := $(boot)/loader.bin
>  else
>  KBUILD_IMAGE := $(boot)/Image.gz
>  endif
> -BOOT_TARGETS := Image Image.gz loader loader.bin
> +endif
> +BOOT_TARGETS := Image Image.gz loader loader.bin xipImage
>  
>  all:	$(notdir $(KBUILD_IMAGE))
>  
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index c59fca695f9d..bda88bec0ad7 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -17,8 +17,20 @@
>  KCOV_INSTRUMENT := n
>  
>  OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
> +OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>  
> -targets := Image loader
> +targets := Image loader xipImage
> +
> +ifeq ($(CONFIG_XIP_KERNEL),y)
> +
> +quiet_cmd_mkxip = $(quiet_cmd_objcopy)
> +cmd_mkxip = $(cmd_objcopy)
> +
> +$(obj)/xipImage: vmlinux FORCE
> +	$(call if_changed,mkxip)
> +	@$(kecho) '  Physical Address of xipImage: $(CONFIG_XIP_PHYS_ADDR)'
> +
> +endif
>  
>  $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 183f1f4b2ae6..62adae3f23a3 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -11,6 +11,40 @@
>  
>  #include <asm/pgtable-bits.h>
>  
> +#ifdef CONFIG_MMU
> +
> +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> +
> +#ifdef CONFIG_XIP_KERNEL
> +/*
> + * Since we use sections to map it, this macro replaces the physical address
> + * with its virtual address while keeping offset from the base section.
> + */
> +#define XIP_OFFSET		SZ_8M
> +#define XIP_MASK		(SZ_8M - 1)
> +#define XIP_VIRT_ADDR(physaddr)	(PAGE_OFFSET - XIP_OFFSET + ((physaddr) & XIP_MASK))
> +#define VMALLOC_END		(PAGE_OFFSET - SZ_16M - 1)
> +
> +#define XIP_VIRT_ADDR_START	XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> +#define __PHYS_RAM_BASE		CONFIG_XIP_PHYS_RAM_BASE
> +
> +#define __XIP_FIXUP(addr) \
> +	(((uintptr_t)(addr) >= CONFIG_XIP_PHYS_ADDR && \
> +	  (uintptr_t)(addr) <= CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
> +	(uintptr_t)(addr) - CONFIG_XIP_PHYS_ADDR + __PHYS_RAM_BASE - XIP_OFFSET : \
> +	(uintptr_t)(addr))
> +
> +#else
> +#define VMALLOC_END		(PAGE_OFFSET - 1)
> +#endif /* CONFIG_XIP_KERNEL */
> +
> +#else
> +
> +#define XIP_VIRT_ADDR(physaddr) physaddr
> +
> +#endif /* CONFIG_MMU */
> +
>  #ifndef __ASSEMBLY__
>  
>  /* Page Upper Directory not used in RISC-V */
> @@ -21,10 +55,6 @@
>  
>  #ifdef CONFIG_MMU
>  
> -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> -#define VMALLOC_END      (PAGE_OFFSET - 1)
> -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> -
>  #define BPF_JIT_REGION_SIZE	(SZ_128M)
>  #define BPF_JIT_REGION_START	(PAGE_OFFSET - BPF_JIT_REGION_SIZE)
>  #define BPF_JIT_REGION_END	(VMALLOC_END)
> @@ -467,8 +497,20 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
>  
>  #define kern_addr_valid(addr)   (1) /* FIXME */
>  
> -extern void *dtb_early_va;
> -extern uintptr_t dtb_early_pa;
> +extern void *_dtb_early_va;
> +extern uintptr_t _dtb_early_pa;
> +#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
> +
> +#define dtb_early_va	(*(void **)__XIP_FIXUP(&_dtb_early_va))
> +#define dtb_early_pa	(*(uintptr_t *)__XIP_FIXUP(&_dtb_early_pa))
> +
> +#else
> +
> +#define dtb_early_va	_dtb_early_va
> +#define dtb_early_pa	_dtb_early_pa
> +
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  void setup_bootmem(void);
>  void paging_init(void);
>  
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 7e849797c9c3..8bdf506c9f61 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -9,11 +9,31 @@
>  #include <linux/linkage.h>
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
> +#include <asm/pgtable.h>
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/image.h>
>  #include "efi-header.S"
>  
> +#ifdef CONFIG_XIP_KERNEL
> +.macro XIP_FIXUP_OFFSET
> +#ifdef CONFIG_64BIT
> +		ld t0, _xip_fixup
> +#else
> +		lw t0, _xip_fixup
> +#endif
> +		add a0, a0, t0
> +.endm
> +
> +_xip_fixup:
> +#ifdef CONFIG_64BIT
> +	.dword CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> +#else
> +	.word CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> +#endif
> +
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  __HEAD
>  ENTRY(_start)
>  	/*
> @@ -69,7 +89,11 @@ pe_head_start:
>  #ifdef CONFIG_MMU
>  relocate:
>  	/* Relocate return address */
> +#ifdef CONFIG_XIP_KERNEL
> +	li a1, XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> +#else
>  	li a1, PAGE_OFFSET
> +#endif
>  	la a2, _start
>  	sub a1, a1, a2
>  	add ra, ra, a1
> @@ -90,7 +114,12 @@ relocate:
>  	 * full fence here because setup_vm() just wrote these PTEs and we need
>  	 * to ensure the new translations are in use.
>  	 */
> +#ifdef CONFIG_XIP_KERNEL
> +	la a0, _trampoline_pg_dir
> +	XIP_FIXUP_OFFSET
> +#else
>  	la a0, trampoline_pg_dir
> +#endif
>  	srl a0, a0, PAGE_SHIFT
>  	or a0, a0, a1
>  	sfence.vma
> @@ -256,15 +285,34 @@ clear_bss_done:
>  	/* Save hart ID and DTB physical address */
>  	mv s0, a0
>  	mv s1, a1
> -	la a2, boot_cpu_hartid
> -	REG_S a0, (a2)
> +
> +#ifdef CONFIG_XIP_KERNEL
> +	la a0, _end + THREAD_SIZE
> +	XIP_FIXUP_OFFSET
> +	mv sp, a0
> +	call __copy_data
> +#endif
> +	la a0, boot_cpu_hartid
> +#ifdef CONFIG_XIP_KERNEL
> +	XIP_FIXUP_OFFSET
> +#endif
> +	sw s0, (a0)
>  
>  	/* Initialize page tables and relocate to virtual addresses */
> -	la sp, init_thread_union + THREAD_SIZE
> +	la a0, init_thread_union + THREAD_SIZE
> +#ifdef CONFIG_XIP_KERNEL
> +	XIP_FIXUP_OFFSET
> +#endif
> +	mv sp, a0
>  	mv a0, s1
>  	call setup_vm
>  #ifdef CONFIG_MMU
> +#ifdef CONFIG_XIP_KERNEL
> +	la a0, _early_pg_dir
> +	XIP_FIXUP_OFFSET
> +#else
>  	la a0, early_pg_dir
> +#endif
>  	call relocate
>  #endif /* CONFIG_MMU */
>  
> diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
> index b48dda3d04f6..aabbc3ac3e48 100644
> --- a/arch/riscv/kernel/head.h
> +++ b/arch/riscv/kernel/head.h
> @@ -12,6 +12,9 @@ extern atomic_t hart_lottery;
>  
>  asmlinkage void do_page_fault(struct pt_regs *regs);
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa);
> +#ifdef CONFIG_XIP_KERNEL
> +asmlinkage void __init __copy_data(void);
> +#endif
>  
>  extern void *__cpu_up_stack_pointer[];
>  extern void *__cpu_up_task_pointer[];
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 117f3212a8e4..9f5cad1540ee 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -84,7 +84,7 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>  	unflatten_and_copy_device_tree();
>  #else
> -	if (early_init_dt_verify(__va(dtb_early_pa)))
> +	if (early_init_dt_verify(dtb_early_va))
>  		unflatten_device_tree();
>  	else
>  		pr_err("No DTB found in kernel mappings\n");
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> new file mode 100644
> index 000000000000..9f0f08c34cd3
> --- /dev/null
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + * Copyright (C) 2020 Vitaly Wool, Konsulko AB
> + */
> +
> +#define LOAD_OFFSET XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
> +/* No __ro_after_init data in the .rodata section - which will always be ro */
> +#define RO_AFTER_INIT_DATA
> +
> +#include <asm/vmlinux.lds.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/cache.h>
> +#include <asm/thread_info.h>
> +
> +OUTPUT_ARCH(riscv)
> +ENTRY(_start)
> +
> +jiffies = jiffies_64;
> +
> +SECTIONS
> +{
> +	/* Beginning of code and text segment */
> +	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> +	_xiprom = .;
> +	_start = .;
> +	HEAD_TEXT_SECTION
> +	INIT_TEXT_SECTION(PAGE_SIZE)
> +	/* we have to discard exit text and such at runtime, not link time */
> +	.exit.text :
> +	{
> +		EXIT_TEXT
> +	}
> +
> +	.text : {
> +		_text = .;
> +		_stext = .;
> +		TEXT_TEXT
> +		SCHED_TEXT
> +		CPUIDLE_TEXT
> +		LOCK_TEXT
> +		KPROBES_TEXT
> +		ENTRY_TEXT
> +		IRQENTRY_TEXT
> +		SOFTIRQENTRY_TEXT
> +		*(.fixup)
> +		_etext = .;
> +	}
> +	RO_DATA(L1_CACHE_BYTES)
> +	.srodata : {
> +		*(.srodata*)
> +	}
> +	.init.rodata : {
> +		INIT_SETUP(16)
> +		INIT_CALLS
> +		CON_INITCALL
> +		INIT_RAM_FS
> +	}
> +	_exiprom = .;			/* End of XIP ROM area */
> +
> +
> +/*
> + * From this point, stuff is considered writable and will be copied to RAM
> + */
> +	__data_loc = ALIGN(16);		/* location in file */
> +	. = PAGE_OFFSET;		/* location in memory */
> +
> +	_sdata = .;			/* Start of data section */
> +	_data = .;
> +	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +	_edata = .;
> +	__start_ro_after_init = .;
> +	.data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> +		*(.data..ro_after_init)
> +	}
> +	__end_ro_after_init = .;
> +
> +	. = ALIGN(PAGE_SIZE);
> +	__init_begin = .;
> +	.init.data : {
> +		INIT_DATA
> +	}
> +	.exit.data : {
> +		EXIT_DATA
> +	}
> +	. = ALIGN(8);
> +	__soc_early_init_table : {
> +		__soc_early_init_table_start = .;
> +		KEEP(*(__soc_early_init_table))
> +		__soc_early_init_table_end = .;
> +	}
> +	__soc_builtin_dtb_table : {
> +		__soc_builtin_dtb_table_start = .;
> +		KEEP(*(__soc_builtin_dtb_table))
> +		__soc_builtin_dtb_table_end = .;
> +	}
> +	PERCPU_SECTION(L1_CACHE_BYTES)
> +
> +	. = ALIGN(PAGE_SIZE);
> +	__init_end = .;
> +
> +	.sdata : {
> +		__global_pointer$ = . + 0x800;
> +		*(.sdata*)
> +		*(.sbss*)
> +	}
> +
> +	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> +	EXCEPTION_TABLE(0x10)
> +
> +	.rel.dyn : AT(ADDR(.rel.dyn) - LOAD_OFFSET) {
> +		*(.rel.dyn*)
> +	}
> +
> +	/*
> +	 * End of copied data. We need a dummy section to get its LMA.
> +	 * Also located before final ALIGN() as trailing padding is not stored
> +	 * in the resulting binary file and useless to copy.
> +	 */
> +	.data.endmark : AT(ADDR(.data.endmark) - LOAD_OFFSET) { }
> +	_edata_loc = LOADADDR(.data.endmark);
> +
> +	. = ALIGN(PAGE_SIZE);
> +	_end = .;
> +
> +	STABS_DEBUG
> +	DWARF_DEBUG
> +
> +	DISCARDS
> +}
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 3ffbd6cbdb86..542dc808b034 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -4,7 +4,12 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#ifdef CONFIG_XIP_KERNEL
> +#include "vmlinux-xip.lds.S"
> +#else
> +
>  #define LOAD_OFFSET PAGE_OFFSET
> +
>  #include <asm/vmlinux.lds.h>
>  #include <asm/page.h>
>  #include <asm/cache.h>
> @@ -121,3 +126,4 @@ SECTIONS
>  
>  	DISCARDS
>  }
> +#endif /* CONFIG_XIP_KERNEL */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8e577f14f120..94adc1d7a10e 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -29,8 +29,8 @@ EXPORT_SYMBOL(empty_zero_page);
>  
>  extern char _start[];
>  #define DTB_EARLY_BASE_VA      PGDIR_SIZE
> -void *dtb_early_va __initdata;
> -uintptr_t dtb_early_pa __initdata;
> +void *_dtb_early_va __initdata;
> +uintptr_t _dtb_early_pa __initdata;
>  
>  struct pt_alloc_ops {
>  	pte_t *(*get_pte_virt)(phys_addr_t pa);
> @@ -85,6 +85,10 @@ static void print_vm_layout(void)
>  		  (unsigned long)VMALLOC_END);
>  	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
>  		  (unsigned long)high_memory);
> +#ifdef CONFIG_XIP_KERNEL
> +	print_mlm("xip", (unsigned long)XIP_VIRT_ADDR_START,
> +		  (unsigned long)XIP_VIRT_ADDR_START + SZ_16M);
> +#endif /* CONFIG_XIP_KERNEL */
>  }
>  #else
>  static void print_vm_layout(void) { }
> @@ -160,6 +164,10 @@ void __init setup_bootmem(void)
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
>  	u64 i;
>  
> +#ifdef CONFIG_XIP_KERNEL
> +	vmlinux_start = __pa_symbol(&_sdata);
> +#endif
> +
>  	/* Find the memory region containing the kernel */
>  	for_each_mem_range(i, &start, &end) {
>  		phys_addr_t size = end - start;
> @@ -191,28 +199,61 @@ void __init setup_bootmem(void)
>  	 * Avoid using early_init_fdt_reserve_self() since __pa() does
>  	 * not work for DTB pointers that are fixmap addresses
>  	 */
> -	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +#ifdef CONFIG_XIP_KERNEL
> +	if (dtb_early_pa < CONFIG_XIP_PHYS_ADDR ||
> +	    dtb_early_pa > CONFIG_XIP_PHYS_ADDR + SZ_16M)
> +#endif
> +	{
> +		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +		dtb_early_va = __va(dtb_early_pa);
> +	}
>  
>  	early_init_fdt_scan_reserved_mem();
>  	memblock_allow_resize();
>  	memblock_dump_all();
>  }
>  
> +#ifdef CONFIG_XIP_KERNEL
> +
> +extern char _xiprom[], _exiprom[];
> +extern char _sdata[], _edata[];
> +
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  #ifdef CONFIG_MMU
> -static struct pt_alloc_ops pt_ops;
> +
> +static struct pt_alloc_ops _pt_ops;
> +#ifdef CONFIG_XIP_KERNEL
> +#define pt_ops (*(struct pt_alloc_ops *)__XIP_FIXUP(&_pt_ops))
> +#else
> +#define pt_ops	_pt_ops
> +#endif
>  
>  unsigned long va_pa_offset;
>  EXPORT_SYMBOL(va_pa_offset);
> +#ifdef CONFIG_XIP_KERNEL
> +#define va_pa_offset	(*((unsigned long *)__XIP_FIXUP(&va_pa_offset)))
> +#endif
>  unsigned long pfn_base;
>  EXPORT_SYMBOL(pfn_base);
>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> -pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> -pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>  
>  #define MAX_EARLY_MAPPING_SIZE	SZ_128M
>  
> +#ifdef CONFIG_XIP_KERNEL
> +pgd_t _trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> +pte_t _fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> +pgd_t _early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> +
> +#define trampoline_pg_dir	((pgd_t *)__XIP_FIXUP(_trampoline_pg_dir))
> +#define fixmap_pte		((pte_t *)__XIP_FIXUP(_fixmap_pte))
> +#define early_pg_dir		((pgd_t *)__XIP_FIXUP(_early_pg_dir))
> +#else
> +pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> +pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> +#endif /* CONFIG_XIP_KERNEL */
>  
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  {
> @@ -284,16 +325,30 @@ static void __init create_pte_mapping(pte_t *ptep,
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
>  
> -pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -
>  #if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
>  #define NUM_EARLY_PMDS		1UL
>  #else
>  #define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
>  #endif
> +#ifdef CONFIG_XIP_KERNEL
> +pmd_t _trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pmd_t _fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pmd_t _xip_pmd[PTRS_PER_PGD * NUM_EARLY_PMDS] __page_aligned_bss;
> +pmd_t _early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +pmd_t _early_dtb_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +
> +#define trampoline_pmd	((pmd_t *)__XIP_FIXUP(_trampoline_pmd))
> +#define fixmap_pmd	((pmd_t *)__XIP_FIXUP(_fixmap_pmd))
> +#define xip_pmd		((pmd_t *)__XIP_FIXUP(_xip_pmd))
> +#define early_pmd	((pmd_t *)__XIP_FIXUP(_early_pmd))
> +#define early_dtb_pmd	((pmd_t *)__XIP_FIXUP(_early_dtb_pmd))
> +#else
> +pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
>  pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> +#endif
> +
>  
>  static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
> @@ -413,6 +468,19 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  	return PMD_SIZE;
>  }
>  
> +#ifdef CONFIG_XIP_KERNEL
> +/* called from head.S with MMU off */
> +asmlinkage void __init __copy_data(void)
> +{
> +	void *from = (void *)(&_sdata);
> +	void *end = (void *)(&_end);
> +	void *to = (void *)CONFIG_XIP_PHYS_RAM_BASE;
> +	size_t sz = (size_t)(end - from);
> +
> +	memcpy(to, from, sz);
> +}
> +#endif
> +
>  /*
>   * setup_vm() is called from head.S with MMU-off.
>   *
> @@ -441,6 +509,19 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	pmd_t fix_bmap_spmd, fix_bmap_epmd;
>  #endif
>  
> +#ifdef CONFIG_XIP_KERNEL
> +	uintptr_t xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
> +	uintptr_t xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
> +	uintptr_t xip_map_size = best_map_size(xiprom,
> +					       MAX_EARLY_MAPPING_SIZE);
> +
> +	BUG_ON((xiprom % xip_map_size) != 0);
> +	BUG_ON(xiprom_sz > MAX_EARLY_MAPPING_SIZE);
> +
> +	load_pa = (uintptr_t)CONFIG_XIP_PHYS_RAM_BASE;
> +	load_sz = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
> +	map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
> +#endif
>  	va_pa_offset = PAGE_OFFSET - load_pa;
>  	pfn_base = PFN_DOWN(load_pa);
>  
> @@ -480,6 +561,21 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  			   load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
>  #endif
>  
> +#ifdef CONFIG_XIP_KERNEL
> +	create_pgd_mapping(trampoline_pg_dir, XIP_VIRT_ADDR_START,
> +			   (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
> +	for (va = XIP_VIRT_ADDR_START;
> +	     va < XIP_VIRT_ADDR_START + xiprom_sz;
> +	     va += PMD_SIZE) {
> +		create_pmd_mapping(xip_pmd, va,
> +				   xiprom + (va - XIP_VIRT_ADDR_START),
> +				   PMD_SIZE, PAGE_KERNEL_EXEC);
> +	}
> +
> +	create_pgd_mapping(early_pg_dir, XIP_VIRT_ADDR_START,
> +			   (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
> +#endif
> +
>  	/*
>  	 * Setup early PGD covering entire kernel which will allows
>  	 * us to reach paging_init(). We map all memory banks later
> @@ -549,6 +645,9 @@ static void __init setup_vm_final(void)
>  	uintptr_t va, map_size;
>  	phys_addr_t pa, start, end;
>  	u64 i;
> +#ifdef CONFIG_XIP_KERNEL
> +	uintptr_t xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
> +#endif
>  
>  	/**
>  	 * MMU is enabled at this point. But page table setup is not complete yet.
> @@ -580,6 +679,21 @@ static void __init setup_vm_final(void)
>  					   map_size, PAGE_KERNEL_EXEC);
>  		}
>  	}
> +#ifdef CONFIG_XIP_KERNEL
> +	for (va = XIP_VIRT_ADDR_START;
> +	     va < XIP_VIRT_ADDR_START + xiprom_sz;
> +	     va += PMD_SIZE)
> +		create_pgd_mapping(swapper_pg_dir, va,
> +				   CONFIG_XIP_PHYS_ADDR + (va - XIP_VIRT_ADDR_START),
> +				   PMD_SIZE, PAGE_KERNEL_EXEC);
> +
> +	/* if DT is in NOR, keep the early mapping */
> +	if (dtb_early_pa >= CONFIG_XIP_PHYS_ADDR &&
> +	    dtb_early_pa <= CONFIG_XIP_PHYS_ADDR + SZ_16M)
> +		create_pgd_mapping(swapper_pg_dir, DTB_EARLY_BASE_VA,
> +				   __pa_symbol(early_dtb_pmd),
> +				   PGDIR_SIZE, PAGE_TABLE);
> +#endif
>  
>  	/* Clear fixmap PTE and PMD mappings */
>  	clear_fixmap(FIX_PTE);
> -- 
> 2.20.1
> 
> 
