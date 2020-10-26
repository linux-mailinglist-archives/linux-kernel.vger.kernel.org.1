Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28C299213
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785272AbgJZQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:14:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44253 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774168AbgJZQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:14:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id t20so9958552edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3H2p+iuwydYaEIXGXh3Sr6LBfik6Qa35VEO/8RXDAl4=;
        b=ZK+AbE/BobLoYSkWq9G6gbh2PODwStnn3Utfx3MnougE5GCN+7r68dBTfd8KyojKZf
         u1LUgbtGEbm7I7CLw3qLmhNMlIcMQy6BUlXiPdQJep1ZO+L53QFelzIwl9z+KSuKoy6+
         FD2JG9aY5Wt9aueay9Qf4lms+LwJLoVlveXE+EGe1Bv6ls4MsYaBBRiWbizkiPmht39q
         SU2D7hwwl0/MIF0xwoss3mNLW0f4G7YBoRWTViXI34AEVGcRag1rxdyTCUxneAlUa0V7
         tpJ6ie6hxSzX+jVhbO8eUFi1uyPHeMk3O50PtPmv3CP6lXusH+cGaVHDibnq55voM000
         r8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3H2p+iuwydYaEIXGXh3Sr6LBfik6Qa35VEO/8RXDAl4=;
        b=tFX11Nku6v3Cn4HaBCWCRJb48f6YCSXRWPSVKUoRq1Gq0cqUzS10zkaXX1qv90WJE2
         EaxVS7QkzG03zshG3dj30kAbdHg3jJNfiqXtGFpPdmvTG/+VqMzdI3t7xYNMCrmRLQUm
         PeEy8Hmar6vBcgm1EcvdcNWYIRAe3QCc/yD5tSv7Ye6AYgssPZ4VYm1CdWIjNyZck8ne
         GZUcuYlEJRZAS0x1p1xhR/Cl3i0dztpuDe9iGePm1Fa44dtCDaSlCVdMHs93PeLmAOU4
         /XVdbus1xphl11C/NhZkBUIoRYF2edPfoMMn+yUTNk9ZnpwK+6aWfbOxARlizc89+IQO
         IsVw==
X-Gm-Message-State: AOAM533lJOrH9A5vxyCtVh73RZrNknUpUuEdag8sLAVQTGKdyTg6lKnX
        LxOLJx56DvrlkKop/W/e7FQCYz1LxXSuJ582AhX6/Q==
X-Google-Smtp-Source: ABdhPJwv0K1VrTH65RZm5WT1r8T06WuHs73DuCD2AlndBawXbhg2SMt8W9kBeaw+h6q96I5BEVpiqh1YA0aEh/Wfnnk=
X-Received: by 2002:a05:6402:1148:: with SMTP id g8mr17037484edw.271.1603728864766;
 Mon, 26 Oct 2020 09:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net> <20201026160513.GC2651@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026160513.GC2651@hirez.programming.kicks-ass.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 09:14:13 -0700
Message-ID: <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 9:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 04:55:21PM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 26, 2020 at 07:33:08AM -0700, Kyle Huey wrote:
> > > After resuming a ptracee with PTRACE_SINGLESTEP, in the following
> > > ptrace stop retrieving the dr6 value for the tracee gets a value that
> > > does not include DR_STEP (it is in fact always DR6_RESERVED). I
> > > bisected this to the 13cb73490f475f8e7669f9288be0bcfa85399b1f merge. I
> > > did not bisect further.
> > >
> > > I don't see any handling to ever set DR_STEP in virtual_dr6, so I
> > > think this code is just broken.
> > >
> > > Sorry for not testing this when I was CCd on the original patch series :)
> >
> > Urgh, now I have to try and remember how all that worked again ...
> >
> > I suspect it's either one (or both) of the last two:
> >
> >   f4956cf83ed1 ("x86/debug: Support negative polarity DR6 bits")
> >   d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
> >
> >
> > Just to clarify, the sequence is something like:
> >
> >  - tracer: ptrace(PTRACE_SINGLESTEP)
> >  - tracee: #DB, DR6 contains DR_STEP
> >  - tracer: ptrace_get_debugreg(6)
> >
> > ?
> >
> > You're right that that would be broken, let me try and figure out what
> > the best way would be 'fix' that.
> >
> > Also, can you confirm that pthread_set_debugreg(6) should not do
> > anything useful?
>
>
> Does something like this make sense?
>
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 3c70fb34028b..0e7641ac19a8 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -799,6 +799,13 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
>          */
>         current->thread.virtual_dr6 = 0;
>
> +       /*
> +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> +        * the ptrace visible DR6 copy.
> +        */
> +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> +               current->thread.virtual_dr6 |= dr6 & DR_STEP;
> +
>         /*
>          * The SDM says "The processor clears the BTF flag when it
>          * generates a debug exception."  Clear TIF_BLOCKSTEP to keep

I don't think the `& DR_STEP` should be necessary, that bit should be
set by the hardware, I believe.

Also if a program sets TF on itself in EFLAGS and generates a trap it
should still have DR_STEP set in the ptrace-visible dr6, which this
won't do.

Is there a reason not to always copy dr6 into virtual_dr6 here,
regardless of TIF_SINGLESTEP/etc?

- Kyle
