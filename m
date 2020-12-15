Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185CA2DB17D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgLOQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbgLOQcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:32:50 -0500
X-Gm-Message-State: AOAM530aT3TC1pP5L0nnPs5/Vj2JRd7wCW2ZtNyBIQs9+LlwJd+veyo+
        IyImYY9LJ7O78Yb3OPBKuabbg4KCs5UUyXvJZ5kHdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608049929;
        bh=HZb2SnCsrrZKVo86TpJR2H+ci2ag6F3BQxnMjpJMsQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AWsO2+f70ZyEM4CR+d8onsVsTGgQHIhBnQnS12HPLCE9UrmnwRO6y52Mt1I5cJFN3
         BotSKPdltXj5K6W0IqVqxj6Y8jO9jLiDLDWYKPsHbdrOOvT2Qs8q5T/b8nbahUAlJH
         WqDPDACzAwtMq3wppyVsqUgsx77sXH+eZQmS961sZsqdiFFA9THlUD8RMnQMj4ZqDI
         hm3401nkkgSOcVZ+nFScMtBaCRyL87u058odH4J3YufJ8qP9PqQ8TOi6DSFq+R6X0R
         UdfGbyUIJJO0abBlawWDnRTcz4Yic1njjc5i3pmphXK8aaxI/oSEC8HfJOoD4CCP1R
         7Ex9C5KOwSJ3g==
X-Google-Smtp-Source: ABdhPJw5YO9UlC+PkZkOIgcU+spji3k3H5wlEuZG+PtItpKGeFEBDlm+LxzB9b9/wLKrDpKEGvVauQjfQhTktZ377X0=
X-Received: by 2002:a7b:c303:: with SMTP id k3mr33531803wmj.21.1608049927611;
 Tue, 15 Dec 2020 08:32:07 -0800 (PST)
MIME-Version: 1.0
References: <01a29d37-7696-f6e0-6a85-8f62c3380b1a@huawei.com>
In-Reply-To: <01a29d37-7696-f6e0-6a85-8f62c3380b1a@huawei.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Dec 2020 08:31:56 -0800
X-Gmail-Original-Message-ID: <CALCETrV-ABENy9YmGhxjaU-rpEfEY_RLzv0kfzrWfN+RKbuQtA@mail.gmail.com>
Message-ID: <CALCETrV-ABENy9YmGhxjaU-rpEfEY_RLzv0kfzrWfN+RKbuQtA@mail.gmail.com>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
To:     "shenkai (D)" <shenkai8@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 6:46 AM shenkai (D) <shenkai8@huawei.com> wrote:
>
> From: shenkai <shenkai8@huawei.com>
> Date: Tue, 15 Dec 2020 01:58:06 +0000
> Subject: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
>
> In kexec reboot on x86 machine, APs will be halted and then waked up
> by the apic INIT and SIPI interrupt. Here we can let APs spin instead
> of being halted and boot APs by writing to specific address. In this way
> we can accelerate smp_init procedure for we don't need to pull APs up
> from a deep C-state.
>
> This is meaningful in many situations where users are sensitive to reboot
> time cost.

I like the concept.

>
> On 72-core x86(Intel Xeon Gold 6154 CPU @ 3.00GHz) machine with
> Linux-5.10.0, time cost of smp_init is 210ms with cpu park while 80ms
> without, and the difference is more significant when there are more
> cores.
>
> Implementation is basicly as follow:
> 1. reserve some space for cpu park code and data
> 2. when APs get reboot IPI and cpu_park is enabled, they will turn MMU
>     off and excute cpu park code where APs will spin and wait on an
>     address.(APs will reuse the pgtable which is used by BSP in kexec
>     procedure to turn MMU off)
> 3. after BSP reboot successfully, it will wake up APs by writing an entry
>     address to the spin-read address so that APs can jmp to normal bootup
>     procedure.
> 4. The hyperthreaded twin processor of BSP can be specified so that the
>     twin processor can halt as normal procedure and will not compete with
>     BSP during booting.
>
> Signed-off-by: shenkai <shenkai8@huawei.com>
> Co-Developed-by: Luo Longjun <luolongjun@huawei.com>
> ---
>   arch/x86/Kconfig                     | 12 ++++
>   arch/x86/include/asm/kexec.h         | 43 ++++++++++++++
>   arch/x86/include/asm/realmode.h      |  3 +
>   arch/x86/kernel/Makefile             |  1 +
>   arch/x86/kernel/cpu-park.S           | 87 +++++++++++++++++++++++++++
>   arch/x86/kernel/machine_kexec_64.c   | 16 +++++
>   arch/x86/kernel/process.c            | 13 ++++
>   arch/x86/kernel/reboot.c             |  6 ++
>   arch/x86/kernel/relocate_kernel_64.S | 51 ++++++++++++++++
>   arch/x86/kernel/setup.c              | 67 +++++++++++++++++++++
>   arch/x86/kernel/smp.c                | 89 ++++++++++++++++++++++++++++
>   arch/x86/kernel/smpboot.c            | 14 +++++
>   arch/x86/realmode/rm/header.S        |  3 +
>   arch/x86/realmode/rm/trampoline_64.S |  5 ++
>   kernel/smp.c                         |  6 ++
>   15 files changed, 416 insertions(+)
>   create mode 100644 arch/x86/kernel/cpu-park.S
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fbf26e0f7a6a..8dedd0e62eb2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2406,6 +2406,18 @@ config MODIFY_LDT_SYSCALL
>         surface.  Disabling it removes the modify_ldt(2) system call.
>
>         Saying 'N' here may make sense for embedded or server kernels.
> +config X86_CPU_PARK
> +    bool "Support CPU PARK on kexec"
> +    default n
> +    depends on SMP
> +    depends on KEXEC_CORE
> +    help
> +      This enables support for CPU PARK feature in
> +      order to save time of cpu down to up.
> +      CPU park is a state through kexec, spin loop
> +      instead of cpu die before jumping to new kernel,
> +      jumping out from loop to new kernel entry in
> +      smp_init.

