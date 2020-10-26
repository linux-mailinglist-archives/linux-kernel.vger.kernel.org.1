Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D0298856
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771775AbgJZIcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:32:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47098 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771767AbgJZIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:32:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id c21so8809595ljn.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxOQTRFoUnIXjv41Nm9Lj/oPqYXmvrurKIw6PMm2Cl4=;
        b=wjRra/zqebpE7vi4fidQCHKHP7qpkadSr324yXAaiYmtSk6AiWrqcdxlXsluoUCjbU
         4VMkbQJX8FKkzho+GyemsjXf/78S1AgMef6cU7MQCItzjamZBsihSLVJ9FaqO+HgaHqz
         XW3EjyX+0zpf7SzxB5qIVxn0tHp5YRF48YJpojobD2c8A+5+Iu5Usa4mhDUAhWpLOAEL
         ug139ZUNM5TevPklAKX87zGe088ZsjYZHb+Kir+dstMSmcKhBdutBcwUpnqAOR2g/AiJ
         8BNnrkXsL77B/Atz+m8wpLjPJs6l5xhoMvgsmUnzgMR2XVb5sZGXPwEpHa47ZlgVgbxa
         AU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxOQTRFoUnIXjv41Nm9Lj/oPqYXmvrurKIw6PMm2Cl4=;
        b=su8ZoQPF0oR7Trxd79GhUcCjjM7nCNWwxVFlXFcmF4Tvm9KR6YFXTFIUI0MsdQHTfA
         JaO+ra++fa5b76VZII3G5wnb76AaDpm1Dxxfo5WIuQvQHJxCYvUjjiDwIoE0cVZrHWVG
         sxsz8IdSHCwiHeXk68fM1NGehQddbJ7UulDdAjNqwYO73KHBdoIaqlpYdEQss9R6Vqz9
         Wqe0yglZFW38IhO/L23WRQQqB0KBCHGXGuH6/Bym43HjkwAp2xHgSpw2Hzs5MtBESFdF
         qfdMQJm2E82Jk8Onjrg6VMu0QTmp/u2jcq832J2EQiN5XaDYx7aHZXiSnu+XNblPBTGV
         qu1w==
X-Gm-Message-State: AOAM532A7S/n4lIG5n/LrOnzxJhBo/WXomq3GiBNnu9h3JrrQcMYbq+E
        i1+Qupxr8PqmmDAf6S48Va9nwdbEBNjuqFdUWe9qRQ==
X-Google-Smtp-Source: ABdhPJyjnxRUcH0uN4o/Hj0rz8UTOudr1uW5cARvi0ws5xluCQCyl86oClkCYCadfZRiILySXoAz+pdT/yFuo+CUXxg=
X-Received: by 2002:a2e:8787:: with SMTP id n7mr5710036lji.111.1603701133815;
 Mon, 26 Oct 2020 01:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201024225716.2854163-1-xii@google.com> <20201024225716.2854163-2-xii@google.com>
In-Reply-To: <20201024225716.2854163-2-xii@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Oct 2020 09:32:02 +0100
Message-ID: <CAKfTPtDf_PXjk62sctdBAuVPSYg2gVdFtX=UgJn+JEOyog8YSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] sched: watchdog: Touch kernel watchdog with sched count
To:     Xi Wang <xii@google.com>
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

On Sun, 25 Oct 2020 at 00:57, Xi Wang <xii@google.com> wrote:
>
> Instead of periodically resetting watchdogs from thread context,
> this patch simply forces resched and checks rq->sched_count.
> Watchdog is reset if the sched count increases. If the same thread
> is picked by pick_next_task during resched, there is no context
> switch.
>
> With the new method we lose coverage on: a migration/n thread
> actually gets picked and we actually context switch to the
> migration/n thread. These steps are unlikely to silently fail.
> The change would provide nearly the same level of protection with
> less latency / jitter.

When a patch provides an improvement, it's usually good to give
figures that show the improvement

