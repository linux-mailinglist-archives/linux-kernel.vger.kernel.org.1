Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C448F291051
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437349AbgJQHGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437119AbgJQHGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:06:43 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F4520758;
        Sat, 17 Oct 2020 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602918403;
        bh=8s8w/ArUyvs9nmV4DlskUsqaLc03Im0p3X5v6JuuvgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbsNyTPB8WZCGCK9dKDZoLamYvUDXoor2VcfjS83S2ol8oVBgWB2QNGuuqqV2qMAR
         WjalGvOxTQHmaDRH9HxlzvL30WqdIc2xBpF/hqJ+9WbmpOEuvNamWpiSytw8bkrKq6
         dHonManXPTeHiNzaNB/nAKZZfIyoyezAFPgCci3c=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v4 1/9] RISC-V: Implement ptrace regs and stack API
Date:   Sat, 17 Oct 2020 07:06:09 +0000
Message-Id: <1602918377-23573-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602918377-23573-1-git-send-email-guoren@kernel.org>
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Stählin <me@packi.ch>

Needed for kprobes support. Copied and adapted from arm64 code.

Guo Ren fixup pt_regs type for linux-5.8-rc1.

Signed-off-by: Patrick Stählin <me@packi.ch>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptrace.h | 29 ++++++++++++
 arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b7821ac..e6424d8b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -87,6 +87,7 @@ config RISCV
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select HAVE_REGS_AND_STACK_ACCESS_API
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index ee49f80..23372bb 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -8,6 +8,7 @@
 
 #include <uapi/asm/ptrace.h>
 #include <asm/csr.h>
+#include <linux/compiler.h>
 
 #ifndef __ASSEMBLY__
 
@@ -60,6 +61,7 @@ struct pt_regs {
 
 #define user_mode(regs) (((regs)->status & SR_PP) == 0)
 
+#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
 
 /* Helpers for working with the instruction pointer */
 static inline unsigned long instruction_pointer(struct pt_regs *regs)
@@ -85,6 +87,12 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 	regs->sp =  val;
 }
 
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->sp;
+}
+
 /* Helpers for working with the frame pointer */
 static inline unsigned long frame_pointer(struct pt_regs *regs)
 {
@@ -101,6 +109,27 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+extern int regs_query_register_offset(const char *name);
+extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+					       unsigned int n);
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	pt_regs from which register value is gotten
+ * @offset:	offset of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+					      unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2d6395f..1a85305 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -114,6 +114,105 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &riscv_user_native_view;
 }
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(epc),
+	REG_OFFSET_NAME(ra),
+	REG_OFFSET_NAME(sp),
+	REG_OFFSET_NAME(gp),
+	REG_OFFSET_NAME(tp),
+	REG_OFFSET_NAME(t0),
+	REG_OFFSET_NAME(t1),
+	REG_OFFSET_NAME(t2),
+	REG_OFFSET_NAME(s0),
+	REG_OFFSET_NAME(s1),
+	REG_OFFSET_NAME(a0),
+	REG_OFFSET_NAME(a1),
+	REG_OFFSET_NAME(a2),
+	REG_OFFSET_NAME(a3),
+	REG_OFFSET_NAME(a4),
+	REG_OFFSET_NAME(a5),
+	REG_OFFSET_NAME(a6),
+	REG_OFFSET_NAME(a7),
+	REG_OFFSET_NAME(s2),
+	REG_OFFSET_NAME(s3),
+	REG_OFFSET_NAME(s4),
+	REG_OFFSET_NAME(s5),
+	REG_OFFSET_NAME(s6),
+	REG_OFFSET_NAME(s7),
+	REG_OFFSET_NAME(s8),
+	REG_OFFSET_NAME(s9),
+	REG_OFFSET_NAME(s10),
+	REG_OFFSET_NAME(s11),
+	REG_OFFSET_NAME(t3),
+	REG_OFFSET_NAME(t4),
+	REG_OFFSET_NAME(t5),
+	REG_OFFSET_NAME(t6),
+	REG_OFFSET_NAME(status),
+	REG_OFFSET_NAME(badaddr),
+	REG_OFFSET_NAME(cause),
+	REG_OFFSET_NAME(orig_a0),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return (addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 void ptrace_disable(struct task_struct *child)
 {
 	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-- 
2.7.4