Why does this need to be configurable?

>
>   source "kernel/livepatch/Kconfig"
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 6802c59e8252..3801df240f5f 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -197,6 +197,49 @@ typedef void crash_vmclear_fn(void);
>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>   extern void kdump_nmi_shootdown_cpus(void);
>
> +#ifdef CONFIG_X86_CPU_PARK
> +#define PARK_MAGIC 0x7061726b
> +#define PARK_SECTION_SIZE PAGE_ALIGN(sizeof(struct cpu_park_section) +
> 2 * PAGE_SIZE - 1)
> +extern unsigned long park_start;
> +extern unsigned long park_len;
> +extern bool cpu_park_enable;
> +extern int boot_core_sibling;
> +extern void cpu_park(unsigned int cpu);
> +extern void __do_cpu_park(unsigned long exit);
> +extern int write_park_exit(unsigned int cpu);
> +extern unsigned long park_cpu(unsigned long pgd_addr,
> +            unsigned long park_code_addr,
> +            unsigned long exit_addr);
> +extern int install_cpu_park(void);
> +extern int uninstall_cpu_park(void);
> +
> +struct cpu_park_section {
> +    struct {
> +        unsigned long exit;    /* entry address to exit loop */
> +        unsigned long magic;    /* maigc indicates park state */

No magic please.  If you actually need a flag, give it a descriptive
name and document what the values are.  But I think you could get away
with just a single field per cpu:

u32 jump_address;

0 means keep spinning.

But I think you could do even better -- just have a single field that
you write to wake all parked CPUs.  You'll also want some indication
of how many CPUs are parked so that the new kernel can reliably tell
when it has unparked all of them.

> +    } para[NR_CPUS];

What does "para" mean?

> +    char text[0];            /* text section of park */

text[0] is useless.  Either give it a real size or just omit it
entirely.  Or use text[] if you absolutely must.


> +#define PARK_MAGIC 0x7061726b

What is this for?

> +
> +    .text
> +    .align PAGE_SIZE
> +SYM_CODE_START_NOALIGN(__do_cpu_park)
> +    .code64
> +
> +    /* %rdi park exit addr */
> +
> +    leaq    gdt(%rip), %rax
> +    /* gdt address will be updated with the same value several times */

Why do you need to change the GDT at all?  You're spinning at CPL0,
and you don't have a usable IDT, and any NMI or MCE that comes in is
going to kill the system entirely.  So either you need a full working
GDT, IDT, and NMI/MCE handler, or you could just not have a valid GDT
at all.

In any case, these comments are useless.  Why would you update the
address with the same value several times?  Why are you sticking a
pointer to "gdt" into "gdt_meta".  (Yes, I figured out that you are
building a pointer to feed lgdt.  Just use the stack for it and make
the code less bizarre.)

> +    movq    %rax, (gdt_meta + 0x2)(%rip)
> +    lgdt    gdt_meta(%rip)
> +
> +    movl    $0x18, %eax    /* data segment */
> +    movl    %eax, %ds
> +    movl    %eax, %es
> +    movl    %eax, %ss
> +    movl    %eax, %fs
> +    movl    %eax, %gs
> +
> +    /* set stack */
> +    leaq    stack_init(%rip), %rsp
> +    leaq    __enter_protection(%rip), %rax
> +    /* stack will be writted with the same value several times */

"written"

But this comment makes no sense at all.  How about "switch to compat mode"?

> +    pushq    $0x08 /* CS */
> +    pushq    %rax
> +    lretq
> +
> +    .code32
> +__enter_protection:
> +    /* Disable paging */
> +    movl    %cr0, %eax
> +    andl    $~0x80000000, %eax
> +    movl    %eax, %cr0
> +
> +    /* Disable long mode */
> +    movl    $0xC0000080, %ecx
> +    rdmsr
> +    andl    $~0x00000100, %eax
> +    wrmsr

I don't think you really need to be in compat mode to exit long mode.
I admit that the semantics would be more bizarre if you just exited
directly.

Also, no magic numbers please.

> +
> +    /* Disable PAE */
> +    xorl    %eax, %eax
> +    movl    %eax, %cr4
> +
> +    mov    $PARK_MAGIC, %eax
> +    mov    %eax, 0x8(%edi)
> +0:
> +    mov    (%edi), %eax
> +    test    %eax, %eax
> +    jz    0b

mwait, please.

> +
> +    mov    $0x18, %edx

What's that for?

>
> diff --git a/arch/x86/kernel/relocate_kernel_64.S
> b/arch/x86/kernel/relocate_kernel_64.S
> index a4d9a261425b..d794b0aefaf3 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -107,6 +107,57 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>       ret
>   SYM_CODE_END(relocate_kernel)
>
> +SYM_CODE_START_NOALIGN(park_cpu)
> +    /*
> +     * %rdi pgd addr
> +     * %rsi __do_cpu_park addr
> +     * %rdx park exit addr
> +     */
> +
> +    /* get physical address of page table now too */
> +    movq    %rdi, %r9
> +    /* Switch to the identity mapped page tables */
> +    movq    %r9, %cr3
> +
> +    movq    %cr4, %rax
> +    movq    %rax, %r13
> +
> +    /*
> +     * Set cr0 to a known state:
> +     *  - Paging enabled
> +     *  - Alignment check disabled
> +     *  - Write protect disabled
> +     *  - No task switch
> +     *  - Don't do FP software emulation.
> +     *  - Proctected mode enabled
> +     */
> +    movq    %cr0, %rax
> +    andq    $~(X86_CR0_AM | X86_CR0_WP | X86_CR0_TS | X86_CR0_EM), %rax
> +    orl        $(X86_CR0_PG | X86_CR0_PE), %eax
> +    movq    %rax, %cr0
> +
> +    /*
> +     * Set cr4 to a known state:
> +     *  - physical address extension enabled
> +     *  - 5-level paging, if it was enabled before
> +     */
> +    movl    $X86_CR4_PAE, %eax
> +    testq    $X86_CR4_LA57, %r13
> +    jz    1f
> +    orl    $X86_CR4_LA57, %eax
> +1:
> +    movq    %rax, %cr4
> +
> +    jmp 1f
> +1:
> +
> +    mov    %rdx, %rdi
> +    mov    %rsi, %rax
> +    jmp    *%rax
> +
> +    ret    /* never */
> +SYM_CODE_END(park_cpu)

What is the purpose of this function?


> +
>   SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>       UNWIND_HINT_EMPTY
>       /* set return address to 0 if not preserving context */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 84f581c91db4..dfe854c1ecf8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -195,6 +195,70 @@ static inline void __init copy_edd(void)
>   }
>   #endif
>
> +#ifdef CONFIG_X86_CPU_PARK
> +/* Physical address of reserved park memory. */
> +unsigned long park_start;
> +/* Virtual address of reserved park memory. */
> +unsigned long park_start_virt;
> +/* park reserve mem len should be PAGE_SIZE * NR_CPUS */
> +unsigned long park_len = PARK_SECTION_SIZE;
> +bool cpu_park_enable;
> +int boot_core_sibling;
> +
> +static int __init parse_boot_core_sibling(char *p)
> +{
> +    if (!p)
> +        return 0;
> +    get_option(&p, &boot_core_sibling);
> +    return 0;
> +}
> +early_param("bootcoresibling", parse_boot_core_sibling);

