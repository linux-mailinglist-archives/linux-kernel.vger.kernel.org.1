Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C289723B6C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgHDIaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 04:30:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42634 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgHDIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:30:13 -0400
Date:   Tue, 04 Aug 2020 08:21:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596529805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A7uQkkytEL8ThgG0ky81jqJWVYktUcjgEeyNh5FlR2g=;
        b=0C1OFQB2DnavbOIC9GeeWGkcaXsVWJHfMvtjYW7So89IWpBvvPkT6Lt5p+b6aNrWptJtKk
        rLYS1HST/MoMOks/VDovOcM9JX+Dn7pMnz8cHiQSsEl+mrfRkvfnglmcuWdiC0EbZNxEvq
        BqoiT9WdzNpVYF9X/h7q8om1pKm/S0eTplqeeX2Lm4zf5CuoCexpyRvO94n76G+xnT7QDk
        YlnfiY90wqUnoK3CE1NoD5F+wYlv2O+/Gjz9muWpRaoA8Dh2pKDml+R39Dl3W9ZVYAcM87
        GJl1ndnmiecPAd3pPhj/bRS2cxQSRL/7x3kpVLmmWD+QPsovpa9iTyT7N3GVZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596529805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A7uQkkytEL8ThgG0ky81jqJWVYktUcjgEeyNh5FlR2g=;
        b=HSI8/3LXNOFDwx8T9ynwNSE19BjRR16QQ07O6ofLcclqfWWz11+u7KOk0MwVxMf6tv759x
        vpZYywKudnptbtDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT pull] x86/fsgsbase for v5.9
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
Message-ID: <159652931824.11821.3260830552527703172.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/fsgsbase branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fsgsbase-2020-08-04

up to:  d029bff60aa6: x86/fsgsbase: Fix Xen PV support

Support for FSGSBASE. Almost 5 years after the first RFC to support it,
this has been brought into a shape which is maintainable and actually
works.

This final version was done by Sasha Levin who took it up after Intel
dropped the ball. Sasha discovered that the SGX (sic!) offerings out there
ship rogue kernel modules enabling FSGSBASE behind the kernels back which
opens an instantanious unpriviledged root hole.

The FSGSBASE instructions provide a considerable speedup of the context
switch path and enable user space to write GSBASE without kernel
interaction. This enablement requires careful handling of the exception
entries which go through the paranoid entry path as they cannot longer rely
on the assumption that user GSBASE is positive (as enforced via prctl() on
non FSGSBASE enabled systemn). All other entries (syscalls, interrupts and
exceptions) can still just utilize SWAPGS unconditionally when the entry
comes from user space. Converting these entries to use FSGSBASE has no
benefit as SWAPGS is only marginally slower than WRGSBASE and locating and
retrieving the kernel GSBASE value is not a free operation either. The real
benefit of RD/WRGSBASE is the avoidance of the MSR reads and writes.

The changes come with appropriate selftests and have held up in field
testing against the (sanitized) Graphene-SGX driver.

Thanks,

	tglx

------------------>
Andi Kleen (2):
      x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
      x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

Andy Lutomirski (8):
      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
      x86/process/64: Use FSBSBASE in switch_to() if available
      x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit
      selftests/x86: Add a syscall_arg_fault_64 test for negative GSBASE
      selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test
      selftests/x86/fsgsbase: Add a missing memory constraint
      x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase
      x86/fsgsbase: Fix Xen PV support

Chang S. Bae (8):
      x86/ptrace: Prevent ptrace from clearing the FS/GS selector
      x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
      x86/process/64: Use FSGSBASE instructions on thread copy and ptrace
      x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
      x86/entry/64: Introduce the FIND_PERCPU_BASE macro
      x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
      selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base write
      selftests/x86/fsgsbase: Test ptracer-induced GS base write with FSGSBASE

Thomas Gleixner (2):
      x86/process/64: Make save_fsgs_for_kvm() ready for FSGSBASE
      Documentation/x86/64: Add documentation for GS/FS addressing mode

Tony Luck (1):
      x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation


 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/x86/x86_64/fsgs.rst               | 199 +++++++++++++++++++
 Documentation/x86/x86_64/index.rst              |   1 +
 arch/x86/entry/calling.h                        |  40 ++++
 arch/x86/entry/entry_64.S                       | 139 ++++++++++----
 arch/x86/include/asm/fsgsbase.h                 |  47 ++++-
 arch/x86/include/asm/inst.h                     |  15 ++
 arch/x86/include/asm/processor.h                |   6 +-
 arch/x86/include/uapi/asm/hwcap2.h              |   3 +
 arch/x86/kernel/cpu/bugs.c                      |   6 +-
 arch/x86/kernel/cpu/common.c                    |  22 +++
 arch/x86/kernel/process.c                       |  10 +-
 arch/x86/kernel/process_64.c                    | 139 ++++++++++++--
 arch/x86/kernel/ptrace.c                        |  60 +++---
 arch/x86/kvm/vmx/vmx.c                          |   2 +-
 tools/testing/selftests/x86/Makefile            |   2 +-
 tools/testing/selftests/x86/fsgsbase.c          |  28 ++-
 tools/testing/selftests/x86/fsgsbase_restore.c  | 245 ++++++++++++++++++++++++
 tools/testing/selftests/x86/syscall_arg_fault.c |  26 +++
 19 files changed, 888 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/x86/x86_64/fsgs.rst
 create mode 100644 tools/testing/selftests/x86/fsgsbase_restore.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..8c0d045f1dc7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3079,6 +3079,8 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/x86/x86_64/fsgs.rst
