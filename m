Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12A2AC9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgKJA4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJA4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:19 -0500
Received: from localhost.localdomain (i15-lef02-th2-89-83-252-17.ft.lns.abo.bbox.fr [89.83.252.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334F720809;
        Tue, 10 Nov 2020 00:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969778;
        bh=LgLMb0qN21dUbxMfRE9QmOEXE7hs+5iGRKqW7JyceBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwSZDamQ4i6VJjfLesv3Sz6MH3ltvkeu4sxgXo/SRKzs88FsOSFxbJh5R2dIcKIpY
         AAHJ18T2nl4+Z62RLwPbmcWESG+/VayiAHDJDnj1fj96eAachS2i/whVDW6txTRd+E
         WMHcryj3AT7rYSHA+CfKV5OhCpEMCD5JLhi3Ms3o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Date:   Tue, 10 Nov 2020 01:56:03 +0100
Message-Id: <20201110005609.40989-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110005609.40989-1-frederic@kernel.org>
References: <20201110005609.40989-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Provide a stub function that return 0 and wire up the static call site
patching to replace the CALL with a single 5 byte instruction that
clears %RAX, the return value register.

The function can be cast to any function pointer type that has a
single %RAX return (including pointers). Also provide a version that
returns an int for convenience. We are clearing the entire %RAX register
in any case, whether the return value is 32 or 64 bits, since %RAX is
always a scratch register anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
[fweisbec: s/disp16/data16, integrate into text_get_insn(), elaborate
 comment on the resulting insn, emulate on int3 trap, provide validation,
 uninline __static_call_return0() for HAVE_STATIC_CALL]
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/text-patching.h | 26 +++++++++++++++++++++++++-
 arch/x86/kernel/alternative.c        |  5 +++++
 arch/x86/kernel/static_call.c        | 10 ++++++++--
 include/linux/static_call.h          |  9 +++++++++
 kernel/static_call.c                 | 10 ++++++++++
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index b7421780e4e9..1250f440d1be 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -65,6 +65,9 @@ extern void text_poke_finish(void);
 #define JMP8_INSN_SIZE		2
 #define JMP8_INSN_OPCODE	0xEB
 
+#define XOR5RAX_INSN_SIZE	5
+#define XOR5RAX_INSN_OPCODE	0x31
+
 #define DISP32_SIZE		4
 
 static __always_inline int text_opcode_size(u8 opcode)
@@ -80,6 +83,7 @@ static __always_inline int text_opcode_size(u8 opcode)
 	__CASE(CALL);
 	__CASE(JMP32);
 	__CASE(JMP8);
+	__CASE(XOR5RAX);
 	}
 
 #undef __CASE
@@ -99,8 +103,21 @@ static __always_inline
 void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
 {
 	static union text_poke_insn insn; /* per instance */
-	int size = text_opcode_size(opcode);
+	int size;
 
+	if (opcode == XOR5RAX_INSN_OPCODE) {
+		/*
+		 * data16 data16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
+		 * The REX.W cancels the effect of any data16.
+		 */
+		static union text_poke_insn xor5rax = {
+			.text = { 0x66, 0x66, 0x48, 0x31, 0xc0 },
+		};
+
+		return &xor5rax.text;
+	}
+
+	size = text_opcode_size(opcode);
 	insn.opcode = opcode;
 
 	if (size > 1) {
@@ -165,6 +182,13 @@ void int3_emulate_ret(struct pt_regs *regs)
 	unsigned long ip = int3_emulate_pop(regs);
 	int3_emulate_jmp(regs, ip);
 }
+
+static __always_inline
+void int3_emulate_xor5rax(struct pt_regs *regs)
+{
+	regs->ax = 0;
+}
+
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2400ad62f330..37592f576a10 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1125,6 +1125,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 		int3_emulate_jmp(regs, (long)ip + tp->rel32);
 		break;
 
+	case XOR5RAX_INSN_OPCODE:
+		int3_emulate_xor5rax(regs);
+		break;
+
 	default:
 		BUG();
 	}
@@ -1291,6 +1295,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
 	case RET_INSN_OPCODE:
+	case XOR5RAX_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ca9a380d9c0b..3a36eaf3dd1f 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -18,7 +18,11 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 
 	switch (type) {
 	case CALL:
-		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		if (func == &__static_call_return0 ||
+		    func == &__static_call_returnl0)
+			code = text_gen_insn(XOR5RAX_INSN_OPCODE, insn, func);
+		else
+			code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
 		break;
 
 	case NOP:
@@ -54,7 +58,9 @@ static void __static_call_validate(void *insn, bool tail)
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5))
+		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5) ||
+		    !memcmp(insn, text_gen_insn(XOR5RAX_INSN_OPCODE, NULL, NULL),
+			    XOR5RAX_INSN_SIZE))
 			return;
 	}
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 695da4c9b338..055544793430 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -136,6 +136,9 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern int __static_call_return0(void);
+extern long __static_call_returnl0(void);
+
 extern int __init static_call_init(void);
 
 struct static_call_mod {
@@ -187,6 +190,9 @@ extern int static_call_text_reserved(void *start, void *end);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+extern int __static_call_return0(void);
+extern long __static_call_returnl0(void);
+
 static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
@@ -234,6 +240,9 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #else /* Generic implementation */
 
+static inline int __static_call_return0(void) { return 0; }
+static inline long __static_call_returnl0(void) { return 0; }
+
 static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 84565c2a41b8..3cb371e71be6 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -438,6 +438,16 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+int __static_call_return0(void)
+{
+	return 0;
+}
+
+long __static_call_returnl0(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
 static int func_a(int x)
-- 
2.25.1

