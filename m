Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA329C4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824029AbgJ0SBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1814692AbgJ0SBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:01:07 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A39E222D9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603821666;
        bh=TzTwdAMYcD4LPCWjUhVT3CxdGaolHmO/jVpnkosMXy8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z5mk9ns0PmrZb8SGFBMQ/FIlShHAHi50QXpeAZF/33pPmCsNkL0R4oKTRFo77NRm/
         yqkjeSrsyrRUn8VZx9LBdCa2r0UbgwPXUiseRgH4XSRWEptJESe9JAPXi6jF0XpxDK
         3EAIAibnNinkj0vIswmyMlD8axqESRiQ5v9idJnc=
Received: by mail-wr1-f48.google.com with SMTP id e17so2905734wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:01:05 -0700 (PDT)
X-Gm-Message-State: AOAM533/sC+S3KKHb/hT34pdUVnBL5lrQ/Y1XAHzcRSPFJx4WS5Qq9GW
        bUdDH14LBUNISPaxNv8ZAPsqdM9gGM1G7ExCbgBwgg==
X-Google-Smtp-Source: ABdhPJxqlszRQTrZ+ysE5KwQCRoFWTNryUspjt1j6bAb6OacxUZmjCBpmOpk//lGSL9F3x8psgHj3QwvJYbmG1VqvYY=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr4306851wrw.18.1603821664354;
 Tue, 27 Oct 2020 11:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net> <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net> <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com> <20201027081932.GY2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201027081932.GY2611@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Oct 2020 11:00:52 -0700
X-Gmail-Original-Message-ID: <CALCETrUcx_GaYhUbdc82faeftn+PssdWbWSPWELZ7Npcrbd92w@mail.gmail.com>
Message-ID: <CALCETrUcx_GaYhUbdc82faeftn+PssdWbWSPWELZ7Npcrbd92w@mail.gmail.com>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Kyle Huey <me@kylehuey.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 26, 2020 at 04:30:32PM -0700, Andy Lutomirski wrote:
>
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
> >
> > I'm guessing that this would fail a much simpler test, though: have a
> > program use PUSHF to set TF and then read out DR6 from the SIGTRAP.  I
> > can whip up such a test if you like.
>
> Kyle also mentioned it. The reason I didn't do that is because ptrace()
> didn't set the TF, so why should it see it in ptrace_get_debugreg(6) ?

I assume you already figured this out, but my specific concern is with
the get_si_code(dr6) part -- that's sent directly to the task being
debugged or debugging itself (and, sadly, to ptrace, and who knows
what debuggers do).
