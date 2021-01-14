Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA52F6B62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbhANTmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730092AbhANTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKoLA+ZrYaxw4gOkq2dnL2+nhquG3713TlssJIRwSC0=;
        b=HUg1jw2WJaluDFgyWvq6TaYxxdJUwWCZn6KnB1VVjBcJrjg6oTL5hSmpLlrxKmeT9iP4wb
        MLf5J6K0dTlLXciZ6tEuiGp3/sJ7pWKQw9zChBJCWo3Fcy5N1pgcarfMzApOCotsU1Aqwu
        5/xpI36CkBtoZJ61f3hkLvPQEFld4A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-8HpPzK8BNLCWje9kbN9bCg-1; Thu, 14 Jan 2021 14:41:07 -0500
X-MC-Unique: 8HpPzK8BNLCWje9kbN9bCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51668030A0;
        Thu, 14 Jan 2021 19:41:05 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1721001E73;
        Thu, 14 Jan 2021 19:41:01 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 09/21] objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC
Date:   Thu, 14 Jan 2021 13:40:05 -0600
Message-Id: <86820e8b33d36ee9c28adcf3d2525f0cd05fb0ad.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ORC metadata generated for UNWIND_HINT_FUNC isn't actually very
func-like.  With certain usages it can cause stack state mismatches
because it doesn't set the return address (CFI_RA).

Also, users of UNWIND_HINT_RET_OFFSET no longer need to set a custom
return stack offset.  Instead they just need to specify a func-like
situation, so the current ret_offset code is hacky for no good reason.

Solve both problems by simplifying the RET_OFFSET handling and
converting it into a more useful UNWIND_HINT_FUNC.

If we end up needing the old 'ret_offset' functionality again in the
future, we should be able to support it pretty easily with the addition
of a custom 'sp_offset' in UNWIND_HINT_FUNC.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/unwind_hints.h | 13 ++--------
 arch/x86/kernel/ftrace_64.S         |  2 +-
 arch/x86/lib/retpoline.S            |  2 +-
 include/linux/objtool.h             |  5 +++-
 tools/include/linux/objtool.h       |  5 +++-
 tools/objtool/arch/x86/decode.c     |  4 ++--
 tools/objtool/check.c               | 37 ++++++++++++-----------------
 tools/objtool/check.h               |  1 -
 8 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 664d4610d700..8e574c0afef8 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -48,17 +48,8 @@
 	UNWIND_HINT_REGS base=\base offset=\offset partial=1
 .endm
 
-.macro UNWIND_HINT_FUNC sp_offset=8
-	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
-.endm
-
-/*
- * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
- * and sibling calls. On these, sp_offset denotes the expected offset from
- * initial_func_cfi.
- */
-.macro UNWIND_HINT_RET_OFFSET sp_offset=8
-	UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
+.macro UNWIND_HINT_FUNC
+	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=8 type=UNWIND_HINT_TYPE_FUNC
 .endm
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 58d125ed9d1a..1bf568d901b1 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -277,7 +277,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	restore_mcount_regs 8
 	/* Restore flags */
 	popfq
-	UNWIND_HINT_RET_OFFSET
+	UNWIND_HINT_FUNC
 	jmp	ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index b4c43a9b1483..f6fb1d218dcc 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -28,7 +28,7 @@ SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
 	jmp	.Lspec_trap_\@
 .Ldo_rop_\@:
 	mov	%\reg, (%_ASM_SP)
