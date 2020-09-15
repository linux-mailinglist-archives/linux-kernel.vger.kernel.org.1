Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCEF26AAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgIORk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgIORPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:15:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CA520829;
        Tue, 15 Sep 2020 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600188719;
        bh=tEfWkFhBw6aXsEPuLRdnhZblwHrDK74rFy82LcC3M38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRlOZ5m2CH1ifaqJh3Aj12xUWVN2zrA9yc3v1GZ4Ewmd/3170CShpLgLtkKJLZ+HK
         TTlUFvhZINdLyXCaqz/1nqN7ZdSiV/7+koF/F1aZs6Dbo0sa5OF38RVjUX4Rnx9EeT
         /BnxHEVTI5jfW33qRZSQwPwQ9qynRV4j/JoMkDGA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 986C9400E9; Tue, 15 Sep 2020 13:51:56 -0300 (-03)
Date:   Tue, 15 Sep 2020 13:51:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 04/11] perf parse-event: Fix cpu map leaks
Message-ID: <20200915165156.GL720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-5-namhyung@kernel.org>
 <20200915121814.GE720847@kernel.org>
 <CAM9d7chORRmiE2R4LnzGh0uS2nKqL_tk+qxV2TfeqZctvCsJ5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chORRmiE2R4LnzGh0uS2nKqL_tk+qxV2TfeqZctvCsJ5w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 11:39:56PM +0900, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Tue, Sep 15, 2020 at 9:18 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Sep 15, 2020 at 12:18:12PM +0900, Namhyung Kim escreveu:
> > > Like evlist cpu map, evsel's cpu map should have proper refcount by
> > > releasing the original count after creation.
> >
> > "releasing original count after creation"?
> >
> > There are two fixes here, one its legit, i.e. when failing to create
> > the new evsel, if you created the perf_cpu_map, drop the refcount,
> > which, in this case, will free it since perf_cpu_map__new() sets it to
> > 1.
> >
> > But what about the other? Humm, I see, since a new refcount is being
> > obtained, then we need to drop the first.
> >
> > This all got complicated, perhaps the following patch is simpler?
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index c4d2394e2b2dc60f..3dceeacf8669bc5d 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -353,18 +353,20 @@ __add_event(struct list_head *list, int *idx,
> >             const char *cpu_list)
> >  {
> >         struct evsel *evsel;
> > -       struct perf_cpu_map *cpus = pmu ? pmu->cpus :
> > +       struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
> >                                cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
> >
> >         if (init_attr)
> >                 event_attr_init(attr);
> >
> >         evsel = evsel__new_idx(attr, *idx);
> > -       if (!evsel)
> > +       if (!evsel) {
> > +               perf_cpu_map__put(cpus);
> >                 return NULL;
> > +       }
> >
> >         (*idx)++;
> > -       evsel->core.cpus   = perf_cpu_map__get(cpus);
> > +       evsel->core.cpus     = cpus;
> >         evsel->core.own_cpus = perf_cpu_map__get(cpus);
> >         evsel->core.system_wide = pmu ? pmu->is_uncore : false;
> >         evsel->auto_merge_stats = auto_merge_stats;
> >
> >
> > ---
> >
> > I.e. if we're going to share pmu->cpus, grab the necessary refcount at
> > that point, if we're going to create one (pmu == NULL), then
> > perf_cpu_map__new() will have the refcount we need (will set it to 1).
> >
> > Then, if we fail to create the new evsel, we just drop the refcount we
> > got either from perf_cpu_map__get(pmu->cpus) or from
> > perf_cpu_map__new(cpu_list) (NULL is ok for __put() operations, that
> > covers that last ': NULL').
> >
> > And then, when we go make evsel->core.cpus share that cpu_map, we know
> > we have the necessary refcount already, right?
> 
> Indeed! This looks a lot better.  Do you want me to resend?

Please, feel free to use whatever snippets from my explanations.

But please consider breaking it into two patches, without thinking too
much about it at this time, it seems there are two fixes to be done in
this case.

- Arnaldo
