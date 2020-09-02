Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B825AFAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgIBPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIBNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:39:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A69C06125E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=urzGtrnZ2TssED/dYrhaoAZnSG8zHOBp4RAF4ZA4GhY=; b=DhDCmGyU0RF+YHVJmEwaqA63dI
        n69Lf8W08eEl0uW7aw7Bz0wOd0zFjfplYssBMtHhBmEogzk8U4rrfDoPxp8NAfjpgN1HF2TJrlBcR
        G4J7Vr1RFMH35OAd9OCOEc9DepZaRdWoekW05txIXJtZxYq8gtXQWFpyhFciOIEzqG69sS+a2SY6e
        qZrYk5anjzAO7yh3XrSH0W1rD1kHY3iv7MeiRBHMo3qHJLRYb+N9dDoZXoHnutYfdI8fB2KVACVmf
        2pRnwxLNtL4P4CVLq28DI6NG1natCxHbKOBnBWPpQrrI3SSL7C1CRr0NXTfSDcD2UBbn+wgq3uQVa
        M1+58gAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxq-0002dc-VJ; Wed, 02 Sep 2020 13:38:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B79B306E07;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C243029A82C22; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133200.907020598@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/13] x86/debug: Remove handle_debug(.user) argument
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handle_debug(.user) argument is used to terminate the #DB handler
early for the INT1-from-kernel case, since the kernel doesn't use
INT1.

Remove the argument and handle this explicitly in #DB-from-kernel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/traps.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,25 +783,18 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
+static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
 	bool user_icebp;
 	int si_code;
 
 	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (!user && !dr6)
-		return;
-
-	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	user_icebp = user && !dr6;
+	user_icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -874,7 +867,13 @@ static __always_inline void exc_debug_ke
 	if (kprobe_debug_handler(regs))
 		goto out;
 
-	handle_debug(regs, dr6, false);
+	/*
+	 * The kernel doesn't use INT1
+	 */
+	if (!dr6)
+		goto out;
+
+	handle_debug(regs, dr6);
 
 out:
 	instrumentation_end();
@@ -904,7 +903,7 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6, true);
+	handle_debug(regs, dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);


