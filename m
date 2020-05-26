Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44281AC04C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634093AbgDPLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506705AbgDPLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D1C0610D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ky754+CLVVHlV5y1DSkxULOOeWjje4mqYPKXavtHYsU=; b=k3tOsxmkzivYN/igBlDcBfD6Y7
        JmawlBC1GkqtV6DePDaYMGTIMOI52MTAN9bCE+l+nxazY6ugJ1Y5JpMyQa0opMqfy7Dphwo+EkZrr
        jGqj/5hJLjVxNvmI0MJAPaXJqBqV2qLeZjz31JJr6OnbEtxlOGMXIKCnzfI0oSzwLoSV/8/fkl5XK
        JBSXGhftt2Yfwg0S3qsTjAXg5sSrBC8keCjMXT3syJxcDP3IWukzxS4SkO/PaW5G4ME3ByxtBwXxD
        YG/nr+8xwPF+cG30L7lWCSrtUjvDFS5E2Q5XJ6O5yZLFQlARr/ENYbyJvh59RGXqdyX6CeECysqEr
        84qgDoxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34D-0004s0-U3; Thu, 16 Apr 2020 11:52:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38D7B307005;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 220392B0DE4C2; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.631224674@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 02/17] objtool: Better handle IRET
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool a little more about IRET so that we can avoid using the
SAVE/RESTORE annotation. In particular, make the weird corner case in
insn->restore go away.

The purpose of that corner case is to deal with the fact that
UNWIND_HINT_RESTORE lands on the instruction after IRET, but that
instruction can end up being outside the basic block, consider:

	if (cond)
		sync_core()
	foo();

Then the hint will land on foo(), and we'll encounter the restore
hint without ever having seen the save hint.

By teaching objtool about the arch specific exception frame size, and
assuming that any IRET in an STT_FUNC symbol is an exception frame
sized POP, we can remove the use of save/restore hints for this code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    2 --
 tools/objtool/arch.h             |    1 +
 tools/objtool/arch/x86/decode.c  |   14 ++++++++++++--
 tools/objtool/check.c            |   29 ++++++++++++++++-------------
 4 files changed, 29 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -727,7 +727,6 @@ static inline void sync_core(void)
 	unsigned int tmp;
 
 	asm volatile (
-		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
@@ -737,7 +736,6 @@ static inline void sync_core(void)
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
 		"iretq\n\t"
-		UNWIND_HINT_RESTORE
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -19,6 +19,7 @@ enum insn_type {
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
+	INSN_EXCEPTION_RETURN,
 	INSN_CONTEXT_SWITCH,
 	INSN_STACK,
 	INSN_BUG,
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -435,9 +435,19 @@ int arch_decode_instruction(struct elf *
 		*type = INSN_RETURN;
 		break;
 
+	case 0xcf: /* iret */
+		*type = INSN_EXCEPTION_RETURN;
+
+		/* add $40, %rsp */
+		op->src.type = OP_SRC_ADD;
+		op->src.reg = CFI_SP;
+		op->src.offset = 5*8;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = CFI_SP;
+		break;
+
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
-	case 0xcf: /* iret */
 		*type = INSN_CONTEXT_SWITCH;
 		break;
 
@@ -483,7 +493,7 @@ int arch_decode_instruction(struct elf *
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK)
+	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
 		list_add_tail(&op->list, ops_list);
 	else
 		free(op);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2080,15 +2080,14 @@ static int validate_return(struct symbol
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *first, struct insn_state state)
+			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *insn, *next_insn;
+	struct instruction *next_insn;
 	struct section *sec;
 	u8 visited;
 	int ret;
 
-	insn = first;
 	sec = insn->sec;
 
 	if (insn->alt_group && list_empty(&insn->alts)) {
@@ -2141,16 +2140,6 @@ static int validate_branch(struct objtoo
 				}
 
 				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
 					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
 						  sec, insn->offset);
 					return 1;
@@ -2243,6 +2232,20 @@ static int validate_branch(struct objtoo
 
 			break;
 
+		case INSN_EXCEPTION_RETURN:
+			if (handle_insn_ops(insn, &state))
+				return 1;
+
+			/*
+			 * This handles x86's sync_core() case, where we use an
+			 * IRET to self. All 'normal' IRET instructions are in
+			 * STT_NOTYPE entry symbols.
+			 */
+			if (func)
+				break;
+
+			return 0;
+
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
 				WARN_FUNC("unsupported instruction in callable function",