What is this for?

> +
> +static int __init parse_park_mem(char *p)
> +{
> +    if (!p)
> +        return 0;
> +
> +    park_start = PAGE_ALIGN(memparse(p, NULL));
> +    if (park_start == 0)
> +        pr_info("cpu park mem params[%s]", p);
> +
> +    return 0;
> +}
> +early_param("cpuparkmem", parse_park_mem);
> +
> +static int __init reserve_park_mem(void)
> +{
> +    if (park_start == 0 || park_len == 0)
> +        return 0;
> +
> +    park_start = PAGE_ALIGN(park_start);
> +    park_len = PAGE_ALIGN(park_len);
> +
> +    if (!memblock_is_region_memory(park_start, park_len)) {
> +        pr_warn("cannot reserve park mem: region is not memory!\n");
> +        goto out;
> +    }
> +
> +    if (memblock_is_region_reserved(park_start, park_len)) {
> +        pr_warn("cannot reserve park mem: region overlaps reserved
> memory!\n");
> +        goto out;
> +    }
> +
> +    memblock_reserve(park_start, park_len);
> +    pr_info("cpu park mem reserved: 0x%016lx - 0x%016lx (%ld KB)\n",
> +        park_start, park_start + park_len, park_len >> 10);
> +
> +    cpu_park_enable = true;
> +    return 0;
> +out:
> +    park_start = 0;
> +    park_len = 0;
> +    cpu_park_enable = false;
> +    return -EINVAL;
> +}
> +#endif
> +
>   void * __init extend_brk(size_t size, size_t align)
>   {
>       size_t mask = align - 1;
> @@ -1154,6 +1218,9 @@ void __init setup_arch(char **cmdline_p)
>        * won't consume hotpluggable memory.
>        */
>       reserve_crashkernel();
> +#ifdef CONFIG_X86_CPU_PARK
> +    reserve_park_mem();
> +#endif
>
>       memblock_find_dma_reserve();
>
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> index eff4ce3b10da..19297fd5cdc2 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -34,6 +34,10 @@
>   #include <asm/kexec.h>
>   #include <asm/virtext.h>
>
> +#ifdef CONFIG_X86_CPU_PARK
> +#include <linux/kexec.h>
> +#include <asm/realmode.h>
> +#endif
>   /*
>    *    Some notes on x86 processor bugs affecting SMP operation:
>    *
> @@ -128,6 +132,91 @@ static int smp_stop_nmi_callback(unsigned int val,
> struct pt_regs *regs)
>       return NMI_HANDLED;
>   }
>
> +#ifdef CONFIG_X86_CPU_PARK
> +/*
> + * Write the secondary_entry to exit section of park state.
> + * Then the secondary cpu will jump straight into the kernel
> + * by the secondary_entry.
> + */
> +int write_park_exit(unsigned int cpu)
> +{
> +    struct cpu_park_section *park_section;
> +    unsigned long *park_exit;
> +    unsigned long *park_magic;
> +
> +    if (!cpu_park_enable)
> +        return  -EPERM;
> +
> +    park_section = cpu_park_section_virt();
> +    park_exit = cpu_park_exit_addr(park_section, cpu);
> +    park_magic = cpu_park_magic_addr(park_section, cpu);
> +
> +    /*
> +     * Test first 8 bytes to determine
> +     * whether needs to write cpu park exit.
> +     */
> +    if (*park_magic == PARK_MAGIC) {
> +        cpumask_clear_cpu(cpu, cpu_initialized_mask);
> +        smp_mb();
> +
> +        *park_exit = real_mode_header->park_startup_32;
> +        pr_info("park cpu %d up", cpu);
> +        return 0;
> +    }
> +    pr_info("normal cpu %d up", cpu);
> +    return -EPERM;
> +}
> +
> +/* Install cpu park sections for the specific cpu. */
> +int install_cpu_park(void)
> +{
> +    struct cpu_park_section *park_section;
> +    unsigned long park_text_len;
> +
> +    park_section = cpu_park_section_virt();
> +    memset((void *)park_section, 0, PARK_SECTION_SIZE);
> +
> +    park_text_len = PAGE_SIZE;
> +    memcpy((void *)park_section->text, __do_cpu_park, park_text_len);
> +
> +    return 0;
> +}
> +
> +int uninstall_cpu_park(void)
> +{
> +    struct cpu_park_section *park_section;
> +
> +    if (!cpu_park_enable)
> +        return -EPERM;
> +
> +    park_section = cpu_park_section_virt();
> +    memset((void *)park_section, 0, PARK_SECTION_SIZE);
> +    pr_info("clear park area 0x%lx - 0x%lx", (unsigned
> long)cpu_park_section_phy(),
> +                    (unsigned long)cpu_park_section_phy() +
> PARK_SECTION_SIZE);
> +
> +    return 0;
> +}
> +
> +void cpu_park(unsigned int cpu)
> +{
> +    struct cpu_park_section *park_section_p;
> +    unsigned long park_exit_phy;
> +    unsigned long do_park;
> +    unsigned long pgd;
> +
> +    park_section_p = cpu_park_section_phy();
> +    park_exit_phy = (unsigned long)cpu_park_exit_addr(park_section_p, cpu);
> +    do_park = (unsigned long)&park_section_p->text;
> +    pgd = (unsigned
> long)__pa(page_address(kexec_image->control_code_page));
> +
> +    hw_breakpoint_disable();
> +
> +    park_cpu(pgd, do_park, park_exit_phy);
> +
> +    unreachable();

A __noreturn would make more sense.
