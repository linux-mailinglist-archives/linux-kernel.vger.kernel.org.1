Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C152DAF56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgLOOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:47:33 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2091 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgLOOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:47:09 -0500
Received: from dggeme710-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CwLdp6D6VzVpYP;
        Tue, 15 Dec 2020 22:45:18 +0800 (CST)
Received: from [10.174.177.7] (10.174.177.7) by dggeme710-chm.china.huawei.com
 (10.1.199.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Tue, 15
 Dec 2020 22:46:20 +0800
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        <luolongjun@huawei.com>, <hejingxian@huawei.com>
From:   "shenkai (D)" <shenkai8@huawei.com>
Subject: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
Message-ID: <01a29d37-7696-f6e0-6a85-8f62c3380b1a@huawei.com>
Date:   Tue, 15 Dec 2020 22:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.7]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggeme710-chm.china.huawei.com (10.1.199.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shenkai <shenkai8@huawei.com>
Date: Tue, 15 Dec 2020 01:58:06 +0000
Subject: [PATCH] use x86 cpu park to speedup smp_init in kexec situation

In kexec reboot on x86 machine, APs will be halted and then waked up
by the apic INIT and SIPI interrupt. Here we can let APs spin instead
of being halted and boot APs by writing to specific address. In this way
we can accelerate smp_init procedure for we don't need to pull APs up
from a deep C-state.

This is meaningful in many situations where users are sensitive to reboot
time cost.

On 72-core x86(Intel Xeon Gold 6154 CPU @ 3.00GHz) machine with
Linux-5.10.0, time cost of smp_init is 210ms with cpu park while 80ms
without, and the difference is more significant when there are more
cores.

Implementation is basicly as follow:
1. reserve some space for cpu park code and data
2. when APs get reboot IPI and cpu_park is enabled, they will turn MMU
    off and excute cpu park code where APs will spin and wait on an
    address.(APs will reuse the pgtable which is used by BSP in kexec
    procedure to turn MMU off)
3. after BSP reboot successfully, it will wake up APs by writing an entry
    address to the spin-read address so that APs can jmp to normal bootup
    procedure.
4. The hyperthreaded twin processor of BSP can be specified so that the
    twin processor can halt as normal procedure and will not compete with
    BSP during booting.

Signed-off-by: shenkai <shenkai8@huawei.com>
Co-Developed-by: Luo Longjun <luolongjun@huawei.com>
---
  arch/x86/Kconfig                     | 12 ++++
  arch/x86/include/asm/kexec.h         | 43 ++++++++++++++
  arch/x86/include/asm/realmode.h      |  3 +
  arch/x86/kernel/Makefile             |  1 +
  arch/x86/kernel/cpu-park.S           | 87 +++++++++++++++++++++++++++
  arch/x86/kernel/machine_kexec_64.c   | 16 +++++
  arch/x86/kernel/process.c            | 13 ++++
  arch/x86/kernel/reboot.c             |  6 ++
  arch/x86/kernel/relocate_kernel_64.S | 51 ++++++++++++++++
  arch/x86/kernel/setup.c              | 67 +++++++++++++++++++++
  arch/x86/kernel/smp.c                | 89 ++++++++++++++++++++++++++++
  arch/x86/kernel/smpboot.c            | 14 +++++
  arch/x86/realmode/rm/header.S        |  3 +
  arch/x86/realmode/rm/trampoline_64.S |  5 ++
  kernel/smp.c                         |  6 ++
  15 files changed, 416 insertions(+)
  create mode 100644 arch/x86/kernel/cpu-park.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fbf26e0f7a6a..8dedd0e62eb2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2406,6 +2406,18 @@ config MODIFY_LDT_SYSCALL
        surface.  Disabling it removes the modify_ldt(2) system call.

        Saying 'N' here may make sense for embedded or server kernels.
+config X86_CPU_PARK
+    bool "Support CPU PARK on kexec"
+    default n
+    depends on SMP
+    depends on KEXEC_CORE
+    help
+      This enables support for CPU PARK feature in
+      order to save time of cpu down to up.
+      CPU park is a state through kexec, spin loop
+      instead of cpu die before jumping to new kernel,
+      jumping out from loop to new kernel entry in
+      smp_init.

  source "kernel/livepatch/Kconfig"

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 6802c59e8252..3801df240f5f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -197,6 +197,49 @@ typedef void crash_vmclear_fn(void);
  extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
  extern void kdump_nmi_shootdown_cpus(void);

+#ifdef CONFIG_X86_CPU_PARK
+#define PARK_MAGIC 0x7061726b
+#define PARK_SECTION_SIZE PAGE_ALIGN(sizeof(struct cpu_park_section) + 
2 * PAGE_SIZE - 1)
+extern unsigned long park_start;
+extern unsigned long park_len;
+extern bool cpu_park_enable;
+extern int boot_core_sibling;
+extern void cpu_park(unsigned int cpu);
+extern void __do_cpu_park(unsigned long exit);
+extern int write_park_exit(unsigned int cpu);
+extern unsigned long park_cpu(unsigned long pgd_addr,
+            unsigned long park_code_addr,
+            unsigned long exit_addr);
+extern int install_cpu_park(void);
+extern int uninstall_cpu_park(void);
+
+struct cpu_park_section {
+    struct {
+        unsigned long exit;    /* entry address to exit loop */
+        unsigned long magic;    /* maigc indicates park state */
+    } para[NR_CPUS];
+    char text[0];            /* text section of park */
+};
+
+static inline unsigned long *cpu_park_exit_addr(struct cpu_park_section 
*sec, unsigned int cpu)
+{
+    return &sec->para[cpu].exit;
+}
+static inline unsigned long *cpu_park_magic_addr(struct 
cpu_park_section *sec, unsigned int cpu)
+{
+    return &sec->para[cpu].magic;
+}
+static inline struct cpu_park_section *cpu_park_section_virt(void)
+{
+    return (struct cpu_park_section *)phys_to_virt(park_start);
+
+}
+static inline struct cpu_park_section *cpu_park_section_phy(void)
+{
+    return (struct cpu_park_section *)park_start;
+}
+#endif
+
  #endif /* __ASSEMBLY__ */

  #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/include/asm/realmode.h 
