Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D120D2DA197
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503282AbgLNU1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:27:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503161AbgLNU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:18 -0500
Date:   Mon, 14 Dec 2020 20:22:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lE9unREjxu2Q8KPhIGyaUCniw0m3T1p/SJl8bglPJ68=;
        b=REjyaRDXnE0H0fSneUlihK8KL8ecRfhUSUeESs+JkwselOo2L9gxlf0aVdGv+xi9eS26V+
        C9st1WMG3UoavwUGft+HfLaymQkvGcAR95/FMs+OzGbxbImLxzKcJ6aDXjGg9v7otm8aKt
        XKx02jqvYdoW1OPxm8Tchnpx0+RQbQZdBNfrXUyZ3pe6PqcWxv/TVPTUhPPEVoZoPzIPuq
        i/UCOg8jOTafeoSDHK4K6sACQtjCsJz0EBuhnG+aS3cTN++G4+BNIXwE0yt5AqpXf+t4w8
        3875apERWOhgVudioPkpOGgDe5C0IoZS/Z190MYXaNNDrQNLnSYGWex18HTxtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lE9unREjxu2Q8KPhIGyaUCniw0m3T1p/SJl8bglPJ68=;
        b=6K5rXVXhmnBfNvDUx1K7z79FG0xx169WU3fY/xWTwLg+IPyJPGyFx7yB42BiiAmZJ3by2S
        5gFc1X5+v417UIBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for v5.11-rc1
Message-ID: <160797732939.10793.9152151866806316627.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2020-12-14

up to:  c6156e1da633: entry: Add syscall_exit_to_user_mode_work()


A set of updates for entry/exit handling:

 - More generalization of entry/exit functionality

 - The consolidation work to reclaim TIF flags on x86 and also for non-x86
   specific TIF flags which are solely relevant for syscall related work
   and have been moved into their own storage space. The x86 specific part
   had to be merged in to avoid a major conflict.

 - The TIF_NOTIFY_SIGNAL work which replaces the inefficient signal
   delivery mode of task work and results in an impressive performance
   improvement for io_uring. The non-x86 consolidation of this is going to
   come seperate via Jens.

 - The selective syscall redirection facility which provides a clean and
   efficient way to support the non-Linux syscalls of WINE by catching them
   at syscall entry and redirecting them to the user space emulation. This
   can be utilized for other purposes as well and has been designed
   carefully to avoid overhead for the regular fastpath. This includes the
   core changes and the x86 support code.

 - Simplification of the context tracking entry/exit handling for the users
   of the generic entry code which guarantee the proper ordering and
   protection.

 - Preparatory changes to make the generic entry code accomodate S390
   specific requirements which are mostly related to their syscall restart
   mechanism.

Thanks,

	tglx

------------------>
Frederic Weisbecker (5):
      context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
      context_tracking: Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
      sched: Detect call to schedule from critical entry code
      context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
      x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK

Gabriel Krisman Bertazi (28):
      perf/x86: Avoid TIF_IA32 when checking 64bit mode
      x86/compat: Simplify compat syscall userspace allocation
      x86/oprofile: Avoid TIF_IA32 when checking 64bit mode
      x86/elf: Use e_machine to choose DLINFO in compat
      elf: Expose ELF header in compat_start_thread()
      x86/elf: Use e_machine to select start_thread for x32
      elf: Expose ELF header on arch_setup_additional_pages()
      x86/elf: Use e_machine to check for x32/ia32 in setup_additional_pages()
      x86/mm: Convert mmu context ia32_compat into a proper flags field
      x86: Reclaim TIF_IA32 and TIF_X32
      x86: Expose syscall_work field in thread_info
      entry: Expose helpers to migrate TIF to SYSCALL_WORK flags
      entry: Wire up syscall_work in common entry code
      seccomp: Migrate to use SYSCALL_WORK flag
      tracepoints: Migrate to use SYSCALL_WORK flag
      ptrace: Migrate to use SYSCALL_TRACE flag
      ptrace: Migrate TIF_SYSCALL_EMU to use SYSCALL_WORK flag
      audit: Migrate to use SYSCALL_WORK flag
      entry: Drop usage of TIF flags in the generic syscall code
      x86: Reclaim unused x86 TI flags
      entry: Fix boot for !CONFIG_GENERIC_ENTRY
      x86: vdso: Expose sigreturn address on vdso to the kernel
      signal: Expose SYS_USER_DISPATCH si_code type
      kernel: Implement selective syscall userspace redirection
      entry: Support Syscall User Dispatch on common syscall entry
      selftests: Add kselftest for syscall user dispatch
      selftests: Add benchmark for syscall user dispatch
      docs: Document Syscall User Dispatch

Ira Weiny (2):
      entry: Fixup irqentry_enter() comment
      entry: Fix spelling/typo errors in irq entry code

Jens Axboe (4):
      signal: Add task_sigpending() helper
      entry: Add support for TIF_NOTIFY_SIGNAL
      task_work: Use TIF_NOTIFY_SIGNAL if available
      x86: Wire up TIF_NOTIFY_SIGNAL

Sven Schnelle (5):
      entry: Rename enter_from_user_mode()
      entry: Rename exit_to_user_mode()
      entry_Add_enter_from_user_mode_wrapper
      entry: Add exit_to_user_mode() wrapper
      entry: Add syscall_exit_to_user_mode_work()

Thomas Gleixner (2):
      x86/entry: Move nmi entry/exit into common code
      MAINTAINERS: Add entry for common entry code


 Documentation/admin-guide/index.rst                |   1 +
 .../admin-guide/syscall-user-dispatch.rst          |  90 ++++++
 MAINTAINERS                                        |  11 +
 arch/Kconfig                                       |  17 ++
 arch/x86/Kconfig                                   |   1 +
 arch/x86/entry/common.c                            |  34 ---
 arch/x86/entry/vdso/vdso2c.c                       |   2 +
 arch/x86/entry/vdso/vdso32/sigreturn.S             |   2 +
 arch/x86/entry/vdso/vma.c                          |  19 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |   2 +-
 arch/x86/events/core.c                             |   2 +-
 arch/x86/events/intel/ds.c                         |   2 +-
 arch/x86/events/intel/lbr.c                        |   2 +-
 arch/x86/include/asm/compat.h                      |  15 +-
 arch/x86/include/asm/elf.h                         |  15 +-
 arch/x86/include/asm/idtentry.h                    |   3 -
 arch/x86/include/asm/mmu.h                         |   9 +-
 arch/x86/include/asm/mmu_context.h                 |   2 +-
 arch/x86/include/asm/thread_info.h                 |  17 +-
 arch/x86/include/asm/vdso.h                        |   2 +
 arch/x86/kernel/cpu/mce/core.c                     |   6 +-
 arch/x86/kernel/nmi.c                              |   6 +-
 arch/x86/kernel/perf_regs.c                        |   2 +-
 arch/x86/kernel/process_64.c                       |  28 +-
 arch/x86/kernel/signal.c                           |   4 +-
 arch/x86/kernel/signal_compat.c                    |   2 +-
 arch/x86/kernel/traps.c                            |  13 +-
 arch/x86/oprofile/backtrace.c                      |   2 +-
 fs/binfmt_elf.c                                    |   4 +-
 fs/compat_binfmt_elf.c                             |  20 +-
 fs/exec.c                                          |   3 +
 include/asm-generic/syscall.h                      |  24 +-
 include/linux/context_tracking.h                   |   6 +-
 include/linux/elf.h                                |  10 +
 include/linux/entry-common.h                       | 171 +++++++++---
 include/linux/entry-kvm.h                          |   4 +-
 include/linux/sched.h                              |   2 +
 include/linux/sched/signal.h                       |  20 +-
 include/linux/seccomp.h                            |   2 +-
 include/linux/syscall_user_dispatch.h              |  40 +++
 include/linux/thread_info.h                        |  50 ++++
 include/linux/tracehook.h                          |  44 ++-
 include/trace/syscall.h                            |   6 +-
 include/uapi/asm-generic/siginfo.h                 |   3 +-
 include/uapi/linux/prctl.h                         |   5 +
 kernel/auditsc.c                                   |   4 +-
 kernel/entry/Makefile                              |   2 +-
 kernel/entry/common.c                              | 188 +++++++++----
 kernel/entry/common.h                              |   7 +
 kernel/entry/kvm.c                                 |   3 +
 kernel/entry/syscall_user_dispatch.c               | 104 +++++++
 kernel/events/uprobes.c                            |   2 +-
 kernel/fork.c                                      |   9 +-
 kernel/ptrace.c                                    |  16 +-
 kernel/sched/core.c                                |   3 +-
 kernel/seccomp.c                                   |   6 +-
 kernel/signal.c                                    |  22 +-
 kernel/sys.c                                       |   5 +
 kernel/task_work.c                                 |  41 ++-
 kernel/trace/trace_events.c                        |   8 +-
 kernel/tracepoint.c                                |   4 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/syscall_user_dispatch/.gitignore     |   3 +
 .../selftests/syscall_user_dispatch/Makefile       |   9 +
 .../testing/selftests/syscall_user_dispatch/config |   1 +
 .../syscall_user_dispatch/sud_benchmark.c          | 200 +++++++++++++
 .../selftests/syscall_user_dispatch/sud_test.c     | 310 +++++++++++++++++++++
 67 files changed, 1391 insertions(+), 282 deletions(-)
 create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/entry/common.h
 create mode 100644 kernel/entry/syscall_user_dispatch.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/sud_test.c

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 4e0c4ae44acd..b29d3c127a95 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -111,6 +111,7 @@ configure specific aspects of kernel behavior to your liking.
    rtc
    serial-console
    svga
+   syscall-user-dispatch
    sysrq
    thunderbolt
    ufs
diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
new file mode 100644
index 000000000000..a380d6515774
--- /dev/null
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Syscall User Dispatch
+=====================
+
+Background
+----------
+
+Compatibility layers like Wine need a way to efficiently emulate system
+calls of only a part of their process - the part that has the
+incompatible code - while being able to execute native syscalls without
+a high performance penalty on the native part of the process.  Seccomp
+falls short on this task, since it has limited support to efficiently
+filter syscalls based on memory regions, and it doesn't support removing
+filters.  Therefore a new mechanism is necessary.
+
+Syscall User Dispatch brings the filtering of the syscall dispatcher
+address back to userspace.  The application is in control of a flip
+switch, indicating the current personality of the process.  A
+multiple-personality application can then flip the switch without
+invoking the kernel, when crossing the compatibility layer API
+boundaries, to enable/disable the syscall redirection and execute
+syscalls directly (disabled) or send them to be emulated in userspace
+through a SIGSYS.
+
+The goal of this design is to provide very quick compatibility layer
+boundary crosses, which is achieved by not executing a syscall to change
+personality every time the compatibility layer executes.  Instead, a
+userspace memory region exposed to the kernel indicates the current
+personality, and the application simply modifies that variable to
+configure the mechanism.
+
+There is a relatively high cost associated with handling signals on most
+architectures, like x86, but at least for Wine, syscalls issued by
+native Windows code are currently not known to be a performance problem,
+since they are quite rare, at least for modern gaming applications.
+
+Since this mechanism is designed to capture syscalls issued by
+non-native applications, it must function on syscalls whose invocation
+ABI is completely unexpected to Linux.  Syscall User Dispatch, therefore
+doesn't rely on any of the syscall ABI to make the filtering.  It uses
+only the syscall dispatcher address and the userspace key.
+
+As the ABI of these intercepted syscalls is unknown to Linux, these
+syscalls are not instrumentable via ptrace or the syscall tracepoints.
+
+Interface
+---------
+
+A thread can setup this mechanism on supported kernels by executing the
+following prctl:
+
+  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
+
+<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
+disable the mechanism globally for that thread.  When
+PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
+
+[<offset>, <offset>+<length>) delimit a memory region interval
+from which syscalls are always executed directly, regardless of the
+userspace selector.  This provides a fast path for the C library, which
+includes the most common syscall dispatchers in the native code
+applications, and also provides a way for the signal handler to return
+without triggering a nested SIGSYS on (rt\_)sigreturn.  Users of this
+interface should make sure that at least the signal trampoline code is
+included in this region. In addition, for syscalls that implement the
+trampoline code on the vDSO, that trampoline is never intercepted.
+
+[selector] is a pointer to a char-sized region in the process memory
+region, that provides a quick way to enable disable syscall redirection
+thread-wide, without the need to invoke the kernel directly.  selector
+can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
+value should terminate the program with a SIGSYS.
+
+Security Notes
+--------------
+
+Syscall User Dispatch provides functionality for compatibility layers to
+quickly capture system calls issued by a non-native part of the
+application, while not impacting the Linux native regions of the
+process.  It is not a mechanism for sandboxing system calls, and it
+should not be seen as a security mechanism, since it is trivial for a
+malicious application to subvert the mechanism by jumping to an allowed
+dispatcher region prior to executing the syscall, or to discover the
+address and modify the selector value.  If the use case requires any
+kind of security sandboxing, Seccomp should be used instead.
+
+Any fork or exec of the existing process resets the mechanism to
+PR_SYS_DISPATCH_OFF.
diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..a35248b05fa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7333,6 +7333,17 @@ S:	Maintained
 F:	drivers/base/arch_topology.c
 F:	include/linux/arch_topology.h
 
+GENERIC ENTRY CODE
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Andy Lutomirski <luto@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
+F:	include/linux/entry-common.h
+F:	include/linux/entry-kvm.h
+F:	kernel/entry/
+
 GENERIC GPIO I2C DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 S:	Supported
diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..090ef3566c56 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -618,6 +618,23 @@ config HAVE_CONTEXT_TRACKING
 	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
+config HAVE_CONTEXT_TRACKING_OFFSTACK
+	bool
+	help
+	  Architecture neither relies on exception_enter()/exception_exit()
+	  nor on schedule_user(). Also preempt_schedule_notrace() and
+	  preempt_schedule_irq() can't be called in a preemptible section
+	  while context tracking is CONTEXT_USER. This feature reflects a sane
+	  entry implementation where the following requirements are met on
+	  critical entry code, ie: before user_exit() or after user_enter():
+
+	  - Critical entry code isn't preemptible (or better yet:
+	    not interruptible).
+	  - No use of RCU read side critical sections, unless rcu_nmi_enter()
+	    got called.
+	  - No use of instrumentation, unless instrumentation_begin() got
+	    called.
+
 config HAVE_TIF_NOHZ
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..d793361839b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -162,6 +162,7 @@ config X86
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
+	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 870efeec8bda..18d8f17f755c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -209,40 +209,6 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
-{
-	bool irq_state = lockdep_hardirqs_enabled();
-
-	__nmi_enter();
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	lockdep_hardirq_enter();
-	rcu_nmi_enter();
-
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	ftrace_nmi_enter();
-	instrumentation_end();
-
-	return irq_state;
-}
-
-noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
-{
-	instrumentation_begin();
-	ftrace_nmi_exit();
-	if (restore) {
-		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	}
-	instrumentation_end();
-
-	rcu_nmi_exit();
-	lockdep_hardirq_exit();
-	if (restore)
-		lockdep_hardirqs_on(CALLER_ADDR0);
-	__nmi_exit();
-}
-
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 7380908045c7..2d0f3d8bcc25 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -101,6 +101,8 @@ struct vdso_sym required_syms[] = {
 	{"__kernel_sigreturn", true},
 	{"__kernel_rt_sigreturn", true},
 	{"int80_landing_pad", true},
+	{"vdso32_rt_sigreturn_landing_pad", true},
+	{"vdso32_sigreturn_landing_pad", true},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vdso32/sigreturn.S
index c3233ee98a6b..1bd068f72d4c 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -18,6 +18,7 @@ __kernel_sigreturn:
 	movl $__NR_sigreturn, %eax
 	SYSCALL_ENTER_KERNEL
 .LEND_sigreturn:
+SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
 	.size __kernel_sigreturn,.-.LSTART_sigreturn
 
@@ -29,6 +30,7 @@ __kernel_rt_sigreturn:
 	movl $__NR_rt_sigreturn, %eax
 	SYSCALL_ENTER_KERNEL
 .LEND_rt_sigreturn:
+SYM_INNER_LABEL(vdso32_rt_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
 	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
 	.previous
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..de60cd37070b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -413,10 +413,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
+				       int uses_interp, bool x32)
 {
 #ifdef CONFIG_X86_X32_ABI
-	if (test_thread_flag(TIF_X32)) {
+	if (x32) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso_randomized(&vdso_image_x32);
@@ -436,6 +436,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 }
 #endif
 
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+	const struct vdso_image *image = current->mm->context.vdso_image;
+	unsigned long vdso = (unsigned long) current->mm->context.vdso;
+
+	if (in_ia32_syscall() && image == &vdso_image_32) {
+		if (regs->ip == vdso + image->sym_vdso32_sigreturn_landing_pad ||
+		    regs->ip == vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
+			return true;
+	}
+#endif
+	return false;
+}
+
 #ifdef CONFIG_X86_64
 static __init int vdso_setup(char *s)
 {
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..1b40b9297083 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -316,7 +316,7 @@ static struct vm_area_struct gate_vma __ro_after_init = {
 struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 #ifdef CONFIG_COMPAT
-	if (!mm || mm->context.ia32_compat)
+	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
 		return NULL;
 #endif
 	if (vsyscall_mode == NONE)
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a88c94d65693..77b963e5e70a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2602,7 +2602,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
 
-	if (!test_thread_flag(TIF_IA32))
+	if (user_64bit_mode(regs))
 		return 0;
 
 	cs_base = get_segment_base(regs->cs);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315df1e16..99a59f38a4e2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1259,7 +1259,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		old_to = to;
 
 #ifdef CONFIG_X86_64
-		is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
+		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
 		insn_get_length(&insn);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..1aadb253d296 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1221,7 +1221,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	 * on 64-bit systems running 32-bit apps
 	 */
 #ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
+	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
 	insn_get_opcode(&insn);
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 0e327a01f50f..f145e3326c6d 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -177,14 +177,13 @@ typedef struct user_regs_struct compat_elf_gregset_t;
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
-	compat_uptr_t sp;
-
-	if (test_thread_flag(TIF_IA32)) {
-		sp = task_pt_regs(current)->sp;
-	} else {
-		/* -128 for the x32 ABI redzone */
-		sp = task_pt_regs(current)->sp - 128;
-	}
+	compat_uptr_t sp = task_pt_regs(current)->sp;
+
+	/*
+	 * -128 for the x32 ABI redzone.  For IA32, it is not strictly
+	 * necessary, but not harmful.
+	 */
+	sp -= 128;
 
 	return (void __user *)round_down(sp - len, 16);
 }
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d488f1a5..66bdfe838d61 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -186,8 +186,9 @@ static inline void elf_common_init(struct thread_struct *t,
 #define	COMPAT_ELF_PLAT_INIT(regs, load_addr)		\
 	elf_common_init(&current->thread, regs, __USER_DS)
 
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp);
-#define compat_start_thread compat_start_thread
+void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32);
+#define COMPAT_START_THREAD(ex, regs, new_ip, new_sp)	\
+	compat_start_thread(regs, new_ip, new_sp, ex->e_machine == EM_X86_64)
 
 void set_personality_ia32(bool);
 #define COMPAT_SET_PERSONALITY(ex)			\
@@ -361,7 +362,7 @@ do {									\
 #define AT_SYSINFO		32
 
 #define COMPAT_ARCH_DLINFO						\
-if (test_thread_flag(TIF_X32))						\
+if (exec->e_machine == EM_X86_64)					\
 	ARCH_DLINFO_X32;						\
 else									\
 	ARCH_DLINFO_IA32
@@ -382,8 +383,12 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp);
-#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
+					      int uses_interp, bool x32);
+#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter)	\
+	compat_arch_setup_additional_pages(bprm, interpreter,		\
+					   (ex->e_machine == EM_X86_64))
+
+extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b2442eb0ac2f..247a60a47331 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,9 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-bool idtentry_enter_nmi(struct pt_regs *regs);
-void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
-
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 9257667d13c5..5d7494631ea9 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -6,6 +6,12 @@
 #include <linux/rwsem.h>
 #include <linux/mutex.h>
 #include <linux/atomic.h>
+#include <linux/bits.h>
+
+/* Uprobes on this MM assume 32-bit code */
+#define MM_CONTEXT_UPROBE_IA32	BIT(0)
+/* vsyscall page is accessible on this MM */
+#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
@@ -33,8 +39,7 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_X86_64
-	/* True if mm supports a task running in 32 bit compatibility mode. */
-	unsigned short ia32_compat;
+	unsigned short flags;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index d98016b83755..054a79157323 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -177,7 +177,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.ia32_compat == TIF_IA32);
+		!(mm->context.flags & MM_CONTEXT_UPROBE_IA32);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 44733a4bfc42..0d751d5da702 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -55,6 +55,7 @@ struct task_struct;
 
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	u32			status;		/* thread synchronous flags */
 };
 
