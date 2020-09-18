Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD426EAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIRBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:51:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50313 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRBvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:51:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id e17so3742331wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbEo+gTNTSrKE2rMnewfncAtDNj5x3gox0tVCjpYOaw=;
        b=naFQBuo+cekd241WEBaigTI+tf2x7McaFq387alpbxxnBKwePh7qKq7lj9I81/ujwr
         WUT74dzRxLOL98pn8VYBYaI8GnHMjBFNVTF3sG09rHWGRKPGHCxn/nKZtQWFnwVxW27t
         dR5ypy+EeSsbw+lmyZUJgyuNnm9dUKamRAHrfT5RWyDXgUl8Lu5oReZ8x2Y6XiDMZMD1
         5G6+s7zxgdgWPVjAswsiYGNP41MoFKCn6yAQcosPkirbyC/Le+nO4km+W3i0NgIj5C91
         GIRE9o6xaKiiYwjVOnigpbD+IZ/IXDElP/i+TjOMbsHeCMIORC8jrB74UvCjKLPv1y/C
         CdRg==
X-Gm-Message-State: AOAM530IDcDsX46aK6jeSaZvfNdMGcfynMho1XYv6gLlh8koYY0oyK/k
        FZ1sU8SeG3iBC5BndlwdBVaBiBx5VhkJ+VVnGZ0=
X-Google-Smtp-Source: ABdhPJye5wnfoZLS/6zpruR3rHZNyJH6kn8zOR6Td0ZX+0UBOAApgfquFvByj1+tJXJYmdDUCMn91wP53Ar2fvaYR9M=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr13567568wmc.154.1600393905120;
 Thu, 17 Sep 2020 18:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200917060219.1287863-1-namhyung@kernel.org> <20200917131058.GA2514666@krava>
 <20200917163031.GD1322686@kernel.org>
In-Reply-To: <20200917163031.GD1322686@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Sep 2020 10:51:34 +0900
Message-ID: <CAM9d7cjqeaF=3_eaQKVoWs3dxLPiiTk+yBd+ncHx5+DtuGnOvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf parse-event: Release cpu_map if evsel alloc failed
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

On Fri, Sep 18, 2020 at 1:30 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Sep 17, 2020 at 03:10:58PM +0200, Jiri Olsa escreveu:
> > On Thu, Sep 17, 2020 at 03:02:18PM +0900, Namhyung Kim wrote:
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/parse-events.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 667cbca1547a..176a51698a64 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -360,8 +360,10 @@ __add_event(struct list_head *list, int *idx,
> > >             event_attr_init(attr);
> > >
> > >     evsel = evsel__new_idx(attr, *idx);
> > > -   if (!evsel)
> > > +   if (!evsel) {
> > > +           perf_cpu_map__put(cpus);
> >
> > if there's pmu defined, we don't we get on perf_cpu_map:
> >
> >         struct perf_cpu_map *cpus = pmu ? pmu->cpus :
> >                                cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>
> Yeah, I fixed this up by applying first the patch that grabs the
> pmu->cpus refcount and makes the first attribution of evsel->core.cpus
> be directly to 'cpus', as it will either have the refcount for pmu->cpus
> or the newly created, refcount set at 1 cpu map.o
>
> Then the error path fix goes in, just dropping the reference to whatever
> cpu map we have a refcount for.

Sorry for messing this up and thanks for fixing it.  I'll take more care later..

Thanks
Namhyung


> >
> > >             return NULL;
> > > +   }
> > >
> > >     (*idx)++;
> > >     evsel->core.cpus   = perf_cpu_map__get(cpus);
> > > --
> > > 2.28.0.618.gf4bc123cb7-goog
> > >
> >
>
> --
>
> - Arnaldo
