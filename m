Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5054E2486D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHROMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHROMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A869C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZUO5Vp9OkQgSb6VnFGJoTj57+Y0nzg4Wq9DZKNwafHk=; b=FQ6CVbjb48m+SLKYl65HtFhaVb
        zHyTF96LIHATyuJyAF0/td196q7gLEAK9F3ZQxZc9ldgoLLdpIMO3onYfFkE/2BqcaVe6XRw2mFZd
        cSnuoSHD/SnJYKJ3slgvn5GaR/Q6HyM1DZ9RR52XSkdZWbbCGcQF8Ys57vcetG/gPNXbm6d3+/Ngy
        oxHYosbntJURxFYaS0SWCDQJsZreXAK9az0vcK99jSgTO1Zdd7iVvzuPuXwTUrqmYH3amnKIEcCld
        dbsqXFVcQDPAoFpCoDtaL3BXUPCPiDwyYXBgKgoWFV8FjBENJy3uo1+0kdtzDv/YMPzDr0mTztTZf
        mWVvLC4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LK-0000oE-Tz; Tue, 18 Aug 2020 14:12:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A931A307943;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C96A723D42C0C; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135804.982214828@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 12/18] x86/alternatives: Teach text_poke_bp() to emulate RET
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future patches will need to poke a RET instruction, provide the
infrastructure required for this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/text-patching.h |   19 +++++++++++++++++++
 arch/x86/kernel/alternative.c        |    5 +++++
 2 files changed, 24 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -53,6 +53,9 @@ extern void text_poke_finish(void);
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
 
+#define RET_INSN_SIZE		1
+#define RET_INSN_OPCODE		0xC3
+
 #define CALL_INSN_SIZE		5
 #define CALL_INSN_OPCODE	0xE8
 
@@ -73,6 +76,7 @@ static __always_inline int text_opcode_s
 
 	switch(opcode) {
 	__CASE(INT3);
+	__CASE(RET);
 	__CASE(CALL);
 	__CASE(JMP32);
 	__CASE(JMP8);
@@ -141,11 +145,26 @@ void int3_emulate_push(struct pt_regs *r
 }
 
 static __always_inline
+unsigned long int3_emulate_pop(struct pt_regs *regs)
+{
+	unsigned long val = *(unsigned long *)regs->sp;
+	regs->sp += sizeof(unsigned long);
+	return val;
+}
+
+static __always_inline
 void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
 }
+
+static __always_inline
+void int3_emulate_ret(struct pt_regs *regs)
+{
+	unsigned long ip = int3_emulate_pop(regs);
+	int3_emulate_jmp(regs, ip);
+}
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1099,6 +1099,10 @@ int noinstr poke_int3_handler(struct pt_
 		 */
 		goto out_put;
 
+	case RET_INSN_OPCODE:
+		int3_emulate_ret(regs);
+		break;
+
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
 		break;
@@ -1240,6 +1244,7 @@ static void text_poke_loc_init(struct te
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
+	case RET_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:


