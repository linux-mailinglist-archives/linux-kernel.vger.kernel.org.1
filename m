Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1092C0C23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgKWNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbgKWNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:46:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20704C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eqo+5xtEEChY6Yq+NrnAD5DS1fVhv2fF+uY8pMNKUoY=; b=dx9rZZeX0w2VnNC6liFUcqYbpV
        RYhMYe6HKsbb0o5u3CtMpp6Ds+78K9FaZjZ7GduiKaOo7Z4EwaZrLQHCS00a9dm4HKSmVeb4xG27U
        2Lmgf2w3x0FhXGXPKf9muzRdy6wq2VuD1uctE5roHoD50cHFexzskejYSUQh1+PICEIkGVz6aPFtY
        ctC7UVrSaUIQNUQQKx0YdJMEt75L9lu8R8SUW1n8aoiGEAk6YA5j5geOT809XCFH+CERxwQWgYW0C
        dmO/wQ5msYZW3Ni8m0qotGCz3v98X8xAe17YaZwbFu8JZzwpOp2+6Gk52y3dzLw0SxyBplLjvleWK
        38aJJ/jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khCAd-0005vj-9x; Mon, 23 Nov 2020 13:46:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5797F3069B1;
        Mon, 23 Nov 2020 14:46:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 427C7210782E4; Mon, 23 Nov 2020 14:46:18 +0100 (CET)
Date:   Mon, 23 Nov 2020 14:46:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, svens@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] intel_idle: Fix intel_idle() vs tracing
Message-ID: <20201123134618.GL3021@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.652731270@infradead.org>
 <CAJZ5v0hhSO36-m-otWp0vqWNNZFiDWPX-xxK-ninRr2d==QOWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hhSO36-m-otWp0vqWNNZFiDWPX-xxK-ninRr2d==QOWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:26:39AM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 20, 2020 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > cpuidle->enter() callbacks should not call into tracing because RCU
> > has already been disabled. Instead of doing the broadcast thing
> > itself, simply advertise to the cpuidle core that those states stop
> > the timer.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  drivers/idle/intel_idle.c |   37 ++++++++++++++++++++-----------------
> >  1 file changed, 20 insertions(+), 17 deletions(-)
> >
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -126,26 +126,9 @@ static __cpuidle int intel_idle(struct c
> >         struct cpuidle_state *state = &drv->states[index];
> >         unsigned long eax = flg2MWAIT(state->flags);
> >         unsigned long ecx = 1; /* break on interrupt flag */
> > -       bool tick;
> > -
> > -       if (!static_cpu_has(X86_FEATURE_ARAT)) {
> > -               /*
> > -                * Switch over to one-shot tick broadcast if the target C-state
> > -                * is deeper than C1.
> > -                */
> > -               if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
> > -                       tick = true;
> > -                       tick_broadcast_enter();
> > -               } else {
> > -                       tick = false;
> > -               }
> > -       }
> >
> >         mwait_idle_with_hints(eax, ecx);
> >
> > -       if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
> > -               tick_broadcast_exit();
> > -
> >         return index;
> >  }
> >
> > @@ -1460,6 +1443,23 @@ static bool __init intel_idle_verify_cst
> >         return true;
> >  }
> >
> > +static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
> > +{
> > +       unsigned long eax = flg2MWAIT(state->flags);
> > +
> > +       if (boot_cpu_has(X86_FEATURE_ARAT))
> > +               return false;
> > +
> > +       /*
> > +        * Switch over to one-shot tick broadcast if the target C-state
> > +        * is deeper than C1.
> > +        */
> > +       if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK)
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
> >  {
> >         int cstate;
> > @@ -1507,6 +1507,9 @@ static void __init intel_idle_init_cstat
> >                      !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
> >                         drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
> >
> > +               if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
> > +                       drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +
> >                 drv->state_count++;
> >         }
> 
> This doesn't cover the ACPI case AFAICS.

aa6b43d57f99 ("ACPI: processor: Use CPUIDLE_FLAG_TIMER_STOP")

did that, no?
