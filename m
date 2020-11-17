Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB102B5900
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 06:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKQFBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 00:01:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36374 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgKQFBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:01:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id f11so28386027lfs.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 21:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6Qu4LBvzg0KV5uCK88WACJ6tGCBOoR1HGCMw7qp6WQ=;
        b=GjD1zuMtoqHO1ziPsds7y1ADtexEBfTRCH8MyjGh8ZI/2BbgIvQpuhr//em49ghvcK
         P5odvFILEMkw8jHfhqpswPUVwjVEowZ8deEI9eO7LtDnGOYdze1DQNG2u3QEDWHENBgG
         Zwlp6ZtealByQVBprI/RJmA2ltGnc2wUnCrfF2loOzJcbJFNGIL7TqkJDomsyRWpvild
         1AKwySar4RquFZlWYsIgDMkGd9nmbsBH3Xgjg9DXqo97qCqHINioMh5rFEOLzMeJA3og
         s4zcg2btoDpbzrL/QA+XWIVcfFbs9d7qUUj7DtIS7pxo4C4Exj1jBal8BNssfEfXMwMD
         fb/w==
X-Gm-Message-State: AOAM530NpWJoaCW0GFKONrs/2CeIQuU8VZ3meTqrxKlwpCFKTf+q1Qst
        dPkca6qqKZ8aXYLmzZJgMYUT1B7NtCMUvdd8AN0=
X-Google-Smtp-Source: ABdhPJyctWAEvCuK1obWq1qK/A5S09DSKpBk8yoYR4poJhvuRnBc6Q1gU+gAmBYuISMpMeysaUxN5HA4TKigj2CHgSM=
X-Received: by 2002:ac2:5e72:: with SMTP id a18mr929091lfr.220.1605589307873;
 Mon, 16 Nov 2020 21:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net> <20201109110405.GN2651@hirez.programming.kicks-ass.net>
 <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com> <20201111162509.GW2611@hirez.programming.kicks-ass.net>
 <2dc483f6-7b29-c42b-13a4-4c549d720aa2@linux.intel.com>
In-Reply-To: <2dc483f6-7b29-c42b-13a4-4c549d720aa2@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Nov 2020 14:01:36 +0900
Message-ID: <CAM9d7cjwFp9JBqs1Ga9n1ojbez9chZLvmOgFv1EE4KDhAa9ryA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 12, 2020 at 4:54 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/11/2020 11:25 AM, Peter Zijlstra wrote:
> > On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:
> >
> >> - When the large PEBS was introduced (9c964efa4330), the sched_task() should
> >> be invoked to flush the PEBS buffer in each context switch. However, The
> >> perf_sched_events in account_event() is not updated accordingly. The
> >> perf_event_task_sched_* never be invoked for a pure per-CPU context. Only
> >> per-task event works.
> >>     At that time, the perf_pmu_sched_task() is outside of
> >> perf_event_context_sched_in/out. It means that perf has to double
> >> perf_pmu_disable() for per-task event.
> >
> >> - The patch 1 tries to fix broken per-CPU events. The CPU context cannot be
> >> retrieved from the task->perf_event_ctxp. So it has to be tracked in the
> >> sched_cb_list. Yes, the code is very similar to the original codes, but it
> >> is actually the new code for per-CPU events. The optimization for per-task
> >> events is still kept.
> >>    For the case, which has both a CPU context and a task context, yes, the
> >> __perf_pmu_sched_task() in this patch is not invoked. Because the
> >> sched_task() only need to be invoked once in a context switch. The
> >> sched_task() will be eventually invoked in the task context.
> >
> > The thing is; your first two patches rely on PERF_ATTACH_SCHED_CB and
> > only set that for large pebs. Are you sure the other users (Intel LBR
> > and PowerPC BHRB) don't need it?
>
> I didn't set it for LBR, because the perf_sched_events is always enabled
> for LBR. But, yes, we should explicitly set the PERF_ATTACH_SCHED_CB
> for LBR.
>
>         if (has_branch_stack(event))
>                 inc = true;
>
> >
> > If they indeed do not require the pmu::sched_task() callback for CPU
> > events, then I still think the whole perf_sched_cb_{inc,dec}() interface
>
> No, LBR requires the pmu::sched_task() callback for CPU events.
>
> Now, The LBR registers have to be reset in sched in even for CPU events.
>
> To fix the shorter LBR callstack issue for CPU events, we also need to
> save/restore LBRs in pmu::sched_task().
> https://lore.kernel.org/lkml/1578495789-95006-4-git-send-email-kan.liang@linux.intel.com/
>
> > is confusing at best.
> >
> > Can't we do something like this instead?
> >
> I think the below patch may have two issues.
> - PERF_ATTACH_SCHED_CB is required for LBR (maybe PowerPC BHRB as well) now.
> - We may disable the large PEBS later if not all PEBS events support
> large PEBS. The PMU need a way to notify the generic code to decrease
> the nr_sched_task.

Any updates on this?  I've reviewed and tested Kan's patches
and they all look good.

Maybe we can talk to PPC folks to confirm the BHRB case?

Thanks,
Namhyung