b/arch/x86/include/asm/realmode.h
index 5db5d083c873..117f82f5c602 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -37,6 +37,9 @@ struct real_mode_header {
  #ifdef CONFIG_X86_64
      u32    machine_real_restart_seg;
  #endif
+#ifdef CONFIG_X86_CPU_PARK
+    u32    park_startup_32;
+#endif
  };

  /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 68608bd892c0..5dab6772ddf7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_X86_UMIP)            += umip.o
  obj-$(CONFIG_UNWINDER_ORC)        += unwind_orc.o
  obj-$(CONFIG_UNWINDER_FRAME_POINTER)    += unwind_frame.o
  obj-$(CONFIG_UNWINDER_GUESS)        += unwind_guess.o
+obj-$(CONFIG_X86_CPU_PARK)        += cpu-park.o

  obj-$(CONFIG_AMD_MEM_ENCRYPT)        += sev-es.o
  ###
diff --git a/arch/x86/kernel/cpu-park.S b/arch/x86/kernel/cpu-park.S
new file mode 100644
index 000000000000..fc2cc675519c
--- /dev/null
+++ b/arch/x86/kernel/cpu-park.S
@@ -0,0 +1,87 @@
+#include <asm/kexec.h>
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+#include <asm/msr-index.h>
+
+#define PARK_MAGIC 0x7061726b
+
+    .text
+    .align PAGE_SIZE
+SYM_CODE_START_NOALIGN(__do_cpu_park)
+    .code64
+
+    /* %rdi park exit addr */
+
+    leaq    gdt(%rip), %rax
+    /* gdt address will be updated with the same value several times */
+    movq    %rax, (gdt_meta + 0x2)(%rip)
+    lgdt    gdt_meta(%rip)
+
+    movl    $0x18, %eax    /* data segment */
+    movl    %eax, %ds
+    movl    %eax, %es
+    movl    %eax, %ss
+    movl    %eax, %fs
+    movl    %eax, %gs
+
+    /* set stack */
+    leaq    stack_init(%rip), %rsp
+    leaq    __enter_protection(%rip), %rax
+    /* stack will be writted with the same value several times */
+    pushq    $0x08 /* CS */
+    pushq    %rax
+    lretq
+
+    .code32
+__enter_protection:
+    /* Disable paging */
+    movl    %cr0, %eax
+    andl    $~0x80000000, %eax
+    movl    %eax, %cr0
+
+    /* Disable long mode */
+    movl    $0xC0000080, %ecx
+    rdmsr
+    andl    $~0x00000100, %eax
+    wrmsr
+
+    /* Disable PAE */
+    xorl    %eax, %eax
+    movl    %eax, %cr4
+
+    mov    $PARK_MAGIC, %eax
+    mov    %eax, 0x8(%edi)
+0:
+    mov    (%edi), %eax
+    test    %eax, %eax
+    jz    0b
+
+    mov    $0x18, %edx
+    jmp    *%eax
+
+    .balign 16
+gdt:
+    /* 0x00 unusable segment
+     */
+    .quad    0
+
+    /* 0x08 32 4GB flat code segment */
+    .word    0xFFFF, 0x0000, 0x9B00, 0x00CF /* protect mode */
+
+    /* 0x10 4GB flat code segment */
+    .word    0xFFFF, 0x0000, 0x9B00, 0x00AF /* long mode */
+
+    /* 0x18 4GB flat data segment */
+    .word    0xFFFF, 0x0000, 0x9300, 0x00CF
+
+gdt_end:
+gdt_meta:
+    .word    gdt_end - gdt - 1
+    .quad    gdt
+    .word    0, 0, 0
+stack:    .quad    0, 0
+stack_init:
+    .fill    PAGE_SIZE - (. - __do_cpu_park), 1, 0
+SYM_CODE_END(__do_cpu_park)
diff --git a/arch/x86/kernel/machine_kexec_64.c 
b/arch/x86/kernel/machine_kexec_64.c
index a29a44a98e5b..95b9a17f7a3b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -241,6 +241,20 @@ static int init_pgtable(struct kimage *image, 
unsigned long start_pgtable)
              return result;
      }

