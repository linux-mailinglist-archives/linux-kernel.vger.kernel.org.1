Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AED2C0C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbgKWNy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:54:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36936 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbgKWNy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:54:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id l36so15950960ota.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tq96Nh1Co8RcOllLdFfkMwlqyVvuQ4D6bMKyZbmcJ3g=;
        b=EUGHKLCNqRN5xveb76D2hNmIYyQsfKmYVKcTz4vJwAmvSRClKXDY8/P+Fr3wWHSnXA
         lPgj3HOcrXZc8iYGg0LH1eQ7K1oBLXH9/TVhZV0OxM6yKVi080o3lRwM5MCXn6DuZ8NX
         uwu75AuH05n3eY+5WG3kKPOEZSiYaUR6KcHe+Pge6vD6jIt9u1sSh7W/VOrjrSI4Xxqx
         OT+/Wnv/SfyLgcnKYL7XCwFFvSSsJyZThHzs1NJBkDZhQUBAr2i1KLNVwX9dC/IUGmcw
         xMzhsJs4/tPjZ+ZiE7ZSTIdlhOgGFn63fQBCIxYV+usCXDvZq3rIkVLJ9QUtV+rZhAJT
         Jskw==
X-Gm-Message-State: AOAM532hB0+IQrtkasFcjYO3UpYzYIQzyaMj2FRobOTC5oMQV2tYhV4K
        9qyGulb6vJZR87ts06c5InCPy6f84qsxpYnWmn+Ceb3I/zI=
X-Google-Smtp-Source: ABdhPJzXXez4p3pf928DPueHy/3kYrLgerW/TZwPzeO9qBSvS35nNwG6l6I5VyAWxg7CBO1/Dl2/8WmECn9XGxZqjoY=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr12789502ots.321.1606139698218;
 Mon, 23 Nov 2020 05:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20201120114145.197714127@infradead.org> <20201120114925.652731270@infradead.org>
 <CAJZ5v0hhSO36-m-otWp0vqWNNZFiDWPX-xxK-ninRr2d==QOWA@mail.gmail.com> <20201123134618.GL3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201123134618.GL3021@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 14:54:47 +0100
Message-ID: <CAJZ5v0invgyZ50AHZmbOBYkgvM2uAqqE+t_mvD=ZCxac_gAtUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] intel_idle: Fix intel_idle() vs tracing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, svens@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 2:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 23, 2020 at 11:26:39AM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 20, 2020 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > cpuidle->enter() callbacks should not call into tracing because RCU
> > > has already been disabled. Instead of doing the broadcast thing
> > > itself, simply advertise to the cpuidle core that those states stop
> > > the timer.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  drivers/idle/intel_idle.c |   37 ++++++++++++++++++++-----------------
> > >  1 file changed, 20 insertions(+), 17 deletions(-)
> > >
> > > --- a/drivers/idle/intel_idle.c
> > > +++ b/drivers/idle/intel_idle.c
> > > @@ -126,26 +126,9 @@ static __cpuidle int intel_idle(struct c
> > >         struct cpuidle_state *state = &drv->states[index];
> > >         unsigned long eax = flg2MWAIT(state->flags);
> > >         unsigned long ecx = 1; /* break on interrupt flag */
> > > -       bool tick;
> > > -
> > > -       if (!static_cpu_has(X86_FEATURE_ARAT)) {
> > > -               /*
> > > -                * Switch over to one-shot tick broadcast if the target C-state
> > > -                * is deeper than C1.
> > > -                */
> > > -               if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
> > > -                       tick = true;
> > > -                       tick_broadcast_enter();
> > > -               } else {
> > > -                       tick = false;
> > > -               }
> > > -       }
> > >
> > >         mwait_idle_with_hints(eax, ecx);
> > >
> > > -       if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
> > > -               tick_broadcast_exit();
> > > -
> > >         return index;
> > >  }
> > >
> > > @@ -1460,6 +1443,23 @@ static bool __init intel_idle_verify_cst
> > >         return true;
> > >  }
> > >
> > > +static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
> > > +{
> > > +       unsigned long eax = flg2MWAIT(state->flags);
> > > +
> > > +       if (boot_cpu_has(X86_FEATURE_ARAT))
> > > +               return false;
> > > +
> > > +       /*
> > > +        * Switch over to one-shot tick broadcast if the target C-state
> > > +        * is deeper than C1.
> > > +        */
> > > +       if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK)
> > > +               return true;
> > > +
> > > +       return false;
> > > +}
> > > +
> > >  static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
> > >  {
> > >         int cstate;
> > > @@ -1507,6 +1507,9 @@ static void __init intel_idle_init_cstat
> > >                      !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
> > >                         drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
> > >
> > > +               if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
> > > +                       drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
> > > +
> > >                 drv->state_count++;
> > >         }
> >
> > This doesn't cover the ACPI case AFAICS.
>
> aa6b43d57f99 ("ACPI: processor: Use CPUIDLE_FLAG_TIMER_STOP")
>
> did that, no?

Nope.

intel_idle_init_cstates_acpi() needs to be updated too as it doesn't
pick up the flags automatically.  It looks like CPUIDLE_FLAG_RCU_IDLE
needs to be copied too.
