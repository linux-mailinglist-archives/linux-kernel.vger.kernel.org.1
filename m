Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6705A29938B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787477AbgJZRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:18:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787470AbgJZRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HO81U7QyFXYaItHcZjf6ITzIZ6KCeQi6xzBpSCGRFkM=; b=PwXw/Y6lP6lxsj9exqyMwudv5A
        xPa3L368Fn/a2BL//V3TO9db/mMeHD9xeyMzy20Wi3R5Tpi5/JWYZmTf3PL1YHVE7NPR8Hb5FntKn
        tYMF2YlXIiBKSVsxiUjwlj8Lz+V3q9TEVNBJotBStHaNRw0lVuff+3e3pz9cq2iBI39ZSTCUOZYKj
        Dq7lsprM3nmzwTuDzhbYzmUNF02AH+9h35q8UPCANksYfpjwP1N3qjmay3PlF9w8aIgnTmgHz6mjG
        iDFf5Aw3BEp/fzE+CraZ0gPLaiJGdZIwyjV+2YwhE/loMX0SqTPmV+xY/vtN9EcjyViNyyEqYJAbv
        rC+2GKVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX67z-00013h-V9; Mon, 26 Oct 2020 17:17:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7DE7302526;
        Mon, 26 Oct 2020 18:17:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF925203BE3CE; Mon, 26 Oct 2020 18:17:49 +0100 (CET)
Date:   Mon, 26 Oct 2020 18:17:49 +0100
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
Message-ID: <20201026171749.GW2611@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net>
 <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CAP045ArgMKSpt3Qa3TwzeE+xc78BJ5DPRazaP+bxNi570s+A=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045ArgMKSpt3Qa3TwzeE+xc78BJ5DPRazaP+bxNi570s+A=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:12:30AM -0700, Kyle Huey wrote:
> On Mon, Oct 26, 2020 at 9:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > @@ -935,6 +936,26 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
> >         irqentry_enter_from_user_mode(regs);
> >         instrumentation_begin();
> >
> > +       /*
> > +        * Clear the virtual DR6 value, ptrace routines will set bits here for
> > +        * things we want signals for.
> > +        */
> > +       current->thread.virtual_dr6 = 0;
> > +
> > +       /*
> > +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> > +        * the ptrace visible DR6 copy.
> > +        */
> > +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> > +               current->thread.virtual_dr6 |= (dr6 & DR_STEP);
> > +
> > +       /*
> > +        * The SDM says "The processor clears the BTF flag when it
> > +        * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
> > +        * TIF_BLOCKSTEP in sync with the hardware BTF flag.
> > +        */
> > +       clear_thread_flag(TIF_BLOCKSTEP);
> > +
> >         /*
> >          * If dr6 has no reason to give us about the origin of this trap,
> >          * then it's very likely the result of an icebp/int01 trap.
> 
> This looks good to me (at least the non BTF parts), and I'll test it
> shortly, but especially now that clearing virtual_dr6 is moved to
> exc_debug_user I still don't see why it's not ok to copy the entire
> dr6 value into virtual_dr6 unconditionally.  Any extraneous dr6 state
> from an in-kernel #DB would have been picked up and cleared already
> when we entered exc_debug_kernel.

There is !ptrace user breakpoints as well. Why should we want potential
random bits in dr6 ?

Suppose perf and ptrace set a user breakpoint on the exact same
instruction. The #DB fires and has two DR_TRAP# bits set. perf consumes
one and ptrace consumes one.

Only the ptrace one should be visible to ptrace, the perf one doesn't
affect the userspace execution at all and shouldn't be visible.