>
> Suggested-by: Paul Turner <pjt@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Xi Wang <xii@google.com>
> ---
>  include/linux/sched.h |  4 ++++
>  kernel/sched/core.c   | 23 +++++++++++++++++++--
>  kernel/sched/sched.h  |  6 +++++-
>  kernel/watchdog.c     | 47 +++++++++++++------------------------------
>  4 files changed, 44 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d383cf09e78f..1e3bef9a9cdb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1662,6 +1662,10 @@ extern int sched_setattr(struct task_struct *, const struct sched_attr *);
>  extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
>  extern struct task_struct *idle_task(int cpu);
>
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +extern unsigned int sched_get_count(int cpu);
> +#endif
> +
>  /**
>   * is_idle_task - is the specified task an idle task?
>   * @p: the task in question.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8160ab5263f8..378f0f36c402 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4293,8 +4293,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>         rcu_sleep_check();
>
>         profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> -
> -       schedstat_inc(this_rq()->sched_count);
>  }
>
>  static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
> @@ -4492,6 +4490,12 @@ static void __sched notrace __schedule(bool preempt)
>         clear_tsk_need_resched(prev);
>         clear_preempt_need_resched();
>
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +       this_rq()->sched_count++; /* sched count is also used by watchdog */
> +#else
> +       schedstat_inc(this_rq()->sched_count);
> +#endif
> +
>         if (likely(prev != next)) {
>                 rq->nr_switches++;
>                 /*
> @@ -5117,6 +5121,21 @@ struct task_struct *idle_task(int cpu)
>         return cpu_rq(cpu)->idle;
>  }
>
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +
> +/**
> + * sched_get_count - get the sched count of a CPU.
> + * @cpu: the CPU in question.
> + *
> + * Return: sched count.
> + */
> +unsigned int sched_get_count(int cpu)
> +{
> +       return cpu_rq(cpu)->sched_count;
> +}
> +
> +#endif
> +
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6b0975..f23255981d52 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -959,6 +959,11 @@ struct rq {
>         u64                     clock_pelt;
>         unsigned long           lost_idle_time;
>
> +#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_SOFTLOCKUP_DETECTOR)
> +       /* Also used by watchdog - no longer grouping with other sched stats */
> +       unsigned int            sched_count;
> +#endif
> +
>         atomic_t                nr_iowait;
>
>  #ifdef CONFIG_MEMBARRIER
> @@ -1036,7 +1041,6 @@ struct rq {
>         unsigned int            yld_count;
>
>         /* schedule() stats */
> -       unsigned int            sched_count;
>         unsigned int            sched_goidle;
>
>         /* try_to_wake_up() stats */
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 5abb5b22ad13..22f87aded95a 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -170,6 +170,7 @@ static bool softlockup_initialized __read_mostly;
>  static u64 __read_mostly sample_period;
>
>  static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
> +static DEFINE_PER_CPU(unsigned int, watchdog_sched_prev);
>  static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
>  static DEFINE_PER_CPU(bool, softlockup_touch_sync);
>  static DEFINE_PER_CPU(bool, soft_watchdog_warn);
> @@ -239,6 +240,7 @@ static void set_sample_period(void)
>  static void __touch_watchdog(void)
>  {
>         __this_cpu_write(watchdog_touch_ts, get_timestamp());
> +       __this_cpu_write(watchdog_sched_prev, sched_get_count(smp_processor_id()));
>  }
>
>  /**
> @@ -318,25 +320,6 @@ static void watchdog_interrupt_count(void)
>         __this_cpu_inc(hrtimer_interrupts);
>  }
>
> -static DEFINE_PER_CPU(struct completion, softlockup_completion);
> -static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
> -
> -/*
> - * The watchdog thread function - touches the timestamp.
> - *
> - * It only runs once every sample_period seconds (4 seconds by
> - * default) to reset the softlockup timestamp. If this gets delayed
> - * for more than 2*watchdog_thresh seconds then the debug-printout
> - * triggers in watchdog_timer_fn().
> - */
> -static int softlockup_fn(void *data)
> -{
> -       __touch_watchdog();
> -       complete(this_cpu_ptr(&softlockup_completion));
> -
> -       return 0;
> -}
> -
>  /* watchdog kicker functions */
>  static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  {
> @@ -351,15 +334,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>         /* kick the hardlockup detector */
>         watchdog_interrupt_count();
>
> -       /* kick the softlockup detector */
> -       if (completion_done(this_cpu_ptr(&softlockup_completion))) {
> -               reinit_completion(this_cpu_ptr(&softlockup_completion));
> -               stop_one_cpu_nowait(smp_processor_id(),
> -                               softlockup_fn, NULL,
> -                               this_cpu_ptr(&softlockup_stop_work));
> -       }
> -
> -       /* .. and repeat */
>         hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
>
>         if (touch_ts == SOFTLOCKUP_RESET) {
> @@ -378,6 +352,18 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>                 return HRTIMER_RESTART;
>         }
>
> +       /* Trigger reschedule for the next round */
> +       set_tsk_need_resched(current);
> +       set_preempt_need_resched();
> +
> +       /* sched_count increase in __schedule is taken as watchdog touched */
> +       if (sched_get_count(smp_processor_id()) -
> +           __this_cpu_read(watchdog_sched_prev)) {
> +               __touch_watchdog();
> +               __this_cpu_write(soft_watchdog_warn, false);
> +               return HRTIMER_RESTART;
> +       }
> +
>         /* check for a softlockup
>          * This is done by making sure a high priority task is
>          * being scheduled.  The task touches the watchdog to
> @@ -443,13 +429,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  static void watchdog_enable(unsigned int cpu)
>  {
>         struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
> -       struct completion *done = this_cpu_ptr(&softlockup_completion);
>
>         WARN_ON_ONCE(cpu != smp_processor_id());
>
> -       init_completion(done);
> -       complete(done);
> -
>         /*
>          * Start the timer first to prevent the NMI watchdog triggering
>          * before the timer has a chance to fire.
> @@ -479,7 +461,6 @@ static void watchdog_disable(unsigned int cpu)
>          */
>         watchdog_nmi_disable(cpu);
>         hrtimer_cancel(hrtimer);
> -       wait_for_completion(this_cpu_ptr(&softlockup_completion));
>  }
>
>  static int softlockup_stop_fn(void *data)
> --
> 2.29.0.rc2.309.g374f81d7ae-goog
>
