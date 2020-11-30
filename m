Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA012C8250
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgK3KgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3KgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:36:08 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D0CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:35:28 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id q13so19927777lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1efkswn4cUycQKBASwkUtMVwPaZz3RLBqwkA/yVPN2Y=;
        b=EjYOkUfDu7eW0Hd51AwmPtk74cTG0Ks5QPrXW6VSvqKwZGGbs8I80+8IfhoqxNOL3z
         RMAa25jUYC3mFzUkCq6m4KbVPvMyN63z70cVkEIxPunkyTeMA8vMxgPtb4J+INJf9+pE
         wx736R1hYMc+g2UumGJnFxPeCUQU7U3/+g/FNY4mRGQO3/F7GcAc0IBs43gsyU9X2GMd
         wU6ELTYYyULMmTrCc6+qyI7CM+4yXJJ+sfxysvEAG/Ch3uBS9WQOpRXb98iu+QjIz6yd
         4E8Qj0+Ty5m1ePO9Akp1J3acjuDaWOMKUmzgM01xeIN9eKjkcjLNnBxNVd8XtaxieG0o
         wR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1efkswn4cUycQKBASwkUtMVwPaZz3RLBqwkA/yVPN2Y=;
        b=k4nTSUrpIOE1TA5Wg1XP+jLYlz66pFrgPHzmMoDYJzdSeqDqQP0ozbNq3gyfn8V98+
         DcdnOVJGICxZqyl1BGhI/ZdELB42cCFOG2Ug6Lft8WxstHdtjW4eDT60KUf+RMdmHI7F
         GEIn98oJjkeyS0m7rNfMRDqWyFCcFc6BL306u8KQ4UJo3YshsCtV16pjOin0SaFmeqvZ
         jN6x/ul6KbdjkomoDPO/tck5ZFfvQ9iOrKXuQR4tNeOEwcEOqCrlSqbf+jF+zvOE+vOe
         ITpSMUhxCWgk2uaQ/itautVKI5DUOdrx0j55AbssXZMZLmuZniEiV8RXyvl7TKcDLucY
         uEPw==
X-Gm-Message-State: AOAM532CQIUhjLkn4axyGpXLC5fkSyVspYSWi+KzTCqry498NFXk7p/q
        MqiuI8EzYn620RlCGtshlo8Yy93Gnx52uG5T47du/A==
X-Google-Smtp-Source: ABdhPJy/cDd7cSD+3NnLHGJtfwf72cutGWqAHZMYaXiKl6y4iCLcHSfnIFbnpKyq8BQTm+Glxw/0BT1fbSCt8a6lnKw=
X-Received: by 2002:a19:8347:: with SMTP id f68mr9106032lfd.83.1606732526677;
 Mon, 30 Nov 2020 02:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org> <20201117232003.3580179-15-joel@joelfernandes.org>
