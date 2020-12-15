Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2CF2DA95D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgLOIll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:41:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44691 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgLOIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:41:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id f16so18574318otl.11;
        Tue, 15 Dec 2020 00:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ba7mc/BCMYdw7FaeaEdwydqlVnKjTzjlShw/SDUcZp0=;
        b=iomaYM7D8ZoEhPrre+p+cApdvqpyI0TWJBcAIK33R5b9bl2BfcwUdy5atCI5GsxKjs
         1wA7fXpUnMNBJki7qeNDgbNkBLiPyEa/2/KD5RhFY30kB9YQFkREKnF4OELBrEIahMue
         XwD85CZXD1bLv+xRRuaa3ZvBFhzyvXH+jqsj4Uvy7O1ixqMQe6BWhV+NuucDyNNomZHB
         s1U7EOKTVYI8t9LXcTaUQVufMECdFBXhzyccYBzc35hrq+W4eyzCoIokMVPjPER63l6k
         MqYj5SjGuuI0qrBOB5+nnHy7NLQQjJq7L0cEHDuRpxqmrxOoZYJZCpKsJ6UMD66zAr9K
         izhg==
X-Gm-Message-State: AOAM5328Rg/fZlWoCS621t4Kuip0KjIAAFN9R9ry7q+Cep/sxbZBQi07
        7pLOaCYBz5s720qZLZH1uf0MjTPTyT8nk5J3CKs=
X-Google-Smtp-Source: ABdhPJyziYSsvqwOWh908ds9wuseIW4WlDDaCvlJB9DaOfZyJAkb5XL0UpuFaCTo13cbBHs4YTr4QhfF+hJ/B4H/oDY=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr22477520otc.145.1608021637754;
 Tue, 15 Dec 2020 00:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20201105233900.GA20676@paulmck-ThinkPad-P72> <20201105233933.20748-3-paulmck@kernel.org>
In-Reply-To: <20201105233933.20748-3-paulmck@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Dec 2020 09:40:26 +0100
Message-ID: <CAMuHMdXjUxfp0h=TiwNoZJUHrSD4sDwYEbuqNR4rcWSRFCjUtw@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 3/4] rcutorture: Make grace-period kthread
 report match RCU flavor being tested
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Nov 6, 2020 at 12:40 AM <paulmck@kernel.org> wrote:
>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> At the end of the test and after rcu_torture_writer() stalls, rcutorture
> invokes show_rcu_gp_kthreads() in order to dump out information on the
> RCU grace-period kthread.  This makes a lot of sense when testing vanilla
> RCU, but not so much for the other flavors.  This commit therefore allows
> per-flavor kthread-dump functions to be specified.
>
> [ paulmck: Apply feedback from kernel test robot <lkp@intel.com>. ]
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for your patch, which is now commit 27c0f1448389baf7
("rcutorture: Make grace-period kthread report match RCU flavor being
tested").

> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -533,4 +533,20 @@ static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
>  static inline void rcu_bind_current_to_nocb(void) { }
>  #endif
>
> +#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RCU)
> +void show_rcu_tasks_classic_gp_kthread(void);
> +#else
> +static inline void show_rcu_tasks_classic_gp_kthread(void) {}
> +#endif
> +#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
> +void show_rcu_tasks_rude_gp_kthread(void);
> +#else
> +static inline void show_rcu_tasks_rude_gp_kthread(void) {}
> +#endif

The #ifdef expression does not match the one for the implementation
below.

> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c

> @@ -762,6 +765,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
>         .exp_sync       = synchronize_rcu_tasks_rude,
>         .call           = call_rcu_tasks_rude,
>         .cb_barrier     = rcu_barrier_tasks_rude,
> +       .gp_kthread_dbg = show_rcu_tasks_rude_gp_kthread,

Perhaps you just want to have a NULL pointer for the dummy case, instead
of instantiating a dummy static inline function and taking its address?

>         .fqs            = NULL,
>         .stats          = NULL,
>         .irq_capable    = 1,


> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

> @@ -696,16 +696,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
>  }
>  core_initcall(rcu_spawn_tasks_rude_kthread);
>
> -#ifndef CONFIG_TINY_RCU
> -static void show_rcu_tasks_rude_gp_kthread(void)
> +#if !defined(CONFIG_TINY_RCU)

Different #ifdef expression.

> +void show_rcu_tasks_rude_gp_kthread(void)

Do you really want to define a non-static function...

>  {
>         show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
>  }
> -#endif /* #ifndef CONFIG_TINY_RCU */
> -
> -#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
> -static void show_rcu_tasks_rude_gp_kthread(void) {}
> -#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
> +EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);

... and export its symbol, from a header file?
I know the file is included only once.

> +#endif // !defined(CONFIG_TINY_RCU)
> +#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
>
>  ////////////////////////////////////////////////////////////////////////
>  //

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
