Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD212A88C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbgKEVPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:15:30 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E65C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:15:30 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s89so2564968ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIUwOrKjUcFm7QvpipUdh8qwCi0+XLdSMj/+BwTDn1k=;
        b=PMGwUABUOZ2y4z5ALGytQT9uGT+6Iq856MG23OwULtX85JWd+VqGpr8Hut5Ymj3vlM
         JbWylQ0sReZ4hcUFkat+MJuQuz4Lq0hOZQaZEpdYr5gX7W5WnO+M5FBiEdib6BQrrqzk
         gOKxWQSqfZiKor+wCvFFgi3UlgV5tispvS/cyAn5orgj6m9g6nJmnj96bXbWMaP4sml0
         Jn2d/mMMc2vHqMYWhYpUfnnNdmCh3rwAdJEmYPxmYBon8NXKV8OYyt8zb8wP+hlroS7u
         x98Qi92M/taD72zOPabdlQj+lZOnVi5nfi+BNrCfmxaHEtI+YQogHXpTcYsF1muppT+7
         H6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIUwOrKjUcFm7QvpipUdh8qwCi0+XLdSMj/+BwTDn1k=;
        b=E6R75V6YLuEmxJXmZJ5ZEXiAFKV88BOzp1J0aBpZlguaEXuEC/ZyJ7X+oDeW+toKj7
         32vx3VeWwJxz/1Mu1uDDaEL3ZOrwaT5mQ3Xhy/6ucvCWjd3xmNzE6kYowz2dQvZ1dWl7
         hoJ6lNILrP3dNaz4xxBZERHlCW0Cf3+mludnYmsDT7UrJewoYv/gBzzcdTsUOxhsQZAS
         +Trib3N1RyAkI/EtPzgb2lR9RiVt2xOlPQx3J8e6V7UDQFdtZ+tGPO8FDhgITcSPv6FN
         AJh7nmyrAmKSmtjjHOZVIng701Ot867lRcZvE06Xi5A3DzEyQgyDVeCinVfOQRi6BH+K
         MlqA==
X-Gm-Message-State: AOAM531L9rTfbxBo22lFhf8bRn/KWhylvx/6giB8J5u3AtkK9GUH+ams
        yZoPbomg8Cp9UjF1AKsa/SgWW6hRTzDJqi53JWIqBg==
X-Google-Smtp-Source: ABdhPJx5Sx4zm1uhQfbiFOC6n1pbBd+iocyJpAxp6O/wl1vty0bq8ww+u4uTld4Cju/rtWXDk5gTnFbkKlUmX5NozyM=
X-Received: by 2002:a25:ac8b:: with SMTP id x11mr6401920ybi.294.1604610929095;
 Thu, 05 Nov 2020 13:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20201102145221.309001-1-namhyung@kernel.org> <20201102145221.309001-3-namhyung@kernel.org>
 <03ba0d07-45bb-0849-1843-915b6873478f@linux.intel.com> <CAM9d7cgwmXmyUd4Y==F120BsAx2iWw6h9D+BB6D_FDw1-7SxBw@mail.gmail.com>
 <bd97ab7c-039c-b968-3008-8bcd51700c8c@linux.intel.com>
In-Reply-To: <bd97ab7c-039c-b968-3008-8bcd51700c8c@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 5 Nov 2020 13:15:17 -0800
Message-ID: <CABPqkBSJPyE0txSgRzRVucMjd+X1XyUiGe141Kcn1y3v7G9k=g@mail.gmail.com>
Subject: Re: [RFC 2/2] perf/core: Invoke pmu::sched_task callback for per-cpu events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/5/2020 10:54 AM, Namhyung Kim wrote:
> >> -void perf_sched_cb_inc(struct pmu *pmu)
> >> +void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
> >>    {
> >>          struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> >>
> >> -       if (!cpuctx->sched_cb_usage++)
> >> -               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
> >> +       cpuctx->sched_cb_usage++;
> >>
> >> -       this_cpu_inc(perf_sched_cb_usages);
> >> +       if (systemwide) {
> >> +               this_cpu_inc(perf_sched_cb_usages);
> >> +               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
> > You need to check the value and make sure it's added only once.
>
> Right, maybe we have to add a new variable for that.
>
Sure, I tend to agree here that we need a narrower scope trigger, only
when needed, i.e., an event
or PMU feature that requires ctxsw work. In fact, I am also interested
in splitting ctxswin and ctswout
callbacks. The reason is that you have overhead in the way the
callback is invoked. You may end up
calling the sched_task on ctxswout when only ctxwin is needed. In
doing that you pay the cost of
stopping/starting the PMU for possibly nothing. Stopping the PMU can
be expensive, like on AMD
where you need multiple wrmsr.

So splitting or adding a flag to convey that either CTXSW_IN or
CTXSW_OUT is needed would help.
I am suggesting this now given you are adding a flag.

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
> index a1b91f2de264..14f936385cc8 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -875,6 +875,7 @@ struct perf_cpu_context {
>
>         struct list_head                sched_cb_entry;
>         int                             sched_cb_usage;
> +       int                             sched_cb_sw_usage;
>
>         int                             online;
>         /*
> @@ -967,8 +968,8 @@ extern const struct perf_event_attr
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
> index 66a9bd71f3da..af75859c9138 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3484,22 +3484,32 @@ static void perf_event_context_sched_out(struct
> task_struct *task, int ctxn,
>
>   static DEFINE_PER_CPU(struct list_head, sched_cb_list);
>
> -void perf_sched_cb_dec(struct pmu *pmu)
> +void perf_sched_cb_dec(struct pmu *pmu, bool systemwide)
>   {
>         struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>
> +       --cpuctx->sched_cb_usage;
> +
> +       if (!systemwide)
> +               return;
> +
>         this_cpu_dec(perf_sched_cb_usages);
>
> -       if (!--cpuctx->sched_cb_usage)
> +       if (!--cpuctx->sched_cb_sw_usage)
>                 list_del(&cpuctx->sched_cb_entry);
>   }
>
>
> -void perf_sched_cb_inc(struct pmu *pmu)
> +void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
>   {
>         struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>
> -       if (!cpuctx->sched_cb_usage++)
> +       cpuctx->sched_cb_usage++;
> +
> +       if (!systemwide)
> +               return;
> +
> +       if (!cpuctx->sched_cb_sw_usage++)
>                 list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
>
>         this_cpu_inc(perf_sched_cb_usages);
>
>
>
> Thanks,
> Kan