@@ -74,15 +75,11 @@ struct thread_info {
  * - these are process state flags that various assembly files
  *   may need to access
  */
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
-#define TIF_SYSCALL_EMU		6	/* syscall emulation active */
-#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
-#define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -91,7 +88,7 @@ struct thread_info {
 #define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_IA32		17	/* IA32 compatibility process */
+#define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -99,19 +96,13 @@ struct thread_info {
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
-#define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-#define TIF_X32			30	/* 32-bit native x86-64 binary */
 
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
-#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
@@ -120,16 +111,14 @@ struct thread_info {
 #define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_IA32		(1 << TIF_IA32)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
-#define _TIF_X32		(1 << TIF_X32)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index bbcdc7b8f963..589f489dd375 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -27,6 +27,8 @@ struct vdso_image {
 	long sym___kernel_rt_sigreturn;
 	long sym___kernel_vsyscall;
 	long sym_int80_landing_pad;
+	long sym_vdso32_sigreturn_landing_pad;
+	long sym_vdso32_rt_sigreturn_landing_pad;
 };
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..f5c860b1a50b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1983,7 +1983,7 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
-	bool irq_state;
+	irqentry_state_t irq_state;
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -1995,7 +1995,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	    mce_check_crashing_cpu())
 		return;
 
-	irq_state = idtentry_enter_nmi(regs);
+	irq_state = irqentry_nmi_enter(regs);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -2006,7 +2006,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bc77aaf1303..bf250a339655 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -475,7 +475,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
-	bool irq_state;
+	irqentry_state_t irq_state;
 
 	/*
 	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
@@ -502,14 +502,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	irq_state = idtentry_enter_nmi(regs);
+	irq_state = irqentry_nmi_enter(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e1132290b..9332c49a64a8 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -123,7 +123,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (test_tsk_thread_flag(task, TIF_IA32))
+	if (!user_64bit_mode(task_pt_regs(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index df342bedea88..ad582f9ac5a6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -511,11 +511,10 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
+void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
 {
 	start_thread_common(regs, new_ip, new_sp,
-			    test_thread_flag(TIF_X32)
-			    ? __USER_CS : __USER32_CS,
+			    x32 ? __USER_CS : __USER32_CS,
 			    __USER_DS, __USER_DS);
 }
 #endif
@@ -641,16 +640,12 @@ void set_personality_64bit(void)
 	/* inherit personality from parent */
 
 	/* Make sure to be in 64bit mode */
-	clear_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_ADDR32);
-	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
-
-	/* Ensure the corresponding mm is not marked. */
 	if (current->mm)
-		current->mm->context.ia32_compat = 0;
+		current->mm->context.flags = MM_CONTEXT_HAS_VSYSCALL;
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -662,10 +657,9 @@ void set_personality_64bit(void)
 static void __set_personality_x32(void)
 {
 #ifdef CONFIG_X86_X32
-	clear_thread_flag(TIF_IA32);
-	set_thread_flag(TIF_X32);
 	if (current->mm)
-		current->mm->context.ia32_compat = TIF_X32;
+		current->mm->context.flags = 0;
+
 	current->personality &= ~READ_IMPLIES_EXEC;
 	/*
 	 * in_32bit_syscall() uses the presence of the x32 syscall bit
@@ -683,10 +677,14 @@ static void __set_personality_x32(void)
 static void __set_personality_ia32(void)
 {
 #ifdef CONFIG_IA32_EMULATION
-	set_thread_flag(TIF_IA32);
-	clear_thread_flag(TIF_X32);
-	if (current->mm)
-		current->mm->context.ia32_compat = TIF_IA32;
+	if (current->mm) {
+		/*
+		 * uprobes applied to this MM need to know this and
+		 * cannot use user_64bit_mode() at that time.
+		 */
+		current->mm->context.flags = MM_CONTEXT_UPROBE_IA32;
+	}
+
 	current->personality |= force_personality32;
 	/* Prepare the first "return" to user space */
 	task_pt_regs(current)->orig_ax = __NR_ia32_execve;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index be0d7d4152ec..ea794a083c44 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -804,11 +804,11 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void arch_do_signal(struct pt_regs *regs)
+void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 {
 	struct ksignal ksig;
 
-	if (get_signal(&ksig)) {
+	if (has_signal && get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
 		return;
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a7f3e12cfbdb..d7b51870f16b 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -31,7 +31,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
-	BUILD_BUG_ON(NSIGSYS  != 1);
+	BUILD_BUG_ON(NSIGSYS  != 2);
 
 	/* This is part of the ABI and can never change in size: */
 	BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e19df6cde35d..e1b78829d909 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -405,7 +405,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	idtentry_enter_nmi(regs);
+	irqentry_nmi_enter(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -651,12 +651,13 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		bool irq_state = idtentry_enter_nmi(regs);
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
 		instrumentation_begin();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
-		idtentry_exit_nmi(regs, irq_state);
+		irqentry_nmi_exit(regs, irq_state);
 	}
 }
 
@@ -851,7 +852,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * includes the entry stack is excluded for everything.
 	 */
 	unsigned long dr7 = local_db_save();
-	bool irq_state = idtentry_enter_nmi(regs);
+	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -908,7 +909,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 		regs->flags &= ~X86_EFLAGS_TF;
 out:
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 
 	local_db_restore(dr7);
 }
@@ -926,7 +927,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 
 	/*
 	 * NB: We can't easily clear DR7 here because
-	 * idtentry_exit_to_usermode() can invoke ptrace, schedule, access
+	 * irqentry_exit_to_usermode() can invoke ptrace, schedule, access
 	 * user memory, etc.  This means that a recursive #DB is possible.  If
 	 * this happens, that #DB will hit exc_debug_kernel() and clear DR7.
 	 * Since we're not on the IST stack right now, everything will be
diff --git a/arch/x86/oprofile/backtrace.c b/arch/x86/oprofile/backtrace.c
index a2488b6e27d6..1d8391fcca68 100644
--- a/arch/x86/oprofile/backtrace.c
+++ b/arch/x86/oprofile/backtrace.c
@@ -49,7 +49,7 @@ x86_backtrace_32(struct pt_regs * const regs, unsigned int depth)
 	struct stack_frame_ia32 *head;
 
 	/* User process is IA32 */
-	if (!current || !test_thread_flag(TIF_IA32))
+	if (!current || user_64bit_mode(regs))
 		return 0;
 
 	head = (struct stack_frame_ia32 *) regs->bp;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fa50e8936f5f..ac0b5fc30ea6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1246,7 +1246,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = arch_setup_additional_pages(bprm, !!interpreter);
+	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
 	if (retval < 0)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
@@ -1307,7 +1307,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 #endif
 
 	finalize_exec(bprm);
-	start_thread(regs, elf_entry, bprm->p);
+	START_THREAD(elf_ex, regs, elf_entry, bprm->p);
 	retval = 0;
 out:
 	return retval;
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 2d24c765cbd7..2c557229696a 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -106,15 +106,25 @@
 #endif
 
 #ifdef	compat_start_thread
-#undef	start_thread
-#define	start_thread		compat_start_thread
+#define COMPAT_START_THREAD(ex, regs, new_ip, new_sp)	\
+	compat_start_thread(regs, new_ip, new_sp)
 #endif
 
-#ifdef	compat_arch_setup_additional_pages
+#ifdef	COMPAT_START_THREAD
+#undef	START_THREAD
+#define START_THREAD		COMPAT_START_THREAD
+#endif
+
+#ifdef compat_arch_setup_additional_pages
+#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
+	compat_arch_setup_additional_pages(bprm, interpreter)
+#endif
+
+#ifdef	COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
 #undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-#undef	arch_setup_additional_pages
-#define	arch_setup_additional_pages compat_arch_setup_additional_pages
+#undef	ARCH_SETUP_ADDITIONAL_PAGES
+#define	ARCH_SETUP_ADDITIONAL_PAGES COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
 #endif
 
 #ifdef	compat_elf_read_implies_exec
diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..aee36e5733ce 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -64,6 +64,7 @@
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1302,6 +1303,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
+	clear_syscall_work_syscall_user_dispatch(me);
+
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
 	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index f3135e734387..524218ae3825 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -43,9 +43,9 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  * @regs:	task_pt_regs() of @task
  *
  * It's only valid to call this when @task is stopped for system
- * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
- * after tracehook_report_syscall_entry() returned nonzero to prevent
- * the system call from taking place.
+ * call exit tracing (due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT), after tracehook_report_syscall_entry()
+ * returned nonzero to prevent the system call from taking place.
  *
  * This rolls back the register state in @regs so it's as if the
  * system call instruction was a no-op.  The registers containing
@@ -63,7 +63,8 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
  * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
 
@@ -76,7 +77,8 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
  * This value is meaningless if syscall_get_error() returned nonzero.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
 
@@ -93,7 +95,8 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
  * code; the user sees a failed system call with this errno code.
  *
  * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * from a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 			      int error, long val);
