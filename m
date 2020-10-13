Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958BB28C7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgJMEWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgJMEWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:22:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79807C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:22:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q202so11387155iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=//IwPOVVvuCjBIXmLQeoJNFx0EbbrHJM3ah6uT01Ego=;
        b=mG7JSxIKx7OxKgZZ+54+VEIw+45uG+4B3ulVHEo8cwoM1/n2kiovhznmEi/njDemZV
         CWkv3XBKZZvbIgq6802VxX/sQCRIg698enwPjZdsuBpZ8oYpK/tbxjX6uzJRn+JYrCFu
         itCX9koVWUZYobZXjeKBzgRHjhazD/XT1ycT7SO/gLO8GHqxtsIJ56C280XvklCvPLfq
         2Rr5NhjgGYoMKpNLXigTBalntbfIsheGmGHGDg16R8RzhSQTz/ZCalu6tcwdBeOdJUNH
         YjVoL2/ZnHva6LEl5ALTfA6YdYLvJ5NhmqGnj8aBUJhKBW9VyIEF4V53QTuJ4jdAxXsW
         HaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=//IwPOVVvuCjBIXmLQeoJNFx0EbbrHJM3ah6uT01Ego=;
        b=giv1QtiPwn6LApeyXZInRtvt8InksJW9x6qhwJ+AJ+QzVRP0ifYDdpHjOJZhzSL7Uj
         LjTRAjJXv1dl5fx94sEX88uXTIg6oSsvzy/x8P+iYp4gaqH9ThXlYOynzG7iZJSU9u4P
         41zXuU5zZx3tG/qm55Z1ZUrPrWifpG/3CjcsPsj6XL1b76YtX0dbsLujI/46yLel1sql
         gxyg0ApyLg9CjZoG6n7cNs/IX5iefJRyhGSDSh7awatvPzMxEXQ1Z9XwsLBNT/Xx6lf4
         UtMb664WcGz7KeyIJMr8RTFEED+3PFOf5q5xzZQb1BGLR+Oa5GwlYC1HT1XObG1gdspw
         KY7g==
X-Gm-Message-State: AOAM5323BdXAuV+PGSZrpc3pui4rfokNBkhQ4TB7UQ58xLb3NbKjdTjM
        sJUBeIgydyAYEKneOq6Z5ADiEgF4nmf9hm+2zA==
X-Google-Smtp-Source: ABdhPJxpOHrOiCjAcjPDhDDPpWkuxk01wWBtR98ijqcTYBgOVQsLZNL/1x6SDTUsrj9XnEmTQZ9x42l1V1ApwgQUgSQ=
X-Received: by 2002:a05:6602:2290:: with SMTP id d16mr18949932iod.210.1602562972556;
 Mon, 12 Oct 2020 21:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <1602510644-24536-1-git-send-email-kernelfans@gmail.com> <CAKc596KLgwE98Hch-WMCFM38W=FryronqASgn2ih3U_-+YU3ww@mail.gmail.com>
