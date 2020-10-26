Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D0299275
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786012AbgJZQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:31:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45284 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786003AbgJZQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8418oRRVSf4j+/KAvzQ3JMGBsl1wnAf6vFE04ew71fA=; b=olfBZEvTnx8bUo67pmMm/aWASZ
        2fLxEVVNy1DKgRT0tLHmyxutuvSX1vAPLZ4BzlKzdWqLhaOod18ZdkxrWaeq8ZKH/+PGOix+lkhPh
        E/wQTIspMoB1byzG6c/iymcPMICBVV2rPBlGp+hcDVdXP0l2L9oL1qzf67Mk1BaG3G6IC97MuQ1St
        a2nF2aMAtjOyIUWHP47hiltSn7uHpimag1eBHGLDO6LdyDRL5YSoC2/w+faaB3sPeIIdBdAeSmlHk
        EwyuKPx2Qhg97fK9f5s+XUO4C1A2lbQqS2XMKiXUxZqEY3xwia/dL3x8Mv+pNlsj95wuurouprneQ
        G/DLq9CQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX5Og-0000IZ-DY; Mon, 26 Oct 2020 16:31:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 888FE3010D2;
        Mon, 26 Oct 2020 17:31:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D5FB203BE3CD; Mon, 26 Oct 2020 17:31:00 +0100 (CET)
Date:   Mon, 26 Oct 2020 17:31:00 +0100
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
Message-ID: <20201026163100.GR2594@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:14:13AM -0700, Kyle Huey wrote:
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 3c70fb34028b..0e7641ac19a8 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -799,6 +799,13 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
> >          */
> >         current->thread.virtual_dr6 = 0;
> >
> > +       /*
> > +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> > +        * the ptrace visible DR6 copy.
> > +        */
> > +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> > +               current->thread.virtual_dr6 |= dr6 & DR_STEP;
> > +
> >         /*
> >          * The SDM says "The processor clears the BTF flag when it
> >          * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
> 
> I don't think the `& DR_STEP` should be necessary, that bit should be
> set by the hardware, I believe.

Yeah, the idea is to only 'copy' the DR_STEP bit, not any others.

> Also if a program sets TF on itself in EFLAGS and generates a trap it
> should still have DR_STEP set in the ptrace-visible dr6, which this
> won't do.

Why? The state was not requested by ptrace(). And the signal should have
it's si_code set to TRACE_TRACE.

> Is there a reason not to always copy dr6 into virtual_dr6 here,
> regardless of TIF_SINGLESTEP/etc?

Why should we expose DR6 bits that are the result of kernel internal
actions?

Suppose someone sets an in-kernel breakpoint (perf can do that for
example), the #DB happens and we write whatever into virtual_dr6.

Even if you have a userspace breakpoint not through ptrace(), then why
should we expose that in dr6 ?


In that respect, I think the current virtual_dr6 = 0 is placed wrong, it
should only be in exc_debug_user(). The only 'problem' then is that we
seem to be able to loose BTF, but perhaps that is already an extant bug.

Consider:

 - perf: setup in-kernel #DB
 - tracer: ptrace(PTRACE_SINGLEBLOCK)
 - tracee: #DB on perf breakpoint, looses BTF
 - tracee .. never triggers actual blockstep

Hmm ? Should we re-set BTF when TIF_BLOCKSTEP && !user_mode(regs) ?


