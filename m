Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216672A82B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgKEPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:54:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51828 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbgKEPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:54:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id v5so2082743wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCSoxE2mm7Ta4F0NDen4TpE7+839AyotSprVLgHnOpA=;
        b=J7vjeIsVYdsdKuzdSs3m22rvo+jAO34oywiBeBGmUjntwngTNUhtypY44ANAXd3VO/
         YdVW4aENe/ma5Q5KCqeaM4VvSZhHe4a85ovWqb96pgvoTKZKDQoPFnGgEtpvOxAizIgm
         +QlSMJQ2okFGbxplDErYDfdbCBH6deTS9FH8CWbDUoEdbCY5Qw9hD+Yx7La60XV1KWRk
         U0XgQc4ROQm0wOGJejqkK2zBEkFhfdCHu70CE3gcbbFlJlZsxOrDfYa0qT/6xd6KxBcN
         9UPf/kSqCx36ux1WW+aPd0cw6GeaLM4h6CFguuRnJwbrZtHg6VqK1QGIC49tfr5grDkX
         JQYQ==
X-Gm-Message-State: AOAM531k6HUyuR+s7IgxsIGJ0N4J3RI/II/os1oaBUiDWlUE9eJ057GK
        gmowCTRlbmPzGaRHf6NQyNBrHRp9uYLZ0//BF8w=
X-Google-Smtp-Source: ABdhPJy2WHksbPfpnv4mms68mbTm//rc9TRlKqTCCefUPvwvm7NIqtTup8vjSiunQOUbQo2Y5RR8CC/ItB1nuA31C5k=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr3454178wmj.146.1604591664643;
 Thu, 05 Nov 2020 07:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20201102145221.309001-1-namhyung@kernel.org> <20201102145221.309001-3-namhyung@kernel.org>
 <03ba0d07-45bb-0849-1843-915b6873478f@linux.intel.com>
In-Reply-To: <03ba0d07-45bb-0849-1843-915b6873478f@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Nov 2020 00:54:13 +0900
Message-ID: <CAM9d7cgwmXmyUd4Y==F120BsAx2iWw6h9D+BB6D_FDw1-7SxBw@mail.gmail.com>
Subject: Re: [RFC 2/2] perf/core: Invoke pmu::sched_task callback for per-cpu events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:48 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/2/2020 9:52 AM, Namhyung Kim wrote:
> > The commit 44fae179ce73 ("perf/core: Pull pmu::sched_task() into
> > perf_event_context_sched_out()") moved the pmu::sched_task callback to
> > be called for task event context.  But it missed to call it for
> > per-cpu events to flush PMU internal buffers (i.e. for PEBS, ...).
> >
> > This commit basically reverts the commit but keeps the optimization
> > for task events and only add missing calls for cpu events.
> >
> > Fixes: 44fae179ce73 ("perf/core: Pull pmu::sched_task() into perf_event_context_sched_out()")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
[SNIP]
> > @@ -3850,6 +3880,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
> >
> >       if (atomic_read(&nr_switch_events))
> >               perf_event_switch(task, prev, true);
> > +
> > +     if (__this_cpu_read(perf_sched_cb_usages))
> > +             perf_pmu_sched_task(prev, task, true);
> >   }
>
> It looks like the ("perf/core: Pull pmu::sched_task() into
> perf_event_context_sched_in()") is also reverted in the patch.

Ah, right..

>
> >
> >   static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
> > @@ -12999,6 +13032,7 @@ static void __init perf_event_init_all_cpus(void)
> >   #ifdef CONFIG_CGROUP_PERF
> >               INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
> >   #endif
> > +             INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
> >       }
> >   }
> >
> >
>
> Can we only update the perf_sched_cb_usages and sched_cb_list for
> per-cpu event as below patch (not tested)?
>
> If user only uses the per-process event, we don't need to go through the
> list.

Hmm... ok.

