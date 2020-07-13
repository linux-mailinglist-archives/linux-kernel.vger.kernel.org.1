Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6421B6F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgGJNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgGJNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2732BC08E763
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PfIDtm2QE+K/DkBlMYuOcQsFGoqkqG/xnPE/RJe+5QA=; b=i1fn4+VjxYP7gNCGsgTNCZBtQN
        0xgBYBAizPgw/oSRWjiTE/D++hur+hEgvLm+oVzu+msU1n75EkKI9HZsHDUPZ4dr+F8PwGIxt/5lo
        VhTh3n/jb5oXC+f0H+TaPV1VZeN+ImMUcD2+FZYwzzDXFqkNDeAy0Ffibicber8gi2Nbjogqc+5jj
        f/loPYeDkWeu001iaoadGNTyV1oZEu4bAtjd/7slPq3zJExibtRYn5PxGiz88tHXDfdKolLu+xdW5
        4D8Sd9nfHaYkMxTltgHc3cbbqfFccxi4tUv00eZ142DRIgSTXv9QEvgnnYXgftyaXaUg5s0+Kxzsn
        a47PRBUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttK2-000184-4i; Fri, 10 Jul 2020 13:44:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9F95307989;
        Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1448D2B7A733D; Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Message-ID: <20200710134336.918547865@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Jul 2020 15:38:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v6 13/17] static_call: Add static_call_cond()
References: <20200710133831.943894387@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the static_call infrastructure to optimize the following common
pattern:

	if (func_ptr)
		func_ptr(args...)

For the trampoline (which is in effect a tail-call), we patch the
JMP.d32 into a RET, which then directly consumes the trampoline call.

For the in-line sites we replace the CALL with a NOP5.

NOTE: this is 'obviously' limited to functions with a 'void' return type.

NOTE: DEFINE_STATIC_COND_CALL() only requires a typename, as opposed
      to a full function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/static_call.h |   12 +++--
 arch/x86/kernel/static_call.c      |   42 +++++++++++++-----
 include/linux/static_call.h        |   86 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -20,15 +20,21 @@
  * it does tail-call optimization on the call; since you cannot compute the
  * relative displacement across sections.
  */
-#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns)			\
 	asm(".pushsection .static_call.text, \"ax\"		\n"	\
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
-	    "	.byte 0xe9 # jmp.d32				\n"	\
-	    "	.long " #func " - (. + 4)			\n"	\
+	    insns "						\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
 	    ".popsection					\n")
 
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
+
 #endif /* _ASM_STATIC_CALL_H */
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -4,19 +4,41 @@
 #include <linux/bug.h>
 #include <asm/text-patching.h>
 
-static void __static_call_transform(void *insn, u8 opcode, void *func)
+enum insn_type {
+	CALL = 0, /* site call */
+	NOP = 1,  /* site cond-call */
+	JMP = 2,  /* tramp / site tail-call */
+	RET = 3,  /* tramp / site cond-tail-call */
+};
+
+static void __static_call_transform(void *insn, enum insn_type type, void *func)
 {
-	const void *code = text_gen_insn(opcode, insn, func);
+	int size = CALL_INSN_SIZE;
+	const void *code;
 
-	if (WARN_ONCE(*(u8 *)insn != opcode,
-		      "unexpected static call insn opcode 0x%x at %pS\n",
-		      opcode, insn))
-		return;
+	switch (type) {
+	case CALL:
+		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		break;
+
+	case NOP:
+		code = ideal_nops[NOP_ATOMIC5];
+		break;
+
+	case JMP:
+		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
+		break;
+
+	case RET:
+		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
+		size = RET_INSN_SIZE;
+		break;
+	}
 
-	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
+	if (memcmp(insn, code, size) == 0)
 		return;
 
-	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);
+	text_poke_bp(insn, code, size, NULL);
 }
 
 void arch_static_call_transform(void *site, void *tramp, void *func)
@@ -24,10 +46,10 @@ void arch_static_call_transform(void *si
 	mutex_lock(&text_mutex);
 
 	if (tramp)
-		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
+		__static_call_transform(tramp, func ? JMP : RET, func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, CALL_INSN_OPCODE, func);
+		__static_call_transform(site, func ? CALL : NOP, func);
 
 	mutex_unlock(&text_mutex);
 }
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -16,7 +16,9 @@
  *
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
+ *   DEFINE_STATIC_CALL_NULL(name, typename);
  *   static_call(name)(args...);
+ *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
  *
  * Usage example:
@@ -52,6 +54,43 @@
  *   rather than calling through the trampoline.  This requires objtool or a
  *   compiler plugin to detect all the static_call() sites and annotate them
  *   in the .static_call_sites section.
+ *
+ *
+ * Notes on NULL function pointers:
+ *
+ *   Static_call()s support NULL functions, with many of the caveats that
+ *   regular function pointers have.
+ *
+ *   Clearly calling a NULL function pointer is 'BAD', so too for
+ *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
+ *   fatal). A NULL static_call can be the result of:
+ *
+ *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
+ *
+ *   which is equivalent to declaring a NULL function pointer with just a
+ *   typename:
+ *
+ *     void (*my_func_ptr)(int arg1) = NULL;
+ *
+ *   or using static_call_update() with a NULL function. In both cases the
+ *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
+ *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
+ *   architectures can patch the trampoline call to a NOP.
+ *
+ *   In all cases, any argument evaluation is unconditional. Unlike a regular
+ *   conditional function pointer call:
+ *
+ *     if (my_func_ptr)
+ *         my_func_ptr(arg1)
+ *
+ *   where the argument evaludation also depends on the pointer value.
+ *
+ *   When calling a static_call that can be NULL, use:
+ *
+ *     static_call_cond(name)(arg1);
+ *
+ *   which will include the required value tests to avoid NULL-pointer
+ *   dereferences.
  */
 
 #include <linux/types.h>
@@ -120,7 +159,16 @@ extern int static_call_text_reserved(voi
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
 #define static_call(name)	__static_call(name)
+#define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
@@ -143,7 +191,15 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
 #define static_call(name)	__static_call(name)
+#define static_call_cond(name)	(void)__static_call(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -179,9 +235,39 @@ struct static_call_key {
 		.func = _func,						\
 	}
 
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+	}
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
+static inline void __static_call_nop(void) { }
+
+/*
+ * This horrific hack takes care of two things:
+ *
+ *  - it ensures the compiler will only load the function pointer ONCE,
+ *    which avoids a reload race.
+ *
+ *  - it ensures the argument evaluation is unconditional, similar
+ *    to the HAVE_STATIC_CALL variant.
+ *
+ * Sadly current GCC/Clang (10 for both) do not optimize this properly
+ * and will emit an indirect call for the NULL case :-(
+ */
+#define __static_call_cond(name)					\
+({									\
+	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
+	if (!func)							\
+		func = &__static_call_nop;				\
+	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
+})
+
+#define static_call_cond(name)	(void)__static_call_cond(name)
+
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {


