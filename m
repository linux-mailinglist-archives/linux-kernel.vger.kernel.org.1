Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A82ECF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbhAGLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:50:29 -0500
Received: from foss.arm.com ([217.140.110.172]:58764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:50:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B766F31B;
        Thu,  7 Jan 2021 03:49:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.34.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D586D3F719;
        Thu,  7 Jan 2021 03:49:36 -0800 (PST)
Date:   Thu, 7 Jan 2021 11:49:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sang Yan <sangyan@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zhuling8@huawei.com,
        luanjianhai@huawei.com, luolongjun@huawei.com,
        lixiaoguang2@huawei.com, luchunhua@huawei.com, shenkai8@huawei.com
Subject: Re: [PATCH] arm64: smp: Add support for cpu park
Message-ID: <20210107114934.GD7523@C02TD0UTHF1T.local>
References: <20201219052317.14106-1-sangyan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219052317.14106-1-sangyan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 01:23:17PM +0800, Sang Yan wrote:
> Introducing a feature of CPU PARK in order to save time
> of cpus down and up during kexec, which may cost 250ms of
> per cpu's down and 30ms of up.

Where is that 250ms spent? Is that mostly in FW, or in the kernel
preparing/monitoring the shutdown? If the majority of that time is
in-kernel we might be able to improve that somewhat.

> As a result, for 128 cores, it costs more than 30 seconds
> to down and up cpus during kexec. Think about 256 cores and more.

For growing core counts we should look at parallelising the shutdown. We
already do that for crash kernels, and IIRC Thomas Glexiner was
interested in making CPU bringup and teardown parallelisable generally,
so we might be able to make core code changes if necessary to permit
that.

> CPU PARK is a state that cpu power-on and staying in spin loop, polling
> for exit chances, such as writing exit address.
> 
> Reserving a block of memory, to fill with cpu park text section,
> exit address and park-magic-flag of each cpu. In implementation,
> reserved one page for one cpu core.
> 
> Cpus going to park state instead of down in machine_shutdown().
> Cpus going out of park state in smp_init instead of brought up.

I really do not want to introduce another mechanism for CPU handoff.
It's very hard to get this right, comes with an ever-growing set of ABI
challenges, and is incompatible with a kexec to another (non-Linux)
target.

I do not think that we should pursue this approach unless we have
exhausted the alternatives.

Thanks,
Mark.

> 
> One of cpu park sections in pre-reserved memory blocks,:
> +--------------+
> + exit address +
> +--------------+
> + park magic   +
> +--------------+
> + park codes   +
> +      .       +
> +      .       +
> +      .       +
> +--------------+
> 
> Signed-off-by: Sang Yan <sangyan@huawei.com>
> ---
>  arch/arm64/Kconfig                |  12 +++
>  arch/arm64/include/asm/cpu.h      |   9 ++
>  arch/arm64/include/asm/kexec.h    |   7 ++
>  arch/arm64/include/asm/smp.h      |   3 +
>  arch/arm64/kernel/Makefile        |   1 +
>  arch/arm64/kernel/cpu-park.S      |  49 +++++++++
>  arch/arm64/kernel/machine_kexec.c |   2 +-
>  arch/arm64/kernel/process.c       |   4 +
>  arch/arm64/kernel/smp.c           | 220 ++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/init.c              |  56 ++++++++++
>  10 files changed, 362 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/cpu-park.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9f0139b..7a9defd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -347,6 +347,18 @@ config KASAN_SHADOW_OFFSET
>  	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>  	default 0xffffffffffffffff
>  
> +config ARM64_CPU_PARK
> +	bool "Support CPU PARK on kexec"
> +	depends on SMP
> +	depends on KEXEC_CORE
> +	help
> +	 This enables support for CPU PARK feature in
> +	 order to save time of cpu down to up.
> +	 CPU park is a state through kexec, spin loop
> +	 instead of cpu die before jumping to new kernel,
> +	 jumping out from loop to new kernel entry in
> +	 smp_init.
> +
>  source "arch/arm64/Kconfig.platforms"
>  
>  menu "Kernel Features"
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 7faae6f..e616a50 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -68,4 +68,13 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info);
>  void update_cpu_features(int cpu, struct cpuinfo_arm64 *info,
>  				 struct cpuinfo_arm64 *boot);
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +#define PARK_SECTION_SIZE PAGE_SIZE
> +extern unsigned long park_start;
> +extern unsigned long park_len;
> +extern unsigned long park_start_v;
> +extern void __cpu_park(unsigned long text, unsigned long exit);
> +extern void __do_cpu_park(unsigned long exit);
> +#endif
> +
>  #endif /* __ASM_CPU_H */
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index d24b527..69a66ca 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -25,6 +25,11 @@
>  
>  #define KEXEC_ARCH KEXEC_ARCH_AARCH64
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +/* CPU park state flag: "park" */
> +#define PARK_MAGIC 0x7061726b
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  
>  /**
> @@ -90,6 +95,8 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> +void machine_kexec_mask_interrupts(void);
> +
>  #ifdef CONFIG_KEXEC_FILE
>  #define ARCH_HAS_KIMAGE_ARCH
>  
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 2e7f529..9141fa8 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -145,6 +145,9 @@ bool cpus_are_stuck_in_kernel(void);
>  
>  extern void crash_smp_send_stop(void);
>  extern bool smp_crash_stop_failed(void);
> +#ifdef CONFIG_ARM64_CPU_PARK
> +extern int kexec_smp_send_park(void);
> +#endif
>  
>  #endif /* ifndef __ASSEMBLY__ */
>  
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 86364ab..7ea26ab 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
>  obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
>  obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
>  					   cpu-reset.o
> +obj-$(CONFIG_ARM64_CPU_PARK)		+= cpu-park.o
>  obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
>  obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
>  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
> diff --git a/arch/arm64/kernel/cpu-park.S b/arch/arm64/kernel/cpu-park.S
> new file mode 100644
> index 00000000..8c01484
> --- /dev/null
> +++ b/arch/arm64/kernel/cpu-park.S
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * CPU park routines
> + *
> + * Copyright (C) 2020 Huawei Technologies., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +#include <asm/kexec.h>
> +#include <asm/sysreg.h>
> +#include <asm/virt.h>
> +
> +.text
> +.pushsection    .idmap.text, "awx"
> +
> +/* cpu park helper in idmap section */
> +SYM_CODE_START(__cpu_park)
> +	/* Clear sctlr_el1 flags. */
> +	mrs	x12, sctlr_el1
> +	ldr	x13, =SCTLR_ELx_FLAGS
> +	bic	x12, x12, x13
> +	pre_disable_mmu_workaround
> +	msr	sctlr_el1, x12		/* disable mmu */
> +	isb
> +
> +	mov	x18, x0
> +	mov	x0, x1			/* secondary_entry addr */
> +	br	x18			/* call __do_cpu_park of each cpu */
> +SYM_CODE_END(__cpu_park)
> +
> +.popsection
> +
> +SYM_CODE_START(__do_cpu_park)
> +	ldr	x18, =PARK_MAGIC	/* magic number "park" */
> +	str	x18, [x0, #8]		/* set on-park flag */
> +
> +.Lloop:	ldr	x19, [x0]
> +	cmp	x19, #0			/* test secondary_entry */
> +	wfe
> +	b.eq	.Lloop
> +
> +	br	x19			/* jump to secondary_entry */
> +SYM_CODE_END(__do_cpu_park)
> +
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index a0b144c..f47ce96 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -213,7 +213,7 @@ void machine_kexec(struct kimage *kimage)
>  	BUG(); /* Should never get here. */
>  }
>  
> -static void machine_kexec_mask_interrupts(void)
> +void machine_kexec_mask_interrupts(void)
>  {
>  	unsigned int i;
>  	struct irq_desc *desc;
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6616486..70d8dac 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -147,6 +147,10 @@ void arch_cpu_idle_dead(void)
>   */
>  void machine_shutdown(void)
>  {
> +#ifdef CONFIG_ARM64_CPU_PARK
> +	if (kexec_smp_send_park() == 0)
> +		return;
> +#endif
>  	smp_shutdown_nonboot_cpus(reboot_cpu);
>  }
>  
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 2499b89..80a7a28 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -93,6 +93,159 @@ static inline int op_cpu_kill(unsigned int cpu)
>  }
>  #endif
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +struct cpu_park_section {
> +	unsigned long exit;	/* exit address of park look */
> +	unsigned long magic;	/* maigc represent park state */
> +	char text[0];		/* text section of park */
> +};
> +
> +static int mmap_cpu_park_mem(void)
> +{
> +	if (!park_start)
> +		return -ENOMEM;
> +
> +	if (park_start_v)
> +		return 0;
> +
> +	park_start_v = (unsigned long)__ioremap(park_start, park_len,
> +						PAGE_KERNEL_EXEC);
> +	if (!park_start_v) {
> +		pr_warn("map park memory failed.");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline unsigned long cpu_park_section_v(unsigned int cpu)
> +{
> +	return PAGE_ALIGN(park_start_v + PARK_SECTION_SIZE * (cpu - 1));
> +}
> +
> +static inline unsigned long cpu_park_section_p(unsigned int cpu)
> +{
> +	return PAGE_ALIGN(park_start + PARK_SECTION_SIZE * (cpu - 1));
> +}
> +
> +/*
> + * Write the secondary_entry to exit section of park state.
> + * Then the secondary cpu will jump straight into the kernel
> + * by the secondary_entry.
> + */
> +static int write_park_exit(unsigned int cpu)
> +{
> +	struct cpu_park_section *park_section;
> +	unsigned long *park_exit;
> +	unsigned long *park_text;
> +
> +	if (mmap_cpu_park_mem() != 0)
> +		return -EPERM;
> +
> +	park_section = (struct cpu_park_section *)cpu_park_section_v(cpu);
> +	park_exit = &park_section->exit;
> +	park_text = (unsigned long *)park_section->text;
> +	pr_info("park_text 0x%lx : 0x%lx, __do_cpu_park text 0x%lx : 0x%lx",
> +		(unsigned long)park_text, *park_text,
> +		(unsigned long)__do_cpu_park,
> +		*(unsigned long *)__do_cpu_park);
> +
> +	isb();
> +
> +	/*
> +	 * Test first 8 bytes to determine
> +	 * whether needs to write cpu park exit.
> +	 */
> +	if (*park_text == *(unsigned long *)__do_cpu_park) {
> +		*park_exit = __pa_symbol(secondary_entry);
> +		isb();
> +		pr_info("Write cpu %u secondary entry 0x%lx to 0x%lx",
> +			 cpu, *park_exit, (unsigned long)park_exit);
> +		return 0;
> +	}
> +
> +	return -EPERM;
> +}
> +
> +/* Install cpu park sections for the specific cpu. */
> +static int install_cpu_park(unsigned int cpu)
> +{
> +	struct cpu_park_section *park_section;
> +	unsigned long *park_exit;
> +	unsigned long *park_magic;
> +	unsigned long park_text_len;
> +
> +	park_section = (struct cpu_park_section *)cpu_park_section_v(cpu);
> +	pr_debug("Install cpu park on cpu %u park exit 0x%lx park text 0x%lx",
> +		 cpu, (unsigned long)park_section,
> +		 (unsigned long)(park_section->text));
> +
> +	park_exit = &park_section->exit;
> +	park_magic = &park_section->magic;
> +	park_text_len = PARK_SECTION_SIZE - sizeof(struct cpu_park_section);
> +
> +	*park_exit = 0UL;
> +	*park_magic = 0UL;
> +	memcpy((void *)park_section->text, __do_cpu_park, park_text_len);
> +
> +	isb();
> +
> +	return 0;
> +}
> +
> +static int uninstall_cpu_park(unsigned int cpu)
> +{
> +	unsigned long park_section;
> +
> +	if (mmap_cpu_park_mem() != 0)
> +		return -EPERM;
> +
> +	park_section = cpu_park_section_v(cpu);
> +	memset((void *)park_section, 0, PARK_SECTION_SIZE);
> +
> +	return 0;
> +}
> +
> +static int cpu_wait_park(unsigned int cpu)
> +{
> +	unsigned long timeout;
> +	struct cpu_park_section *park_section;
> +	unsigned long *park_magic;
> +
> +	park_section = (struct cpu_park_section *)cpu_park_section_v(cpu);
> +	park_magic = &park_section->magic;
> +
> +	timeout = USEC_PER_SEC;
> +	while (*park_magic != PARK_MAGIC && timeout--)
> +		udelay(1);
> +
> +	if (timeout)
> +		pr_debug("cpu %u park done.", cpu);
> +	else
> +		pr_err("cpu %u park failed.", cpu);
> +
> +	return *park_magic == PARK_MAGIC;
> +}
> +
> +static void cpu_park(unsigned int cpu)
> +{
> +	unsigned long park_section_p;
> +	unsigned long park_exit_phy;
> +	unsigned long do_park;
> +	typeof(__cpu_park) *park;
> +
> +	park_section_p = cpu_park_section_p(cpu);
> +	park_exit_phy = park_section_p;
> +	pr_debug("Go to park cpu %u exit address 0x%lx", cpu, park_exit_phy);
> +
> +	do_park = park_section_p + sizeof(struct cpu_park_section);
> +	park = (void *)__pa_symbol(__cpu_park);
> +
> +	cpu_install_idmap();
> +	park(do_park, park_exit_phy);
> +	unreachable();
> +}
> +#endif
>  
>  /*
>   * Boot a secondary CPU, and assign it the specified idle task.
> @@ -102,6 +255,10 @@ static int boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	const struct cpu_operations *ops = get_cpu_ops(cpu);
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +	if (write_park_exit(cpu) == 0)
> +		return 0;
> +#endif
>  	if (ops->cpu_boot)
>  		return ops->cpu_boot(cpu);
>  
> @@ -131,6 +288,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		return ret;
>  	}
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +	uninstall_cpu_park(cpu);
> +#endif
>  	/*
>  	 * CPU was successfully started, wait for it to come online or
>  	 * time out.
> @@ -843,10 +1003,31 @@ void arch_irq_work_raise(void)
>  
>  static void local_cpu_stop(void)
>  {
> +	int cpu;
> +	const struct cpu_operations *ops = NULL;
> +
>  	set_cpu_online(smp_processor_id(), false);
>  
>  	local_daif_mask();
>  	sdei_mask_local_cpu();
> +
> +#ifdef CONFIG_ARM64_CPU_PARK
> +	/*
> +	 * Go to cpu park state.
> +	 * Otherwise go to cpu die.
> +	 */
> +	cpu = smp_processor_id();
> +	if (kexec_in_progress) {
> +		machine_kexec_mask_interrupts();
> +		if (park_start_v)
> +			cpu_park(cpu);
> +
> +		ops = get_cpu_ops(cpu);
> +		if (ops && ops->cpu_die)
> +			ops->cpu_die(cpu);
> +	}
> +#endif
> +
>  	cpu_park_loop();
>  }
>  
> @@ -1052,6 +1233,45 @@ void smp_send_stop(void)
>  	sdei_mask_local_cpu();
>  }
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +int kexec_smp_send_park(void)
> +{
> +	unsigned long cpu;
> +
> +	if (WARN_ON(!kexec_in_progress)) {
> +		pr_crit("%s called not in kexec progress.", __func__);
> +		return -EPERM;
> +	}
> +
> +	if (mmap_cpu_park_mem() != 0) {
> +		pr_info("no cpuparkmem, goto normal way.");
> +		return -EPERM;
> +	}
> +
> +	local_irq_disable();
> +
> +	if (num_online_cpus() > 1) {
> +		cpumask_t mask;
> +
> +		cpumask_copy(&mask, cpu_online_mask);
> +		cpumask_clear_cpu(smp_processor_id(), &mask);
> +
> +		for_each_cpu(cpu, &mask)
> +			install_cpu_park(cpu);
> +		smp_cross_call(&mask, IPI_CPU_STOP);
> +
> +		/* Wait for other CPUs to park */
> +		for_each_cpu(cpu, &mask)
> +			cpu_wait_park(cpu);
> +		pr_info("smp park other cpus done\n");
> +	}
> +
> +	sdei_mask_local_cpu();
> +
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_KEXEC_CORE
>  void crash_smp_send_stop(void)
>  {
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 69d4251..d25bb61 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -279,6 +279,58 @@ static void __init fdt_enforce_memory_region(void)
>  		memblock_cap_memory_range(reg.base, reg.size);
>  }
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +/* Physical address of reserved park memory. */
> +unsigned long park_start;
> +/* Virtual address of reserved park memory. */
> +unsigned long park_start_v;
> +/* park reserve mem len should be PAGE_SIZE * NR_CPUS */
> +unsigned long park_len = PAGE_SIZE * NR_CPUS;
> +
> +static int __init parse_park_mem(char *p)
> +{
> +	if (!p)
> +		return 0;
> +
> +	park_start = PAGE_ALIGN(memparse(p, NULL));
> +	if (park_start == 0)
> +		pr_info("cpu park mem params[%s]", p);
> +
> +	return 0;
> +}
> +early_param("cpuparkmem", parse_park_mem);
> +
> +static int __init reserve_park_mem(void)
> +{
> +	if (park_start == 0 || park_len == 0)
> +		return 0;
> +
> +	park_start = PAGE_ALIGN(park_start);
> +	park_len = PAGE_ALIGN(park_len);
> +
> +	if (!memblock_is_region_memory(park_start, park_len)) {
> +		pr_warn("cannot reserve park mem: region is not memory!");
> +		goto out;
> +	}
> +
> +	if (memblock_is_region_reserved(park_start, park_len)) {
> +		pr_warn("cannot reserve park mem: region overlaps reserved memory!");
> +		goto out;
> +	}
> +
> +	memblock_reserve(park_start, park_len);
> +	memblock_remove(park_start, park_len);
> +	pr_info("cpu park mem reserved: 0x%016lx - 0x%016lx (%ld MB)",
> +		park_start, park_start + park_len, park_len >> 20);
> +
> +	return 0;
> +out:
> +	park_start = 0;
> +	park_len = 0;
> +	return -EINVAL;
> +}
> +#endif
> +
>  void __init arm64_memblock_init(void)
>  {
>  	const s64 linear_region_size = PAGE_END - _PAGE_OFFSET(vabits_actual);
> @@ -396,6 +448,10 @@ void __init arm64_memblock_init(void)
>  	else
>  		arm64_dma32_phys_limit = PHYS_MASK + 1;
>  
> +#ifdef CONFIG_ARM64_CPU_PARK
> +	reserve_park_mem();
> +#endif
> +
>  	reserve_elfcorehdr();
>  
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> -- 
> 2.9.5
> 
