Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B28291057
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437380AbgJQHHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437372AbgJQHHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:07:20 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948E720780;
        Sat, 17 Oct 2020 07:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602918438;
        bh=CGMVuWunYlXlS6scp6KuAmFR6frDmxHPue5V1gjRkvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OP3BNNoFmMB5wnUZylQSj/9FgXIxgtn0ziGR2hbOsKaaGIEfeqAC/Ct8Tyd8WrwBI
         7Ykn1DQHmcCWppoKyBkBQwre5/5f64a33QjKfuoeFOLAXCjUZWCJgVfeu/FvFHVc7z
         Gm3+tLEA/m+rZn6tF0fwTDIMBqqWP7eukgOHevBA=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 4/9] riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
Date:   Sat, 17 Oct 2020 07:06:12 +0000
Message-Id: <1602918377-23573-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602918377-23573-1-git-send-email-guoren@kernel.org>
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch changes the current detour mechanism of dynamic ftrace
which has been discussed during LPC 2020 RISCV-MC [1].

Before the patch, we used mcount for detour:
<funca>:
	addi sp,sp,-16
	sd   ra,8(sp)
	sd   s0,0(sp)
	addi s0,sp,16
	mv   a5,ra
	mv   a0,a5
	auipc ra,0x0 -> nop
	jalr  -296(ra) <_mcount@plt> ->nop
	...

After the patch:
<funca>:
	nop
	nop
	nop, nop
	nop, nop
	nop
	nop
	...

The mcount mechanism is mixed with gcc function prologue which is
not very clear. The patchable function entry just put 16 bytes nop
before the front of the function prologue which could be filled
with a separated detour mechanism.

[1] https://www.linuxplumbersconf.org/event/7/contributions/807/

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Alan Kao <alankao@andestech.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/Makefile            |   2 +
 arch/riscv/kernel/ftrace.c     |  94 +++++++++---------
 arch/riscv/kernel/mcount-dyn.S | 211 ++++++++++++++++-------------------------
 3 files changed, 131 insertions(+), 176 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index fb6e37d..599aed6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -12,6 +12,8 @@ OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux :=
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux := --no-relax
+	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=8
 endif
 
 ifeq ($(CONFIG_64BIT)$(CONFIG_CMODEL_MEDLOW),yy)
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 99e12fa..a4e66b4 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -72,29 +72,55 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 	return 0;
 }
 
+/*
+ * Put 5 instructions with 16 bytes at the front of function within
+ * patchable function entry nops' area.
+ *
+ * 0: addi   sp,sp,-8
+ * 1: sd     ra, 0(sp)
+ * 2: auipc  ra, 0x?
+ * 3: jalr   -?(ra)
+ * 4: ld     ra,0(sp)
+ * 5: addi   sp,sp,8
+ *
+ * So the opcodes is:
+ * 0: 0x1161
+ * 1: 0xe006
+ * 2: 0x????????
+ * 3: 0x????????
+ * 4: 0x6082
+ * 5: 0x0121
+ */
+#define INSN0_1		0xe0061161
+#define INSN4_5		0x01216082
+
+#define FUNC_ENTRY_SIZE	16
+#define FUNC_ENTRY_JMP	4
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	int ret = ftrace_check_current_call(rec->ip, NULL);
+	unsigned int call[4] = {INSN0_1, 0, 0, INSN4_5};
+	unsigned long target = addr;
+	unsigned long caller = rec->ip + FUNC_ENTRY_JMP;
 
-	if (ret)
-		return ret;
+	call[1] = to_auipc_insn((unsigned int)(target - caller));
+	call[2] = to_jalr_insn((unsigned int)(target - caller));
+
+	if (patch_text_nosync((void *)rec->ip, call, FUNC_ENTRY_SIZE))
+		return -EPERM;
 
-	return __ftrace_modify_call(rec->ip, addr, true);
+	return 0;
 }
 
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	unsigned int call[2];
-	int ret;
-
-	make_call(rec->ip, addr, call);
-	ret = ftrace_check_current_call(rec->ip, call);
+	unsigned int nops[4] = {NOP4, NOP4, NOP4, NOP4};
 
-	if (ret)
-		return ret;
+	if (patch_text_nosync((void *)rec->ip, nops, FUNC_ENTRY_SIZE))
+		return -EPERM;
 
-	return __ftrace_modify_call(rec->ip, addr, false);
+	return 0;
 }
 
 
@@ -139,15 +165,16 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
 	unsigned int call[2];
+	unsigned long caller = rec->ip + FUNC_ENTRY_JMP;
 	int ret;
 
-	make_call(rec->ip, old_addr, call);
-	ret = ftrace_check_current_call(rec->ip, call);
+	make_call(caller, old_addr, call);
+	ret = ftrace_check_current_call(caller, call);
 
 	if (ret)
 		return ret;
 
-	return __ftrace_modify_call(rec->ip, addr, true);
+	return __ftrace_modify_call(caller, addr, true);
 }
 #endif
 
