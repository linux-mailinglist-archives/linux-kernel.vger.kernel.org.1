Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E482C0E42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgKWOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:54:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41540 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbgKWOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:54:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id m13so19921323oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdDzxvC81GM8ysJ3lhFnaqueUFlqQjeIhTfbA5tb7kc=;
        b=TyZ5jwN+2p3Cc+0YxeEeKIq/Si1kQ3x+MCjuxIVYHW5chRmoxlfjoQPp1nLG1A9BL0
         HRG3xgiuemDMfRlvUn0l3nO01Mg8fMWpxHsw5EjaKGEtL00OVfitcg2u1pqe9CPPw/uN
         4dTHEWrQ+DKersI8nDRWr6y+VEbKKFDYkyDdRM7S0LRbH5WdyFnff7bRzUmF+mkp+9/1
         y+5Z/4v9ShP+HifrX14DyfYYJE6cKnRd0GFwl+uWzqw/RQF1PqSMegL/lyTW6jfeilQp
         mHAXfUgAyZwugvcTEwvtaykje7Mn//khgYvBs25i3qr2NC3qIfir+cHlqkHXmoQHYRFY
         EHTg==
X-Gm-Message-State: AOAM533wtYsUc85BwwxFYAJnUvz/gClM6p1Q0xe6xWi1NQU0qdCcOjf3
        0KmOHUntG26W2jTMX6YkFJaCsZAZ7nxEaZeFncM=
X-Google-Smtp-Source: ABdhPJxZr/YjE6PkD0NoI8ZRmVL6w1sEKs3Or8fNr/NjsUD2m3jSb/FO4kE/ertuB12FG44O6Tqdx09VWrEcfES8vqM=
X-Received: by 2002:aca:da02:: with SMTP id r2mr10469083oig.157.1606143294240;
 Mon, 23 Nov 2020 06:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20201120114145.197714127@infradead.org> <20201120114925.652731270@infradead.org>
 <CAJZ5v0hhSO36-m-otWp0vqWNNZFiDWPX-xxK-ninRr2d==QOWA@mail.gmail.com>
 <20201123134618.GL3021@hirez.programming.kicks-ass.net> <CAJZ5v0invgyZ50AHZmbOBYkgvM2uAqqE+t_mvD=ZCxac_gAtUQ@mail.gmail.com>
 <20201123143510.GR3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201123143510.GR3021@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 15:54:43 +0100
Message-ID: <CAJZ5v0grKGsyLo70KBTsiBgyuh_mVJf+Jh-aLabJHVnONtX0-A@mail.gmail.com>
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

On Mon, Nov 23, 2020 at 3:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 23, 2020 at 02:54:47PM +0100, Rafael J. Wysocki wrote:
>
> > intel_idle_init_cstates_acpi() needs to be updated too as it doesn't
> > pick up the flags automatically.
>
> Ooh, it has two different state init routines :-/, sorry I missed that.
> See below.
>
> > It looks like CPUIDLE_FLAG_RCU_IDLE needs to be copied too.
>
> I might need more clue again; processor_idle() needs this because it
> calls into ACPI (acpi_idle_enter_bm()) for that BM crud. I didn't find
> anything like that here.
>
>
> ---
> Subject: intel_idle: Fix intel_idle() vs tracing
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 20 11:28:35 CET 2020
>
> cpuidle->enter() callbacks should not call into tracing because RCU
> has already been disabled. Instead of doing the broadcast thing
> itself, simply advertise to the cpuidle core that those states stop
> the timer.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

with a very minor nit below.

> ---
>  drivers/idle/intel_idle.c |   40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -126,26 +126,9 @@ static __cpuidle int intel_idle(struct c
>         struct cpuidle_state *state = &drv->states[index];
>         unsigned long eax = flg2MWAIT(state->flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
> -       bool tick;
> -
> -       if (!static_cpu_has(X86_FEATURE_ARAT)) {
> -               /*
> -                * Switch over to one-shot tick broadcast if the target C-state
> -                * is deeper than C1.
> -                */
> -               if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
> -                       tick = true;
> -                       tick_broadcast_enter();
> -               } else {
> -                       tick = false;
> -               }
> -       }
>
>         mwait_idle_with_hints(eax, ecx);
>
> -       if (!static_cpu_has(X86_FEATURE_ARAT) && tick)
> -               tick_broadcast_exit();
> -
>         return index;
>  }
>
> @@ -1227,6 +1210,23 @@ static bool __init intel_idle_acpi_cst_e
>         return false;
>  }
>
> +static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
> +{
> +       unsigned long eax = flg2MWAIT(state->flags);
> +
> +       if (boot_cpu_has(X86_FEATURE_ARAT))
> +               return false;
> +
> +       /*
> +        * Switch over to one-shot tick broadcast if the target C-state
> +        * is deeper than C1.
> +        */
> +       if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK)
> +               return true;
> +
> +       return false;

The above can be written as

return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);

> +}
> +
>  static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
>  {
>         int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
> @@ -1269,6 +1269,9 @@ static void __init intel_idle_init_cstat
>                 if (disabled_states_mask & BIT(cstate))
>                         state->flags |= CPUIDLE_FLAG_OFF;
>
> +               if (intel_idle_state_needs_timer_stop(state))
> +                       state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +
>                 state->enter = intel_idle;
>                 state->enter_s2idle = intel_idle_s2idle;
>         }
> @@ -1507,6 +1510,9 @@ static void __init intel_idle_init_cstat
>                      !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
>                         drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
>
> +               if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
> +                       drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
> +
>                 drv->state_count++;
>         }
>