>
>
> diff --git a/arch/powerpc/perf/core-book3s.c
> b/arch/powerpc/perf/core-book3s.c
> index 6586f7e71cfb..63c9b87cab5e 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -380,7 +380,7 @@ static void power_pmu_bhrb_enable(struct perf_event
> *event)
>                 cpuhw->bhrb_context = event->ctx;
>         }
>         cpuhw->bhrb_users++;
> -       perf_sched_cb_inc(event->ctx->pmu);
> +       perf_sched_cb_inc(event->ctx->pmu, !(event->attach_state &
> PERF_ATTACH_TASK));
>   }
>
>   static void power_pmu_bhrb_disable(struct perf_event *event)
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 444e5f061d04..a34b90c7fa6d 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1022,9 +1022,9 @@ pebs_update_state(bool needed_cb, struct
> cpu_hw_events *cpuc,
>
>         if (needed_cb != pebs_needs_sched_cb(cpuc)) {
>                 if (!needed_cb)
> -                       perf_sched_cb_inc(pmu);
> +                       perf_sched_cb_inc(pmu, !(event->attach_state & PERF_ATTACH_TASK));
>                 else
> -                       perf_sched_cb_dec(pmu);
> +                       perf_sched_cb_dec(pmu, !(event->attach_state & PERF_ATTACH_TASK));
>
>                 update = true;
>         }
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 8961653c5dd2..8d4d02cde3d4 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -693,7 +693,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
>          */
>         if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
>                 cpuc->lbr_pebs_users++;
> -       perf_sched_cb_inc(event->ctx->pmu);
> +       perf_sched_cb_inc(event->ctx->pmu, !(event->attach_state &
> PERF_ATTACH_TASK));
>         if (!cpuc->lbr_users++ && !event->total_time_running)
>                 intel_pmu_lbr_reset();
>
> @@ -740,7 +740,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
>         cpuc->lbr_users--;
>         WARN_ON_ONCE(cpuc->lbr_users < 0);
>         WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
> -       perf_sched_cb_dec(event->ctx->pmu);
> +       perf_sched_cb_dec(event->ctx->pmu, !(event->attach_state &
> PERF_ATTACH_TASK));
>   }
>
>   static inline bool vlbr_exclude_host(void)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index abb70a557cb5..5a02239ca8fd 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -966,8 +966,8 @@ extern const struct perf_event_attr
> *perf_event_attrs(struct perf_event *event);
>   extern void perf_event_print_debug(void);
>   extern void perf_pmu_disable(struct pmu *pmu);
>   extern void perf_pmu_enable(struct pmu *pmu);
> -extern void perf_sched_cb_dec(struct pmu *pmu);
> -extern void perf_sched_cb_inc(struct pmu *pmu);
> +extern void perf_sched_cb_dec(struct pmu *pmu, bool systemwide);
> +extern void perf_sched_cb_inc(struct pmu *pmu, bool systemwide);
>   extern int perf_event_task_disable(void);
>   extern int perf_event_task_enable(void);
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e6b98507734a..2d7c07af02f8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3484,25 +3484,29 @@ static void perf_event_context_sched_out(struct
> task_struct *task, int ctxn,
>
>   static DEFINE_PER_CPU(struct list_head, sched_cb_list);
>
> -void perf_sched_cb_dec(struct pmu *pmu)
> +void perf_sched_cb_dec(struct pmu *pmu, bool systemwide)
>   {
>         struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>
> -       this_cpu_dec(perf_sched_cb_usages);
> +       --cpuctx->sched_cb_usage;
>
> -       if (!--cpuctx->sched_cb_usage)
> +       if (systemwide) {
> +               this_cpu_dec(perf_sched_cb_usages);
>                 list_del(&cpuctx->sched_cb_entry);
> +       }
>   }
>
>
> -void perf_sched_cb_inc(struct pmu *pmu)
> +void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
>   {
>         struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>
> -       if (!cpuctx->sched_cb_usage++)
> -               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
> +       cpuctx->sched_cb_usage++;
>
> -       this_cpu_inc(perf_sched_cb_usages);
> +       if (systemwide) {
> +               this_cpu_inc(perf_sched_cb_usages);
> +               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));

You need to check the value and make sure it's added only once.

Thanks
Namhyung


> +       }
>   }
>
>   /*
>
> Thanks,
> Kan