@@ -176,53 +203,30 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern void ftrace_graph_call(void);
+extern void ftrace_graph_regs_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	unsigned int call[2];
-	static int init_graph = 1;
 	int ret;
 
-	make_call(&ftrace_graph_call, &ftrace_stub, call);
-
-	/*
-	 * When enabling graph tracer for the first time, ftrace_graph_call
-	 * should contains a call to ftrace_stub.  Once it has been disabled,
-	 * the 8-bytes at the position becomes NOPs.
-	 */
-	if (init_graph) {
-		ret = ftrace_check_current_call((unsigned long)&ftrace_graph_call,
-						call);
-		init_graph = 0;
-	} else {
-		ret = ftrace_check_current_call((unsigned long)&ftrace_graph_call,
-						NULL);
-	}
-
+	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
+				    (unsigned long)&prepare_ftrace_return, true);
 	if (ret)
 		return ret;
 
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
 				    (unsigned long)&prepare_ftrace_return, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	unsigned int call[2];
 	int ret;
 
-	make_call(&ftrace_graph_call, &prepare_ftrace_return, call);
-
-	/*
-	 * This is to make sure that ftrace_enable_ftrace_graph_caller
-	 * did the right thing.
-	 */
-	ret = ftrace_check_current_call((unsigned long)&ftrace_graph_call,
-					call);
-
+	ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
+				    (unsigned long)&prepare_ftrace_return, false);
 	if (ret)
 		return ret;
 
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
+	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
 				    (unsigned long)&prepare_ftrace_return, false);
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 35a6ed7..f49ac2d 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -13,117 +13,52 @@
 
 	.text
 