new file mode 100644
index 000000000000..50960e09e1f6
--- /dev/null
+++ b/Documentation/x86/x86_64/fsgs.rst
@@ -0,0 +1,199 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Using FS and GS segments in user space applications
+===================================================
+
+The x86 architecture supports segmentation. Instructions which access
+memory can use segment register based addressing mode. The following
+notation is used to address a byte within a segment:
+
+  Segment-register:Byte-address
+
+The segment base address is added to the Byte-address to compute the
+resulting virtual address which is accessed. This allows to access multiple
+instances of data with the identical Byte-address, i.e. the same code. The
+selection of a particular instance is purely based on the base-address in
+the segment register.
+
+In 32-bit mode the CPU provides 6 segments, which also support segment
+limits. The limits can be used to enforce address space protections.
+
+In 64-bit mode the CS/SS/DS/ES segments are ignored and the base address is
+always 0 to provide a full 64bit address space. The FS and GS segments are
+still functional in 64-bit mode.
+
+Common FS and GS usage
+------------------------------
+
+The FS segment is commonly used to address Thread Local Storage (TLS). FS
+is usually managed by runtime code or a threading library. Variables
+declared with the '__thread' storage class specifier are instantiated per
+thread and the compiler emits the FS: address prefix for accesses to these
+variables. Each thread has its own FS base address so common code can be
+used without complex address offset calculations to access the per thread
+instances. Applications should not use FS for other purposes when they use
+runtimes or threading libraries which manage the per thread FS.
+
+The GS segment has no common use and can be used freely by
+applications. GCC and Clang support GS based addressing via address space
+identifiers.
+
+Reading and writing the FS/GS base address
+------------------------------------------
+
+There exist two mechanisms to read and write the FS/GS base address:
+
+ - the arch_prctl() system call
+
+ - the FSGSBASE instruction family
+
+Accessing FS/GS base with arch_prctl()
+--------------------------------------
+
+ The arch_prctl(2) based mechanism is available on all 64-bit CPUs and all
+ kernel versions.
+
+ Reading the base:
+
+   arch_prctl(ARCH_GET_FS, &fsbase);
+   arch_prctl(ARCH_GET_GS, &gsbase);
+
+ Writing the base:
+
+   arch_prctl(ARCH_SET_FS, fsbase);
+   arch_prctl(ARCH_SET_GS, gsbase);
+
+ The ARCH_SET_GS prctl may be disabled depending on kernel configuration
+ and security settings.
+
+Accessing FS/GS base with the FSGSBASE instructions
+---------------------------------------------------
+
+ With the Ivy Bridge CPU generation Intel introduced a new set of
+ instructions to access the FS and GS base registers directly from user
+ space. These instructions are also supported on AMD Family 17H CPUs. The
+ following instructions are available:
+
+  =============== ===========================
+  RDFSBASE %reg   Read the FS base register
+  RDGSBASE %reg   Read the GS base register
+  WRFSBASE %reg   Write the FS base register
+  WRGSBASE %reg   Write the GS base register
+  =============== ===========================
+
+ The instructions avoid the overhead of the arch_prctl() syscall and allow
+ more flexible usage of the FS/GS addressing modes in user space
+ applications. This does not prevent conflicts between threading libraries
+ and runtimes which utilize FS and applications which want to use it for
+ their own purpose.
+
+FSGSBASE instructions enablement
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ The instructions are enumerated in CPUID leaf 7, bit 0 of EBX. If
+ available /proc/cpuinfo shows 'fsgsbase' in the flag entry of the CPUs.
+
+ The availability of the instructions does not enable them
+ automatically. The kernel has to enable them explicitly in CR4. The
+ reason for this is that older kernels make assumptions about the values in
+ the GS register and enforce them when GS base is set via
+ arch_prctl(). Allowing user space to write arbitrary values to GS base
+ would violate these assumptions and cause malfunction.
+
+ On kernels which do not enable FSGSBASE the execution of the FSGSBASE
+ instructions will fault with a #UD exception.
+
+ The kernel provides reliable information about the enabled state in the
+ ELF AUX vector. If the HWCAP2_FSGSBASE bit is set in the AUX vector, the
+ kernel has FSGSBASE instructions enabled and applications can use them.
+ The following code example shows how this detection works::
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+
+   /* Will be eventually in asm/hwcap.h */
+   #ifndef HWCAP2_FSGSBASE
+   #define HWCAP2_FSGSBASE        (1 << 1)
+   #endif
+
+   ....
+
+   unsigned val = getauxval(AT_HWCAP2);
+
+   if (val & HWCAP2_FSGSBASE)
+        printf("FSGSBASE enabled\n");
+
+FSGSBASE instructions compiler support
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
+instructions. Clang 5 supports them as well.
+
+  =================== ===========================
+  _readfsbase_u64()   Read the FS base register
+  _readfsbase_u64()   Read the GS base register
+  _writefsbase_u64()  Write the FS base register
+  _writegsbase_u64()  Write the GS base register
+  =================== ===========================
+
+To utilize these instrinsics <immintrin.h> must be included in the source
+code and the compiler option -mfsgsbase has to be added.
+
+Compiler support for FS/GS based addressing
+-------------------------------------------
+
+GCC version 6 and newer provide support for FS/GS based addressing via
+Named Address Spaces. GCC implements the following address space
+identifiers for x86:
+
+  ========= ====================================
+  __seg_fs  Variable is addressed relative to FS
+  __seg_gs  Variable is addressed relative to GS
+  ========= ====================================
+
+The preprocessor symbols __SEG_FS and __SEG_GS are defined when these
+address spaces are supported. Code which implements fallback modes should
+check whether these symbols are defined. Usage example::
+
+  #ifdef __SEG_GS
+
+  long data0 = 0;
+  long data1 = 1;
+
+  long __seg_gs *ptr;
+
+  /* Check whether FSGSBASE is enabled by the kernel (HWCAP2_FSGSBASE) */
+  ....
+
+  /* Set GS base to point to data0 */
+  _writegsbase_u64(&data0);
+
+  /* Access offset 0 of GS */
+  ptr = 0;
+  printf("data0 = %ld\n", *ptr);
+
+  /* Set GS base to point to data1 */
+  _writegsbase_u64(&data1);
+  /* ptr still addresses offset 0! */
+  printf("data1 = %ld\n", *ptr);
+
+
+Clang does not provide the GCC address space identifiers, but it provides
+address spaces via an attribute based mechanism in Clang 2.6 and newer
+versions:
+
+ ==================================== =====================================
+  __attribute__((address_space(256))  Variable is addressed relative to GS
+  __attribute__((address_space(257))  Variable is addressed relative to FS
+ ==================================== =====================================
+
+FS/GS based addressing with inline assembly
+-------------------------------------------
+
+In case the compiler does not support address spaces, inline assembly can
+be used for FS/GS based addressing mode::
+
+	mov %fs:offset, %reg
+	mov %gs:offset, %reg
+
+	mov %reg, %fs:offset
+	mov %reg, %gs:offset
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index d6eaaa5a35fc..a56070fc8e77 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -14,3 +14,4 @@ x86_64 Support
    fake-numa-for-cpusets
    cpu-hotplug-spec
    machinecheck
+   fsgs
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 4208c1e3f601..98e4d8886f11 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/inst.h>
 
 /*
 
@@ -341,6 +342,12 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
+.macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
+	rdgsbase \save_reg
+	GET_PERCPU_BASE \scratch_reg
+	wrgsbase \scratch_reg
+.endm
+
 #else /* CONFIG_X86_64 */
 # undef		UNWIND_HINT_IRET_REGS
 # define	UNWIND_HINT_IRET_REGS
@@ -351,3 +358,36 @@ For 32-bit we have the following conventions - kernel is built with
 	call stackleak_erase
 #endif
 .endm
+
+#ifdef CONFIG_SMP
+
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ */
+.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
+	movq	$__CPUNODE_SEG, \reg
+	lsl	\reg, \reg
+.endm
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+.macro GET_PERCPU_BASE reg:req
+	ALTERNATIVE \
+		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
+		"RDPID	\reg", \
+		X86_FEATURE_RDPID
+	andq	$VDSO_CPUNODE_MASK, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+#else
+
+.macro GET_PERCPU_BASE reg:req
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d2a00c97e53f..fb729f4c4fbc 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/frame.h>
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -426,10 +427,7 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS-ORIG_RAX(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
+	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 
 	UNWIND_HINT_REGS
@@ -458,10 +456,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
+	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
@@ -798,24 +793,21 @@ SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs. Return GSBASE related information
+ * in EBX depending on the availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        GSBASE value at entry, must be restored in paranoid_exit
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	movl	$1, %ebx
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	1f				/* negative -> in kernel */
-	SWAPGS
-	xorl	%ebx, %ebx
 
-1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
 	 * verbatim, at exit.  Needed if paranoid_entry interrupted
@@ -825,9 +817,51 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/*
+	 * Handling GSBASE depends on the availability of FSGSBASE.
+	 *
+	 * Without FSGSBASE the kernel enforces that negative GSBASE
+	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
+	 * can be made about the GSBASE value when entering from user
+	 * space.
+	 */
+	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/*
+	 * Read the current GSBASE and store it in %rbx unconditionally,
+	 * retrieve and set the current CPUs kernel GSBASE. The stored value
+	 * has to be restored in paranoid_exit unconditionally.
+	 *
+	 * The MSR write ensures that no subsequent load is based on a
+	 * mispredicted GSBASE. No extra FENCE required.
+	 */
+	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
+	ret
+
+.Lparanoid_entry_checkgs:
+	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	movl	$1, %ebx
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
+	 */
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	testl	%edx, %edx
+	jns	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_swapgs:
+	SWAPGS
+
 	/*
 	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
 	 * unconditional CR3 write, even in the PTI case.  So do an lfence
@@ -835,6 +869,8 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 */
 	FENCE_SWAPGS_KERNEL_ENTRY
 
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
@@ -845,23 +881,45 @@ SYM_CODE_END(paranoid_entry)
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, we there's no good reason
- * to try to handle preemption here.
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ *
+ * R/EBX contains the GSBASE related information depending on the
+ * availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
-	testl	%ebx, %ebx			/* swapgs needed? */
-	jnz	.Lparanoid_exit_no_swapgs
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+	/*
+	 * The order of operations is important. RESTORE_CR3 requires
+	 * kernel GSBASE.
+	 *
+	 * NB to anyone to try to optimize this code: this code does
+	 * not execute at all for exceptions from user mode. Those
+	 * exceptions go through error_exit instead.
+	 */
+	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+
+	/* Handle the three GSBASE cases */
+	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/* With FSGSBASE enabled, unconditionally restore GSBASE */
+	wrgsbase	%rbx
+	jmp		restore_regs_and_return_to_kernel
+
+.Lparanoid_exit_checkgs:
+	/* On non-FSGSBASE systems, conditionally do SWAPGS */
+	testl		%ebx, %ebx
+	jnz		restore_regs_and_return_to_kernel
+
+	/* We are returning to a context with user GSBASE */
 	SWAPGS_UNSAFE_STACK
-	jmp	restore_regs_and_return_to_kernel
-.Lparanoid_exit_no_swapgs:
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-	jmp restore_regs_and_return_to_kernel
+	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
 /*
@@ -1266,10 +1324,27 @@ end_repeat_nmi:
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/*
+	 * The above invocation of paranoid_entry stored the GSBASE
+	 * related information in R/EBX depending on the availability
+	 * of FSGSBASE.
+	 *
+	 * If FSGSBASE is enabled, restore the saved GSBASE value
+	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 */
+	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
+
+	wrgsbase	%rbx
+	jmp	nmi_restore
+
+nmi_no_fsgsbase:
+	/* EBX == 0 -> invoke SWAPGS */
+	testl	%ebx, %ebx
 	jnz	nmi_restore
+
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
+
 nmi_restore:
 	POP_REGS
 
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index bca4c743de77..d552646411a9 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -19,36 +19,65 @@ extern unsigned long x86_gsbase_read_task(struct task_struct *task);
 extern void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
 extern void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
-/* Helper functions for reading/writing FS/GS base */
+/* Must be protected by X86_FEATURE_FSGSBASE check. */
 
-static inline unsigned long x86_fsbase_read_cpu(void)
+static __always_inline unsigned long rdfsbase(void)
 {
 	unsigned long fsbase;
 
-	rdmsrl(MSR_FS_BASE, fsbase);
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
 
 	return fsbase;
 }
 
-static inline unsigned long x86_gsbase_read_cpu_inactive(void)
+static __always_inline unsigned long rdgsbase(void)
 {
 	unsigned long gsbase;
 
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
 
 	return gsbase;
 }
 
-static inline void x86_fsbase_write_cpu(unsigned long fsbase)
+static __always_inline void wrfsbase(unsigned long fsbase)
 {
-	wrmsrl(MSR_FS_BASE, fsbase);
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
 }
 
-static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+static __always_inline void wrgsbase(unsigned long gsbase)
 {
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
+#include <asm/cpufeature.h>
+
+/* Helper functions for reading/writing FS/GS base */
+
+static inline unsigned long x86_fsbase_read_cpu(void)
+{
+	unsigned long fsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		fsbase = rdfsbase();
+	else
+		rdmsrl(MSR_FS_BASE, fsbase);
+
+	return fsbase;
+}
+
+static inline void x86_fsbase_write_cpu(unsigned long fsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		wrfsbase(fsbase);
+	else
+		wrmsrl(MSR_FS_BASE, fsbase);
+}
+
+extern unsigned long x86_gsbase_read_cpu_inactive(void);
+extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
+extern unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+					    unsigned short selector);
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index f5a796da07f8..d063841a17e3 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -306,6 +306,21 @@
 	.endif
 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
 	.endm
+
+.macro RDPID opd
+	REG_TYPE rdpid_opd_type \opd
+	.if rdpid_opd_type == REG_TYPE_R64
+	R64_NUM rdpid_opd \opd
+	.else
+	R32_NUM rdpid_opd \opd
+	.endif
+	.byte 0xf3
+	.if rdpid_opd > 7
+	PFX_REX rdpid_opd 0
+	.endif
+	.byte 0x0f, 0xc7
+	MODRM 0xc0 rdpid_opd 0x7
+.endm
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 42cd333616c4..7c2ecdf7e064 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -457,10 +457,8 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
-#if IS_ENABLED(CONFIG_KVM)
 /* Save actual FS/GS selectors and bases to current->thread */
-void save_fsgs_for_kvm(void);
-#endif
+void current_save_fsgs(void);
 #else	/* X86_64 */
 #ifdef CONFIG_STACKPROTECTOR
 /*
@@ -575,7 +573,7 @@ native_load_sp0(unsigned long sp0)
 	this_cpu_write(cpu_tss_rw.x86_tss.sp0, sp0);
 }
 
-static inline void native_swapgs(void)
+static __always_inline void native_swapgs(void)
 {
 #ifdef CONFIG_X86_64
 	asm volatile("swapgs" ::: "memory");
diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 8b2effe6efb8..5fdfcb47000f 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -5,4 +5,7 @@
 /* MONITOR/MWAIT enabled in Ring 3 */
 #define HWCAP2_RING3MWAIT		(1 << 0)
 
+/* Kernel allows FSGSBASE instructions available in Ring 3 */
+#define HWCAP2_FSGSBASE			BIT(1)
+
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b71970d2d3d..5ea5fbd76ad0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -543,14 +543,12 @@ static void __init spectre_v1_select_mitigation(void)
 		 * If FSGSBASE is enabled, the user can put a kernel address in
 		 * GS, in which case SMAP provides no protection.
 		 *
-		 * [ NOTE: Don't check for X86_FEATURE_FSGSBASE until the
-		 *	   FSGSBASE enablement patches have been merged. ]
-		 *
 		 * If FSGSBASE is disabled, the user can only put a user space
 		 * address in GS.  That makes an attack harder, but still
 		 * possible if there's no SMAP protection.
 		 */
-		if (!smap_works_speculatively()) {
+		if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
+		    !smap_works_speculatively()) {
 			/*
 			 * Mitigation can be provided from SWAPGS itself or
 			 * PTI as the CR3 write in the Meltdown mitigation
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 043d93cdcaad..fca56129ddc7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -441,6 +441,22 @@ static void __init setup_cr_pinning(void)
 	static_key_enable(&cr_pinning.key);
 }
 
+static __init int x86_nofsgsbase_setup(char *arg)
+{
+	/* Require an exact match without trailing characters. */
+	if (strlen(arg))
+		return 0;
+
+	/* Do not emit a message if the feature is not present. */
+	if (!boot_cpu_has(X86_FEATURE_FSGSBASE))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+	pr_info("FSGSBASE disabled via kernel command line\n");
+	return 1;
+}
+__setup("nofsgsbase", x86_nofsgsbase_setup);
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1495,6 +1511,12 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smap(c);
 	setup_umip(c);
 
+	/* Enable FSGSBASE instructions if available. */
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
+		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
+
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f362ce0d5ac0..216c88df1919 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -140,10 +140,12 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
+	current_save_fsgs();
+	p->thread.fsindex = current->thread.fsindex;
+	p->thread.fsbase = current->thread.fsbase;
+	p->thread.gsindex = current->thread.gsindex;
+	p->thread.gsbase = current->thread.gsbase;
+
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
 #else
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9a97415b2139..e14476f0c533 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -149,6 +149,56 @@ enum which_selector {
 	GS
 };
 
+/*
+ * Out of line to be protected from kprobes and tracing. If this would be
+ * traced or probed than any access to a per CPU variable happens with
+ * the wrong GS.
+ *
+ * It is not used on Xen paravirt. When paravirt support is needed, it
+ * needs to be renamed with native_ prefix.
+ */
+static noinstr unsigned long __rdgsbase_inactive(void)
+{
+	unsigned long gsbase;
+
+	lockdep_assert_irqs_disabled();
+
+	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+		native_swapgs();
+		gsbase = rdgsbase();
+		native_swapgs();
+	} else {
+		instrumentation_begin();
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		instrumentation_end();
+	}
+
+	return gsbase;
+}
+
+/*
+ * Out of line to be protected from kprobes and tracing. If this would be
+ * traced or probed than any access to a per CPU variable happens with
+ * the wrong GS.
+ *
+ * It is not used on Xen paravirt. When paravirt support is needed, it
+ * needs to be renamed with native_ prefix.
+ */
+static noinstr void __wrgsbase_inactive(unsigned long gsbase)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+		native_swapgs();
+		wrgsbase(gsbase);
+		native_swapgs();
+	} else {
+		instrumentation_begin();
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+		instrumentation_end();
+	}
+}
+
 /*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
@@ -198,22 +248,35 @@ static __always_inline void save_fsgs(struct task_struct *task)
 {
 	savesegment(fs, task->thread.fsindex);
 	savesegment(gs, task->thread.gsindex);
-	save_base_legacy(task, task->thread.fsindex, FS);
-	save_base_legacy(task, task->thread.gsindex, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * If FSGSBASE is enabled, we can't make any useful guesses
+		 * about the base, and user code expects us to save the current
+		 * value.  Fortunately, reading the base directly is efficient.
+		 */
+		task->thread.fsbase = rdfsbase();
+		task->thread.gsbase = __rdgsbase_inactive();
+	} else {
+		save_base_legacy(task, task->thread.fsindex, FS);
+		save_base_legacy(task, task->thread.gsindex, GS);
+	}
 }
 
