Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84E02CE883
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgLDHP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:15:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34617 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgLDHP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:15:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id n132so4661756qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tSrT55qtwUdqJ18CjAG8c7u7qoXLcFmKTEI2RQl2YI=;
        b=aa8BaVqTESFF0KzkwjC0VRybbt7rCgoxdnbHUKsNyZEV8CFZj18LWMXHWlAgF0lPjE
         qV7tgR/XZtFwDEvj641d7WELfBB2NMLhKpyeIzbcUPNcv489fzwquq7JRsa8SsXq1WB9
         ZFbg5yW5WO8bFV40s5kzrp2CCnK5FZtBFXamDq45uR+jBLQ4H1URzkpMk/v3L1udQdRh
         vFEdLv9R4/7aCT6bOHXCDJlg2dpBEtRMxvGZka3OtiuOF+g0y67TGsCNAfd5uU3fAO+x
         7NWRHs7ptqbYNWKL/5y+iwOXOSf69s61mQ15tGEgdxLtKo9BvjZevEw2dUEPRz1LATi9
         FhpQ==
X-Gm-Message-State: AOAM531jHwov3/8/HdJsJHgPpbTATdbDS1+PsMceD3WJxacQvZA0F3nY
        KmnoSs5QgGsAevdgIG3SFM38YSZFDAEssey9FXI=
X-Google-Smtp-Source: ABdhPJzVgDIflybUIsGciZlvPCLzgFBU9YCbO+u1jy9CuLd6Bakcz7o5yRunhD43oszYHFWxePC3axFwoEGgFp5bbzo=
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr7369204qka.278.1607066085155;
 Thu, 03 Dec 2020 23:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com> <20201201172903.GT3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201201172903.GT3040@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 4 Dec 2020 16:14:33 +0900
Message-ID: <CAM9d7ciukm4RAH+44YWhZRummKzk1HTbnZ0Sc4Xd5ZyCo=x0xQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Dec 2, 2020 at 2:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 30, 2020 at 11:38:42AM -0800, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Some calls to sched_task() in a context switch can be avoided. For
> > example, large PEBS only requires flushing the buffer in context switch
> > out. The current code still invokes the sched_task() for large PEBS in
> > context switch in.
>
> I still hate this one, how's something like this then?
> Which I still don't really like.. but at least its simpler.
>
> (completely untested, may contain spurious edits, might ICE the
> compiler and set your pets on fire if it doesn't)

I've tested this version... and it worked well besides the optimization.. :)

[SNIP]
> +static void context_sched_task(struct perf_cpu_context *cpuctx,
> +                              struct perf_event_context *ctx,
> +                              bool sched_in)
> +{
> +       struct pmu *pmu = ctx->pmu;
> +
> +       if (cpuctx->sched_cb_dir[sched_in] && pmu->sched_task)
> +               pmu->sched_task(ctx, false);

applied: s/false/sched_in/


> +}
> +
>  static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>                                          struct task_struct *next)
>  {
> @@ -3424,9 +3433,7 @@ static void perf_event_context_sched_out
>                         WRITE_ONCE(next_ctx->task, task);
>
>                         perf_pmu_disable(pmu);
> -
> -                       if (cpuctx->sched_cb_usage && pmu->sched_task)
> -                               pmu->sched_task(ctx, false);
> +                       context_sched_task(cpuctx, ctx, false);
>
>                         /*
>                          * PMU specific parts of task perf context can require
> @@ -3465,8 +3472,7 @@ static void perf_event_context_sched_out
>                 raw_spin_lock(&ctx->lock);
>                 perf_pmu_disable(pmu);
>
> -               if (cpuctx->sched_cb_usage && pmu->sched_task)
> -                       pmu->sched_task(ctx, false);
> +               context_sched_task(cpuctx, ctx, false);
>                 task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
>
>                 perf_pmu_enable(pmu);

[SNIP]
> @@ -3563,8 +3582,7 @@ void __perf_event_task_sched_out(struct
>  {
>         int ctxn;
>
> -       if (__this_cpu_read(perf_sched_cb_usage))
> -               perf_pmu_sched_task(task, next, false);
> +       perf_pmu_sched_task(task, next, false);

I think the reason is this change.  It now calls perf_pmu_sched_task()
without checking the counter.  And this is for per-cpu events.

>
>         if (atomic_read(&nr_switch_events))
>                 perf_event_switch(task, next, false);
> @@ -3828,8 +3846,7 @@ static void perf_event_context_sched_in(
>                 cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>         perf_event_sched_in(cpuctx, ctx, task);
>
> -       if (cpuctx->sched_cb_usage && pmu->sched_task)
> -               pmu->sched_task(cpuctx->task_ctx, true);
> +       context_sched_task(cpuctx, ctx, true);
>
>         perf_pmu_enable(pmu);
>
> @@ -3875,8 +3892,7 @@ void __perf_event_task_sched_in(struct t
>         if (atomic_read(&nr_switch_events))
>                 perf_event_switch(task, prev, true);
>
> -       if (__this_cpu_read(perf_sched_cb_usage))
> -               perf_pmu_sched_task(prev, task, true);
> +       perf_pmu_sched_task(prev, task, true);

Ditto.

>  }
>
>  static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)

So I made a change like below.. and it could bring the optimization back.

Thanks,
Namhyung


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9107e7c3ccfb..a30243a9fab5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3528,6 +3528,9 @@ static void __perf_pmu_sched_task(struct
perf_cpu_context *cpuctx, bool sched_in
 {
        struct pmu *pmu;

+       if (!cpuctx->sched_cb_dir[sched_in])
+               return;
+
        pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */

        if (WARN_ON_ONCE(!pmu->sched_task))