-	UNWIND_HINT_RET_OFFSET
+	UNWIND_HINT_FUNC
 	ret
 SYM_FUNC_END(__x86_retpoline_\reg)
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index add1c6eb157e..7e72d975cb76 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -29,11 +29,14 @@ struct unwind_hint {
  *
  * UNWIND_HINT_TYPE_REGS_PARTIAL: Used in entry code to indicate that
  * sp_reg+sp_offset points to the iret return frame.
+ *
+ * UNWIND_HINT_FUNC: Generate the unwind metadata of a callable function.
+ * Useful for code which doesn't have an ELF function annotation.
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
-#define UNWIND_HINT_TYPE_RET_OFFSET	3
+#define UNWIND_HINT_TYPE_FUNC		3
 
 #ifdef CONFIG_STACK_VALIDATION
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index add1c6eb157e..7e72d975cb76 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -29,11 +29,14 @@ struct unwind_hint {
  *
  * UNWIND_HINT_TYPE_REGS_PARTIAL: Used in entry code to indicate that
  * sp_reg+sp_offset points to the iret return frame.
+ *
+ * UNWIND_HINT_FUNC: Generate the unwind metadata of a callable function.
+ * Useful for code which doesn't have an ELF function annotation.
  */
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
-#define UNWIND_HINT_TYPE_RET_OFFSET	3
+#define UNWIND_HINT_TYPE_FUNC		3
 
 #ifdef CONFIG_STACK_VALIDATION
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cde9c36e40ae..6f5a45754ad8 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -563,8 +563,8 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->cfa.offset = 8;
 
 	/* initial RA (return address) */
-	state->regs[16].base = CFI_CFA;
-	state->regs[16].offset = -8;
+	state->regs[CFI_RA].base = CFI_CFA;
+	state->regs[CFI_RA].offset = -8;
 }
 
 const char *arch_nop_insn(int len)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d833855f3aa8..6636f4fd694a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1400,13 +1400,20 @@ static int add_jump_table_alts(struct objtool_file *file)
 	return 0;
 }
 
+static void set_func_state(struct cfi_state *state)
+{
+	state->cfa = initial_func_cfi.cfa;
+	memcpy(&state->regs, &initial_func_cfi.regs,
+	       CFI_NUM_REGS * sizeof(struct cfi_reg));
+	state->stack_size = initial_func_cfi.cfa.offset;
+}
+
 static int read_unwind_hints(struct objtool_file *file)
 {
 	struct section *sec, *relocsec;
 	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
-	struct cfi_reg *cfa;
 	int i;
 
 	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1441,22 +1448,20 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa = &insn->cfi.cfa;
+		insn->hint = true;
 
-		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
+		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
+			set_func_state(&insn->cfi);
 			continue;
 		}
 
-		insn->hint = true;
-
 		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
 		}
 
-		cfa->offset = hint->sp_offset;
+		insn->cfi.cfa.offset = hint->sp_offset;
 		insn->cfi.type = hint->type;
 		insn->cfi.end = hint->end;
 	}
@@ -1712,27 +1717,18 @@ static bool is_fentry_call(struct instruction *insn)
 
 static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
-	u8 ret_offset = insn->ret_offset;
 	struct cfi_state *cfi = &state->cfi;
 	int i;
 
 	if (cfi->cfa.base != initial_func_cfi.cfa.base || cfi->drap)
 		return true;
 
-	if (cfi->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
+	if (cfi->cfa.offset != initial_func_cfi.cfa.offset)
 		return true;
 
-	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
+	if (cfi->stack_size != initial_func_cfi.cfa.offset)
 		return true;
 
-	/*
-	 * If there is a ret offset hint then don't check registers
-	 * because a callee-saved register might have been pushed on
-	 * the stack.
-	 */
-	if (ret_offset)
-		return false;
-
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)
@@ -2824,10 +2820,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 			continue;
 
 		init_insn_state(&state, sec);
-		state.cfi.cfa = initial_func_cfi.cfa;
-		memcpy(&state.cfi.regs, &initial_func_cfi.regs,
-		       CFI_NUM_REGS * sizeof(struct cfi_reg));
-		state.cfi.stack_size = initial_func_cfi.cfa.offset;
+		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
 	}
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 2804848e628e..4615ca210fae 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,7 +33,6 @@ struct instruction {
 	bool retpoline_safe;
 	s8 instr;
 	u8 visited;
-	u8 ret_offset;
 	int alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
-- 
2.29.2