@@ -108,7 +111,8 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 *  @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned long *args);
@@ -123,7 +127,8 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * The first argument gets value @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_AUDIT.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 			   const unsigned long *args);
@@ -135,7 +140,8 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
+ * call, due to %SYSCALL_WORK_SYSCALL_TRACE, %SYSCALL_WORK_SYSCALL_AUDIT, or
+ * %SYSCALL_WORK_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d53cd331c4dd..bceb06498521 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -51,7 +51,8 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (!context_tracking_enabled())
+	if (IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) ||
+	    !context_tracking_enabled())
 		return 0;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
@@ -63,7 +64,8 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (context_tracking_enabled()) {
+	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
+	    context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			context_tracking_enter(prev_ctx);
 	}
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 5d5b0321da0b..c9a46c4e183b 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -22,6 +22,16 @@
 	SET_PERSONALITY(ex)
 #endif
 
+#ifndef START_THREAD
+#define START_THREAD(elf_ex, regs, elf_entry, start_stack)	\
+	start_thread(regs, elf_entry, start_stack)
+#endif
+
+#if defined(ARCH_HAS_SETUP_ADDITIONAL_PAGES) && !defined(ARCH_SETUP_ADDITIONAL_PAGES)
+#define ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
+	arch_setup_additional_pages(bprm, interpreter)
+#endif
+
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 474f29638d2c..7c581a4c3797 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -13,22 +13,6 @@
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
  */
-#ifndef _TIF_SYSCALL_EMU
-# define _TIF_SYSCALL_EMU		(0)
-#endif
-
-#ifndef _TIF_SYSCALL_TRACEPOINT
-# define _TIF_SYSCALL_TRACEPOINT	(0)
-#endif
-
-#ifndef _TIF_SECCOMP
-# define _TIF_SECCOMP			(0)
-#endif
-
-#ifndef _TIF_SYSCALL_AUDIT
-# define _TIF_SYSCALL_AUDIT		(0)
-#endif
-
 #ifndef _TIF_PATCH_PENDING
 # define _TIF_PATCH_PENDING		(0)
 #endif
@@ -37,28 +21,36 @@
 # define _TIF_UPROBE			(0)
 #endif
 
+#ifndef _TIF_NOTIFY_SIGNAL
+# define _TIF_NOTIFY_SIGNAL		(0)
+#endif
+
 /*
- * TIF flags handled in syscall_enter_from_user_mode()
+ * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
  */
-#ifndef ARCH_SYSCALL_ENTER_WORK
-# define ARCH_SYSCALL_ENTER_WORK	(0)
+#ifndef ARCH_SYSCALL_WORK_ENTER
+# define ARCH_SYSCALL_WORK_ENTER	(0)
 #endif
 
-#define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
-	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
-	 ARCH_SYSCALL_ENTER_WORK)
-
 /*
- * TIF flags handled in syscall_exit_to_user_mode()
+ * SYSCALL_WORK flags handled in syscall_exit_to_user_mode()
  */
-#ifndef ARCH_SYSCALL_EXIT_WORK
-# define ARCH_SYSCALL_EXIT_WORK		(0)
+#ifndef ARCH_SYSCALL_WORK_EXIT
+# define ARCH_SYSCALL_WORK_EXIT		(0)
 #endif
 
-#define SYSCALL_EXIT_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
-	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
+#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
+				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
+				 SYSCALL_WORK_SYSCALL_TRACE |		\
+				 SYSCALL_WORK_SYSCALL_EMU |		\
+				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 ARCH_SYSCALL_WORK_ENTER)
+#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
+				 SYSCALL_WORK_SYSCALL_TRACE |		\
+				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
@@ -69,7 +61,7 @@
 
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
@@ -109,6 +101,27 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 }
 #endif
 
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall/interrupt entry disables interrupts, but user mode is traced as
+ * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct and interrupts are still
+ * disabled. The subsequent functions can be instrumented.
+ *
+ * This is invoked when there is architecture specific functionality to be
+ * done between establishing state and enabling interrupts. The caller must
+ * enable interrupts before invoking syscall_enter_from_user_mode_work().
+ */
+void enter_from_user_mode(struct pt_regs *regs);
+
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
@@ -118,7 +131,8 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
  * function returns all state is correct, interrupts are enabled and the
  * subsequent functions can be instrumented.
  *
- * This handles lockdep, RCU (context tracking) and tracing state.
+ * This handles lockdep, RCU (context tracking) and tracing state, i.e.
+ * the functionality provided by enter_from_user_mode().
  *
  * This is invoked when there is extra architecture specific functionality
  * to be done between establishing state and handling user mode entry work.
@@ -144,8 +158,8 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *
  * It handles the following work items:
  *
- *  1) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
- *     __secure_computing(), trace_sys_enter()
+ *  1) syscall_work flag dependent invocations of
+ *     arch_syscall_enter_tracehook(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
 long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
@@ -259,12 +273,13 @@ static __always_inline void arch_exit_to_user_mode(void) { }
 #endif
 
 /**
- * arch_do_signal -  Architecture specific signal delivery function
+ * arch_do_signal_or_restart -  Architecture specific signal delivery function
  * @regs:	Pointer to currents pt_regs
+ * @has_signal:	actual signal to handle
  *
  * Invoked from exit_to_user_mode_loop().
  */
-void arch_do_signal(struct pt_regs *regs);
+void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal);
 
 /**
  * arch_syscall_exit_tracehook - Wrapper around tracehook_report_syscall_exit()
@@ -285,6 +300,41 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
 }
 #endif
 
+/**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall/interrupt exit enables interrupts, but the kernel state is
+ * interrupts disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Invoke architecture specific last minute exit code, e.g. speculation
+ *    mitigations, etc.: arch_exit_to_user_mode()
+ * 4) Tell lockdep that interrupts are enabled
+ *
+ * Invoked from architecture specific code when syscall_exit_to_user_mode()
+ * is not suitable as the last step before returning to userspace. Must be
+ * invoked with interrupts disabled and the caller must be
+ * non-instrumentable.
+ * The caller has to invoke syscall_exit_to_user_mode_work() before this.
+ */
+void exit_to_user_mode(void);
+
+/**
+ * syscall_exit_to_user_mode_work - Handle work before returning to user mode
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
+ * exit_to_user_mode() to perform the final transition to user mode.
+ *
+ * Calling convention is the same as for syscall_exit_to_user_mode() and it
+ * returns with all work handled and interrupts disabled. The caller must
+ * invoke exit_to_user_mode() before actually switching to user mode to
+ * make the final state transitions. Interrupts must stay disabled between
+ * return from this function and the invocation of exit_to_user_mode().
+ */
+void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
@@ -307,8 +357,12 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
  *	- Architecture specific one time work arch_exit_to_user_mode_prepare()
  *	- Address limit and lockdep checks
  *
- *  3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
- *     arch_exit_to_user_mode() to handle e.g. speculation mitigations
+ *  3) Final transition (lockdep, tracing, context tracking, RCU), i.e. the
+ *     functionality in exit_to_user_mode().
+ *
+ * This is a combination of syscall_exit_to_user_mode_work() (1,2) and
+ * exit_to_user_mode(). This function is preferred unless there is a
+ * compelling architectural reason to use the seperate functions.
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
@@ -341,8 +395,26 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
 #ifndef irqentry_state
+/**
+ * struct irqentry_state - Opaque object for exception state storage
+ * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
+ *            exit path has to invoke rcu_irq_exit().
+ * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
+ *           lockdep state is restored correctly on exit from nmi.
+ *
+ * This opaque object is filled in by the irqentry_*_enter() functions and
+ * must be passed back into the corresponding irqentry_*_exit() functions
+ * when the exception is complete.
+ *
+ * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
+ * and all members private.  Descriptions of the members are provided to aid in
+ * the maintenance of the irqentry_*() functions.
+ */
 typedef struct irqentry_state {
-	bool	exit_rcu;
+	union {
+		bool	exit_rcu;
+		bool	lockdep;
+	};
 } irqentry_state_t;
 #endif
 
@@ -392,7 +464,7 @@ void irqentry_exit_cond_resched(void);
  * @state:	Return value from matching call to irqentry_enter()
  *
  * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and reguired and returns to
+ * preemption and work checks if possible and required and returns to
  * the caller with interrupts disabled and no further work pending.
  *
  * This is the last action before returning to the low level ASM code which
@@ -402,4 +474,23 @@ void irqentry_exit_cond_resched(void);
  */
 void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
 
+/**
+ * irqentry_nmi_enter - Handle NMI entry
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Similar to irqentry_enter() but taking care of the NMI constraints.
+ */
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_nmi_exit - Handle return from NMI handling
+ * @regs:	Pointer to pt_regs (NMI entry regs)
+ * @irq_state:	Return value from matching call to irqentry_nmi_enter()
+ *
+ * Last action before returning to the low level assembly code.
+ *
+ * Counterpart to irqentry_nmi_enter().
+ */
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
+
 #endif
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0cef17afb41a..9b93f8584ff7 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -11,8 +11,8 @@
 # define ARCH_XFER_TO_GUEST_MODE_WORK	(0)
 #endif
 
