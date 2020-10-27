Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020A229C8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829905AbgJ0TW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:22:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56080 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829784AbgJ0TUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VEzFHgL0HPz0HMmGxJDO5yInCLZElbuDa2OIjgfzZ8M=; b=tpxkmnDk/FCCJupXnig4CJyTKD
        wqtXyBehLYOouAr6EZs2c+4d7jblmNUhhyIu4fWjZ9C8eCRQS7aCE4VnxXHtJAwp2AxIVpTuqPEr0
        QKmqeRzZB87Fp/hySJwK6B218j+T4YFLLem45IUZDMtq990235v/AVMvytMKr4bE7HrG5hqMHa7Ir
        rEoRZfX9s8d37kuXuq20v9jWo7PUawNDcKf5M9GmPuEpsWcEc78yapXo6MFSvnbTFBz7CBqHoH2EK
        159QDtn7lJy9pFEgm/jvVoqDrxmxxVc0uCLzfwOkvnN0JWbSaKJOvDjIPY9NCsGq7mlLVG2Mz4LsN
        OZUlMaiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXUVv-0003jm-1Y; Tue, 27 Oct 2020 19:20:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47ECD307ABA;
        Tue, 27 Oct 2020 20:20:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 352A7203C2679; Tue, 27 Oct 2020 20:20:09 +0100 (CET)
Date:   Tue, 27 Oct 2020 20:20:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
Message-ID: <20201027192009.GQ2628@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net>
 <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
 <20201027081932.GY2611@hirez.programming.kicks-ass.net>
 <CALCETrUcx_GaYhUbdc82faeftn+PssdWbWSPWELZ7Npcrbd92w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUcx_GaYhUbdc82faeftn+PssdWbWSPWELZ7Npcrbd92w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:00:52AM -0700, Andy Lutomirski wrote:
> On Tue, Oct 27, 2020 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 26, 2020 at 04:30:32PM -0700, Andy Lutomirski wrote:
> >
> > > > @@ -935,6 +936,26 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
> > > >         irqentry_enter_from_user_mode(regs);
> > > >         instrumentation_begin();
> > > >
> > > > +       /*
> > > > +        * Clear the virtual DR6 value, ptrace routines will set bits here for
> > > > +        * things we want signals for.
> > > > +        */
> > > > +       current->thread.virtual_dr6 = 0;
> > > > +
> > > > +       /*
> > > > +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> > > > +        * the ptrace visible DR6 copy.
> > > > +        */
> > > > +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> > > > +               current->thread.virtual_dr6 |= (dr6 & DR_STEP);
> > >
> > > I'm guessing that this would fail a much simpler test, though: have a
> > > program use PUSHF to set TF and then read out DR6 from the SIGTRAP.  I
> > > can whip up such a test if you like.
> >
> > Kyle also mentioned it. The reason I didn't do that is because ptrace()
> > didn't set the TF, so why should it see it in ptrace_get_debugreg(6) ?
> 
> I assume you already figured this out, but my specific concern is with
> the get_si_code(dr6) part -- that's sent directly to the task being
> debugged or debugging itself (and, sadly, to ptrace, and who knows
> what debuggers do).

Right, so for a task doing TF on its own, DR_STEP should remain set in
our on-stack dr6 variable, nothing should consume it.

So the get_si_code(dr6) should be identical. So the only difference is
if DR_STEP is visible in ptrace or not.
