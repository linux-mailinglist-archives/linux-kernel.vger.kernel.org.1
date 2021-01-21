Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9182FE49C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbhAUIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:06:18 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36410 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbhAUIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:01:34 -0500
Received: by mail-lf1-f43.google.com with SMTP id o13so1280710lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oa6H4n/eycwtJnbwl9l/fjfVcB2EBahp7fc3hP9Piks=;
        b=odDD21vUy8HZknQkOSv6x15GuEJzsH55SsTkJL5j9Q4J4j9orpxUhBoMB+2J5jx/fz
         FPEPzRaWqOyK1MdAy4SK8uWbd1kFH8NZjIoO3VpPtnLsYMHs7bUaxEngKbIfWuemsnE3
         R7HU5+sCd6EMHUhwS2GLAB8uKSs/Jh78Pd2ehf07E9OebGN0RwGRVUO+kOpRGrCCr/Ou
         Q8W5/G30U/hgyaKe/wVTgpm1gJhK5ima3B1BdKle759qAQ7ym6WLIa7d0lTN8cW9xdtz
         /mK3HujVL34eiBwgwmmkiQBWzn/lUb4MfT74gdtEaAoXYadZNGooS2OGSHSjzEqA1y2U
         yv8g==
X-Gm-Message-State: AOAM531S9sCp8QN89Hf2sAn9lRkTsgY7+VlAh68s/7zszwPXAglbDWQu
        aS86LlqBNEJ9stwO12Sg8uF4YO7t5MCOq1yHzT8=
X-Google-Smtp-Source: ABdhPJxfdjR57AoIBbltaPd6MmLJTVsbiv387VKWVwAS4Gh+L875oWP+aihas2KBQhZlnDe2jRW6wtO5pEFk46w+Bf0=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr5785870lfu.112.1611216030264;
 Thu, 21 Jan 2021 00:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20210114085004.26606-1-namhyung@kernel.org>
In-Reply-To: <20210114085004.26606-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Jan 2021 17:00:18 +0900
Message-ID: <CAM9d7cgbQ6vQTu76NqZdE33-+LuMMJw4YdoSy5uOv49hm0Rrog@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Can you please take a look at this again?

Thanks,
Namhyung

On Thu, Jan 14, 2021 at 5:50 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> This patch adds a new software event to count context switches
> involving cgroup switches.  So it's counted only if cgroups of
> previous and next tasks are different.  Note that it only checks the
> cgroups in the perf_event subsystem.  For cgroup v2, it shouldn't
> matter anyway.
>
> One can argue that we can do this by using existing sched_switch event
> with eBPF.  But some systems might not have eBPF for some reason so
> I'd like to add this as a simple way.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/perf_event.h      | 38 +++++++++++++++------------------
>  include/uapi/linux/perf_event.h |  1 +
>  2 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 9a38f579bc76..304ef42d42d1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1174,30 +1174,24 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
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
>  {
> -       if (perf_sw_migrate_enabled())
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS))
>                 task->sched_migrated = 1;
>  }
>
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
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b15e3447cd9f..16b9538ad89b 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -112,6 +112,7 @@ enum perf_sw_ids {
>         PERF_COUNT_SW_EMULATION_FAULTS          = 8,
>         PERF_COUNT_SW_DUMMY                     = 9,
>         PERF_COUNT_SW_BPF_OUTPUT                = 10,
> +       PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
>
>         PERF_COUNT_SW_MAX,                      /* non-ABI */
>  };
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