-	.macro SAVE_ABI_STATE
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi    sp, sp, -48
-	sd      s0, 32(sp)
-	sd      ra, 40(sp)
-	addi    s0, sp, 48
-	sd      t0, 24(sp)
-	sd      t1, 16(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	sd      t2, 8(sp)
-#endif
-#else
-	addi	sp, sp, -16
-	sd	s0, 0(sp)
-	sd	ra, 8(sp)
-	addi	s0, sp, 16
-#endif
-	.endm
-
-	.macro RESTORE_ABI_STATE
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	ld	s0, 32(sp)
-	ld	ra, 40(sp)
-	addi	sp, sp, 48
-#else
-	ld	ra, 8(sp)
-	ld	s0, 0(sp)
-	addi	sp, sp, 16
-#endif
+#define FENTRY_RA_OFFSET	12
+#define ABI_SIZE_ON_STACK	72
+#define ABI_A0			0
+#define ABI_A1			8
+#define ABI_A2			16
+#define ABI_A3			24
+#define ABI_A4			32
+#define ABI_A5			40
+#define ABI_A6			48
+#define ABI_A7			56
+#define ABI_RA			64
+
+	.macro SAVE_ABI
+	addi	sp, sp, -ABI_SIZE_ON_STACK
+
+	sd	a0, ABI_A0(sp)
+	sd	a1, ABI_A1(sp)
+	sd	a2, ABI_A2(sp)
+	sd	a3, ABI_A3(sp)
+	sd	a4, ABI_A4(sp)
+	sd	a5, ABI_A5(sp)
+	sd	a6, ABI_A6(sp)
+	sd	a7, ABI_A7(sp)
+	sd	ra, ABI_RA(sp)
 	.endm
 
-	.macro RESTORE_GRAPH_ARGS
-	ld	a0, 24(sp)
-	ld	a1, 16(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	ld	a2, 8(sp)
-#endif
+	.macro RESTORE_ABI
+	ld	a0, ABI_A0(sp)
+	ld	a1, ABI_A1(sp)
+	ld	a2, ABI_A2(sp)
+	ld	a3, ABI_A3(sp)
+	ld	a4, ABI_A4(sp)
+	ld	a5, ABI_A5(sp)
+	ld	a6, ABI_A6(sp)
+	ld	a7, ABI_A7(sp)
+	ld	ra, ABI_RA(sp)
+
+	addi	sp, sp, ABI_SIZE_ON_STACK
 	.endm
 
-ENTRY(ftrace_graph_caller)
-	addi	sp, sp, -16
-	sd	s0, 0(sp)
-	sd	ra, 8(sp)
-	addi	s0, sp, 16
-ftrace_graph_call:
-	.global ftrace_graph_call
-	/*
-	 * Calling ftrace_enable/disable_ftrace_graph_caller would overwrite the
-	 * call below.  Check ftrace_modify_all_code for details.
-	 */
-	call	ftrace_stub
-	ld	ra, 8(sp)
-	ld	s0, 0(sp)
-	addi	sp, sp, 16
-	ret
-ENDPROC(ftrace_graph_caller)
-
-ENTRY(ftrace_caller)
-	/*
-	 * a0: the address in the caller when calling ftrace_caller
-	 * a1: the caller's return address
-	 * a2: the address of global variable function_trace_op
-	 */
-	ld	a1, -8(s0)
-	addi	a0, ra, -MCOUNT_INSN_SIZE
-	la	t5, function_trace_op
-	ld	a2, 0(t5)
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/*
-	 * the graph tracer (specifically, prepare_ftrace_return) needs these
-	 * arguments but for now the function tracer occupies the regs, so we
-	 * save them in temporary regs to recover later.
-	 */
-	addi	t0, s0, -8
-	mv	t1, a0
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	ld	t2, -16(s0)
-#endif
-#endif
-
-	SAVE_ABI_STATE
-ftrace_call:
-	.global ftrace_call
-	/*
-	 * For the dynamic ftrace to work, here we should reserve at least
-	 * 8 bytes for a functional auipc-jalr pair.  The following call
-	 * serves this purpose.
-	 *
-	 * Calling ftrace_update_ftrace_func would overwrite the nops below.
-	 * Check ftrace_modify_all_code for details.
-	 */
-	call	ftrace_stub
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	RESTORE_GRAPH_ARGS
-	call	ftrace_graph_caller
-#endif
-
-	RESTORE_ABI_STATE
-	ret
-ENDPROC(ftrace_caller)
-
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 	.macro SAVE_ALL
-	addi	sp, sp, -(PT_SIZE_ON_STACK+16)
-	sd	s0, (PT_SIZE_ON_STACK)(sp)
-	sd	ra, (PT_SIZE_ON_STACK+8)(sp)
-	addi	s0, sp, (PT_SIZE_ON_STACK+16)
+	addi	sp, sp, -PT_SIZE_ON_STACK
 
 	sd x1,  PT_RA(sp)
+	sd x1,  PT_EPC(sp)
 	sd x2,  PT_SP(sp)
 	sd x3,  PT_GP(sp)
 	sd x4,  PT_TP(sp)
@@ -157,7 +92,7 @@ ENDPROC(ftrace_caller)
 	.endm
 
 	.macro RESTORE_ALL
-	ld x1,  PT_RA(sp)
+	ld x1,  PT_EPC(sp)
 	ld x2,  PT_SP(sp)
 	ld x3,  PT_GP(sp)
 	ld x4,  PT_TP(sp)
@@ -189,48 +124,62 @@ ENDPROC(ftrace_caller)
 	ld x30, PT_T5(sp)
 	ld x31, PT_T6(sp)
 
-	ld	s0, (PT_SIZE_ON_STACK)(sp)
-	ld	ra, (PT_SIZE_ON_STACK+8)(sp)
-	addi	sp, sp, (PT_SIZE_ON_STACK+16)
+	addi	sp, sp, PT_SIZE_ON_STACK
 	.endm
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
-	.macro RESTORE_GRAPH_REG_ARGS
-	ld	a0, PT_T0(sp)
-	ld	a1, PT_T1(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	ld	a2, PT_T2(sp)
-#endif
-	.endm
+ENTRY(ftrace_caller)
+	SAVE_ABI
 
-/*
- * Most of the contents are the same as ftrace_caller.
- */
-ENTRY(ftrace_regs_caller)
-	/*
-	 * a3: the address of all registers in the stack
-	 */
-	ld	a1, -8(s0)
-	addi	a0, ra, -MCOUNT_INSN_SIZE
-	la	t5, function_trace_op
-	ld	a2, 0(t5)
-	addi	a3, sp, -(PT_SIZE_ON_STACK+16)
+	addi	a0, ra, -FENTRY_RA_OFFSET
+	la	a1, function_trace_op
+	ld	a2, 0(a1)
+	ld	a1, ABI_SIZE_ON_STACK(sp)
+	mv	a3, sp
+
+ftrace_call:
+	.global ftrace_call
+	call	ftrace_stub
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	t0, s0, -8
-	mv	t1, a0
+	addi	a0, sp, ABI_SIZE_ON_STACK
+	ld	a1, ABI_RA(sp)
+	addi	a1, a1, -FENTRY_RA_OFFSET
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	ld	t2, -16(s0)
+	mv	a2, s0
 #endif
+ftrace_graph_call:
+	.global ftrace_graph_call
+	call	ftrace_stub
 #endif
+	RESTORE_ABI
+	ret
+ENDPROC(ftrace_caller)
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+ENTRY(ftrace_regs_caller)
 	SAVE_ALL
 
+	addi	a0, ra, -FENTRY_RA_OFFSET
+	la	a1, function_trace_op
+	ld	a2, 0(a1)
+	ld	a1, PT_SIZE_ON_STACK(sp)
+	mv	a3, sp
+
 ftrace_regs_call:
 	.global ftrace_regs_call
 	call	ftrace_stub
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	RESTORE_GRAPH_REG_ARGS
-	call	ftrace_graph_caller
+	addi	a0, sp, PT_SIZE_ON_STACK
+	ld	a1, PT_RA(sp)
+	addi	a1, a1, -FENTRY_RA_OFFSET
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	mv	a2, s0
+#endif
+ftrace_graph_regs_call:
+	.global ftrace_graph_regs_call
+	call	ftrace_stub
 #endif
 
 	RESTORE_ALL
-- 
2.7.4

