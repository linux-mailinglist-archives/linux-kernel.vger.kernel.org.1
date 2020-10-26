Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D12299A75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406324AbgJZXat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406250AbgJZXaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:30:46 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675A0206DB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755045;
        bh=HGEo1Vp0eHrX0uYPz8ISeIcKVqaXNHvUFyeBXs1dDow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qh1WEL/4Ru5brZ5hnrEKPb/kGNDpiysrF2mR6JhLBvd3CHaSHxpm061VjFTAA0Im6
         eClFuQKvh4Gy+Rtg+jJWKelSksww7hhTNEEDT5i3h4+KGfwRWz9aFG7zKES2OrpkVS
         xpcy+tN1KQFGqax8OW0KTGIb4anKsOwjihAe/rGI=
Received: by mail-wr1-f41.google.com with SMTP id n15so14977945wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:30:45 -0700 (PDT)
X-Gm-Message-State: AOAM533bVcqiD5BjyfRDzGB/jsgdUTK4snyqDgI8qXWjwxU7Hs3OS/qM
        84befGtIcy+t4hQ6v1oEE2s0o6hADzWqQLINfbBvOA==
X-Google-Smtp-Source: ABdhPJyMAjguYwVKORqB+YASt595ET3GIDMTdzbCZ1xrDD5HblwKX8dvrljDO/8DqC4ctdD80AExACyU6Ubk/EUgBls=
X-Received: by 2002:adf:df03:: with SMTP id y3mr20031829wrl.70.1603755043953;
 Mon, 26 Oct 2020 16:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net> <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net> <20201026165519.GD2651@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026165519.GD2651@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 26 Oct 2020 16:30:32 -0700
X-Gmail-Original-Message-ID: <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
Message-ID: <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 9:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 05:31:00PM +0100, Peter Zijlstra wrote:
> > In that respect, I think the current virtual_dr6 = 0 is placed wrong, it
> > should only be in exc_debug_user(). The only 'problem' then is that we
> > seem to be able to loose BTF, but perhaps that is already an extant bug.
> >
> > Consider:
> >
> >  - perf: setup in-kernel #DB
> >  - tracer: ptrace(PTRACE_SINGLEBLOCK)
> >  - tracee: #DB on perf breakpoint, looses BTF
> >  - tracee .. never triggers actual blockstep
> >
> > Hmm ? Should we re-set BTF when TIF_BLOCKSTEP && !user_mode(regs) ?
>
> Something like so then.
>
> Or sould we also have the userspace #DB re-set BTF when it was !DR_STEP?
> I need to go untangle that ptrace stuff :/
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 3c70fb34028b..31de8b0980ca 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -793,19 +793,6 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
>         set_debugreg(DR6_RESERVED, 6);
>         dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
>
> -       /*
> -        * Clear the virtual DR6 value, ptrace routines will set bits here for
> -        * things we want signals for.
> -        */
> -       current->thread.virtual_dr6 = 0;
> -
> -       /*
> -        * The SDM says "The processor clears the BTF flag when it
> -        * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
> -        * TIF_BLOCKSTEP in sync with the hardware BTF flag.
> -        */
> -       clear_thread_flag(TIF_BLOCKSTEP);
> -
>         return dr6;
>  }
>
> @@ -873,6 +860,20 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
>          */
>         WARN_ON_ONCE(user_mode(regs));
>
> +       if (test_thread_flag(TIF_BLOCKSTEP)) {
> +               /*
> +                * The SDM says "The processor clears the BTF flag when it
> +                * generates a debug exception." but PTRACE_BLOCKSTEP requested
> +                * it for userspace, but we just took a kernel #DB, so re-set
> +                * BTF.
> +                */
> +               unsigned long debugctl;
> +
> +               rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> +               debugctl |= DEBUGCTLMSR_BTF;
> +               wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> +       }
> +
>         /*
>          * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
>          * watchpoint at the same time then that will still be handled.
> @@ -935,6 +936,26 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
>         irqentry_enter_from_user_mode(regs);
>         instrumentation_begin();
>
> +       /*
> +        * Clear the virtual DR6 value, ptrace routines will set bits here for
> +        * things we want signals for.
> +        */
> +       current->thread.virtual_dr6 = 0;
> +
> +       /*
> +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> +        * the ptrace visible DR6 copy.
> +        */
> +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> +               current->thread.virtual_dr6 |= (dr6 & DR_STEP);

I'm guessing that this would fail a much simpler test, though: have a
program use PUSHF to set TF and then read out DR6 from the SIGTRAP.  I
can whip up such a test if you like.

Is there any compelling reason not to just drop the condition and do:

current->thread.virtual_dr6 |= (dr6 & DR_STEP);

unconditionally?  This DR6 cause, along with ICEBP, have the
regrettable distinctions of being the only causes that a user program
can trigger all on its own without informing the kernel first.  This
means that we can't fully separate the concept of "user mode is
single-stepping itself" from "ptrace or something else is causing the
kernel to single step a program."

I bet that, without making this tweak, the virtual_dr6 change will
regress some horrific Wine use case.

--Andy
