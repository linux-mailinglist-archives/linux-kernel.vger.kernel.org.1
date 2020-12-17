Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690F22DD4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgLQQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbgLQQFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:05:53 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org,
        bjorn.topel@intel.com, pdp7pdp7@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v5 9/9] riscv: Add support for function error injection
Date:   Thu, 17 Dec 2020 16:01:45 +0000
Message-Id: <1608220905-1962-10-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608220905-1962-1-git-send-email-guoren@kernel.org>
References: <1608220905-1962-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Inspired by the commit 42d038c4fb00 ("arm64: Add support for function
error injection"), this patch supports function error injection for
riscv.

This patch mainly support two functions: one is regs_set_return_value()
which is used to overwrite the return value; the another function is
override_function_with_return() which is to override the probed
function returning and jump to its caller.

Test log:
 cd /sys/kernel/debug/fail_function
 echo sys_clone > inject
 echo 100 > probability
 echo 1 > interval
 ls /
[  313.176875] FAULT_INJECTION: forcing a failure.
[  313.176875] name fail_function, interval 1, probability 100, space 0, times 1
[  313.184357] CPU: 0 PID: 87 Comm: sh Not tainted 5.8.0-rc5-00007-g6a758cc #117
[  313.187616] Call Trace:
[  313.189100] [<ffffffe0002036b6>] walk_stackframe+0x0/0xc2
[  313.191626] [<ffffffe00020395c>] show_stack+0x40/0x4c
[  313.193927] [<ffffffe000556c60>] dump_stack+0x7c/0x96
[  313.194795] [<ffffffe0005522e8>] should_fail+0x140/0x142
[  313.195923] [<ffffffe000299ffc>] fei_kprobe_handler+0x2c/0x5a
[  313.197687] [<ffffffe0009e2ec4>] kprobe_breakpoint_handler+0xb4/0x18a
[  313.200054] [<ffffffe00020357e>] do_trap_break+0x36/0xca
[  313.202147] [<ffffffe000201bca>] ret_from_exception+0x0/0xc
[  313.204556] [<ffffffe000201bbc>] ret_from_syscall+0x0/0x2
-sh: can't fork: Invalid argument

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptrace.h |  6 ++++++
 arch/riscv/lib/Makefile         |  2 ++
 arch/riscv/lib/error-inject.c   | 10 ++++++++++
 4 files changed, 19 insertions(+)
 create mode 100644 arch/riscv/lib/error-inject.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index af0ec36..a627ae2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -67,6 +67,7 @@ config RISCV
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index 23372bb..cb4abb6 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -109,6 +109,12 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs,
+					 unsigned long val)
+{
+	regs->a0 = val;
+}
+
 extern int regs_query_register_offset(const char *name);
 extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 					       unsigned int n);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 47e7a82..699ed20 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -4,3 +4,5 @@ lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
+
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/riscv/lib/error-inject.c b/arch/riscv/lib/error-inject.c
new file mode 100644
index 00000000..d667ade
--- /dev/null
+++ b/arch/riscv/lib/error-inject.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	instruction_pointer_set(regs, regs->ra);
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.7.4