+#ifdef CONFIG_X86_CPU_PARK
+    if (cpu_park_enable) {
+        void *control_page;
+
+        control_page = page_address(image->control_code_page) + PAGE_SIZE;
+        memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+
+        result = kernel_ident_mapping_init(&info, level4p, park_start, 
park_start + park_len);
+        if (result) {
+            cpu_park_enable = false;
+            return result;
+        }
+    }
+#endif
      /*
       * Prepare EFI systab and ACPI tables for kexec kernel since they are
       * not covered by pfn_mapped.
@@ -353,7 +367,9 @@ void machine_kexec(struct kimage *image)
      }

      control_page = page_address(image->control_code_page) + PAGE_SIZE;
+#ifndef CONFIG_X86_CPU_PARK
      memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+#endif

      page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
      page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..15c52036bbba 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -46,6 +46,9 @@

  #include "process.h"

+#ifdef CONFIG_X86_CPU_PARK
+#include <linux/kexec.h>
+#endif
  /*
   * per-CPU TSS segments. Threads are completely 'soft' on Linux,
   * no more per-task TSS's. The TSS size is kept cacheline-aligned
@@ -723,6 +726,16 @@ void stop_this_cpu(void *dummy)
       */
      if (boot_cpu_has(X86_FEATURE_SME))
          native_wbinvd();
