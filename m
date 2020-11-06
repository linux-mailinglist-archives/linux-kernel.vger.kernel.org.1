Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65B2A8BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgKFAxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:53:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52130 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732706AbgKFAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:53:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id v5so3308302wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 16:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boppSBMJx32ZfiF7X9zjZYOt9YxgRmOiF6nm2qOrqj8=;
        b=mv+bDX9kLRiouRVuqjU+l5bLl/jvAwuE9AmWIkmLnCICB5RRu/h+20hQL7jyYjzpMw
         opZzp8Pn3aStHFYMUHzf7Uu6JElTw07/kTYvS2rzB9yDMsSvKvrInbuysundxXEPTQP0
         3JlegFje07iSXOaK38WlrffpVhxDWh9ALutumrjvH2IOgcqyxdHO5LR+byGp3z85aARr
         6tShjXHt7tq8ifdK0QPtlpKbUIVM6kJoosiO9gIgT30/weLn2ipAAicw8pdnFKix18Wo
         gXkS7tSrmSao5t4vywQ7C2H1f8/+tMpl4y8u36Tx8DpkhCsC3VSQtG9nKy2HqZTS8ttr
         MZBA==
X-Gm-Message-State: AOAM531i38IvViv3EzbpdBCOuleX2S+eMw3V3K10mjbGZ7uJLwskPn49
        aYcfe51y54g2bM3z15Alj52FEBeZqRorn7Vvg6o=
X-Google-Smtp-Source: ABdhPJwhvnKOfwAqKXklv5tls2QQP9/ViAPSthQG9tF0Z/JHWCKQI7193wCHgrK06h7v8Lpd4iMVua9YWb0TIGKSXZI=
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr5285829wmc.8.1604623998749;
 Thu, 05 Nov 2020 16:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20201102145221.309001-1-namhyung@kernel.org> <20201102145221.309001-2-namhyung@kernel.org>
 <f92281d1-03ec-a1bc-b54f-e2b867d5b787@linux.intel.com> <CAM9d7cgsNEoeotoumY0S9kvn0uc34TOas_3rVRL3VyQ9_VVM5Q@mail.gmail.com>
 <84bc6e54-eed8-5230-ad76-7c637613a3ec@linux.intel.com>
In-Reply-To: <84bc6e54-eed8-5230-ad76-7c637613a3ec@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Nov 2020 09:53:07 +0900
Message-ID: <CAM9d7cgQHN0sLb4Oro0+aMQsLrgx+XUnSMB1RWAnayodXPkdPw@mail.gmail.com>
Subject: Re: [RFC 1/2] perf/core: Enable sched_task callbacks if PMU has it
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

On Fri, Nov 6, 2020 at 4:01 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/5/2020 10:45 AM, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Nov 5, 2020 at 11:47 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 11/2/2020 9:52 AM, Namhyung Kim wrote:
> >>> If an event associated with a PMU which has a sched_task callback,
> >>> it should be called regardless of cpu/task context.  For example,
> >>
> >>
> >> I don't think it's necessary. We should call it when we have to.
> >> Otherwise, it just waste cycles.
> >> Shouldn't the patch 2 be enough?
> >
> > I'm not sure, without this patch __perf_event_task_sched_in/out
> > cannot be called for per-cpu events (w/o cgroups)  IMHO.
> > And I could not find any other place to check the
> > perf_sched_cb_usages.
> >
>
> Yes, it should a bug for large PEBS, and it should has always been there
> since the large PEBS was introduced. I just tried some older kernels
> (before recent change). Large PEBS is not flushed with per-cpu events.
>
> But from your description, it looks like the issue is only found after
> recent change. Could you please double check if the issue can also be
> reproduced before the recent change?

Yep, actually Gabriel reported this problem on v4.4 kernel.
I'm sorry that my description was misleading.

>
>
> >>> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >>> index b458ed3dc81b..aaa0155c4142 100644
> >>> --- a/kernel/events/core.c
> >>> +++ b/kernel/events/core.c
> >>> @@ -4696,6 +4696,8 @@ static void unaccount_event(struct perf_event *event)
> >>>                dec = true;
> >>>        if (has_branch_stack(event))
> >>>                dec = true;
> >>> +     if (event->pmu->sched_task)
> >>> +             dec = true;
>
> I think sched_task is a too big hammer. The
> __perf_event_task_sched_in/out will be invoked even for non-pebs per-cpu
> events, which is not necessary.

Agreed.

>
> Maybe we can introduce a flag to indicate the case. How about the patch
> as below?

LGTM, but I prefer PERF_ATTACH_SCHED_CB, though. :)

Thanks
Namhyung

>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index c79748f6921d..953a4bb98330 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3565,8 +3565,10 @@ static int intel_pmu_hw_config(struct perf_event
> *event)
>                 if (!(event->attr.freq || (event->attr.wakeup_events &&
> !event->attr.watermark))) {
>                         event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>                         if (!(event->attr.sample_type &
> -                             ~intel_pmu_large_pebs_flags(event)))
> +                             ~intel_pmu_large_pebs_flags(event))) {
>                                 event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
> +                               event->attach_state |= PERF_ATTACH_SCHED_DATA;
> +                       }
>                 }
>                 if (x86_pmu.pebs_aliases)
>                         x86_pmu.pebs_aliases(event);
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0defb526cd0c..3eef7142aa11 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -606,6 +606,7 @@ struct swevent_hlist {
>   #define PERF_ATTACH_TASK      0x04
>   #define PERF_ATTACH_TASK_DATA 0x08
>   #define PERF_ATTACH_ITRACE    0x10
> +#define PERF_ATTACH_SCHED_DATA 0x20
>
>   struct perf_cgroup;
>   struct perf_buffer;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dba4ea4e648b..a38133b5543a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4675,7 +4675,7 @@ static void unaccount_event(struct perf_event *event)
>         if (event->parent)
>                 return;
>
> -       if (event->attach_state & PERF_ATTACH_TASK)
> +       if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_DATA))
>                 dec = true;
>         if (event->attr.mmap || event->attr.mmap_data)
>                 atomic_dec(&nr_mmap_events);
> @@ -11204,7 +11204,7 @@ static void account_event(struct perf_event *event)
>         if (event->parent)
>                 return;
>
> -       if (event->attach_state & PERF_ATTACH_TASK)
> +       if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_DATA))
>                 inc = true;
>         if (event->attr.mmap || event->attr.mmap_data)
>                 atomic_inc(&nr_mmap_events);
>
> Thanks,
> Kan
