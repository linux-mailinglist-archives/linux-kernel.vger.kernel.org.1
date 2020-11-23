Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8610C2C0343
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgKWK0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:26:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41229 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgKWK0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:26:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id o3so15415870ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5u0xzZz9ImFFa+4Dc6Fet6O4+9bCjJoGhoQNnf3226E=;
        b=prRPr7kEo6K5TWuT8zbh43M+2bAJlGLFF7YSfZnQFsFbuKEypqQk2k8fKsxtMCH4OR
         fIjYBKCByMLBYgSNUiv5b1z5Qp7QHmmYxIWR6yJ0S623sMIHz9b8GHn4QK5ciliBD4I4
         MDky3o1QK4Du6nckPGV7Hb30Yh9K72svco0Rn7GWSGCtH7I68xcMdSn/q4j4LGJ4VRVH
         sTT6zR0eH6lYnKHwOCOe+exAt5fprZhdmMimQAGu9xokCC1PWXfkHz9pRXAu3YwAvve9
         qXAgiIe1ip4Bh/wwSlkAAijW+jo7DQNfDl0Kd+KaqTP8WGbdL0G+q+VZ7iKrO4bCZGc8
         Y8/w==
X-Gm-Message-State: AOAM533mlBMMqvYPUsdAqSfp9UvPuuteXn/UtzgeqwFyMjtHuFv5rz8l
        cvqUYCI32xVlYuAqwdH3VZsMMYxbJRdlQi3cIOk=
X-Google-Smtp-Source: ABdhPJyerjH6lnUTs24LfvLv17KtbjaFsTq+GdntqMGuOKMHsHStLyKZCKTQynSN6e/FcaY0fO59j5f6bIx1ECDWYkg=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr12195105ots.321.1606127211528;
 Mon, 23 Nov 2020 02:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20201120114145.197714127@infradead.org> <20201120114925.652731270@infradead.org>
In-Reply-To: <20201120114925.652731270@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 11:26:39 +0100
Message-ID: <CAJZ5v0hhSO36-m-otWp0vqWNNZFiDWPX-xxK-ninRr2d==QOWA@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> cpuidle->enter() callbacks should not call into tracing because RCU
> has already been disabled. Instead of doing the broadcast thing
> itself, simply advertise to the cpuidle core that those states stop
> the timer.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/idle/intel_idle.c |   37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
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
> @@ -1460,6 +1443,23 @@ static bool __init intel_idle_verify_cst
>         return true;
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
> +}
> +
>  static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>  {
>         int cstate;
> @@ -1507,6 +1507,9 @@ static void __init intel_idle_init_cstat
>                      !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
>                         drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
>
> +               if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
> +                       drv->states[drv->state_count].flags |= CPUIDLE_FLAG_TIMER_STOP;
> +
>                 drv->state_count++;
>         }

This doesn't cover the ACPI case AFAICS.