+#ifdef CONFIG_X86_CPU_PARK
+    /*
+     * Go to cpu park state.
+     * Otherwise go to cpu die.
+     */
+    if (kexec_in_progress && cpu_park_enable) {
+        if (smp_processor_id() != boot_core_sibling)
+            cpu_park(smp_processor_id());
+    }
+#endif
      for (;;) {
          /*
           * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index db115943e8bd..a34b975efa9f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -32,6 +32,9 @@
  #include <asm/realmode.h>
  #include <asm/x86_init.h>
  #include <asm/efi.h>
+#ifdef CONFIG_X86_CPU_PARK
+#include <linux/kexec.h>
+#endif

  /*
   * Power off function, if any
@@ -705,6 +708,9 @@ void native_machine_shutdown(void)
       * scheduler's load balance.
       */
      local_irq_disable();
+#ifdef CONFIG_X86_CPU_PARK
+    install_cpu_park();
+#endif
      stop_other_cpus();
  #endif

diff --git a/arch/x86/kernel/relocate_kernel_64.S 
b/arch/x86/kernel/relocate_kernel_64.S
index a4d9a261425b..d794b0aefaf3 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -107,6 +107,57 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
      ret
  SYM_CODE_END(relocate_kernel)

+SYM_CODE_START_NOALIGN(park_cpu)
+    /*
+     * %rdi pgd addr
+     * %rsi __do_cpu_park addr
+     * %rdx park exit addr
+     */
+
+    /* get physical address of page table now too */
+    movq    %rdi, %r9
+    /* Switch to the identity mapped page tables */
+    movq    %r9, %cr3
+
+    movq    %cr4, %rax
+    movq    %rax, %r13
+
+    /*
+     * Set cr0 to a known state:
+     *  - Paging enabled
+     *  - Alignment check disabled
+     *  - Write protect disabled
+     *  - No task switch
+     *  - Don't do FP software emulation.
+     *  - Proctected mode enabled
+     */
+    movq    %cr0, %rax
+    andq    $~(X86_CR0_AM | X86_CR0_WP | X86_CR0_TS | X86_CR0_EM), %rax
+    orl        $(X86_CR0_PG | X86_CR0_PE), %eax
+    movq    %rax, %cr0
+
+    /*
+     * Set cr4 to a known state:
+     *  - physical address extension enabled
+     *  - 5-level paging, if it was enabled before
+     */
+    movl    $X86_CR4_PAE, %eax
+    testq    $X86_CR4_LA57, %r13
+    jz    1f
+    orl    $X86_CR4_LA57, %eax
+1:
+    movq    %rax, %cr4
+
+    jmp 1f
+1:
+
+    mov    %rdx, %rdi
+    mov    %rsi, %rax
+    jmp    *%rax
+
+    ret    /* never */
+SYM_CODE_END(park_cpu)
+
  SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
      UNWIND_HINT_EMPTY
      /* set return address to 0 if not preserving context */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84f581c91db4..dfe854c1ecf8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -195,6 +195,70 @@ static inline void __init copy_edd(void)
  }
  #endif

