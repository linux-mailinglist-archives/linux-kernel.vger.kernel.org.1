Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191262DE3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgLROMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgLROMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:12:54 -0500
From:   Masami Hiramatsu <mhiramat@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: [PATCH -tip v2] x86/kprobes: Do not decode opcode in resume_execution()
Date:   Fri, 18 Dec 2020 23:12:05 +0900
Message-Id: <160830072561.349576.3014979564448023213.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218214432.b025656de019c64a8f4e2da5@kernel.org>
References: <20201218214432.b025656de019c64a8f4e2da5@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kprobes x86 decodes opcode right after single
stepping in resume_execution(). But it already decoded the
opcode while preparing arch_specific_insn in arch_copy_kprobe().

This decodes opcode in arch_copy_kprobe() instead of
resume_execution() and sets some flags which classifies
the opcode for resuming process.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Changes in v2:
  - Fix the timing of memset() for avoiding unexpected
    cleanup of kprobe.ainsn.insn.
---
 arch/x86/include/asm/kprobes.h |   11 ++-
 arch/x86/kernel/kprobes/core.c |  167 ++++++++++++++++++----------------------
 2 files changed, 81 insertions(+), 97 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 991a7ad540c7..d20a3d6be36e 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -58,14 +58,17 @@ struct arch_specific_insn {
 	/* copy of the original instruction */
 	kprobe_opcode_t *insn;
 	/*
-	 * boostable = false: This instruction type is not boostable.
-	 * boostable = true: This instruction has been boosted: we have
+	 * boostable = 0: This instruction type is not boostable.
+	 * boostable = 1: This instruction has been boosted: we have
 	 * added a relative jump after the instruction copy in insn,
 	 * so no single-step and fixup are needed (unless there's
 	 * a post_handler).
 	 */
-	bool boostable;
-	bool if_modifier;
+	unsigned boostable:1;
+	unsigned if_modifier:1;
+	unsigned is_call:1;
+	unsigned is_pushf:1;
+	unsigned is_abs_ip:1;
 	/* Number of bytes of text poked */
 	int tp_len;
 };
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 547c7abb39f5..01440e57961b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -132,26 +132,6 @@ void synthesize_relcall(void *dest, void *from, void *to)
 }
 NOKPROBE_SYMBOL(synthesize_relcall);
 
-/*
- * Skip the prefixes of the instruction.
- */
-static kprobe_opcode_t *skip_prefixes(kprobe_opcode_t *insn)
-{
-	insn_attr_t attr;
-
-	attr = inat_get_opcode_attribute((insn_byte_t)*insn);
-	while (inat_is_legacy_prefix(attr)) {
-		insn++;
-		attr = inat_get_opcode_attribute((insn_byte_t)*insn);
-	}
-#ifdef CONFIG_X86_64
-	if (inat_is_rex_prefix(attr))
-		insn++;
-#endif
-	return insn;
-}
-NOKPROBE_SYMBOL(skip_prefixes);
-
 /*
  * Returns non-zero if INSN is boostable.
  * RIP relative instructions are adjusted at copying time in 64 bits mode
@@ -311,25 +291,6 @@ static int can_probe(unsigned long paddr)
 	return (addr == paddr);
 }
 
-/*
- * Returns non-zero if opcode modifies the interrupt flag.
- */
-static int is_IF_modifier(kprobe_opcode_t *insn)
-{
-	/* Skip prefixes */
-	insn = skip_prefixes(insn);
-
-	switch (*insn) {
-	case 0xfa:		/* cli */
-	case 0xfb:		/* sti */
-	case 0xcf:		/* iret/iretd */
-	case 0x9d:		/* popf/popfd */
-		return 1;
-	}
-
-	return 0;
-}
-
 /*
  * Copy an instruction with recovering modified instruction by kprobes
  * and adjust the displacement if the instruction uses the %rip-relative
@@ -411,9 +372,9 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 		synthesize_reljump(buf + len, p->ainsn.insn + len,
 				   p->addr + insn->length);
 		len += JMP32_INSN_SIZE;
-		p->ainsn.boostable = true;
+		p->ainsn.boostable = 1;
 	} else {
-		p->ainsn.boostable = false;
+		p->ainsn.boostable = 0;
 	}
 
 	return len;
@@ -450,6 +411,67 @@ void free_insn_page(void *page)
 	module_memfree(page);
 }
 
+static void set_resume_flags(struct kprobe *p, struct insn *insn)
+{
+	insn_byte_t opcode = insn->opcode.bytes[0];
+
+	switch (opcode) {
+	case 0xfa:		/* cli */
+	case 0xfb:		/* sti */
+	case 0x9d:		/* popf/popfd */
+		/* Check whether the instruction modifies Interrupt Flag or not */
+		p->ainsn.if_modifier = 1;
+		break;
+	case 0x9c:	/* pushfl */
+		p->ainsn.is_pushf = 1;
+		break;
+	case 0xcf:	/* iret */
+		p->ainsn.if_modifier = 1;
+		fallthrough;
+	case 0xc2:	/* ret/lret */
+	case 0xc3:
+	case 0xca:
+	case 0xcb:
+	case 0xea:	/* jmp absolute -- ip is correct */
+		/* ip is already adjusted, no more changes required */
+		p->ainsn.is_abs_ip = 1;
+		/* Without resume jump, this is boostable */
+		p->ainsn.boostable = 1;
+		break;
+	case 0xe8:	/* call relative - Fix return addr */
+		p->ainsn.is_call = 1;
+		break;
+#ifdef CONFIG_X86_32
+	case 0x9a:	/* call absolute -- same as call absolute, indirect */
+		p->ainsn.is_call = 1;
+		p->ainsn.is_abs_ip = 1;
+		break;
+#endif
+	case 0xff:
+		opcode = insn->opcode.bytes[1];
+		if ((opcode & 0x30) == 0x10) {
+			/*
+			 * call absolute, indirect
+			 * Fix return addr; ip is correct.
+			 * But this is not boostable
+			 */
+			p->ainsn.is_call = 1;
+			p->ainsn.is_abs_ip = 1;
+			break;
+		} else if (((opcode & 0x31) == 0x20) ||
+			   ((opcode & 0x31) == 0x21)) {
+			/*
+			 * jmp near and far, absolute indirect
+			 * ip is correct.
+			 */
+			p->ainsn.is_abs_ip = 1;
+			/* Without resume jump, this is boostable */
+			p->ainsn.boostable = 1;
+		}
+		break;
+	}
+}
+
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	struct insn insn;
@@ -467,8 +489,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 	 */
 	len = prepare_boost(buf, p, &insn);
 