-#define XFER_TO_GUEST_MODE_WORK					\
-	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
+#define XFER_TO_GUEST_MODE_WORK						\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
 	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..5a24a033b3f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -28,6 +28,7 @@
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
+#include <linux/syscall_user_dispatch.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
@@ -965,6 +966,7 @@ struct task_struct {
 	unsigned int			sessionid;
 #endif
 	struct seccomp			seccomp;
+	struct syscall_user_dispatch	syscall_dispatch;
 
 	/* Thread group tracking: */
 	u64				parent_exec_id;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1bad18a1d8ba..bd5afa076189 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -353,11 +353,25 @@ static inline int restart_syscall(void)
 	return -ERESTARTNOINTR;
 }
 
-static inline int signal_pending(struct task_struct *p)
+static inline int task_sigpending(struct task_struct *p)
 {
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+static inline int signal_pending(struct task_struct *p)
+{
+#if defined(TIF_NOTIFY_SIGNAL)
+	/*
+	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
+	 * behavior in terms of ensuring that we break out of wait loops
+	 * so that notify signal callbacks can be processed.
+	 */
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+		return 1;
+#endif
+	return task_sigpending(p);
+}
+
 static inline int __fatal_signal_pending(struct task_struct *p)
 {
 	return unlikely(sigismember(&p->pending.signal, SIGKILL));
@@ -365,7 +379,7 @@ static inline int __fatal_signal_pending(struct task_struct *p)
 
 static inline int fatal_signal_pending(struct task_struct *p)
 {
-	return signal_pending(p) && __fatal_signal_pending(p);
+	return task_sigpending(p) && __fatal_signal_pending(p);
 }
 
 static inline int signal_pending_state(long state, struct task_struct *p)
@@ -502,7 +516,7 @@ extern int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize);
 static inline void restore_saved_sigmask_unless(bool interrupted)
 {
 	if (interrupted)
-		WARN_ON(!test_thread_flag(TIF_SIGPENDING));
+		WARN_ON(!signal_pending(current));
 	else
 		restore_saved_sigmask();
 }
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..47763f3999f7 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -42,7 +42,7 @@ struct seccomp {
 extern int __secure_computing(const struct seccomp_data *sd);
 static inline int secure_computing(void)
 {
-	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+	if (unlikely(test_syscall_work(SECCOMP)))
 		return  __secure_computing(NULL);
 	return 0;
 }
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
new file mode 100644
index 000000000000..a0ae443fb7df
--- /dev/null
+++ b/include/linux/syscall_user_dispatch.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#ifndef _SYSCALL_USER_DISPATCH_H
+#define _SYSCALL_USER_DISPATCH_H
+
+#include <linux/thread_info.h>
+
+#ifdef CONFIG_GENERIC_ENTRY
+
+struct syscall_user_dispatch {
+	char __user	*selector;
+	unsigned long	offset;
+	unsigned long	len;
+	bool		on_dispatch;
+};
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector);
+
+#define clear_syscall_work_syscall_user_dispatch(tsk) \
+	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
+
+#else
+struct syscall_user_dispatch {};
+
+static inline int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+					    unsigned long len, char __user *selector)
+{
+	return -EINVAL;
+}
+
+static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *tsk)
+{
+}
+
+#endif /* CONFIG_GENERIC_ENTRY */
+
+#endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249a4e9b..c8a974cead73 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -35,6 +35,24 @@ enum {
 	GOOD_STACK,
 };
 
+#ifdef CONFIG_GENERIC_ENTRY
+enum syscall_work_bit {
+	SYSCALL_WORK_BIT_SECCOMP,
+	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
+	SYSCALL_WORK_BIT_SYSCALL_TRACE,
+	SYSCALL_WORK_BIT_SYSCALL_EMU,
+	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
+	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
+};
+
+#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
+#define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
+#define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
+#define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
+#define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
+#endif
+
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
@@ -97,6 +115,38 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 #define test_thread_flag(flag) \
 	test_ti_thread_flag(current_thread_info(), flag)
 
+#ifdef CONFIG_GENERIC_ENTRY
+#define set_syscall_work(fl) \
+	set_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+#define test_syscall_work(fl) \
+	test_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+#define clear_syscall_work(fl) \
+	clear_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+
+#define set_task_syscall_work(t, fl) \
+	set_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+#define test_task_syscall_work(t, fl) \
+	test_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+#define clear_task_syscall_work(t, fl) \
+	clear_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+
+#else /* CONFIG_GENERIC_ENTRY */
+
+#define set_syscall_work(fl)						\
+	set_ti_thread_flag(current_thread_info(), TIF_##fl)
+#define test_syscall_work(fl) \
+	test_ti_thread_flag(current_thread_info(), TIF_##fl)
+#define clear_syscall_work(fl) \
+	clear_ti_thread_flag(current_thread_info(), TIF_##fl)
+
+#define set_task_syscall_work(t, fl) \
+	set_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define test_task_syscall_work(t, fl) \
+	test_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define clear_task_syscall_work(t, fl) \
+	clear_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#endif /* !CONFIG_GENERIC_ENTRY */
+
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index b480e1a07ed8..54b925224a13 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -83,11 +83,12 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
  * tracehook_report_syscall_entry - task is about to attempt a system call
  * @regs:		user register state of current task
  *
- * This will be called if %TIF_SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
- * when the current task has just entered the kernel for a system call.
- * Full user register state is available here.  Changing the values
- * in @regs can affect the system call number and arguments to be tried.
- * It is safe to block here, preventing the system call from beginning.
+ * This will be called if %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_EMU have been set, when the current task has just
+ * entered the kernel for a system call.  Full user register state is
+ * available here.  Changing the values in @regs can affect the system
+ * call number and arguments to be tried.  It is safe to block here,
+ * preventing the system call from beginning.
  *
  * Returns zero normally, or nonzero if the calling arch code should abort
  * the system call.  That must prevent normal entry so no system call is
@@ -109,15 +110,15 @@ static inline __must_check int tracehook_report_syscall_entry(
  * @regs:		user register state of current task
  * @step:		nonzero if simulating single-step or block-step
  *
- * This will be called if %TIF_SYSCALL_TRACE has been set, when the
- * current task has just finished an attempted system call.  Full
+ * This will be called if %SYSCALL_WORK_SYSCALL_TRACE has been set, when
+ * the current task has just finished an attempted system call.  Full
  * user register state is available here.  It is safe to block here,
  * preventing signals from being processed.
  *
  * If @step is nonzero, this report is also in lieu of the normal
  * trap that would follow the system call instruction because
  * user_enable_block_step() or user_enable_single_step() was used.
- * In this case, %TIF_SYSCALL_TRACE might not be set.
+ * In this case, %SYSCALL_WORK_SYSCALL_TRACE might not be set.
  *
  * Called without locks, just before checking for pending signals.
  */
@@ -198,4 +199,31 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 	blkcg_maybe_throttle_current();
 }
 
+/*
+ * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
+ * is currently used by TWA_SIGNAL based task_work, which requires breaking
+ * wait loops to ensure that task_work is noticed and run.
+ */
+static inline void tracehook_notify_signal(void)
+{
+#if defined(TIF_NOTIFY_SIGNAL)
+	clear_thread_flag(TIF_NOTIFY_SIGNAL);
+	smp_mb__after_atomic();
+	if (current->task_works)
+		task_work_run();
+#endif
+}
+
+/*
+ * Called when we have work to process from exit_to_user_mode_loop()
+ */
+static inline void set_notify_signal(struct task_struct *task)
+{
+#if defined(TIF_NOTIFY_SIGNAL)
+	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
+	    !wake_up_state(task, TASK_INTERRUPTIBLE))
+		kick_process(task);
+#endif
+}
+
 #endif	/* <linux/tracehook.h> */
diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index dc8ac27d27c1..8e193f3a33b3 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -37,10 +37,10 @@ struct syscall_metadata {
 #if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_HAVE_SYSCALL_TRACEPOINTS)
 static inline void syscall_tracepoint_update(struct task_struct *p)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+	if (test_syscall_work(SYSCALL_TRACEPOINT))
+		set_task_syscall_work(p, SYSCALL_TRACEPOINT);
 	else
-		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+		clear_task_syscall_work(p, SYSCALL_TRACEPOINT);
 }
 #else
 static inline void syscall_tracepoint_update(struct task_struct *p)
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 7aacf9389010..d2597000407a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -286,7 +286,8 @@ typedef struct siginfo {
  * SIGSYS si_codes
  */
 #define SYS_SECCOMP	1	/* seccomp triggered */
-#define NSIGSYS		1
+#define SYS_USER_DISPATCH 2	/* syscall user dispatch triggered */
+#define NSIGSYS		2
 
 /*
  * SIGEMT si_codes
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7f0827705c9a..90deb41c8a34 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -247,4 +247,9 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Dispatch syscalls to a userspace handler */
+#define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF		0
+# define PR_SYS_DISPATCH_ON		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0983b5..c00aa5837965 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -952,7 +952,7 @@ int audit_alloc(struct task_struct *tsk)
 
 	state = audit_filter_task(tsk, &key);
 	if (state == AUDIT_DISABLED) {
-		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+		clear_task_syscall_work(tsk, SYSCALL_AUDIT);
 		return 0;
 	}
 
@@ -964,7 +964,7 @@ int audit_alloc(struct task_struct *tsk)
 	context->filterkey = key;
 
 	audit_set_context(tsk, context);
-	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+	set_task_syscall_work(tsk, SYSCALL_AUDIT);
 	return 0;
 }
 
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 34c8a3f1c735..095c775e001e 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -9,5 +9,5 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o syscall_user_dispatch.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e9e2df3f3f9e..d6b73937dab3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,20 +5,13 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
+#include "common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/**
- * enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall/interrupt entry disables interrupts, but user mode is traced as
- * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+/* See comment for enter_from_user_mode() in entry-common.h */
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	arch_check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -31,6 +24,11 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 }
 
+void noinstr enter_from_user_mode(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs);
+}
+
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -42,19 +40,29 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 }
 
 static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long ti_work)
