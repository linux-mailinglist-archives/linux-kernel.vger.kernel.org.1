Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E5A29957F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790053AbgJZSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:36:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46847 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790047AbgJZSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:36:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id 33so10490564edq.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Meb4Uu74gU/GLZTWsW7zoeEha865HBw11sRZdjUpX6E=;
        b=cMe8xEycnXESgefU7nBMu2Cqc2Cbwfx9mbgBBopdZXk3pwI1T+Pc3k2e8D/clIofLm
         FeYfjfDTq2n4TUzcCmiEcccS1UCft8oGPyRCKkdvz5Rn6YMXE97J8rzxQJRf9QP4Jnn5
         e6sRaZohJhtLkKNqoVm0qvGSZ/MgxK26UYp2pCszeNrSVv3hBxxQuaFi/9pF+rkoG71h
         F3WseHK88yGH1sfhxH9RcR9C/+OXxRshXkyIeVvRs9AWLyAkzBJMZdq/7QfeCZbFEC0w
         +IHB+I3T8uJ4yNLvizWFtJYRqImjeobU2OPX1gAFqn3eIo/Ae96Bm9yRh4eT4YKuXS/k
         cQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Meb4Uu74gU/GLZTWsW7zoeEha865HBw11sRZdjUpX6E=;
        b=tyHEiBX5tAQr9BMKBQTTM3SH1zWrWHM2QJXiL42TN+fB3uo6vuBBsazgimt8sGBGTO
         zic5CNWKRLD1sLcmEQe0eB9rh24xaHgFaISFlZvwca7tg/4BzSNS9h3vTlRyCTla1L4n
         wWxqVkdAO+D7vP0yLV9YJTsjYtjA2vUcbp2exukQcakxMGkRLyb8rdjdZUhDbftGcYNs
         DkKLtQxdi1ZntOw65fB1SJb8cwCDelIOZRsScpS8GVL6KoxCqWb1NyjwpQc//n8KsnQK
         fdORiRXryTJXiMKP5155urlaaNQYmKhXlXlACXPrqWI3djt0+hVUtIo9mbM9ie+db2iU
         P4+Q==
X-Gm-Message-State: AOAM530w4cdYdGkyMbKNHtfCD8QXjQtsW9fGCOtUFTT+pmdvdaX0+ltj
        gqDJRqBVPdleZAmN/qNCzJSNfEdA03VxHn+dgXKAtw==
X-Google-Smtp-Source: ABdhPJwJogA5mwCJtEqMIZn3ZMl/qxEG+YaZBShGmHXsAMo1eWT9w00bFkmOoeUBKFApbjU5R4LgbEG94LDCJ4Kg/Zk=
X-Received: by 2002:a05:6402:1148:: with SMTP id g8mr17681745edw.271.1603737412766;
 Mon, 26 Oct 2020 11:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net> <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net> <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CAP045ArgMKSpt3Qa3TwzeE+xc78BJ5DPRazaP+bxNi570s+A=Q@mail.gmail.com> <20201026171749.GW2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026171749.GW2611@hirez.programming.kicks-ass.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 11:36:41 -0700
Message-ID: <CAP045ArAxjGNwTHbf7ysfH4zGM2=cHUwgAxb9bJH3bjxrEptVA@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 10:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 10:12:30AM -0700, Kyle Huey wrote:
> > On Mon, Oct 26, 2020 at 9:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > @@ -935,6 +936,26 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
> > >         irqentry_enter_from_user_mode(regs);
> > >         instrumentation_begin();
> > >
> > > +       /*
> > > +        * Clear the virtual DR6 value, ptrace routines will set bits here for
> > > +        * things we want signals for.
> > > +        */
> > > +       current->thread.virtual_dr6 = 0;
> > > +
> > > +       /*
> > > +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> > > +        * the ptrace visible DR6 copy.
> > > +        */
> > > +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> > > +               current->thread.virtual_dr6 |= (dr6 & DR_STEP);
> > > +
> > > +       /*
> > > +        * The SDM says "The processor clears the BTF flag when it
> > > +        * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
> > > +        * TIF_BLOCKSTEP in sync with the hardware BTF flag.
> > > +        */
> > > +       clear_thread_flag(TIF_BLOCKSTEP);
> > > +
> > >         /*
> > >          * If dr6 has no reason to give us about the origin of this trap,
> > >          * then it's very likely the result of an icebp/int01 trap.
> >
> > This looks good to me (at least the non BTF parts), and I'll test it
> > shortly, but especially now that clearing virtual_dr6 is moved to
> > exc_debug_user I still don't see why it's not ok to copy the entire
> > dr6 value into virtual_dr6 unconditionally.  Any extraneous dr6 state
> > from an in-kernel #DB would have been picked up and cleared already
> > when we entered exc_debug_kernel.
>
> There is !ptrace user breakpoints as well. Why should we want potential
> random bits in dr6 ?
>
> Suppose perf and ptrace set a user breakpoint on the exact same
> instruction. The #DB fires and has two DR_TRAP# bits set. perf consumes
> one and ptrace consumes one.
>
> Only the ptrace one should be visible to ptrace, the perf one doesn't
> affect the userspace execution at all and shouldn't be visible.

Ok. Makes sense.

I can confirm that your second patch does fix the behavior I was
seeing and rr works again.

- Kyle