-	/* Check whether the instruction modifies Interrupt Flag or not */
-	p->ainsn.if_modifier = is_IF_modifier(buf);
+	/* Analyze the opcode and set resume flags */
+	set_resume_flags(p, &insn);
 
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
@@ -491,6 +513,9 @@ int arch_prepare_kprobe(struct kprobe *p)
 
 	if (!can_probe((unsigned long)p->addr))
 		return -EILSEQ;
+
+	memset(&p->ainsn, 0, sizeof(p->ainsn));
+
 	/* insn: must be on special executable page on x86. */
 	p->ainsn.insn = get_insn_slot();
 	if (!p->ainsn.insn)
@@ -806,11 +831,6 @@ NOKPROBE_SYMBOL(trampoline_handler);
  * 2) If the single-stepped instruction was a call, the return address
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
- *
- * If this is the first time we've single-stepped the instruction at
- * this probepoint, and the instruction is boostable, boost it: add a
- * jump instruction after the copied instruction, that jumps to the next
- * instruction after the probepoint.
  */
 static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 			     struct kprobe_ctlblk *kcb)
@@ -818,59 +838,20 @@ static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 	unsigned long *tos = stack_addr(regs);
 	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
 	unsigned long orig_ip = (unsigned long)p->addr;
-	kprobe_opcode_t *insn = p->ainsn.insn;
-
-	/* Skip prefixes */
-	insn = skip_prefixes(insn);
 
 	regs->flags &= ~X86_EFLAGS_TF;
-	switch (*insn) {
-	case 0x9c:	/* pushfl */
+
+	/* Fixup the contents of top of stack */
+	if (p->ainsn.is_pushf) {
 		*tos &= ~(X86_EFLAGS_TF | X86_EFLAGS_IF);
 		*tos |= kcb->kprobe_old_flags;
-		break;
-	case 0xc2:	/* iret/ret/lret */
-	case 0xc3:
-	case 0xca:
-	case 0xcb:
-	case 0xcf:
-	case 0xea:	/* jmp absolute -- ip is correct */
-		/* ip is already adjusted, no more changes required */
-		p->ainsn.boostable = true;
-		goto no_change;
-	case 0xe8:	/* call relative - Fix return addr */
+	} else if (p->ainsn.is_call) {
 		*tos = orig_ip + (*tos - copy_ip);
-		break;
-#ifdef CONFIG_X86_32
-	case 0x9a:	/* call absolute -- same as call absolute, indirect */
-		*tos = orig_ip + (*tos - copy_ip);
-		goto no_change;
-#endif
-	case 0xff:
-		if ((insn[1] & 0x30) == 0x10) {
-			/*
-			 * call absolute, indirect
-			 * Fix return addr; ip is correct.
-			 * But this is not boostable
-			 */
-			*tos = orig_ip + (*tos - copy_ip);
-			goto no_change;
-		} else if (((insn[1] & 0x31) == 0x20) ||
-			   ((insn[1] & 0x31) == 0x21)) {
-			/*
-			 * jmp near and far, absolute indirect
-			 * ip is correct. And this is boostable
-			 */
-			p->ainsn.boostable = true;
-			goto no_change;
-		}
-	default:
-		break;
 	}
 
-	regs->ip += orig_ip - copy_ip;
+	if (!p->ainsn.is_abs_ip)
+		regs->ip += orig_ip - copy_ip;
 
-no_change:
 	restore_btf();
 }
 NOKPROBE_SYMBOL(resume_execution);

