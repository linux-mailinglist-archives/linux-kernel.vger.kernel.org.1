Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28C726D0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIQBfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:35:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIQBfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:35:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id e17so363397wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XB6xKHXsDglEG87/HgjvrXLWqhuYIA21MKPVVa06mMo=;
        b=cMnQm64tGTcapKibjkcW5hqX45xBuL9OJlH2xl4nMmFYBY4HZJ0jWpYmK4eAmdem6A
         rHSa1KF/wie2ATOwufVuoCTRfwn0FDuB7TdV87SBxuBSpG+mYwX0Ji3OWfM6NVUT1pXj
         7ZsE0pykqy6KwUBxDUpMQ7Q4v8pUD9fTi8SzbruEg/hce0lFp0ytUo91LSuJSw3jfQuk
         zePWHIdvI+zME+hTwfANE1UjOy+EUSUFynm6sYfzU+7Efob9RK3a6YT/FpsKdYiKHJyw
         JCr/40+ujPSDb1PPapesvyXb2XXqKgG6riy5HqjDZl08NjhyVYfIorscEybQLQRT/Vq9
         94OQ==
X-Gm-Message-State: AOAM532ACkvmzLmEya535xd8wfSHGMxivehGuRziJ73eMelrp/xCI5ES
        GGILgWpneBJxLVK0sAZd09kqyCTnxHv4Zg4mIBc=
X-Google-Smtp-Source: ABdhPJzbdXvKz3NkmgKcY9yMsirzTpFyzrr5B+UBKAny3iuW2Ru8OYmgTGy/UVuFeaZ8VXpANcZMA8aXcnCWlFN6ffU=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr7432996wmb.70.1600306511550;
 Wed, 16 Sep 2020 18:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916053131.1001604-1-namhyung@kernel.org> <20200916053131.1001604-2-namhyung@kernel.org>
 <20200916140010.GQ720847@kernel.org>
In-Reply-To: <20200916140010.GQ720847@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 10:35:00 +0900
Message-ID: <CAM9d7cj+6YEHn9f2tVfQqVpUzurPigDnNC+w80sgk+vA0LLwtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf parse-event: Fix cpu map leaks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:00 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Sep 16, 2020 at 02:31:31PM +0900, Namhyung Kim escreveu:
> > Like evlist cpu map, evsel's cpu map should have a proper refcount.
> > As it's created with a refcount, we don't need to get an extra count.
> > Thanks to Arnaldo for the simpler suggestion.
>
> You forgot this part:
>
>
> [acme@five perf]$ git diff
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 667cbca1547ac5f6..0154331ea213f166 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -353,7 +353,7 @@ __add_event(struct list_head *list, int *idx,
>             const char *cpu_list)
>  {
>         struct evsel *evsel;
> -       struct perf_cpu_map *cpus = pmu ? pmu->cpus :
> +       struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
>                                cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>
>         if (init_attr)
>
> Right?

Oops, you're right!  Will send v2 soon.

Thanks
Namhyung


> > This fixes the following ASAN report:
> >
> >   Direct leak of 840 byte(s) in 70 object(s) allocated from:
> >     #0 0x7fe36703f628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
> >     #1 0x559fbbf611ca in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
> >     #2 0x559fbbf6229c in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:237
> >     #3 0x559fbbcc6c6d in __add_event util/parse-events.c:357
> >     #4 0x559fbbcc6c6d in add_event_tool util/parse-events.c:408
> >     #5 0x559fbbcc6c6d in parse_events_add_tool util/parse-events.c:1414
> >     #6 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
> >     #7 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
> >     #8 0x559fbbcc95da in __parse_events util/parse-events.c:2141
> >     #9 0x559fbbc2788b in check_parse_id tests/pmu-events.c:406
> >     #10 0x559fbbc2788b in check_parse_id tests/pmu-events.c:393
> >     #11 0x559fbbc2788b in check_parse_fake tests/pmu-events.c:436
> >     #12 0x559fbbc2788b in metric_parse_fake tests/pmu-events.c:553
> >     #13 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:599
> >     #14 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:574
> >     #15 0x559fbbc0109b in run_test tests/builtin-test.c:410
> >     #16 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
> >     #17 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
> >     #18 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
> >     #19 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
> >     #20 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
> >     #21 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
> >     #22 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
> >     #23 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308
> >
> > And I've failed which commit introduced this bug as the code was
> > heavily changed since then. ;-/
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/parse-events.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 176a51698a64..204395596381 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -366,7 +366,7 @@ __add_event(struct list_head *list, int *idx,
> >       }
> >
> >       (*idx)++;
> > -     evsel->core.cpus   = perf_cpu_map__get(cpus);
> > +     evsel->core.cpus = cpus;
> >       evsel->core.own_cpus = perf_cpu_map__get(cpus);
> >       evsel->core.system_wide = pmu ? pmu->is_uncore : false;
> >       evsel->auto_merge_stats = auto_merge_stats;
> > --
> > 2.28.0.618.gf4bc123cb7-goog
> >
>
> --
>
> - Arnaldo