In-Reply-To: <20201117232003.3580179-15-joel@joelfernandes.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Nov 2020 11:35:15 +0100
Message-ID: <CAKfTPtC1VvON-Q6RrEXUkkURbY14b=nEAzGdXwCbWdqNiOz5yg@mail.gmail.com>
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 00:20, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: Aubrey Li <aubrey.li@intel.com>
>
>  - Don't migrate if there is a cookie mismatch
>      Load balance tries to move task from busiest CPU to the
>      destination CPU. When core scheduling is enabled, if the
>      task's cookie does not match with the destination CPU's
>      core cookie, this task will be skipped by this CPU. This
>      mitigates the forced idle time on the destination CPU.
>
>  - Select cookie matched idle CPU
>      In the fast path of task wakeup, select the first cookie matched
>      idle CPU instead of the first idle CPU.
>
>  - Find cookie matched idlest CPU
>      In the slow path of task wakeup, find the idlest CPU whose core
>      cookie matches with task's cookie
>
>  - Don't migrate task if cookie not match
>      For the NUMA load balance, don't migrate task to the CPU whose
>      core cookie does not match with task's cookie
>
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h | 29 ++++++++++++++++++++
>  2 files changed, 88 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index de82f88ba98c..ceb3906c9a8a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1921,6 +1921,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>                 if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>                         continue;
>
> +#ifdef CONFIG_SCHED_CORE
> +               /*
> +                * Skip this cpu if source task's cookie does not match
> +                * with CPU's core cookie.
> +                */
> +               if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> +                       continue;
> +#endif
> +
>                 env->dst_cpu = cpu;
>                 if (task_numa_compare(env, taskimp, groupimp, maymove))
>                         break;
> @@ -5867,11 +5876,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>
>         /* Traverse only the allowed CPUs */
>         for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> +               struct rq *rq = cpu_rq(i);
> +
> +#ifdef CONFIG_SCHED_CORE
> +               if (!sched_core_cookie_match(rq, p))
> +                       continue;
> +#endif
> +
>                 if (sched_idle_cpu(i))
>                         return i;
>
>                 if (available_idle_cpu(i)) {
> -                       struct rq *rq = cpu_rq(i);
>                         struct cpuidle_state *idle = idle_get_state(rq);
>                         if (idle && idle->exit_latency < min_exit_latency) {
>                                 /*
> @@ -6129,8 +6144,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
>                         return -1;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       break;
> +
> +               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
> +#ifdef CONFIG_SCHED_CORE
> +                       /*
> +                        * If Core Scheduling is enabled, select this cpu
> +                        * only if the process cookie matches core cookie.
> +                        */
> +                       if (sched_core_enabled(cpu_rq(cpu)) &&
> +                           p->core_cookie == cpu_rq(cpu)->core->core_cookie)
> +#endif
> +                               break;
> +               }

This makes code unreadable.
Put this coresched specific stuff in an inline function; You can have
a look at what is done with asym_fits_capacity()

>         }
>
>         time = cpu_clock(this) - time;
> @@ -7530,8 +7555,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>          * We do not migrate tasks that are:
>          * 1) throttled_lb_pair, or
>          * 2) cannot be migrated to this CPU due to cpus_ptr, or
> -        * 3) running (obviously), or
> -        * 4) are cache-hot on their current CPU.
> +        * 3) task's cookie does not match with this CPU's core cookie
> +        * 4) running (obviously), or
> +        * 5) are cache-hot on their current CPU.
>          */
>         if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>                 return 0;
> @@ -7566,6 +7592,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>                 return 0;
>         }
>
> +#ifdef CONFIG_SCHED_CORE
> +       /*
> +        * Don't migrate task if the task's cookie does not match
> +        * with the destination CPU's core cookie.
> +        */
> +       if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> +               return 0;
> +#endif
> +
>         /* Record that we found atleast one task that could run on dst_cpu */
>         env->flags &= ~LBF_ALL_PINNED;
>
> @@ -8792,6 +8827,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                                         p->cpus_ptr))
>                         continue;
>
> +#ifdef CONFIG_SCHED_CORE
> +               if (sched_core_enabled(cpu_rq(this_cpu))) {
> +                       int i = 0;
> +                       bool cookie_match = false;
> +
> +                       for_each_cpu(i, sched_group_span(group)) {
> +                               struct rq *rq = cpu_rq(i);
> +
> +                               if (sched_core_cookie_match(rq, p)) {
> +                                       cookie_match = true;
> +                                       break;
> +                               }
> +                       }
> +                       /* Skip over this group if no cookie matched */
> +                       if (!cookie_match)
> +                               continue;
> +               }
> +#endif

same here, encapsulate this to keep find_idlest_group readable

> +
>                 local_group = cpumask_test_cpu(this_cpu,
>                                                sched_group_span(group));
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e72942a9ee11..de553d39aa40 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1135,6 +1135,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>
>  bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
>
> +/*
> + * Helper to check if the CPU's core cookie matches with the task's cookie
> + * when core scheduling is enabled.
> + * A special case is that the task's cookie always matches with CPU's core
> + * cookie if the CPU is in an idle core.
> + */
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +       bool idle_core = true;
> +       int cpu;
> +
> +       /* Ignore cookie match if core scheduler is not enabled on the CPU. */
> +       if (!sched_core_enabled(rq))
> +               return true;
> +
> +       for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> +               if (!available_idle_cpu(cpu)) {
> +                       idle_core = false;
> +                       break;
> +               }
> +       }
> +
> +       /*
> +        * A CPU in an idle core is always the best choice for tasks with
> +        * cookies.
> +        */
> +       return idle_core || rq->core->core_cookie == p->core_cookie;
> +}
> +
>  extern void queue_core_balance(struct rq *rq);
>
>  #else /* !CONFIG_SCHED_CORE */
> --
> 2.29.2.299.gdc1121823c-goog
>