+				unsigned long work)
 {
 	long ret = 0;
 
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
 	/* Handle ptrace */
-	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret = arch_syscall_enter_tracehook(regs);
-		if (ret || (ti_work & _TIF_SYSCALL_EMU))
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (ti_work & _TIF_SECCOMP) {
+	if (work & SYSCALL_WORK_SECCOMP) {
 		ret = __secure_computing(NULL);
 		if (ret == -1L)
 			return ret;
@@ -63,7 +71,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
 	syscall_enter_audit(regs, syscall);
@@ -74,11 +82,10 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
-	unsigned long ti_work;
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	ti_work = READ_ONCE(current_thread_info()->flags);
-	if (ti_work & SYSCALL_ENTER_WORK)
-		syscall = syscall_trace_enter(regs, syscall, ti_work);
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
 
 	return syscall;
 }
@@ -92,7 +99,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -104,25 +111,14 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
 }
 
-/**
- * exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall/interupt exit enables interrupts, but the kernel state is
- * interrupts disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Invoke architecture specific last minute exit code, e.g. speculation
- *    mitigations, etc.
- * 4) Tell lockdep that interrupts are enabled
- */
-static __always_inline void exit_to_user_mode(void)
+/* See comment for exit_to_user_mode() in entry-common.h */
+static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
@@ -134,8 +130,21 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+void noinstr exit_to_user_mode(void)
+{
+	__exit_to_user_mode();
+}
+
 /* Workaround to allow gradual conversion of architecture code */
-void __weak arch_do_signal(struct pt_regs *regs) { }
+void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
+
+static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
+{
+	if (ti_work & _TIF_NOTIFY_SIGNAL)
+		tracehook_notify_signal();
+
+	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
+}
 
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
@@ -157,8 +166,8 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		if (ti_work & _TIF_SIGPENDING)
-			arch_do_signal(regs);
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			handle_signal_work(regs, ti_work);
 
 		if (ti_work & _TIF_NOTIFY_RESUME) {
 			tracehook_notify_resume(regs);
@@ -199,35 +208,50 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 }
 
 #ifndef _TIF_SINGLESTEP
-static inline bool report_single_step(unsigned long ti_work)
+static inline bool report_single_step(unsigned long work)
 {
 	return false;
 }
 #else
 /*
- * If TIF_SYSCALL_EMU is set, then the only reason to report is when
+ * If SYSCALL_EMU is set, then the only reason to report is when
  * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
  * instruction has been already reported in syscall_enter_from_user_mode().
  */
-#define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
-
-static inline bool report_single_step(unsigned long ti_work)
+static inline bool report_single_step(unsigned long work)
 {
-	return (ti_work & SYSEMU_STEP) == _TIF_SINGLESTEP;
+	if (!(work & SYSCALL_WORK_SYSCALL_EMU))
+		return false;
+
+	return !!(current_thread_info()->flags & _TIF_SINGLESTEP);
 }
 #endif
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
+
+static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch = false;
+			return;
+		}
+	}
+
 	audit_syscall_exit(regs);
 
-	if (ti_work & _TIF_SYSCALL_TRACEPOINT)
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	step = report_single_step(ti_work);
-	if (step || ti_work & _TIF_SYSCALL_TRACE)
+	step = report_single_step(work);
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
 }
 
@@ -237,7 +261,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
  */
 static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long nr = syscall_get_nr(current, regs);
 
 	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
@@ -254,23 +278,33 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	 * enabled, we want to run them exactly once per syscall exit with
 	 * interrupts enabled.
 	 */
-	if (unlikely(cached_flags & SYSCALL_EXIT_WORK))
-		syscall_exit_work(regs, cached_flags);
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
 }
 
-__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
 {
-	instrumentation_begin();
 	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
+}
+
+void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	__syscall_exit_to_user_mode_work(regs);
+}
+
+__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	__enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
@@ -278,7 +312,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	exit_to_user_mode();
+	__exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
@@ -296,7 +330,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * If this entry hit the idle task invoke rcu_irq_enter() whether
 	 * RCU is watching or not.
 	 *
-	 * Interupts can nest when the first interrupt invokes softirq
+	 * Interrupts can nest when the first interrupt invokes softirq
 	 * processing on return which enables interrupts.
 	 *
 	 * Scheduler ticks in the idle task can mark quiescent state and
@@ -307,7 +341,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
 	 * assume that it is the first interupt and eventually claim
-	 * quiescient state and end grace periods prematurely.
+	 * quiescent state and end grace periods prematurely.
 	 *
 	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
 	 * consistent.
@@ -319,7 +353,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
-		 * as in irq_enter_from_user_mode().
+		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
@@ -397,3 +431,39 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			rcu_irq_exit();
 	}
 }