+#ifdef CONFIG_X86_CPU_PARK
+/* Physical address of reserved park memory. */
+unsigned long park_start;
+/* Virtual address of reserved park memory. */
+unsigned long park_start_virt;
+/* park reserve mem len should be PAGE_SIZE * NR_CPUS */
+unsigned long park_len = PARK_SECTION_SIZE;
+bool cpu_park_enable;
+int boot_core_sibling;
+
+static int __init parse_boot_core_sibling(char *p)
+{
+    if (!p)
+        return 0;
+    get_option(&p, &boot_core_sibling);
+    return 0;
+}
+early_param("bootcoresibling", parse_boot_core_sibling);
+
+static int __init parse_park_mem(char *p)
+{
+    if (!p)
+        return 0;
+
+    park_start = PAGE_ALIGN(memparse(p, NULL));
+    if (park_start == 0)
+        pr_info("cpu park mem params[%s]", p);
+
+    return 0;
+}
+early_param("cpuparkmem", parse_park_mem);
+
+static int __init reserve_park_mem(void)
+{
+    if (park_start == 0 || park_len == 0)
+        return 0;
+
+    park_start = PAGE_ALIGN(park_start);
+    park_len = PAGE_ALIGN(park_len);
+
+    if (!memblock_is_region_memory(park_start, park_len)) {
+        pr_warn("cannot reserve park mem: region is not memory!\n");
+        goto out;
+    }
+
+    if (memblock_is_region_reserved(park_start, park_len)) {
+        pr_warn("cannot reserve park mem: region overlaps reserved 
memory!\n");
+        goto out;
+    }
+
+    memblock_reserve(park_start, park_len);
+    pr_info("cpu park mem reserved: 0x%016lx - 0x%016lx (%ld KB)\n",
+        park_start, park_start + park_len, park_len >> 10);
+
+    cpu_park_enable = true;
+    return 0;
+out:
+    park_start = 0;
+    park_len = 0;
+    cpu_park_enable = false;
+    return -EINVAL;
+}
+#endif
+
  void * __init extend_brk(size_t size, size_t align)
  {
      size_t mask = align - 1;
@@ -1154,6 +1218,9 @@ void __init setup_arch(char **cmdline_p)
       * won't consume hotpluggable memory.
       */
      reserve_crashkernel();
+#ifdef CONFIG_X86_CPU_PARK
+    reserve_park_mem();
+#endif

      memblock_find_dma_reserve();

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index eff4ce3b10da..19297fd5cdc2 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -34,6 +34,10 @@
  #include <asm/kexec.h>
  #include <asm/virtext.h>

+#ifdef CONFIG_X86_CPU_PARK
+#include <linux/kexec.h>
+#include <asm/realmode.h>
+#endif
  /*
   *    Some notes on x86 processor bugs affecting SMP operation:
   *
@@ -128,6 +132,91 @@ static int smp_stop_nmi_callback(unsigned int val, 
struct pt_regs *regs)
      return NMI_HANDLED;
  }

+#ifdef CONFIG_X86_CPU_PARK
+/*
+ * Write the secondary_entry to exit section of park state.
+ * Then the secondary cpu will jump straight into the kernel
+ * by the secondary_entry.
+ */
+int write_park_exit(unsigned int cpu)
+{
+    struct cpu_park_section *park_section;
+    unsigned long *park_exit;
+    unsigned long *park_magic;
+
+    if (!cpu_park_enable)
+        return  -EPERM;
+
+    park_section = cpu_park_section_virt();
+    park_exit = cpu_park_exit_addr(park_section, cpu);
+    park_magic = cpu_park_magic_addr(park_section, cpu);
+
+    /*
+     * Test first 8 bytes to determine
+     * whether needs to write cpu park exit.
+     */
+    if (*park_magic == PARK_MAGIC) {
+        cpumask_clear_cpu(cpu, cpu_initialized_mask);
+        smp_mb();
+
+        *park_exit = real_mode_header->park_startup_32;
+        pr_info("park cpu %d up", cpu);
+        return 0;
+    }
+    pr_info("normal cpu %d up", cpu);
+    return -EPERM;
+}
+
+/* Install cpu park sections for the specific cpu. */
+int install_cpu_park(void)
+{
+    struct cpu_park_section *park_section;
+    unsigned long park_text_len;
+
+    park_section = cpu_park_section_virt();
+    memset((void *)park_section, 0, PARK_SECTION_SIZE);
+
+    park_text_len = PAGE_SIZE;
+    memcpy((void *)park_section->text, __do_cpu_park, park_text_len);
+
+    return 0;
+}
+
+int uninstall_cpu_park(void)
+{
+    struct cpu_park_section *park_section;
+
+    if (!cpu_park_enable)
+        return -EPERM;
+
+    park_section = cpu_park_section_virt();
+    memset((void *)park_section, 0, PARK_SECTION_SIZE);
+    pr_info("clear park area 0x%lx - 0x%lx", (unsigned 
long)cpu_park_section_phy(),
+                    (unsigned long)cpu_park_section_phy() + 
PARK_SECTION_SIZE);
+
+    return 0;
+}
+
+void cpu_park(unsigned int cpu)
+{
+    struct cpu_park_section *park_section_p;
+    unsigned long park_exit_phy;
+    unsigned long do_park;
+    unsigned long pgd;
+
+    park_section_p = cpu_park_section_phy();
+    park_exit_phy = (unsigned long)cpu_park_exit_addr(park_section_p, cpu);
+    do_park = (unsigned long)&park_section_p->text;
+    pgd = (unsigned 
long)__pa(page_address(kexec_image->control_code_page));
+
+    hw_breakpoint_disable();
+
+    park_cpu(pgd, do_park, park_exit_phy);
+
+    unreachable();
+}
+#endif
+
  /*
   * this function calls the 'stop' function on all other CPUs in the 
system.
   */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2e6046..4d8f7ac9f9ed 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,10 @@
  #include <asm/hw_irq.h>
  #include <asm/stackprotector.h>

+#ifdef CONFIG_X86_CPU_PARK
+#include <linux/kexec.h>
+#endif
+
  /* representing HT siblings of each logical CPU */
  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
  EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
@@ -1048,6 +1052,13 @@ static int do_boot_cpu(int apicid, int cpu, 
struct task_struct *idle,
       * the targeted processor.
       */

+#ifdef CONFIG_X86_CPU_PARK
+    if (cpu != boot_core_sibling && write_park_exit(cpu) == 0) {
+        cpumask_set_cpu(cpu, cpu_callout_mask);
+        goto unpark;
+    }
+#endif
+
      if (x86_platform.legacy.warm_reset) {

          pr_debug("Setting warm reset code and vector.\n");
@@ -1102,6 +1113,9 @@ static int do_boot_cpu(int apicid, int cpu, struct 
task_struct *idle,
          }
      }

+#ifdef CONFIG_X86_CPU_PARK
+unpark:
+#endif
      if (!boot_error) {
          /*
           * Wait till AP completes initial initialization
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 8c1db5bf5d78..8c786c13a7e0 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -36,6 +36,9 @@ SYM_DATA_START(real_mode_header)
  #ifdef CONFIG_X86_64
      .long    __KERNEL32_CS
  #endif
+#ifdef CONFIG_X86_CPU_PARK
+    .long    pa_park_startup_32
+#endif
  SYM_DATA_END(real_mode_header)

      /* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S 
b/arch/x86/realmode/rm/trampoline_64.S
index 84c5d1b33d10..2f25d414844b 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -161,6 +161,11 @@ SYM_CODE_START(startup_32)
      ljmpl    $__KERNEL_CS, $pa_startup_64
  SYM_CODE_END(startup_32)

+SYM_CODE_START(park_startup_32)
+    movl    $rm_stack_end, %esp
+    jmp    startup_32
+SYM_CODE_END(park_startup_32)
+
      .section ".text64","ax"
      .code64
      .balign 4
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d17501433be..fc0b9c488618 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -23,6 +23,9 @@
  #include <linux/sched/clock.h>
  #include <linux/nmi.h>
  #include <linux/sched/debug.h>
+#ifdef CONFIG_X86_CPU_PARK
+#include <linux/kexec.h>
+#endif

  #include "smpboot.h"
  #include "sched/smp.h"
@@ -817,6 +820,9 @@ void __init smp_init(void)

      /* Any cleanup work */
      smp_cpus_done(setup_max_cpus);
+#ifdef CONFIG_X86_CPU_PARK
+    uninstall_cpu_park();
+#endif
  }

  /*
-- 
2.23.0


