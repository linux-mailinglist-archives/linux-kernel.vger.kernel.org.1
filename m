Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908A72CCC4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgLCCLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:11:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35950 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgLCCLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:11:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id v14so454352lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 18:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CODcqWU9dJfympMWTdQNPabcVNI+FJqAgdc2bmt5Tvw=;
        b=TFDNVj+kAvjOQR3hqqAKwisSqi3bGJXbiuJXdAUKKXqvOCQaQjhFqBkHHNcSH+2nkl
         ST5ZbY0+ZJSEcAVYm8pvlnkR4EmsPXEuPeBk/RydRcVXIRUcSPrkMUKtYJlWMsc3sLB6
         ZGc0TUnpnEBjEPeLtMIlb5BV2Ets+usl62DmrRnMVHyg7eveb0ajcPn5GLbHrC7H1+lr
         AsM9mW5quBlbNwHxVSNGdSFGOI8OS5uB07WE5NVrO0KfX52ommXUr4Rr7Ipl/K/I9Xi1
         oNmNhDvfTgZx4rp+GVdOnp9T2TYO8PQvsGeK/0uOxPe5rSEhudwAJwjpD0CXwQZhX7Z8
         P8SA==
X-Gm-Message-State: AOAM532lDF28Jpw0PvrH5/Jf41sUSO9xSD5wk0f7lVRbi/53uHwxcYn3
        Da6oIutZ5H9YJ8yqQFgPFcYlhYUnr/yYti7UEzE=
X-Google-Smtp-Source: ABdhPJzPRSxTTqB+2U7FqTeT4eZS6v07ZYbhfU9w8S8pHbqKTbUppt4nmXMP3AL/EAHWXooROHDSDYr44fKI+HBGDHM=
X-Received: by 2002:a19:38e:: with SMTP id 136mr367231lfd.593.1606961442392;
 Wed, 02 Dec 2020 18:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202161934.GL3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201202161934.GL3021@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Dec 2020 11:10:30 +0900
Message-ID: <CAM9d7cjMsofCLNbBWisd6d03q6Ucx2FG9xxV2mALp+gykDkAyg@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:

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

It'd be nice to avoid the __ prefix if possible.


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

Ditto.


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

It seems task->sched_migrate is set only if the event is enabled,
then can we just check the value here?


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

I was not clear about the RCU protection here.  Is it ok to access
the task's css_set directly?

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
