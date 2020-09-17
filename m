Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B026DD01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIQNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:43:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36402 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgIQNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:35:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id z9so2090080wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpVtaXWQ5D1qPdZ2YyEvy4eIPN92vWUCSfHuIMRx3OI=;
        b=WmF3zLVSZYI2/W2H41lmVBYE6WcgexLIx3MTjWHrI/rsXb0QAFdSZ0+G4dLeJYeGss
         kwKnQQVP8Y32sgqDqUlT6wmgteRAztjhCHiTuYe055YDjfH4jCZ7WEpVX9Cf6emqWI9+
         ZKXF2LgWl4dSQzfAFI3ER5yEIZy/TCcdvus8ZoBS5eQXnJW7FElEaZw7lB5vSwJmeKjr
         ogkA3aoRh7HOpPXQw4Npyq7e0FRyRtmi2dPThJZe4lX40TK0fXfw1WhW6ggcP4Z+9r6O
         KM8v4Ehkw1wvKKpDHhUKiYD+v6u10B8FceB/c34DRdaZPDwFsMW02AByPLwpU09lEk3k
         6/Hw==
X-Gm-Message-State: AOAM531fY8ZKeNUXQdMLZFM0xzDO+daDCtspyL4vy1mI4xHLTT8RomyY
        GaU+BW/kiVdMNOxU5kROQyEVPfFryfVYybUZ0G7eh2h+
X-Google-Smtp-Source: ABdhPJzL/RxQO6Rjd39pYwn3RvqGaiv6XCWiQ3kZCM+fcB5givJEYHlkkc2eSrv49QXJzQz3WI2j0GbT/kXsZxB12d8=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr10157645wmb.70.1600349248614;
 Thu, 17 Sep 2020 06:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200917060219.1287863-1-namhyung@kernel.org> <20200917131058.GA2514666@krava>
In-Reply-To: <20200917131058.GA2514666@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 22:27:17 +0900
Message-ID: <CAM9d7ci_oPsOzRnCiU4PXK7Ye9xT_cTLNshs3P2MTXjxJUcH7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf parse-event: Release cpu_map if evsel alloc failed
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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

On Thu, Sep 17, 2020 at 10:11 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Sep 17, 2020 at 03:02:18PM +0900, Namhyung Kim wrote:
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/parse-events.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 667cbca1547a..176a51698a64 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -360,8 +360,10 @@ __add_event(struct list_head *list, int *idx,
> >               event_attr_init(attr);
> >
> >       evsel = evsel__new_idx(attr, *idx);
> > -     if (!evsel)
> > +     if (!evsel) {
> > +             perf_cpu_map__put(cpus);
>
> if there's pmu defined, we don't we get on perf_cpu_map:
>
>         struct perf_cpu_map *cpus = pmu ? pmu->cpus :
>                                cpu_list ? perf_cpu_map__new(cpu_list) : NULL;

Right, but it's changed in the next patch.  Maybe I need to exchange them.

Thanks
Namhyung


>
> >               return NULL;
> > +     }
> >
> >       (*idx)++;
> >       evsel->core.cpus   = perf_cpu_map__get(cpus);
> > --
> > 2.28.0.618.gf4bc123cb7-goog
> >
>
