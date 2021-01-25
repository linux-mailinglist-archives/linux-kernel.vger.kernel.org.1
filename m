Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37688302A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbhAYSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbhAYShG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:37:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7A622B3F;
        Mon, 25 Jan 2021 18:36:24 +0000 (UTC)
Date:   Mon, 25 Jan 2021 13:36:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86_64: Update the NMI handler nesting logic comment
Message-ID: <20210125133622.7aea0401@gandalf.local.home>
In-Reply-To: <4415FFC4-995A-4C77-9A96-744ED697AF05@amacapital.net>
References: <20210125123859.39b244ca@gandalf.local.home>
        <4415FFC4-995A-4C77-9A96-744ED697AF05@amacapital.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The NMI handler on x86 needs to deal with nested NMIs becaues if an NMI
takes an exception (page fault or breakpoint), the exception handle triggers
a iretq which unlatches NMIs in the hardware allowing for another NMI to
take place.

The current code does a bit of work arounds to handle this case, and over
time it has changed to become safer and more efficient. But the comment has
not kept up as much to the current logic. That needs to be fixed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

This is added on top of Lai's patch.

 arch/x86/entry/entry_64.S | 68 +++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 21f67ea62341..962e0bfb69dd 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1117,33 +1117,46 @@ SYM_CODE_START(asm_exc_nmi)
 	 * stack of the previous NMI. NMI handlers are not re-entrant
 	 * anyway.
 	 *
-	 * To handle this case we do the following:
-	 *  Check the a special location on the stack that contains
-	 *  a variable that is set when NMIs are executing.
-	 *  The interrupted task's stack is also checked to see if it
-	 *  is an NMI stack.
-	 *  If the variable is not set and the stack is not the NMI
-	 *  stack then:
-	 *    o Set the special variable on the stack
-	 *    o Copy the interrupt frame into an "outermost" location on the
-	 *      stack
-	 *    o Copy the interrupt frame into an "iret" location on the stack
-	 *    o Continue processing the NMI
-	 *  If the variable is set or the previous stack is the NMI stack:
-	 *    o Modify the "iret" location to jump to the repeat_nmi
-	 *    o return back to the first NMI
+	 * To handle this case, the following is performed:
 	 *
-	 * Now on exit of the first NMI, we first clear the stack variable
-	 * The NMI stack will tell any nested NMIs at that point that it is
-	 * nested. Then we pop the stack normally with iret, and if there was
-	 * a nested NMI that updated the copy interrupt stack frame, a
-	 * jump will be made to the repeat_nmi code that will handle the second
-	 * NMI.
+	 *  If the NMI came in from user space, then the stack used is the
+	 *   kernel thread stack, and the C code of the nmi handler handles
+	 *   NMI nesting just like it is done for x86_32. This also allows
+	 *   NMIs from user space to handle the issues that ISTs have
+	 *   going back to user space.
 	 *
-	 * However, espfix prevents us from directly returning to userspace
-	 * with a single IRET instruction.  Similarly, IRET to user mode
-	 * can fault.  We therefore handle NMIs from user space like
-	 * other IST entries.
+	 *  If the NMI came in from kernel space, then perform the following:
+	 *   Add a variable at a specific location on the stack which is
+	 *    called "NMI executing". This variable will be set as early
+	 *    in the process as possible, and cleared just before the iretq.
+	 *   Copy the hardware stack frame twice onto the stack.
+	 *    The original hardware stack will be replaced by the hardware if
+	 *	any nested NMIs occur, so it must not be used.
+	 *    The first copy will be used by the iretq of the NMI handler.
+	 *      If a nested NMI arrives, it will update this copy to have
+	 *      the interrupted NMI return to the "repeat_nmi" location and
+	 *      that will execute the next NMI at the finish of the first NMI.
+	 *    The second copy is used to reset the first copy of the NMI stack
+	 *	frame to return to the original location of the first NMI.
+	 *
+	 *  On entering the NMI handler, if the "NMI executing" bit is set
+	 *   or the RIP of the interrupted location is located between
+	 *   the labels of "repeat_nmi" and "end_repeat_nmi" or is located
+	 *   at the iretq (.Lnmi_iret) then the current NMI had interrupted
+	 *   another NMI handler. It will update the first copy of the
+	 *   stack frame to return to "repeat_nmi" and exit.
+	 *
+	 *  When the first NMI exits, it clears the "NMI executing" variable
+	 *  and immediately calls iretq. If this NMI had triggered an exception
+	 *  that executed an iretq, allowing a nested NMI to come in, then
+	 *  that nested NMI would have updated the stack frame that the iretq
+	 *  is executing to jump to the "repeat_nmi" label. The repeat_nmi
+	 *  code is reponsible for setting the "NMI executing" variable and
+	 *  copying the second copy of the stack frame to the first copy.
+	 *
+	 *  NB the repeated NMI still has NMIs enabled from the start, and
+	 *   an NMI can come in even after the first iretq jumps to the
+	 *   repeat_nmi code.
 	 */
 
 	ASM_CLAC
@@ -1193,6 +1206,11 @@ SYM_CODE_START(asm_exc_nmi)
 	call	exc_nmi
 
 	/*
+	 * However, espfix prevents us from directly returning to userspace
+	 * with a single IRET instruction.  Similarly, IRET to user mode
+	 * can fault.  We therefore handle NMIs from user space like
+	 * other IST entries.
+	 *
 	 * Return back to user mode.  We must *not* do the normal exit
 	 * work, because we don't want to enable interrupts.
 	 */
-- 
2.25.4

