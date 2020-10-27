Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2629C2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821275AbgJ0Rlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:41:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39412 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369991AbgJ0Rjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:39:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so1876006otj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDtB+eghwJOjXqKtOewABuOEz9Qjl3er6dI/sU5rBDU=;
        b=sk89hnO48O7QxDHkVzjVVYl7ZfRw9Hk4eS+Y4lFOgybm5oYaeI4psuDW36oq1PGqXb
         MNcTpVzV1bVo5rBO5eZIF/MvQpo4/jagrFUNRdYiz5mCCbKqGNMHtULJ/b1KJnwy1ttm
         93/qBOzEAY30d3lnFVAnByTKcUuvo02dC659BXc5t2WPTtrRFYzCHq9SB4h25eivsui2
         kHeofTy6mtK0IVWqAD53reHm42o7SUD0DF7HL7TqAVZ//oJrY44hlISjBg6OZWXJnfaK
         EHhmjEwJFEhLCXBJ5n2+HqfwsdEV6pXlCHooyzHpaawowSi24Kvr+WzQCkJAYG2eMNEd
         g1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDtB+eghwJOjXqKtOewABuOEz9Qjl3er6dI/sU5rBDU=;
        b=ckYehpR8xz4C/Ly+Wo1WoapaOxTJ99T0VQsjfwsnDOYs2y2YpiVCgVu7twyw/AOVoK
         rU87KW6AWTytj+HM2iTeAqpBxJDAqIA497P0YC9ZzvRm8IpGmBihO5d28WvqDUQoNQbU
         TzH4wns9viM2uLUtCenWWVRF5aTMU6VKkb3MVY3G/4nsQI+L5aDrAhv0am8qFbDU0yFS
         UvLMm0pOKZYNTYCUy2bPhz9+m/PRIc3fTHH9qxX0inuQ0L48n/Tpmc8ZoxxZCJkCw6Q1
         Em+61o+cg1QffBSv2IfA3HVWjCS3C0bei8wLYf5s7SrPL/nfcsUoLxHW8em8nhO3aOo3
         9nHQ==
X-Gm-Message-State: AOAM532AAwvXgSCeAXuRJTJ5RXeH60UFGMVbhChhBk9vpgFCjQ+vbFbh
        /c2rE+bxVTMI2yFi1NfQQomzI9CIV/lNUIVY8LtMDg==
X-Google-Smtp-Source: ABdhPJyEmgS7AzBizZ+ALnWOp2e/lw3WUf1uVAGW6qILcFa5k95Q7+eMcg3Ki4FopxlACl1FBMeXg9Lpz45pmJRVl0I=
X-Received: by 2002:a9d:70d1:: with SMTP id w17mr2156655otj.219.1603820392233;
 Tue, 27 Oct 2020 10:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201024225716.2854163-1-xii@google.com> <20201024225716.2854163-2-xii@google.com>
 <CAKfTPtDf_PXjk62sctdBAuVPSYg2gVdFtX=UgJn+JEOyog8YSQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDf_PXjk62sctdBAuVPSYg2gVdFtX=UgJn+JEOyog8YSQ@mail.gmail.com>
From:   Xi Wang <xii@google.com>
Date:   Tue, 27 Oct 2020 10:39:57 -0700
Message-ID: <CAOBoifgyM7Zo3jjBtt_s1mHGnmGnmarJEmZch3cnK9+K9QU33A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] sched: watchdog: Touch kernel watchdog with sched count
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 1:32 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sun, 25 Oct 2020 at 00:57, Xi Wang <xii@google.com> wrote:
> >
> > Instead of periodically resetting watchdogs from thread context,
> > this patch simply forces resched and checks rq->sched_count.
> > Watchdog is reset if the sched count increases. If the same thread
> > is picked by pick_next_task during resched, there is no context
> > switch.
> >
> > With the new method we lose coverage on: a migration/n thread
> > actually gets picked and we actually context switch to the
> > migration/n thread. These steps are unlikely to silently fail.
> > The change would provide nearly the same level of protection with
> > less latency / jitter.
>
> When a patch provides an improvement, it's usually good to give
> figures that show the improvement

This change would reduce jitters for a continuously running thread.
The difference is likely too small to tell for sched latency
benchmarks.

will-it-scale mmap1 reported 15.8% improvement for the v1 patch:
https://lkml.org/lkml/2020/3/10/129

The performance change is actually unexpected. If it's not noise there
might be contentions related to watchdog thread wake up or context
switch.

-Xi


