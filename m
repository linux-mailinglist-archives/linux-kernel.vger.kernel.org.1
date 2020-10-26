Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF62A299378
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787397AbgJZRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:12:47 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44861 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787389AbgJZRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:12:47 -0400
Received: by mail-ej1-f68.google.com with SMTP id d6so10055514ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhjQk9pWrZ2ODeE3ruxT9vPMWpV1kCCg3a9DVTYLYlA=;
        b=PANW3EDTlWyAXfuUjjrurj0a/QTd7SLz4wQhzBVHQDwdvR639mDyS69NGd6hH5hqHk
         f7YtIuOXcV3V8jhoPllVWm0HGRZeJndjVSzlFPoUUgnwNpAv1d1kmnIGtzPgG+InNXkh
         w3JnDCDPmdSr/qdjuvMzfBZvR4ayokuWkA5h7n5PM5Rw0zGjpY903I1XnTzldp54xdCZ
         Bm82SNZY+TlS8+RxF6bbEolo545eXbPknOxoX7HnNZ772QtzDZO0J3pbQVE5j4pAYmIW
         aNK/wMdmmMDrqpdn0DzJd4pYzhBjaB06Ky8H2yVG3a1ZzBLbhL47WU2yfi/3q9kUfHmX
         btAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhjQk9pWrZ2ODeE3ruxT9vPMWpV1kCCg3a9DVTYLYlA=;
        b=QjMUXaBlNW+/i0tNmwddQ/YxNeY0R2w4QYeLThv/5VgosphyPQjI0xpERHCOF1gHGe
         xH4d2XKf03CKIGbw4kkeB0XT6cjvnlDVafHkfGU3I361Ngv18rqDomRvfhDrx9V54JCw
         2nshYGAqa/xF/4CyANOuoYeLyg+p0HBq9dWnaokvxWiD3kc3nXSnHBcHVhrjPmem4+5K
         0AgvWbleyuGOcS3V9FLFSRFKYpa0wRgRdfcXecagvzXUoLN/ySzyX48Sbd+Ro72MpVan
         7ySfZnFxSYbNWT8VUKg/QXtu7Qa5Z+GXwJAaZcrMQqW2NfkyHE5WrMonGHTHnllxKGh5
         CXuQ==
X-Gm-Message-State: AOAM533Vvfc/hbyF0LQJeqyKSFxGlwI7BBTP9lADgbiQlduK/DkBYe6t
        67B5GfPMQRfDtMsij8BZY4wu69kksqOXxTQURu6rsyP6NKjze+SN
X-Google-Smtp-Source: ABdhPJzW6mfIwfGEGkjG94g+hkwsT71iK/C55YQjz5H/vpkx12at10R6OURwD0ql6oCibVZOOxUPQe1iZ9tck5A/KvI=
X-Received: by 2002:a17:906:6a07:: with SMTP id o7mr16307637ejr.454.1603732362968;
 Mon, 26 Oct 2020 10:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net> <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net> <20201026165519.GD2651@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026165519.GD2651@hirez.programming.kicks-ass.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 10:12:30 -0700
Message-ID: <CAP045ArgMKSpt3Qa3TwzeE+xc78BJ5DPRazaP+bxNi570s+A=Q@mail.gmail.com>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
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
> +
> +       /*
> +        * The SDM says "The processor clears the BTF flag when it
> +        * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
> +        * TIF_BLOCKSTEP in sync with the hardware BTF flag.
> +        */
> +       clear_thread_flag(TIF_BLOCKSTEP);
> +
>         /*
>          * If dr6 has no reason to give us about the origin of this trap,
>          * then it's very likely the result of an icebp/int01 trap.

This looks good to me (at least the non BTF parts), and I'll test it
shortly, but especially now that clearing virtual_dr6 is moved to
exc_debug_user I still don't see why it's not ok to copy the entire
dr6 value into virtual_dr6 unconditionally.  Any extraneous dr6 state
from an in-kernel #DB would have been picked up and cleared already
when we entered exc_debug_kernel.

- Kyle