-#if IS_ENABLED(CONFIG_KVM)
 /*
  * While a process is running,current->thread.fsbase and current->thread.gsbase
- * may not match the corresponding CPU registers (see save_base_legacy()). KVM
- * wants an efficient way to save and restore FSBASE and GSBASE.
- * When FSGSBASE extensions are enabled, this will have to use RD{FS,GS}BASE.
+ * may not match the corresponding CPU registers (see save_base_legacy()).
  */
-void save_fsgs_for_kvm(void)
+void current_save_fsgs(void)
 {
+	unsigned long flags;
+
+	/* Interrupts need to be off for FSGSBASE */
+	local_irq_save(flags);
 	save_fsgs(current);
+	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(save_fsgs_for_kvm);
+#if IS_ENABLED(CONFIG_KVM)
+EXPORT_SYMBOL_GPL(current_save_fsgs);
 #endif
 
 static __always_inline void loadseg(enum which_selector which,
@@ -278,14 +341,26 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
-	load_seg_legacy(prev->fsindex, prev->fsbase,
-			next->fsindex, next->fsbase, FS);
-	load_seg_legacy(prev->gsindex, prev->gsbase,
-			next->gsindex, next->gsbase, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/* Update the FS and GS selectors if they could have changed. */
+		if (unlikely(prev->fsindex || next->fsindex))
+			loadseg(FS, next->fsindex);
+		if (unlikely(prev->gsindex || next->gsindex))
+			loadseg(GS, next->gsindex);
+
+		/* Update the bases. */
+		wrfsbase(next->fsbase);
+		__wrgsbase_inactive(next->gsbase);
+	} else {
+		load_seg_legacy(prev->fsindex, prev->fsbase,
+				next->fsindex, next->fsbase, FS);
+		load_seg_legacy(prev->gsindex, prev->gsbase,
+				next->gsindex, next->gsbase, GS);
+	}
 }
 
-static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-					    unsigned short selector)
+unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+				     unsigned short selector)
 {
 	unsigned short idx = selector >> 3;
 	unsigned long base;
@@ -327,13 +402,44 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		gsbase = __rdgsbase_inactive();
+		local_irq_restore(flags);
+	} else {
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		__wrgsbase_inactive(gsbase);
+		local_irq_restore(flags);
+	} else {
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -347,7 +453,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 44130588987f..3f006489087f 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -281,17 +281,9 @@ static int set_segment_reg(struct task_struct *task,
 		return -EIO;
 
 	/*
-	 * This function has some ABI oddities.
-	 *
-	 * A 32-bit ptracer probably expects that writing FS or GS will change
-	 * FSBASE or GSBASE respectively.  In the absence of FSGSBASE support,
-	 * this code indeed has that effect.  When FSGSBASE is added, this
-	 * will require a special case.
-	 *
-	 * For existing 64-bit ptracers, writing FS or GS *also* currently
-	 * changes the base if the selector is nonzero the next time the task
-	 * is run.  This behavior may not be needed, and trying to preserve it
-	 * when FSGSBASE is added would be complicated at best.
+	 * Writes to FS and GS will change the stored selector.  Whether
+	 * this changes the segment base as well depends on whether
+	 * FSGSBASE is enabled.
 	 */
 
 	switch (offset) {
@@ -379,25 +371,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 *
-		 * NB: This behavior is nonsensical and likely needs to
-		 * change when FSGSBASE support is added.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
@@ -880,14 +859,39 @@ long arch_ptrace(struct task_struct *child, long request,
 static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 {
 	struct pt_regs *regs = task_pt_regs(child);
+	int ret;
 
 	switch (regno) {
 
 	SEG32(cs);
 	SEG32(ds);
 	SEG32(es);
-	SEG32(fs);
-	SEG32(gs);
+
+	/*
+	 * A 32-bit ptracer on a 64-bit kernel expects that writing
+	 * FS or GS will also update the base.  This is needed for
+	 * operations like PTRACE_SETREGS to fully restore a saved
+	 * CPU state.
+	 */
+
+	case offsetof(struct user32, regs.fs):
+		ret = set_segment_reg(child,
+				      offsetof(struct user_regs_struct, fs),
+				      value);
+		if (ret == 0)
+			child->thread.fsbase =
+				x86_fsgsbase_read_task(child, value);
+		return ret;
+
+	case offsetof(struct user32, regs.gs):
+		ret = set_segment_reg(child,
+				      offsetof(struct user_regs_struct, gs),
+				      value);
+		if (ret == 0)
+			child->thread.gsbase =
+				x86_fsgsbase_read_task(child, value);
+		return ret;
+
 	SEG32(ss);
 
 	R32(ebx, bx);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 36c771728c8c..ccd5b7bb617c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1172,7 +1172,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 
 	gs_base = cpu_kernelmode_gs_base(cpu);
 	if (likely(is_64bit_mm(current->mm))) {
-		save_fsgs_for_kvm();
+		current_save_fsgs();
 		fs_sel = current->thread.fsindex;
 		gs_sel = current->thread.gsindex;
 		fs_base = current->thread.fsbase;
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5f16821c7f63..3ff94575d02d 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault
+			syscall_arg_fault fsgsbase_restore
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 15a329da59fa..998319553523 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -285,7 +285,8 @@ static unsigned short load_gs(void)
 		/* 32-bit set_thread_area */
 		long ret;
 		asm volatile ("int $0x80"
-			      : "=a" (ret) : "a" (243), "b" (low_desc)
+			      : "=a" (ret), "+m" (*low_desc)
+			      : "a" (243), "b" (low_desc)
 			      : "r8", "r9", "r10", "r11");
 		memcpy(&desc, low_desc, sizeof(desc));
 		munmap(low_desc, sizeof(desc));
@@ -489,11 +490,28 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs == 0 && base == 0xFF) {
-			printf("[OK]\tGS was reset as expected\n");
-		} else {
+		if (gs != *shared_scratch) {
 			nerrs++;
-			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
+			printf("[FAIL]\tGS changed to %lx\n", gs);
+
+			/*
+			 * On older kernels, poking a nonzero value into the
+			 * base would zero the selector.  On newer kernels,
+			 * this behavior has changed -- poking the base
+			 * changes only the base and, if FSGSBASE is not
+			 * available, this may have no effect once the tracee
+			 * is resumed.
+			 */
+			if (gs == 0)
+				printf("\tNote: this is expected behavior on older kernels.\n");
+		} else if (have_fsgsbase && (base != 0xFF)) {
+			nerrs++;
+			printf("[FAIL]\tGSBASE changed to %lx\n", base);
+		} else {
+			printf("[OK]\tGS remained 0x%hx", *shared_scratch);
+			if (have_fsgsbase)
+				printf(" and GSBASE changed to 0xFF");
+			printf("\n");
 		}
 	}
 
diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
new file mode 100644
index 000000000000..6fffadc51579
--- /dev/null
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * fsgsbase_restore.c, test ptrace vs fsgsbase
+ * Copyright (c) 2020 Andy Lutomirski
+ *
+ * This test case simulates a tracer redirecting tracee execution to
+ * a function and then restoring tracee state using PTRACE_GETREGS and
+ * PTRACE_SETREGS.  This is similar to what gdb does when doing
+ * 'p func()'.  The catch is that this test has the called function
+ * modify a segment register.  This makes sure that ptrace correctly
+ * restores segment state when using PTRACE_SETREGS.
+ *
+ * This is not part of fsgsbase.c, because that test is 64-bit only.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <err.h>
+#include <sys/user.h>
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+#include <asm/ldt.h>
+#include <sys/mman.h>
+#include <stddef.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
+#include <stdint.h>
+
+#define EXPECTED_VALUE 0x1337f00d
+
+#ifdef __x86_64__
+# define SEG "%gs"
+#else
+# define SEG "%fs"
+#endif
+
+static unsigned int dereference_seg_base(void)
+{
+	int ret;
+	asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
+	return ret;
+}
+
+static void init_seg(void)
+{
+	unsigned int *target = mmap(
+		NULL, sizeof(unsigned int),
+		PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
+	if (target == MAP_FAILED)
+		err(1, "mmap");
+
+	*target = EXPECTED_VALUE;
+
+	printf("\tsegment base address = 0x%lx\n", (unsigned long)target);
+
+	struct user_desc desc = {
+		.entry_number    = 0,
+		.base_addr       = (unsigned int)(uintptr_t)target,
+		.limit           = sizeof(unsigned int) - 1,
+		.seg_32bit       = 1,
+		.contents        = 0, /* Data, grow-up */
+		.read_exec_only  = 0,
+		.limit_in_pages  = 0,
+		.seg_not_present = 0,
+		.useable         = 0
+	};
+	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
+		printf("\tusing LDT slot 0\n");
+		asm volatile ("mov %0, %" SEG :: "rm" ((unsigned short)0x7));
+	} else {
+		/* No modify_ldt for us (configured out, perhaps) */
+
+		struct user_desc *low_desc = mmap(
+			NULL, sizeof(desc),
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
+		memcpy(low_desc, &desc, sizeof(desc));
+
+		low_desc->entry_number = -1;
+
+		/* 32-bit set_thread_area */
+		long ret;
+		asm volatile ("int $0x80"
+			      : "=a" (ret), "+m" (*low_desc)
+			      : "a" (243), "b" (low_desc)
+#ifdef __x86_64__
+			      : "r8", "r9", "r10", "r11"
+#endif
+			);
+		memcpy(&desc, low_desc, sizeof(desc));
+		munmap(low_desc, sizeof(desc));
+
+		if (ret != 0) {
+			printf("[NOTE]\tcould not create a segment -- can't test anything\n");
+			exit(0);
+		}
+		printf("\tusing GDT slot %d\n", desc.entry_number);
+
+		unsigned short sel = (unsigned short)((desc.entry_number << 3) | 0x3);
+		asm volatile ("mov %0, %" SEG :: "rm" (sel));
+	}
+}
+
+static void tracee_zap_segment(void)
+{
+	/*
+	 * The tracer will redirect execution here.  This is meant to
+	 * work like gdb's 'p func()' feature.  The tricky bit is that
+	 * we modify a segment register in order to make sure that ptrace
+	 * can correctly restore segment registers.
+	 */
+	printf("\tTracee: in tracee_zap_segment()\n");
+
+	/*
+	 * Write a nonzero selector with base zero to the segment register.
+	 * Using a null selector would defeat the test on AMD pre-Zen2
+	 * CPUs, as such CPUs don't clear the base when loading a null
+	 * selector.
+	 */
+	unsigned short sel;
+	asm volatile ("mov %%ss, %0\n\t"
+		      "mov %0, %" SEG
+		      : "=rm" (sel));
+
+	pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
+	printf("\tTracee is going back to sleep\n");
+	syscall(SYS_tgkill, pid, tid, SIGSTOP);
+
+	/* Should not get here. */
+	while (true) {
+		printf("[FAIL]\tTracee hit unreachable code\n");
+		pause();
+	}
+}
+
+int main()
+{
+	printf("\tSetting up a segment\n");
+	init_seg();
+
+	unsigned int val = dereference_seg_base();
+	if (val != EXPECTED_VALUE) {
+		printf("[FAIL]\tseg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
+		return 1;
+	}
+	printf("[OK]\tThe segment points to the right place.\n");
+
+	pid_t chld = fork();
+	if (chld < 0)
+		err(1, "fork");
+
+	if (chld == 0) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0, 0);
+
+		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
+		printf("\tTracee will take a nap until signaled\n");
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
+
+		printf("\tTracee was resumed.  Will re-check segment.\n");
+
+		val = dereference_seg_base();
+		if (val != EXPECTED_VALUE) {
+			printf("[FAIL]\tseg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
+			exit(1);
+		}
+
+		printf("[OK]\tThe segment points to the right place.\n");
+		exit(0);
+	}
+
+	int status;
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
+		err(1, "waitpid");
+
+	struct user_regs_struct regs;
+
+	if (ptrace(PTRACE_GETREGS, chld, NULL, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+
+#ifdef __x86_64__
+	printf("\tChild GS=0x%lx, GSBASE=0x%lx\n", (unsigned long)regs.gs, (unsigned long)regs.gs_base);
+#else
+	printf("\tChild FS=0x%lx\n", (unsigned long)regs.xfs);
+#endif
+
+	struct user_regs_struct regs2 = regs;
+#ifdef __x86_64__
+	regs2.rip = (unsigned long)tracee_zap_segment;
+	regs2.rsp -= 128;	/* Don't clobber the redzone. */
+#else
+	regs2.eip = (unsigned long)tracee_zap_segment;
+#endif
+
+	printf("\tTracer: redirecting tracee to tracee_zap_segment()\n");
+	if (ptrace(PTRACE_SETREGS, chld, NULL, &regs2) != 0)
+		err(1, "PTRACE_GETREGS");
+	if (ptrace(PTRACE_CONT, chld, NULL, NULL) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
+		err(1, "waitpid");
+
+	printf("\tTracer: restoring tracee state\n");
+	if (ptrace(PTRACE_SETREGS, chld, NULL, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+	if (ptrace(PTRACE_DETACH, chld, NULL, NULL) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld)
+		err(1, "waitpid");
+
+	if (WIFSIGNALED(status)) {
+		printf("[FAIL]\tTracee crashed\n");
+		return 1;
+	}
+
+	if (!WIFEXITED(status)) {
+		printf("[FAIL]\tTracee stopped for an unexpected reason: %d\n", status);
+		return 1;
+	}
+
+	int exitcode = WEXITSTATUS(status);
+	if (exitcode != 0) {
+		printf("[FAIL]\tTracee reported failure\n");
+		return 1;
+	}
+
+	printf("[OK]\tAll is well.\n");
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bc0ecc2e862e..62fba40866d5 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -72,6 +72,7 @@ static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 	if (ax != -EFAULT && ax != -ENOSYS) {
 		printf("[FAIL]\tAX had the wrong value: 0x%lx\n",
 		       (unsigned long)ax);
+		printf("\tIP = 0x%lx\n", (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
 		n_errs++;
 	} else {
 		printf("[OK]\tSeems okay\n");
@@ -226,5 +227,30 @@ int main()
 	}
 	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 
+#ifdef __x86_64__
+	printf("[RUN]\tSYSENTER with TF, invalid state, and GSBASE < 0\n");
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sigtrap_consecutive_syscalls = 0;
+
+		asm volatile ("wrgsbase %%rax\n\t"
+			      :: "a" (0xffffffffffff0000UL));
+
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		asm volatile (
+			"movl $-1, %%eax\n\t"
+			"movl $-1, %%ebx\n\t"
+			"movl $-1, %%ecx\n\t"
+			"movl $-1, %%edx\n\t"
+			"movl $-1, %%esi\n\t"
+			"movl $-1, %%edi\n\t"
+			"movl $-1, %%ebp\n\t"
+			"movl $-1, %%esp\n\t"
+			"sysenter"
+			: : : "memory", "flags");
+	}
+	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
+#endif
+
 	return 0;
 }