+
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
+{
+	irqentry_state_t irq_state;
+
+	irq_state.lockdep = lockdep_hardirqs_enabled();
+
+	__nmi_enter();
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirq_enter();
+	rcu_nmi_enter();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	ftrace_nmi_enter();
+	instrumentation_end();
+
+	return irq_state;
+}
+
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
+{
+	instrumentation_begin();
+	ftrace_nmi_exit();
+	if (irq_state.lockdep) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	}
+	instrumentation_end();
+
+	rcu_nmi_exit();
+	lockdep_hardirq_exit();
+	if (irq_state.lockdep)
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	__nmi_exit();
+}
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
new file mode 100644
index 000000000000..f6e6d02f07fe
--- /dev/null
+++ b/kernel/entry/common.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _COMMON_H
+#define _COMMON_H
+
+bool syscall_user_dispatch(struct pt_regs *regs);
+
+#endif
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index b6678a5e3cf6..49972ee99aff 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -8,6 +8,9 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 	do {
 		int ret;
 
+		if (ti_work & _TIF_NOTIFY_SIGNAL)
+			tracehook_notify_signal();
+
 		if (ti_work & _TIF_SIGPENDING) {
 			kvm_handle_signal_exit(vcpu);
 			return -EINTR;
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
new file mode 100644
index 000000000000..b0338a5625d9
--- /dev/null
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#include <linux/sched.h>
+#include <linux/prctl.h>
+#include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess.h>
+#include <linux/signal.h>
+#include <linux/elf.h>
+
+#include <linux/sched/signal.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/syscall.h>
+
+#include "common.h"
+
+static void trigger_sigsys(struct pt_regs *regs)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_USER_DISPATCH;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = 0;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall_get_nr(current, regs);
+
+	force_sig_info(&info);
+}
+
+bool syscall_user_dispatch(struct pt_regs *regs)
+{
+	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
+	char state;
+
+	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
+		return false;
+
+	if (unlikely(arch_syscall_is_vdso_sigreturn(regs)))
+		return false;
+
+	if (likely(sd->selector)) {
+		/*
+		 * access_ok() is performed once, at prctl time, when
+		 * the selector is loaded by userspace.
+		 */
+		if (unlikely(__get_user(state, sd->selector)))
+			do_exit(SIGSEGV);
+
+		if (likely(state == PR_SYS_DISPATCH_OFF))
+			return false;
+
+		if (state != PR_SYS_DISPATCH_ON)
+			do_exit(SIGSYS);
+	}
+
+	sd->on_dispatch = true;
+	syscall_rollback(current, regs);
+	trigger_sigsys(regs);
+
+	return true;
+}
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	switch (mode) {
+	case PR_SYS_DISPATCH_OFF:
+		if (offset || len || selector)
+			return -EINVAL;
+		break;
+	case PR_SYS_DISPATCH_ON:
+		/*
+		 * Validate the direct dispatcher region just for basic
+		 * sanity against overflow and a 0-sized dispatcher
+		 * region.  If the user is able to submit a syscall from
+		 * an address, that address is obviously valid.
+		 */
+		if (offset && offset + len <= offset)
+			return -EINVAL;
+
+		if (selector && !access_ok(selector, sizeof(*selector)))
+			return -EFAULT;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	current->syscall_dispatch.selector = selector;
+	current->syscall_dispatch.offset = offset;
+	current->syscall_dispatch.len = len;
+	current->syscall_dispatch.on_dispatch = false;
+
+	if (mode == PR_SYS_DISPATCH_ON)
+		set_syscall_work(SYSCALL_USER_DISPATCH);
+	else
+		clear_syscall_work(SYSCALL_USER_DISPATCH);
+
+	return 0;
+}
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 00b0358739ab..bf9edd8d75be 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1973,7 +1973,7 @@ bool uprobe_deny_signal(void)
 
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
-	if (signal_pending(t)) {
+	if (task_sigpending(t)) {
 		spin_lock_irq(&t->sighand->siglock);
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
 		spin_unlock_irq(&t->sighand->siglock);
diff --git a/kernel/fork.c b/kernel/fork.c
index 32083db7a2a2..4a5ecb41f440 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -906,6 +906,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
+	clear_syscall_work_syscall_user_dispatch(tsk);
 
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
@@ -1625,7 +1626,7 @@ static void copy_seccomp(struct task_struct *p)
 	 * to manually enable the seccomp thread flag here.
 	 */
 	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
-		set_tsk_thread_flag(p, TIF_SECCOMP);
+		set_task_syscall_work(p, SECCOMP);
 #endif
 }
 
@@ -2158,9 +2159,9 @@ static __latent_entropy struct task_struct *copy_process(
 	 * child regardless of CLONE_PTRACE.
 	 */
 	user_disable_single_step(p);
-	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
+	clear_task_syscall_work(p, SYSCALL_TRACE);
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
+	clear_task_syscall_work(p, SYSCALL_EMU);
 #endif
 	clear_tsk_latency_tracing(p);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..237bcd6d255c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -117,9 +117,9 @@ void __ptrace_unlink(struct task_struct *child)
 	const struct cred *old_cred;
 	BUG_ON(!child->ptrace);
 
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+	clear_task_syscall_work(child, SYSCALL_TRACE);
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
+	clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
 	child->parent = child->real_parent;
@@ -812,15 +812,15 @@ static int ptrace_resume(struct task_struct *child, long request,
 		return -EIO;
 
 	if (request == PTRACE_SYSCALL)
-		set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		set_task_syscall_work(child, SYSCALL_TRACE);
 	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		clear_task_syscall_work(child, SYSCALL_TRACE);
 
-#ifdef TIF_SYSCALL_EMU
+#if defined(CONFIG_GENERIC_ENTRY) || defined(TIF_SYSCALL_EMU)
 	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
-		set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		set_task_syscall_work(child, SYSCALL_EMU);
 	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
 	if (is_singleblock(request)) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..44426e5acde2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4291,6 +4291,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
+	SCHED_WARN_ON(ct_state() == CONTEXT_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
@@ -4630,7 +4631,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8ad7a293255a..f67e92d11ad7 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -356,14 +356,14 @@ static inline void seccomp_assign_mode(struct task_struct *task,
 
 	task->seccomp.mode = seccomp_mode;
 	/*
-	 * Make sure TIF_SECCOMP cannot be set before the mode (and
+	 * Make sure SYSCALL_WORK_SECCOMP cannot be set before the mode (and
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
 		arch_seccomp_spec_mitigate(task);
-	set_tsk_thread_flag(task, TIF_SECCOMP);
+	set_task_syscall_work(task, SECCOMP);
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -929,7 +929,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 
 	/*
 	 * Make sure that any changes to mode from another thread have
-	 * been seen after TIF_SECCOMP was seen.
+	 * been seen after SYSCALL_WORK_SECCOMP was seen.
 	 */
 	rmb();
 
diff --git a/kernel/signal.c b/kernel/signal.c
index a38b3edc6851..f67ea9a08ac0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -983,7 +983,7 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	if (task_is_stopped_or_traced(p))
 		return false;
 
-	return task_curr(p) || !signal_pending(p);
+	return task_curr(p) || !task_sigpending(p);
 }
 
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
@@ -2529,6 +2529,20 @@ bool get_signal(struct ksignal *ksig)
 	struct signal_struct *signal = current->signal;
 	int signr;
 
+	/*
+	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
+	 * that the arch handlers don't all have to do it. If we get here
+	 * without TIF_SIGPENDING, just exit after running signal work.
+	 */
+#ifdef TIF_NOTIFY_SIGNAL
+	if (!IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
+		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
+			tracehook_notify_signal();
+		if (!task_sigpending(current))
+			return false;
+	}
+#endif
+
 	if (unlikely(uprobe_deny_signal()))
 		return false;
 
@@ -2822,7 +2836,7 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 		/* Remove the signals this thread can handle. */
 		sigandsets(&retarget, &retarget, &t->blocked);
 
-		if (!signal_pending(t))
+		if (!task_sigpending(t))
 			signal_wake_up(t, 0);
 
 		if (sigisemptyset(&retarget))
@@ -2856,7 +2870,7 @@ void exit_signals(struct task_struct *tsk)
 
 	cgroup_threadgroup_change_end(tsk);
 
-	if (!signal_pending(tsk))
+	if (!task_sigpending(tsk))
 		goto out;
 
 	unblocked = tsk->blocked;
@@ -2900,7 +2914,7 @@ long do_no_restart_syscall(struct restart_block *param)
 
 static void __set_task_blocked(struct task_struct *tsk, const sigset_t *newset)
 {
-	if (signal_pending(tsk) && !thread_group_empty(tsk)) {
+	if (task_sigpending(tsk) && !thread_group_empty(tsk)) {
 		sigset_t newblocked;
 		/* A set of now blocked but previously unblocked signals. */
 		sigandnsets(&newblocked, newset, &current->blocked);
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..51f00fe20e4d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2530,6 +2531,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_SYSCALL_USER_DISPATCH:
+		error = set_syscall_user_dispatch(arg2, arg3, arg4,
+						  (char __user *) arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 8d6e1217c451..15b087286bea 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -5,6 +5,34 @@
 
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
+/*
+ * TWA_SIGNAL signaling - use TIF_NOTIFY_SIGNAL, if available, as it's faster
+ * than TIF_SIGPENDING as there's no dependency on ->sighand. The latter is
+ * shared for threads, and can cause contention on sighand->lock. Even for
+ * the non-threaded case TIF_NOTIFY_SIGNAL is more efficient, as no locking
+ * or IRQ disabling is involved for notification (or running) purposes.
+ */
+static void task_work_notify_signal(struct task_struct *task)
+{
+#if defined(TIF_NOTIFY_SIGNAL)
+	set_notify_signal(task);
+#else
+	unsigned long flags;
+
+	/*
+	 * Only grab the sighand lock if we don't already have some
+	 * task_work pending. This pairs with the smp_store_mb()
+	 * in get_signal(), see comment there.
+	 */
+	if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
+	    lock_task_sighand(task, &flags)) {
+		task->jobctl |= JOBCTL_TASK_WORK;
+		signal_wake_up(task, 0);
+		unlock_task_sighand(task, &flags);
+	}
+#endif
+}
+
 /**
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
@@ -33,7 +61,6 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
-	unsigned long flags;
 
 	do {
 		head = READ_ONCE(task->task_works);
@@ -49,17 +76,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		set_notify_resume(task);
 		break;
 	case TWA_SIGNAL:
-		/*
-		 * Only grab the sighand lock if we don't already have some
-		 * task_work pending. This pairs with the smp_store_mb()
-		 * in get_signal(), see comment there.
-		 */
-		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
-		    lock_task_sighand(task, &flags)) {
-			task->jobctl |= JOBCTL_TASK_WORK;
-			signal_wake_up(task, 0);
-			unlock_task_sighand(task, &flags);
-		}
+		task_work_notify_signal(task);
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 47a71f96e5bc..adf65b502453 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3428,10 +3428,10 @@ static __init int event_trace_enable(void)
  * initialize events and perhaps start any events that are on the
  * command line. Unfortunately, there are some events that will not
  * start this early, like the system call tracepoints that need
- * to set the TIF_SYSCALL_TRACEPOINT flag of pid 1. But event_trace_enable()
- * is called before pid 1 starts, and this flag is never set, making
- * the syscall tracepoint never get reached, but the event is enabled
- * regardless (and not doing anything).
+ * to set the %SYSCALL_WORK_SYSCALL_TRACEPOINT flag of pid 1. But
+ * event_trace_enable() is called before pid 1 starts, and this flag
+ * is never set, making the syscall tracepoint never get reached, but
+ * the event is enabled regardless (and not doing anything).
  */
 static __init int event_trace_enable_again(void)
 {
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 3f659f855074..7261fa0f5e3c 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -594,7 +594,7 @@ int syscall_regfunc(void)
 	if (!sys_tracepoint_refcount) {
 		read_lock(&tasklist_lock);
 		for_each_process_thread(p, t) {
-			set_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
+			set_task_syscall_work(t, SYSCALL_TRACEPOINT);
 		}
 		read_unlock(&tasklist_lock);
 	}
@@ -611,7 +611,7 @@ void syscall_unregfunc(void)
 	if (!sys_tracepoint_refcount) {
 		read_lock(&tasklist_lock);
 		for_each_process_thread(p, t) {
-			clear_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
+			clear_task_syscall_work(t, SYSCALL_TRACEPOINT);
 		}
 		read_unlock(&tasklist_lock);
 	}
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c283503159..96d5682fb9d8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -56,6 +56,7 @@ TARGETS += sparc64
 TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
+TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
 TARGETS += timens
diff --git a/tools/testing/selftests/syscall_user_dispatch/.gitignore b/tools/testing/selftests/syscall_user_dispatch/.gitignore
new file mode 100644
index 000000000000..f539615ad5da
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sud_test
+sud_benchmark
diff --git a/tools/testing/selftests/syscall_user_dispatch/Makefile b/tools/testing/selftests/syscall_user_dispatch/Makefile
new file mode 100644
index 000000000000..03c120270953
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+top_srcdir = ../../../..
+INSTALL_HDR_PATH = $(top_srcdir)/usr
+LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
+
+CFLAGS += -Wall -I$(LINUX_HDR_PATH)
+
+TEST_GEN_PROGS := sud_test sud_benchmark
+include ../lib.mk
diff --git a/tools/testing/selftests/syscall_user_dispatch/config b/tools/testing/selftests/syscall_user_dispatch/config
new file mode 100644
index 000000000000..039e303e59d7
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/config
@@ -0,0 +1 @@
+CONFIG_GENERIC_ENTRY=y
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
new file mode 100644
index 000000000000..6689f1183dbf
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Collabora Ltd.
+ *
+ * Benchmark and test syscall user dispatch
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <errno.h>
+#include <time.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+
+#ifndef PR_SET_SYSCALL_USER_DISPATCH
+# define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF	0
+# define PR_SYS_DISPATCH_ON	1
+#endif
+
+#ifdef __NR_syscalls
+# define MAGIC_SYSCALL_1 (__NR_syscalls + 1) /* Bad Linux syscall number */
+#else
+# define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
+#endif
+
+/*
+ * To test returning from a sigsys with selector blocked, the test
+ * requires some per-architecture support (i.e. knowledge about the
+ * signal trampoline address).  On i386, we know it is on the vdso, and
+ * a small trampoline is open-coded for x86_64.  Other architectures
+ * that have a trampoline in the vdso will support TEST_BLOCKED_RETURN
+ * out of the box, but don't enable them until they support syscall user
+ * dispatch.
+ */
+#if defined(__x86_64__) || defined(__i386__)
+#define TEST_BLOCKED_RETURN
+#endif
+
+#ifdef __x86_64__
+void* (syscall_dispatcher_start)(void);
+void* (syscall_dispatcher_end)(void);
+#else
+unsigned long syscall_dispatcher_start = 0;
+unsigned long syscall_dispatcher_end = 0;
+#endif
+
+unsigned long trapped_call_count = 0;
+unsigned long native_call_count = 0;
+
+char selector;
+#define SYSCALL_BLOCK   (selector = PR_SYS_DISPATCH_ON)
+#define SYSCALL_UNBLOCK (selector = PR_SYS_DISPATCH_OFF)
+
+#define CALIBRATION_STEP 100000
+#define CALIBRATE_TO_SECS 5
+int factor;
+
+static double one_sysinfo_step(void)
+{
+	struct timespec t1, t2;
+	int i;
+	struct sysinfo info;
+
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	for (i = 0; i < CALIBRATION_STEP; i++)
+		sysinfo(&info);
+	clock_gettime(CLOCK_MONOTONIC, &t2);
+	return (t2.tv_sec - t1.tv_sec) + 1.0e-9 * (t2.tv_nsec - t1.tv_nsec);
+}
+
+static void calibrate_set(void)
+{
+	double elapsed = 0;
+
+	printf("Calibrating test set to last ~%d seconds...\n", CALIBRATE_TO_SECS);
+
+	while (elapsed < 1) {
+		elapsed += one_sysinfo_step();
+		factor += CALIBRATE_TO_SECS;
+	}
+
+	printf("test iterations = %d\n", CALIBRATION_STEP * factor);
+}
+
+static double perf_syscall(void)
+{
+	unsigned int i;
+	double partial = 0;
+
+	for (i = 0; i < factor; ++i)
+		partial += one_sysinfo_step()/(CALIBRATION_STEP*factor);
+	return partial;
+}
+
+static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
+{
+	char buf[1024];
+	int len;
+
+	SYSCALL_UNBLOCK;
+
+	/* printf and friends are not signal-safe. */
+	len = snprintf(buf, 1024, "Caught sys_%x\n", info->si_syscall);
+	write(1, buf, len);
+
+	if (info->si_syscall == MAGIC_SYSCALL_1)
+		trapped_call_count++;
+	else
+		native_call_count++;
+
+#ifdef TEST_BLOCKED_RETURN
+	SYSCALL_BLOCK;
+#endif
+
+#ifdef __x86_64__
+	__asm__ volatile("movq $0xf, %rax");
+	__asm__ volatile("leaveq");
+	__asm__ volatile("add $0x8, %rsp");
+	__asm__ volatile("syscall_dispatcher_start:");
+	__asm__ volatile("syscall");
+	__asm__ volatile("nop"); /* Landing pad within dispatcher area */
+	__asm__ volatile("syscall_dispatcher_end:");
+#endif
+
+}
+
+int main(void)
+{
+	struct sigaction act;
+	double time1, time2;
+	int ret;
+	sigset_t mask;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	calibrate_set();
+
+	time1 = perf_syscall();
+	printf("Avg syscall time %.0lfns.\n", time1 * 1.0e9);
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	if (ret) {
+		perror("Error sigaction:");
+		exit(-1);
+	}
+
+	fprintf(stderr, "Enabling syscall trapping.\n");
+
+	if (prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON,
+		  syscall_dispatcher_start,
+		  (syscall_dispatcher_end - syscall_dispatcher_start + 1),
+		  &selector)) {
+		perror("prctl failed\n");
+		exit(-1);
+	}
+
+	SYSCALL_BLOCK;
+	syscall(MAGIC_SYSCALL_1);
+
+#ifdef TEST_BLOCKED_RETURN
+	if (selector == PR_SYS_DISPATCH_OFF) {
+		fprintf(stderr, "Failed to return with selector blocked.\n");
+		exit(-1);
+	}
+#endif
+
+	SYSCALL_UNBLOCK;
+
+	if (!trapped_call_count) {
+		fprintf(stderr, "syscall trapping does not work.\n");
+		exit(-1);
+	}
+
+	time2 = perf_syscall();
+
+	if (native_call_count) {
+		perror("syscall trapping intercepted more syscalls than expected\n");
+		exit(-1);
+	}
+
+	printf("trapped_call_count %lu, native_call_count %lu.\n",
+	       trapped_call_count, native_call_count);
+	printf("Avg syscall time %.0lfns.\n", time2 * 1.0e9);
+	printf("Interception overhead: %.1lf%% (+%.0lfns).\n",
+	       100.0 * (time2 / time1 - 1.0), 1.0e9 * (time2 - time1));
+	return 0;
+
+}
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
new file mode 100644
index 000000000000..6498b050ef89
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Collabora Ltd.
+ *
+ * Test code for syscall user dispatch
+ */
+
+#define _GNU_SOURCE
+#include <sys/prctl.h>
+#include <sys/sysinfo.h>
+#include <sys/syscall.h>
+#include <signal.h>
+
+#include <asm/unistd.h>
+#include "../kselftest_harness.h"
+
+#ifndef PR_SET_SYSCALL_USER_DISPATCH
+# define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF	0
+# define PR_SYS_DISPATCH_ON	1
+#endif
+
+#ifndef SYS_USER_DISPATCH
+# define SYS_USER_DISPATCH	2
+#endif
+
+#ifdef __NR_syscalls
+# define MAGIC_SYSCALL_1 (__NR_syscalls + 1) /* Bad Linux syscall number */
+#else
+# define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
+#endif
+
+#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
+#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
+
+/* Test Summary:
+ *
+ * - dispatch_trigger_sigsys: Verify if PR_SET_SYSCALL_USER_DISPATCH is
+ *   able to trigger SIGSYS on a syscall.
+ *
+ * - bad_selector: Test that a bad selector value triggers SIGSYS with
+ *   si_errno EINVAL.
+ *
+ * - bad_prctl_param: Test that the API correctly rejects invalid
+ *   parameters on prctl
+ *
+ * - dispatch_and_return: Test that a syscall is selectively dispatched
+ *   to userspace depending on the value of selector.
+ *
+ * - disable_dispatch: Test that the PR_SYS_DISPATCH_OFF correctly
+ *   disables the dispatcher
+ *
+ * - direct_dispatch_range: Test that a syscall within the allowed range
+ *   can bypass the dispatcher.
+ */
+
+TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
+{
+	char sel = 0;
+	struct sysinfo info;
+	int ret;
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	sysinfo(&info);
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(bad_prctl_param)
+{
+	char sel = 0;
+	int op;
+
+	/* Invalid op */
+	op = -1;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
+	ASSERT_EQ(EINVAL, errno);
+
+	/* PR_SYS_DISPATCH_OFF */
+	op = PR_SYS_DISPATCH_OFF;
+
+	/* offset != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* len != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* sel != NULL */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Valid parameter */
+	errno = 0;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
+	EXPECT_EQ(0, errno);
+
+	/* PR_SYS_DISPATCH_ON */
+	op = PR_SYS_DISPATCH_ON;
+
+	/* Dispatcher region is bad (offset > 0 && len == 0) */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Invalid selector */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
+	ASSERT_EQ(EFAULT, errno);
+
+	/*
+	 * Dispatcher range overflows unsigned long
+	 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
+	ASSERT_EQ(EINVAL, errno) {
+		TH_LOG("Should reject bad syscall range");
+	}
+
+	/*
+	 * Allowed range overflows usigned long
+	 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
+	ASSERT_EQ(EINVAL, errno) {
+		TH_LOG("Should reject bad syscall range");
+	}
+}
+
+/*
+ * Use global selector for handle_sigsys tests, to avoid passing
+ * selector to signal handler
+ */
+char glob_sel;
+int nr_syscalls_emulated;
+int si_code;
+int si_errno;
+
+static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
+{
+	si_code = info->si_code;
+	si_errno = info->si_errno;
+
+	if (info->si_syscall == MAGIC_SYSCALL_1)
+		nr_syscalls_emulated++;
+
+	/* In preparation for sigreturn. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
+TEST(dispatch_and_return)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(-1, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+
+	/* MAGIC_SYSCALL_1 should be emulated. */
+	nr_syscalls_emulated = 0;
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(MAGIC_SYSCALL_1, ret) {
+		TH_LOG("Failed to intercept syscall");
+	}
+	EXPECT_EQ(1, nr_syscalls_emulated) {
+		TH_LOG("Failed to emulate syscall");
+	}
+	ASSERT_EQ(SYS_USER_DISPATCH, si_code) {
+		TH_LOG("Bad si_code in SIGSYS");
+	}
+	ASSERT_EQ(0, si_errno) {
+		TH_LOG("Bad si_errno in SIGSYS");
+	}
+}
+
+TEST_SIGNAL(bad_selector, SIGSYS)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+	struct sysinfo info;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	glob_sel = -1;
+
+	sysinfo(&info);
+
+	/* Even though it is ready to catch SIGSYS, the signal is
+	 * supposed to be uncatchable.
+	 */
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(disable_dispatch)
+{
+	int ret;
+	struct sysinfo info;
+	char sel = 0;
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_OFF, 0, 0, 0);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Failed to unset syscall user dispatch");
+	}
+
+	/* Shouldn't have any effect... */
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(__NR_sysinfo, &info);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST(direct_dispatch_range)
+{
+	int ret = 0;
+	struct sysinfo info;
+	char sel = 0;
+
+	/*
+	 * Instead of calculating libc addresses; allow the entire
+	 * memory map and lock the selector.
+	 */
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST_HARNESS_MAIN

