Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A967B28C77F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgJMDKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJMDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:10:36 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A136C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:10:36 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r24so10253985vsp.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Px9JgYEdBFcF+MKgyNKdrOGF5njr/oCa3pYGfZo2og=;
        b=qGTFbtfyGbzUkJYS803OSuEfX5dXXT+tpxtlPvWkIUgdwhCVDqeCTyt/zzd7KHtpNq
         ky3tsBtkceIrBu95rgap8m2428RlfIbMBsK1rcnDN79sUFHY3bKRtBMBlTTXBQJVMLvx
         zDZf7adLLUnZ61ng1/sjozlphd4cbR7FZogVF/QwQyArAAzsFOiOSO5srZo/Z6G4LEcp
         5aM+nm8Yaon4s7aTT701Vx2wEGV9kq89TZ5TwOsLAcuKYyow9YpR+oUw3eziySZSb8Ib
         MdKtOAQJ1bKKIvmixkM7JrttbHSTRndQTnLqoxxks3oE3MeF6DM9+WVUK1ORwhTPXqX0
         Kfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Px9JgYEdBFcF+MKgyNKdrOGF5njr/oCa3pYGfZo2og=;
        b=L2A/NBXjFpQeQ6NQQ9et8itBazLpMTvYbBKRNqowbf1Afd/eTzZcWXZtDSk/JCz/GP
         6mTb5hO73/NRMlASMaDkXyr8bNZo6J9MV1hsgBmF9c8LRrZVcKsUXlgjQN9jqH2spd1V
         O/YMbUqRpASZx/qSUHujJvR8oFTKQ2CKC/8RXgroFtmmVGMsiqTlmeyzXhEmp2uC5HW3
         4tMocEtZqelzyL6Nz5BNRjfa2vkvV2OI38wOQzVoar5ALWOT/ROSBXtWMYZ8doYNkMfi
         0pY4Ofuw2R0yWRzZgdvTxPhgNffhmYEcujpdsHEWVmyfH7qj4AFDT7k8tkYjCJ0fwVNg
         0cvQ==
X-Gm-Message-State: AOAM532SYs9ecPOop0m7UBENZCLbTBxPuBZX/crsnlSLrz97vfmy0mT2
        8dmgJb9QL9JCjtrxpvBo1yfmkBskG2G98RxfexQ=
X-Google-Smtp-Source: ABdhPJzCR8B9S96aSpwjUlTCdezBt9My5bTQNTk0o3Gx2w3MOq2z9z/oaOdgdC1vmBljT6BnjRD0n/gWsxU72CIFYdo=
X-Received: by 2002:a67:fb96:: with SMTP id n22mr15752410vsr.13.1602558635141;
 Mon, 12 Oct 2020 20:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <1602510644-24536-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1602510644-24536-1-git-send-email-kernelfans@gmail.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Tue, 13 Oct 2020 11:10:24 +0800
