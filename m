Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069429930B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786678AbgJZQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:55:53 -0400
Received: from casper.infradead.org ([90.155.50.34]:45286 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786671AbgJZQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bit45RXYD4rtvCyrZ2193fGP+7fUaQJSARCv+n40cck=; b=nRd2BYVBPRZr/Jk+nJcC9m5BtM
        OoiOSlgOvAPXy5jGfni6EXjw3oqCes/V24b2hd8O/KR57tXapbBHpEKQJ2Me4V6KxihRFD8g9m/9G
        LtB/KaXXA10NQojqTvQTGI7dQApoEl22WpRilvrIoLqe+qtyHQPs9kB1olEfAivs7M2DpSCgWSMKb
        a3ig0CHmolGB3g3bRty2OEdTzs7C4JDV38ggAAJVS4xdT85WeRncSHeSDyR/LQW/qdHTwEV7yyd7/
        fxb4/yyo88z0CrvjP2xssdF6/m9mMc5PL92hY1tUu82QmvaYFzErGzURzkK1IJEK3pHCuM/MMwbO2
        vVnjXKqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX5mE-00044I-DP; Mon, 26 Oct 2020 16:55:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D82BE302526;
        Mon, 26 Oct 2020 17:55:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C54CC20116727; Mon, 26 Oct 2020 17:55:19 +0100 (CET)
Date:   Mon, 26 Oct 2020 17:55:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
Message-ID: <20201026165519.GD2651@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026163100.GR2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:31:00PM +0100, Peter Zijlstra wrote:
> In that respect, I think the current virtual_dr6 = 0 is placed wrong, it
> should only be in exc_debug_user(). The only 'problem' then is that we
> seem to be able to loose BTF, but perhaps that is already an extant bug.
> 
> Consider:
> 
>  - perf: setup in-kernel #DB
>  - tracer: ptrace(PTRACE_SINGLEBLOCK)
>  - tracee: #DB on perf breakpoint, looses BTF
>  - tracee .. never triggers actual blockstep
> 
> Hmm ? Should we re-set BTF when TIF_BLOCKSTEP && !user_mode(regs) ?

Something like so then.

Or sould we also have the userspace #DB re-set BTF when it was !DR_STEP?
I need to go untangle that ptrace stuff :/

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb34028b..31de8b0980ca 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -793,19 +793,6 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	set_debugreg(DR6_RESERVED, 6);
 	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
-	/*
-	 * Clear the virtual DR6 value, ptrace routines will set bits here for
-	 * things we want signals for.
-	 */
-	current->thread.virtual_dr6 = 0;
-
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
 	return dr6;
 }
 
@@ -873,6 +860,20 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 */
 	WARN_ON_ONCE(user_mode(regs));
 
+	if (test_thread_flag(TIF_BLOCKSTEP)) {
+		/*
+		 * The SDM says "The processor clears the BTF flag when it
+		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
+		 * it for userspace, but we just took a kernel #DB, so re-set
+		 * BTF.
+		 */
+		unsigned long debugctl;
+
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		debugctl |= DEBUGCTLMSR_BTF;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	}
+
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
@@ -935,6 +936,26 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
+	/*
+	 * Clear the virtual DR6 value, ptrace routines will set bits here for
+	 * things we want signals for.
+	 */
+	current->thread.virtual_dr6 = 0;
+
+	/*
+	 * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
+	 * the ptrace visible DR6 copy.
+	 */
+	if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
+		current->thread.virtual_dr6 |= (dr6 & DR_STEP);
+
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
