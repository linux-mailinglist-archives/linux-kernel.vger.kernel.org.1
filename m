Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018AA2CCB66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgLCBGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:06:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36872 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgLCBGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:06:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id s30so270580lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c91sM3Z5f8KJIA116v/c00f4+lFeX2slAZ6rw/YW0/U=;
        b=kdKz/lGW14uGm+gkapsti527mRb2lfi4JgYadwE9UxR5jiIGBCoL9QZCWo1qknRMoJ
         BGKWD/r4fAkyISKWQDmFT7r7toJ63nfcYZMoKvg4MrbdpYPwGi2KFtOmtGFVC6YvX7JX
         VEerUAdRJstSoW/HEMRDGBi2qEduGqR6cv6JL2x/PBPpJhpJniUQ9rGvi2jF/Jm1NQKc
         5i3x8QXRR7m4lQh3jw8FmoAsiD8auHokUICr7e4ZPLYSOPsaCHk4FdsgKDXx95SBavDE
         k37f+Bu1tqmbBHJ44H+T036VZajTSrOp2vOaImB5OLJSV6uTQFBJ/yELW/Bl4tNE3Hfw
         o5JQ==
X-Gm-Message-State: AOAM5337LoGBP4urwNMxZCVOr5/4dW5Mdchsu8qWOTr6k7e88Kg6a6xL
        +iasqkvSnknsYuoVvtVzosIu2AU6UG9ABdV6YaY=
X-Google-Smtp-Source: ABdhPJyy2Ggdw2zz89U9uGOA/5AYDQiMoKUYdY1YHAPG9pueI8sjH2tUE3/dRn3EqpRHi6+948bgofYe9xPfA5LiPS0=
X-Received: by 2002:a19:38e:: with SMTP id 136mr289889lfd.593.1606957555162;
 Wed, 02 Dec 2020 17:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202161934.GL3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201202161934.GL3021@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Dec 2020 10:05:44 +0900
Message-ID: <CAM9d7cgmgmjmkUOOSDYaV3WG1GPzCzxbPG88qOXYXri1HNYW_g@mail.gmail.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Dec 3, 2020 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 03, 2020 at 12:02:04AM +0900, Namhyung Kim wrote:
>
> > +#ifdef CONFIG_CGROUP_PERF
> > +static inline void
> > +perf_sw_event_cgroup_switch(struct task_struct *prev, struct task_struct *next)
> > +{
> > +     struct cgroup *prev_cgrp, *next_cgrp;
> > +
> > +     rcu_read_lock();
> > +
> > +     prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > +     next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > +
> > +     if (prev_cgrp != next_cgrp)
> > +             perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> > +
> > +     rcu_read_unlock();
> > +}
> > +#else
> > +static inline void perf_sw_event_cgroup_switch(struct task_struct *prev,
> > +                                            struct task_struct *next) {}
> > +#endif  /* CONFIG_CGROUP_PERF */
> > +
> >  extern struct static_key_false perf_sched_events;
> >
> >  static __always_inline bool
> > @@ -1220,6 +1241,7 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
> >                                            struct task_struct *next)
> >  {
> >       perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> > +     perf_sw_event_cgroup_switch(prev, next);
> >
> >       if (static_branch_unlikely(&perf_sched_events))
> >               __perf_event_task_sched_out(prev, next);
>
> Urgh.. that's horrible, try something like this.
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 9a38f579bc76..5eb284819ee5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1174,25 +1174,19 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
>   * which is guaranteed by us not actually scheduling inside other swevents
>   * because those disable preemption.
>   */
> -static __always_inline void
> -perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
> +static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
>  {
> -       if (static_key_false(&perf_swevent_enabled[event_id])) {
> -               struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
> +       struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
>
> -               perf_fetch_caller_regs(regs);
> -               ___perf_sw_event(event_id, nr, regs, addr);
> -       }
> +       perf_fetch_caller_regs(regs);
> +       ___perf_sw_event(event_id, nr, regs, addr);
>  }
>
>  extern struct static_key_false perf_sched_events;
>
> -static __always_inline bool
> -perf_sw_migrate_enabled(void)
> +static __always_inline bool __perf_sw_enabled(int swevt)
>  {
> -       if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
> -               return true;
> -       return false;
> +       return static_key_false(&perf_swevent_enabled[swevt]);
>  }
>
>  static inline void perf_event_task_migrate(struct task_struct *task)
> @@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
>         if (static_branch_unlikely(&perf_sched_events))
>                 __perf_event_task_sched_in(prev, task);
>
> -       if (perf_sw_migrate_enabled() && task->sched_migrated) {
> -               struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
> -
> -               perf_fetch_caller_regs(regs);
> -               ___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
> +           task->sched_migrated) {
> +               __perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
>                 task->sched_migrated = 0;
>         }
>  }
> @@ -1219,7 +1211,13 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
>  static inline void perf_event_task_sched_out(struct task_struct *prev,
>                                              struct task_struct *next)
>  {
> -       perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
> +               __perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> +
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
> +           (task_css_check(prev, perf_event_cgrp_id, 1)->cgroup !=
> +            task_css_check(next, perf_event_cgrp_id, 1)->cgroup))
> +               __perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);

Right, it needs to check only when the event is enabled.

Thanks,
Namhyung


>
>         if (static_branch_unlikely(&perf_sched_events))
>                 __perf_event_task_sched_out(prev, next);
> @@ -1475,8 +1473,6 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
>  static inline void
>  perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)    { }
>  static inline void
> -perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)                    { }
> -static inline void
>  perf_bp_event(struct perf_event *event, void *data)                    { }
>
>  static inline int perf_register_guest_info_callbacks