>
> >
> > Suggested-by: Paul Turner <pjt@google.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Xi Wang <xii@google.com>
> > ---
> >  include/linux/sched.h |  4 ++++
> >  kernel/sched/core.c   | 23 +++++++++++++++++++--
> >  kernel/sched/sched.h  |  6 +++++-
> >  kernel/watchdog.c     | 47 +++++++++++++------------------------------
> >  4 files changed, 44 insertions(+), 36 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d383cf09e78f..1e3bef9a9cdb 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1662,6 +1662,10 @@ extern int sched_setattr(struct task_struct *, const struct sched_attr *);
> >  extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
> >  extern struct task_struct *idle_task(int cpu);
> >
> > +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> > +extern unsigned int sched_get_count(int cpu);
> > +#endif
> > +
> >  /**
> >   * is_idle_task - is the specified task an idle task?
> >   * @p: the task in question.
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 8160ab5263f8..378f0f36c402 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4293,8 +4293,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >         rcu_sleep_check();
> >
> >         profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > -
> > -       schedstat_inc(this_rq()->sched_count);
> >  }
> >
> >  static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> > @@ -4492,6 +4490,12 @@ static void __sched notrace __schedule(bool preempt)
> >         clear_tsk_need_resched(prev);
> >         clear_preempt_need_resched();
> >
> > +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> > +       this_rq()->sched_count++; /* sched count is also used by watchdog */
> > +#else
> > +       schedstat_inc(this_rq()->sched_count);
> > +#endif
> > +
> >         if (likely(prev != next)) {
> >                 rq->nr_switches++;
> >                 /*
> > @@ -5117,6 +5121,21 @@ struct task_struct *idle_task(int cpu)
> >         return cpu_rq(cpu)->idle;
> >  }
> >
> > +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> > +
> > +/**
> > + * sched_get_count - get the sched count of a CPU.
> > + * @cpu: the CPU in question.
> > + *
> > + * Return: sched count.
> > + */
> > +unsigned int sched_get_count(int cpu)
> > +{
> > +       return cpu_rq(cpu)->sched_count;
> > +}
> > +
> > +#endif
> > +
> >  /**
> >   * find_process_by_pid - find a process with a matching PID value.
> >   * @pid: the pid in question.
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 28709f6b0975..f23255981d52 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -959,6 +959,11 @@ struct rq {
> >         u64                     clock_pelt;
> >         unsigned long           lost_idle_time;
> >
> > +#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_SOFTLOCKUP_DETECTOR)
> > +       /* Also used by watchdog - no longer grouping with other sched stats */
> > +       unsigned int            sched_count;
> > +#endif
> > +
> >         atomic_t                nr_iowait;
> >
> >  #ifdef CONFIG_MEMBARRIER
> > @@ -1036,7 +1041,6 @@ struct rq {
> >         unsigned int            yld_count;
> >
> >         /* schedule() stats */
> > -       unsigned int            sched_count;
> >         unsigned int            sched_goidle;
> >
> >         /* try_to_wake_up() stats */
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 5abb5b22ad13..22f87aded95a 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -170,6 +170,7 @@ static bool softlockup_initialized __read_mostly;
> >  static u64 __read_mostly sample_period;
> >
> >  static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
> > +static DEFINE_PER_CPU(unsigned int, watchdog_sched_prev);
> >  static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
> >  static DEFINE_PER_CPU(bool, softlockup_touch_sync);
> >  static DEFINE_PER_CPU(bool, soft_watchdog_warn);
> > @@ -239,6 +240,7 @@ static void set_sample_period(void)
> >  static void __touch_watchdog(void)
> >  {
> >         __this_cpu_write(watchdog_touch_ts, get_timestamp());
> > +       __this_cpu_write(watchdog_sched_prev, sched_get_count(smp_processor_id()));
> >  }
> >
> >  /**
> > @@ -318,25 +320,6 @@ static void watchdog_interrupt_count(void)
> >         __this_cpu_inc(hrtimer_interrupts);
> >  }
> >
> > -static DEFINE_PER_CPU(struct completion, softlockup_completion);
> > -static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
> > -
> > -/*
> > - * The watchdog thread function - touches the timestamp.
> > - *
> > - * It only runs once every sample_period seconds (4 seconds by
> > - * default) to reset the softlockup timestamp. If this gets delayed
> > - * for more than 2*watchdog_thresh seconds then the debug-printout
> > - * triggers in watchdog_timer_fn().
> > - */
> > -static int softlockup_fn(void *data)
> > -{
> > -       __touch_watchdog();
> > -       complete(this_cpu_ptr(&softlockup_completion));
> > -
> > -       return 0;
> > -}
> > -
> >  /* watchdog kicker functions */
> >  static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  {
> > @@ -351,15 +334,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >         /* kick the hardlockup detector */
> >         watchdog_interrupt_count();
> >
> > -       /* kick the softlockup detector */
> > -       if (completion_done(this_cpu_ptr(&softlockup_completion))) {
> > -               reinit_completion(this_cpu_ptr(&softlockup_completion));
> > -               stop_one_cpu_nowait(smp_processor_id(),
> > -                               softlockup_fn, NULL,
> > -                               this_cpu_ptr(&softlockup_stop_work));
> > -       }
> > -
> > -       /* .. and repeat */
> >         hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
> >
> >         if (touch_ts == SOFTLOCKUP_RESET) {
> > @@ -378,6 +352,18 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >                 return HRTIMER_RESTART;
> >         }
> >
> > +       /* Trigger reschedule for the next round */
> > +       set_tsk_need_resched(current);
> > +       set_preempt_need_resched();
> > +
> > +       /* sched_count increase in __schedule is taken as watchdog touched */
> > +       if (sched_get_count(smp_processor_id()) -
> > +           __this_cpu_read(watchdog_sched_prev)) {
> > +               __touch_watchdog();
> > +               __this_cpu_write(soft_watchdog_warn, false);
> > +               return HRTIMER_RESTART;
> > +       }
> > +
> >         /* check for a softlockup
> >          * This is done by making sure a high priority task is
> >          * being scheduled.  The task touches the watchdog to
> > @@ -443,13 +429,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  static void watchdog_enable(unsigned int cpu)
> >  {
> >         struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
> > -       struct completion *done = this_cpu_ptr(&softlockup_completion);
> >
> >         WARN_ON_ONCE(cpu != smp_processor_id());
> >
> > -       init_completion(done);
> > -       complete(done);
> > -
> >         /*
> >          * Start the timer first to prevent the NMI watchdog triggering
> >          * before the timer has a chance to fire.
> > @@ -479,7 +461,6 @@ static void watchdog_disable(unsigned int cpu)
> >          */
> >         watchdog_nmi_disable(cpu);
> >         hrtimer_cancel(hrtimer);
> > -       wait_for_completion(this_cpu_ptr(&softlockup_completion));
> >  }
> >
> >  static int softlockup_stop_fn(void *data)
> > --
> > 2.29.0.rc2.309.g374f81d7ae-goog
> >
