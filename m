Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E562A827B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgKEPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:45:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36845 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgKEPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:45:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so2321081wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1nC8Ep9mivgJZksY7MG5lSo7fvXUWLe5EVSJUjtJ2w=;
        b=U21S6VzMslqV3hLOfEa+otU2dkuVBjSOietDRBn1QMnacHyhXOIeL07X2NIq2+2ay2
         1BVuQkVnY7eW1frmNDm0cj66bAJhpyNivNfaWQ6dgmqRSwPaHL/SqwysYrQ+eb5u4Nhi
         ohCJtSGHUPSR9F/P4NBJYlyMv4kg9FbGaX1rs+Jc+lGQX43LFunlvRwEcajlzn/Jh+aJ
         Q27TPBtFXUYsxbXyx0jrlWPHSgyu4LwTeV+Dt7byimbJAXrRs078yNyxMXbFRuS+RtCW
         ueQyJ3oSVBg0kZKRkUp/sEeirlq04b2NVbp5+vmP9y5+Kv/DyHTRGyJek9JzDt06eVZS
         UT7Q==
X-Gm-Message-State: AOAM531Ts2wmMzTxhRzG/a/BQkgSlkzvR6WAMydO5LfwJNT0x97c6gdf
        4IE1z6tkNYdsgMXKZEAqlA6iufYj38JjKlr8oj0=
X-Google-Smtp-Source: ABdhPJxOzi1LYhpQNz43dcRN/35mXWEtr1O27x38BbvP6TvwwMe56G+SMwctz2ZAacPqdCqDoxNx8kZCRZxgszDaoNE=
X-Received: by 2002:adf:84a5:: with SMTP id 34mr3642106wrg.8.1604591113331;
 Thu, 05 Nov 2020 07:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20201102145221.309001-1-namhyung@kernel.org> <20201102145221.309001-2-namhyung@kernel.org>
 <f92281d1-03ec-a1bc-b54f-e2b867d5b787@linux.intel.com>
In-Reply-To: <f92281d1-03ec-a1bc-b54f-e2b867d5b787@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Nov 2020 00:45:02 +0900
Message-ID: <CAM9d7cgsNEoeotoumY0S9kvn0uc34TOas_3rVRL3VyQ9_VVM5Q@mail.gmail.com>
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

Hello,

On Thu, Nov 5, 2020 at 11:47 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/2/2020 9:52 AM, Namhyung Kim wrote:
> > If an event associated with a PMU which has a sched_task callback,
> > it should be called regardless of cpu/task context.  For example,
>
>
> I don't think it's necessary. We should call it when we have to.
> Otherwise, it just waste cycles.
> Shouldn't the patch 2 be enough?

I'm not sure, without this patch __perf_event_task_sched_in/out
cannot be called for per-cpu events (w/o cgroups)  IMHO.
And I could not find any other place to check the
perf_sched_cb_usages.

Thanks
Namhyung


>
> > a per-cpu event might enable large PEBS buffers so it needs to flush
> > the buffer whenever task scheduling happens. >
> > The underlying PMU may or may not require this for the given event,
> > but it will be handled in the pmu::sched_task() callback anyway.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   kernel/events/core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b458ed3dc81b..aaa0155c4142 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -4696,6 +4696,8 @@ static void unaccount_event(struct perf_event *event)
> >               dec = true;
> >       if (has_branch_stack(event))
> >               dec = true;
> > +     if (event->pmu->sched_task)
> > +             dec = true;
> >       if (event->attr.ksymbol)
> >               atomic_dec(&nr_ksymbol_events);
> >       if (event->attr.bpf_event)
> > @@ -11225,6 +11227,8 @@ static void account_event(struct perf_event *event)
> >               inc = true;
> >       if (is_cgroup_event(event))
> >               inc = true;
> > +     if (event->pmu->sched_task)
> > +             inc = true;
> >       if (event->attr.ksymbol)
> >               atomic_inc(&nr_ksymbol_events);
> >       if (event->attr.bpf_event)
> >
