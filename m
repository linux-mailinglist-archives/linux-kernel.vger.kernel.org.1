Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043B02AC92F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgKIXQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbgKIXQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:16:15 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367CB206ED;
        Mon,  9 Nov 2020 23:16:13 +0000 (UTC)
Date:   Mon, 9 Nov 2020 18:16:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/3 v4] ftrace/x86: Allow for arguments to be passed in
 to ftrace_regs by default
Message-ID: <20201109181610.1b3f7d9f@oasis.local.home>
In-Reply-To: <20201109111043.GD2594@hirez.programming.kicks-ass.net>
References: <20201106214234.618790276@goodmis.org>
        <20201106214403.328699055@goodmis.org>
        <20201109111043.GD2594@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 12:10:43 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> >  SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
> >  	/* Load the ftrace_ops into the 3rd parameter */
> >  	movq function_trace_op(%rip), %rdx
> >  
> > -	/* regs go into 4th parameter (but make it NULL) */
> > -	movq $0, %rcx
> > +	/* regs go into 4th parameter */
> > +	leaq (%rsp), %rcx
> > +
> > +	/* Only ops with REGS flag set should have CS register set */
> > +	movq $0, CS(%rsp)
> >  
> >  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> >  	call ftrace_stub  
> 
> You now seem to be relying on save_mcount_regs() resulting in a cleared
> CS, however, AFAICT CS is uninitialized stack garbage.

We have two trampolines that are also used to copy for other
trampolines that are dynamically created. There's this one
(ftrace_caller) and then there's the regs one (ftrace_regs_caller).
This one clears the CS in pt_regs to let the arch code know that the
ftrace_regs is not a full pt_regs and anyone trying to get it with
ftrace_get_regs() will get a NULL pointer. But the ftrace_regs_caller
loads the CS register with __KERNEL_CS, which is non zero, and the
ftrace_get_regs() will return the full pt_regs if it is set.

ftrace_caller:
	[..]
	movq $0, CS(%rsp) <- loads zero into pt_regs->cs for internal use only.
	[..]
	call callback

ftrace_regs_caller:
	[..]
	movq $__KERNEL_CS, %rcx
	movq %rcx, CS(%rsp)
	[..]
	call callback


Then in the callback we have:


callback(..., struct ftrace_regs *fregs)
{
	struct pt_regs *regs = ftrace_get_regs(fregs);
}

Where ftrace_get_regs is arch specific and returns for x86_64:

static __always_inline struct pt_regs *
arch_ftrace_get_regs(struct ftrace_regs *fregs)
{
	/* Only when FL_SAVE_REGS is set, cs will be non zero */
	if (!fregs->regs.cs)
		return NULL;
	return &fregs->regs;
}

What am I missing?

-- Steve