Message-ID: <CAKc596KLgwE98Hch-WMCFM38W=FryronqASgn2ih3U_-+YU3ww@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: correct account of irqtime
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pingfan Liu <kernelfans@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:54=E5=86=99=E9=81=93=EF=BC=9A
>
> __do_softirq() may be interrupted by hardware interrupts. In this case,
> irqtime_account_irq() will account the time slice as CPUTIME_SOFTIRQ by
> mistake.
>
> By passing irqtime_account_irq() an extra param about either hardirq or
> softirq, irqtime_account_irq() can handle the above case.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Allen Pais <allen.lkml@gmail.com>
> Cc: Romain Perier <romain.perier@gmail.com>
> To: linux-kernel@vger.kernel.org
> ---
>  include/linux/hardirq.h |  4 ++--
>  include/linux/vtime.h   | 12 ++++++------
>  kernel/sched/cputime.c  |  4 ++--
>  kernel/softirq.c        |  6 +++---
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 754f67a..56e7bb5 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -32,7 +32,7 @@ static __always_inline void rcu_irq_enter_check_tick(vo=
id)
>   */
>  #define __irq_enter()                                  \
>         do {                                            \
> -               account_irq_enter_time(current);        \
> +               account_irq_enter_time(current, true);  \
>                 preempt_count_add(HARDIRQ_OFFSET);      \
>                 lockdep_hardirq_enter();                \
>         } while (0)
> @@ -63,7 +63,7 @@ void irq_enter_rcu(void);
>  #define __irq_exit()                                   \
>         do {                                            \
>                 lockdep_hardirq_exit();                 \
> -               account_irq_exit_time(current);         \
> +               account_irq_exit_time(current, true);   \
>                 preempt_count_sub(HARDIRQ_OFFSET);      \
>         } while (0)
>
> diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> index 2cdeca0..294188ae1 100644
> --- a/include/linux/vtime.h
> +++ b/include/linux/vtime.h
> @@ -98,21 +98,21 @@ static inline void vtime_flush(struct task_struct *ts=
k) { }
>
>
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -extern void irqtime_account_irq(struct task_struct *tsk);
> +extern void irqtime_account_irq(struct task_struct *tsk, bool hardirq);
>  #else
> -static inline void irqtime_account_irq(struct task_struct *tsk) { }
> +static inline void irqtime_account_irq(struct task_struct *tsk, bool har=
dirq) { }
>  #endif
>
> -static inline void account_irq_enter_time(struct task_struct *tsk)
> +static inline void account_irq_enter_time(struct task_struct *tsk, bool =
hardirq)
>  {
>         vtime_account_irq_enter(tsk);
> -       irqtime_account_irq(tsk);
> +       irqtime_account_irq(tsk, hardirq);
>  }
>
> -static inline void account_irq_exit_time(struct task_struct *tsk)
> +static inline void account_irq_exit_time(struct task_struct *tsk, bool h=
ardirq)
>  {
>         vtime_account_irq_exit(tsk);
> -       irqtime_account_irq(tsk);
> +       irqtime_account_irq(tsk, hardirq);
>  }
>
>  #endif /* _LINUX_KERNEL_VTIME_H */
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 5a55d23..166f1d7 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -47,7 +47,7 @@ static void irqtime_account_delta(struct irqtime *irqti=
me, u64 delta,
>   * Called before incrementing preempt_count on {soft,}irq_enter
>   * and before decrementing preempt_count on {soft,}irq_exit.
>   */
> -void irqtime_account_irq(struct task_struct *curr)
> +void irqtime_account_irq(struct task_struct *curr, bool hardirq)
>  {
>         struct irqtime *irqtime =3D this_cpu_ptr(&cpu_irqtime);
>         s64 delta;
> @@ -68,7 +68,7 @@ void irqtime_account_irq(struct task_struct *curr)
>          */
>         if (hardirq_count())
>                 irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> -       else if (in_serving_softirq() && curr !=3D this_cpu_ksoftirqd())
> +       else if (in_serving_softirq() && curr !=3D this_cpu_ksoftirqd() &=
& !hardirq)
>                 irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>  }

In my opinion, we don't need to use the hardirq flag, the code: if
(hardirq_count())
already tell us that where the delt time is from.

Thanks

>  EXPORT_SYMBOL_GPL(irqtime_account_irq);
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index bf88d7f6..da59ea39 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -270,7 +270,7 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
>         current->flags &=3D ~PF_MEMALLOC;
>
>         pending =3D local_softirq_pending();
> -       account_irq_enter_time(current);
> +       account_irq_enter_time(current, false);
>
>         __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>         in_hardirq =3D lockdep_softirq_start();
> @@ -321,7 +321,7 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
>         }
>
>         lockdep_softirq_end(in_hardirq);
> -       account_irq_exit_time(current);
> +       account_irq_exit_time(current, false);
>         __local_bh_enable(SOFTIRQ_OFFSET);
>         WARN_ON_ONCE(in_interrupt());
>         current_restore_flags(old_flags, PF_MEMALLOC);
> @@ -417,7 +417,7 @@ static inline void __irq_exit_rcu(void)
>  #else
>         lockdep_assert_irqs_disabled();
>  #endif
> -       account_irq_exit_time(current);
> +       account_irq_exit_time(current, true);
>         preempt_count_sub(HARDIRQ_OFFSET);
>         if (!in_interrupt() && local_softirq_pending())
>                 invoke_softirq();
> --
> 2.7.5
>
