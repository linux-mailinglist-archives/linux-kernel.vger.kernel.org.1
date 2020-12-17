Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812472DD4ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgLQQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgLQQFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:05:42 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org,
        bjorn.topel@intel.com, pdp7pdp7@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v5 8/9] riscv: Add uprobes supported
Date:   Thu, 17 Dec 2020 16:01:44 +0000
Message-Id: <1608220905-1962-9-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608220905-1962-1-git-send-email-guoren@kernel.org>
References: <1608220905-1962-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds support for uprobes on riscv architecture.

Just like kprobe, it support single-step and simulate instructions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig                   |   3 +
 arch/riscv/include/asm/processor.h   |   1 +
 arch/riscv/include/asm/thread_info.h |   4 +-
 arch/riscv/include/asm/uprobes.h     |  40 ++++++++
 arch/riscv/kernel/probes/Makefile    |   1 +
 arch/riscv/kernel/probes/uprobes.c   | 186 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/signal.c           |   3 +
 arch/riscv/kernel/traps.c            |  10 ++
 arch/riscv/mm/fault.c                |   6 ++
 9 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/uprobes.h
 create mode 100644 arch/riscv/kernel/probes/uprobes.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f58b234..af0ec36 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -160,6 +160,9 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
+config ARCH_SUPPORTS_UPROBES
+	def_bool y
+
 config SYS_SUPPORTS_HUGETLBFS
 	depends on MMU
 	def_bool y
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index bdddcd5..3a24003 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -34,6 +34,7 @@ struct thread_struct {
 	unsigned long sp;	/* Kernel mode stack */
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
+	unsigned long bad_cause;
 };
 
 #define INIT_THREAD {					\
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index a390711..bdb5928 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -74,6 +74,7 @@ struct thread_info {
 #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing */
 #define TIF_SECCOMP		8	/* syscall secure computing */
+#define TIF_UPROBE		9	/* uprobe breakpoint or singlestep */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
@@ -82,9 +83,10 @@ struct thread_info {
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_UPROBE		(1 << TIF_UPROBE)
 
 #define _TIF_WORK_MASK \
-	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
+	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_UPROBE)
 
 #define _TIF_SYSCALL_WORK \
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT | \
diff --git a/arch/riscv/include/asm/uprobes.h b/arch/riscv/include/asm/uprobes.h
new file mode 100644
index 00000000..f2183e0
--- /dev/null
+++ b/arch/riscv/include/asm/uprobes.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_RISCV_UPROBES_H
+#define _ASM_RISCV_UPROBES_H
+
+#include <asm/probes.h>
+#include <asm/patch.h>
+#include <asm/bug.h>
+
+#define MAX_UINSN_BYTES		8
+
+#ifdef CONFIG_RISCV_ISA_C
+#define UPROBE_SWBP_INSN	__BUG_INSN_16
+#define UPROBE_SWBP_INSN_SIZE	2
+#else
+#define UPROBE_SWBP_INSN	__BUG_INSN_32
+#define UPROBE_SWBP_INSN_SIZE	4
+#endif
+#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+
+typedef u32 uprobe_opcode_t;
+
+struct arch_uprobe_task {
+	unsigned long   saved_cause;
+};
+
+struct arch_uprobe {
+	union {
+		u8 insn[MAX_UINSN_BYTES];
+		u8 ixol[MAX_UINSN_BYTES];
+	};
+	struct arch_probe_insn api;
+	unsigned long insn_size;
+	bool simulate;
+};
+
+bool uprobe_breakpoint_handler(struct pt_regs *regs);
+bool uprobe_single_step_handler(struct pt_regs *regs);
+
+#endif /* _ASM_RISCV_UPROBES_H */
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index abbd131..7f0840d 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
+obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
new file mode 100644
index 00000000..7a057b5
--- /dev/null
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/uprobes.h>
+
+#include "decode-insn.h"
+
+#define UPROBE_TRAP_NR	UINT_MAX
+
+bool is_swbp_insn(uprobe_opcode_t *insn)
+{
+#ifdef CONFIG_RISCV_ISA_C
+	return (*insn & 0xffff) == UPROBE_SWBP_INSN;
+#else
+	return *insn == UPROBE_SWBP_INSN;
+#endif
+}
+
+unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
+{
+	return instruction_pointer(regs);
+}
+
+int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
+			     unsigned long addr)
+{
+	probe_opcode_t opcode;
+
+	opcode = *(probe_opcode_t *)(&auprobe->insn[0]);
+
+	auprobe->insn_size = GET_INSN_LENGTH(opcode);
+
+	switch (riscv_probe_decode_insn(&opcode, &auprobe->api)) {
+	case INSN_REJECTED:
+		return -EINVAL;
+
+	case INSN_GOOD_NO_SLOT:
+		auprobe->simulate = true;
+		break;
+
+	case INSN_GOOD:
+		auprobe->simulate = false;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	utask->autask.saved_cause = current->thread.bad_cause;
+	current->thread.bad_cause = UPROBE_TRAP_NR;
+
+	instruction_pointer_set(regs, utask->xol_vaddr);
+
+	regs->status &= ~SR_SPIE;
+
+	return 0;
+}
+
+int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	WARN_ON_ONCE(current->thread.bad_cause != UPROBE_TRAP_NR);
+
+	instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
+
+	regs->status |= SR_SPIE;
+
+	return 0;
+}
+
+bool arch_uprobe_xol_was_trapped(struct task_struct *t)
+{
+	if (t->thread.bad_cause != UPROBE_TRAP_NR)
+		return true;
+
+	return false;
+}
+
+bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	probe_opcode_t insn;
+	unsigned long addr;
+
+	if (!auprobe->simulate)
+		return false;
+
+	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	addr = instruction_pointer(regs);
+
+	if (auprobe->api.handler)
+		auprobe->api.handler(insn, addr, regs);
+
+	return true;
+}
+
+void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	/*
+	 * Task has received a fatal signal, so reset back to probbed
+	 * address.
+	 */
+	instruction_pointer_set(regs, utask->vaddr);
+
+	regs->status &= ~SR_SPIE;
+}
+
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+		struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return regs->sp <= ret->stack;
+	else
+		return regs->sp < ret->stack;
+}
+
+unsigned long
+arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
+				  struct pt_regs *regs)
+{
+	unsigned long ra;
+
+	ra = regs->ra;
+
+	regs->ra = trampoline_vaddr;
+
+	return ra;
+}
+
+int arch_uprobe_exception_notify(struct notifier_block *self,
+				 unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
+bool uprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	if (uprobe_pre_sstep_notifier(regs))
+		return true;
+
+	return false;
+}
+
+bool uprobe_single_step_handler(struct pt_regs *regs)
+{
+	if (uprobe_post_sstep_notifier(regs))
+		return true;
+
+	return false;
+}
+
+void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+			   void *src, unsigned long len)
+{
+	/* Initialize the slot */
+	void *kaddr = kmap_atomic(page);
+	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+
+	memcpy(dst, src, len);
+
+	/* Add ebreak behind opcode to simulate singlestep */
+	if (vaddr) {
+		dst += GET_INSN_LENGTH(*(probe_opcode_t *)src);
+		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
+	}
+
+	kunmap_atomic(kaddr);
+
+	/*
+	 * We probably need flush_icache_user_page() but it needs vma.
+	 * This should work on most of architectures by default. If
+	 * architecture needs to do something different it can define
+	 * its own version of the function.
+	 */
+	flush_dcache_page(page);
+}
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index bc68418..18fd97a 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -309,6 +309,9 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 					   unsigned long thread_info_flags)
 {
+	if (thread_info_flags & _TIF_UPROBE)
+		uprobe_notify_resume(regs);
+
 	/* Handle pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 19a788a..2bca2fa 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -76,6 +76,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	unsigned long addr, const char *str)
 {
+	current->thread.bad_cause = regs->cause;
+
 	if (user_mode(regs)) {
 		do_trap(regs, signo, code, addr);
 	} else {
@@ -153,6 +155,14 @@ asmlinkage __visible void do_trap_break(struct pt_regs *regs)
 	if (kprobe_breakpoint_handler(regs))
 		return;
 #endif
+#ifdef CONFIG_UPROBES
+	if (uprobe_single_step_handler(regs))
+		return;
+
+	if (uprobe_breakpoint_handler(regs))
+		return;
+#endif
+	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
 		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 602f125..0c98db9 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -229,6 +229,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * in an atomic region, then we must not take the fault.
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
+		tsk->thread.bad_cause = cause;
 		no_context(regs, addr);
 		return;
 	}
@@ -246,16 +247,19 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	mmap_read_lock(mm);
 	vma = find_vma(mm, addr);
 	if (unlikely(!vma)) {
+		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
 		return;
 	}
 	if (likely(vma->vm_start <= addr))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
+		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
 		return;
 	}
 	if (unlikely(expand_stack(vma, addr))) {
+		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
 		return;
 	}
@@ -268,6 +272,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	code = SEGV_ACCERR;
 
 	if (unlikely(access_error(cause, vma))) {
+		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
 		return;
 	}
@@ -301,6 +306,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	mmap_read_unlock(mm);
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
+		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
 		return;
 	}
-- 
2.7.4

