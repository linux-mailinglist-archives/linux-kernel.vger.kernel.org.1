Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A729A66B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509032AbgJ0IUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:20:24 -0400
Received: from casper.infradead.org ([90.155.50.34]:34394 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894589AbgJ0IT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZE1MXiQvZEuT9v9i4wiPmXal4aSR35J5m2P8MAzmPgo=; b=ofoBOW8kmJGcEWu9GjGzLq53wc
        hstJvbsgNGlqxx2mAIbcCS2zyZG4FpFOUd3lHZOall1KU0G7Ym5Eeh6ygv310HZHOh2yOn553GiLt
        jAUrixEcFFXr+siNcRp5ovuRdZHbKPeynBkDPHXx3kMqYvoczfSB6VJAwRJA//9tGsETqJZ3Xquc1
        FuoE46OjMR5z+Ap32+QR9vDS/7OuuE81zQB2O3Iqrt44aeCQCQ53Q0obMfqC0heI2HpP5uUstf9VG
        G7EGDfKs0zvJqNd58PHNvw+OM9khSLjWjCWZ8HhJAI6uUr//2uAz1XBTA4ziVv/kOIOOtqIpBXbCv
        jxI2baDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXKCb-0001Q4-EQ; Tue, 27 Oct 2020 08:19:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5484C30411F;
        Tue, 27 Oct 2020 09:19:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F7962127D318; Tue, 27 Oct 2020 09:19:32 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:19:32 +0100
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
Message-ID: <20201027081932.GY2611@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net>
 <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:30:32PM -0700, Andy Lutomirski wrote:

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
> 
> I'm guessing that this would fail a much simpler test, though: have a
> program use PUSHF to set TF and then read out DR6 from the SIGTRAP.  I
> can whip up such a test if you like.

Kyle also mentioned it. The reason I didn't do that is because ptrace()
didn't set the TF, so why should it see it in ptrace_get_debugreg(6) ?

> Is there any compelling reason not to just drop the condition and do:
> 
> current->thread.virtual_dr6 |= (dr6 & DR_STEP);
> 
> unconditionally?  This DR6 cause, along with ICEBP, have the
> regrettable distinctions of being the only causes that a user program
> can trigger all on its own without informing the kernel first.  This
> means that we can't fully separate the concept of "user mode is
> single-stepping itself" from "ptrace or something else is causing the
> kernel to single step a program."

As per the other reply; TF and INT1 should work just fine. virtual_dr6
has nothing to do with that.
