Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AED1D6741
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEQKEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgEQKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 06:04:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BEC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 03:04:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaG9z-0001jh-Pk; Sun, 17 May 2020 12:04:43 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E392B100F15;
        Sun, 17 May 2020 12:04:42 +0200 (CEST)
Date:   Sun, 17 May 2020 10:04:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/urgent for v5.7-rc6
Message-ID: <158970986085.17297.6965424675815657314.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-05-17

up to:  71c95825289f: x86/unwind/orc: Fix error handling in __unwind_start()


A single bugfix for the ORC unwinder to ensure that the error flag which
tells the unwinding code whether a stack trace can be trusted or not is
always set correctly. This was messed up by a couple of changes in the
recent past.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      x86/unwind/orc: Fix error handling in __unwind_start()


 arch/x86/kernel/unwind_orc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 5b0bd8581fe6..fa79e4227d3d 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -617,23 +617,23 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
-	if (!orc_init)
-		goto done;
-
 	memset(state, 0, sizeof(*state));
 	state->task = task;
 
+	if (!orc_init)
+		goto err;
+
 	/*
 	 * Refuse to unwind the stack of a task while it's executing on another
 	 * CPU.  This check is racy, but that's ok: the unwinder has other
 	 * checks to prevent it from going off the rails.
 	 */
 	if (task_on_another_cpu(task))
-		goto done;
+		goto err;
 
 	if (regs) {
 		if (user_mode(regs))
-			goto done;
+			goto the_end;
 
 		state->ip = regs->ip;
 		state->sp = regs->sp;
@@ -666,6 +666,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		 * generate some kind of backtrace if this happens.
 		 */
 		void *next_page = (void *)PAGE_ALIGN((unsigned long)state->sp);
+		state->error = true;
 		if (get_stack_info(next_page, state->task, &state->stack_info,
 				   &state->stack_mask))
 			return;
@@ -691,8 +692,9 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 
 	return;
 
-done:
+err:
+	state->error = true;
+the_end:
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
-	return;
 }
 EXPORT_SYMBOL_GPL(__unwind_start);