In-Reply-To: <CAKc596KLgwE98Hch-WMCFM38W=FryronqASgn2ih3U_-+YU3ww@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 13 Oct 2020 12:22:41 +0800
Message-ID: <CAFgQCTs2r6TVEtJEt5D_OasKQZavzgRNcW1pn3Jov9e9WdqV2A@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: correct account of irqtime
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Tue, Oct 13, 2020 at 11:10 AM jun qian <qianjun.kernel@gmail.com> wrote:
>
> Pingfan Liu <kernelfans@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:54=E5=86=99=E9=81=93=EF=BC=9A
> >
> > __do_softirq() may be interrupted by hardware interrupts. In this case,
> > irqtime_account_irq() will account the time slice as CPUTIME_SOFTIRQ by
> > mistake.
> >
> > By passing irqtime_account_irq() an extra param about either hardirq or
> > softirq, irqtime_account_irq() can handle the above case.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Allen Pais <allen.lkml@gmail.com>
> > Cc: Romain Perier <romain.perier@gmail.com>
> > To: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/hardirq.h |  4 ++--
> >  include/linux/vtime.h   | 12 ++++++------
> >  kernel/sched/cputime.c  |  4 ++--
> >  kernel/softirq.c        |  6 +++---
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> > index 754f67a..56e7bb5 100644
> > --- a/include/linux/hardirq.h
> > +++ b/include/linux/hardirq.h
> > @@ -32,7 +32,7 @@ static __always_inline void rcu_irq_enter_check_tick(=
void)
> >   */
> >  #define __irq_enter()                                  \
> >         do {                                            \
> > -               account_irq_enter_time(current);        \
> > +               account_irq_enter_time(current, true);  \
> >                 preempt_count_add(HARDIRQ_OFFSET);      \
> >                 lockdep_hardirq_enter();                \
> >         } while (0)
> > @@ -63,7 +63,7 @@ void irq_enter_rcu(void);
> >  #define __irq_exit()                                   \
> >         do {                                            \
> >                 lockdep_hardirq_exit();                 \
> > -               account_irq_exit_time(current);         \
> > +               account_irq_exit_time(current, true);   \
> >                 preempt_count_sub(HARDIRQ_OFFSET);      \
> >         } while (0)
> >
> > diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> > index 2cdeca0..294188ae1 100644
> > --- a/include/linux/vtime.h
> > +++ b/include/linux/vtime.h
> > @@ -98,21 +98,21 @@ static inline void vtime_flush(struct task_struct *=
tsk) { }
> >
> >
> >  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> > -extern void irqtime_account_irq(struct task_struct *tsk);
> > +extern void irqtime_account_irq(struct task_struct *tsk, bool hardirq)=
;
> >  #else
> > -static inline void irqtime_account_irq(struct task_struct *tsk) { }
> > +static inline void irqtime_account_irq(struct task_struct *tsk, bool h=
ardirq) { }
> >  #endif
> >
> > -static inline void account_irq_enter_time(struct task_struct *tsk)
> > +static inline void account_irq_enter_time(struct task_struct *tsk, boo=
l hardirq)
> >  {
> >         vtime_account_irq_enter(tsk);
> > -       irqtime_account_irq(tsk);
> > +       irqtime_account_irq(tsk, hardirq);
> >  }
> >
> > -static inline void account_irq_exit_time(struct task_struct *tsk)
> > +static inline void account_irq_exit_time(struct task_struct *tsk, bool=
 hardirq)
> >  {
> >         vtime_account_irq_exit(tsk);
> > -       irqtime_account_irq(tsk);
> > +       irqtime_account_irq(tsk, hardirq);
> >  }
> >
> >  #endif /* _LINUX_KERNEL_VTIME_H */
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 5a55d23..166f1d7 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -47,7 +47,7 @@ static void irqtime_account_delta(struct irqtime *irq=
time, u64 delta,
> >   * Called before incrementing preempt_count on {soft,}irq_enter
> >   * and before decrementing preempt_count on {soft,}irq_exit.
> >   */
> > -void irqtime_account_irq(struct task_struct *curr)
> > +void irqtime_account_irq(struct task_struct *curr, bool hardirq)
> >  {
> >         struct irqtime *irqtime =3D this_cpu_ptr(&cpu_irqtime);
> >         s64 delta;
> > @@ -68,7 +68,7 @@ void irqtime_account_irq(struct task_struct *curr)
> >          */
> >         if (hardirq_count())
> >                 irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> > -       else if (in_serving_softirq() && curr !=3D this_cpu_ksoftirqd()=
)
> > +       else if (in_serving_softirq() && curr !=3D this_cpu_ksoftirqd()=
 && !hardirq)
> >                 irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> >  }
>
> In my opinion, we don't need to use the hardirq flag, the code: if
> (hardirq_count())
> already tell us that where the delt time is from.

Considering the scenario in which hardirq happens immediately after
__do_softirq()->local_irq_enable(). The following code shows that
hardirq_count() can not help.
#define __irq_enter() \
do { \
account_irq_enter_time(current); \
preempt_count_add(HARDIRQ_OFFSET); \
lockdep_hardirq_enter(); \
} while (0)

Anything I missed?

Thanks,
Pingfan
