Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14026E0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgIQQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgIQQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:30:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1254D206B6;
        Thu, 17 Sep 2020 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600360234;
        bh=SwA4GzVDjFMXxHbLJlgIocEQg3KBF/MEs3lwul3fjb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMY0p3kFrO2qtW63noCt/K/CoW6LvOUmdLYfykmZH6AsMuQ26XdUaCzx4H7xmBTLi
         GYAOFqVczjY6NHwr63FNjm4tNxGA8abzgQWcRbOMXd+1DLMziS14bAxnH97q9za5dQ
         e5tgWRUcvs/0EhHDf/UgVOvWj7G4EQ2uc6U047Co=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15E35400E9; Thu, 17 Sep 2020 13:30:32 -0300 (-03)
Date:   Thu, 17 Sep 2020 13:30:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf parse-event: Release cpu_map if evsel alloc
 failed
Message-ID: <20200917163031.GD1322686@kernel.org>
References: <20200917060219.1287863-1-namhyung@kernel.org>
 <20200917131058.GA2514666@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131058.GA2514666@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 17, 2020 at 03:10:58PM +0200, Jiri Olsa escreveu:
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
> >  		event_attr_init(attr);
> >  
> >  	evsel = evsel__new_idx(attr, *idx);
> > -	if (!evsel)
> > +	if (!evsel) {
> > +		perf_cpu_map__put(cpus);
> 
> if there's pmu defined, we don't we get on perf_cpu_map:
> 
>         struct perf_cpu_map *cpus = pmu ? pmu->cpus :
>                                cpu_list ? perf_cpu_map__new(cpu_list) : NULL;

Yeah, I fixed this up by applying first the patch that grabs the
pmu->cpus refcount and makes the first attribution of evsel->core.cpus
be directly to 'cpus', as it will either have the refcount for pmu->cpus
or the newly created, refcount set at 1 cpu map.o

Then the error path fix goes in, just dropping the reference to whatever
cpu map we have a refcount for.

- Arnaldo
 
> jirka
> 
> >  		return NULL;
> > +	}
> >  
> >  	(*idx)++;
> >  	evsel->core.cpus   = perf_cpu_map__get(cpus);
> > -- 
> > 2.28.0.618.gf4bc123cb7-goog
> > 
> 

-- 

- Arnaldo
