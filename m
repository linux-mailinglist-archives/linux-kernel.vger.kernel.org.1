Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C932766C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIXDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:12:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIXDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:12:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id c18so2084512wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 20:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaBFSHtaQ8b7ZcWpldx/Dcu5M6kSYigru1/TvIVDxTI=;
        b=Ur6ggvK5gEQjAkxpqeXxUadYgrsmYhHBu/RT5geR4V+egGVxhFwUfPzkuKT/5JAcYD
         L8QbmQ1pM8lSQkoSNmPVg0aJyxHvlvpEBjS4NBeHDK7VpIurQgxonu1BV8BoJBh2JdGN
         D9Gf0JtxrNQq2RLGvEs5Mom524NcYqY7E939WKnG2k/3+cBTrLbeaA8o/wLSLDwkh7IV
         BrF6VyovN3K+4+Ht732IYR9HnZwkpbagAE7DCHXx7mD/qgAmD42mJgoNDjFAGYmYAtzp
         e/gbULM+uw49EAHbMkhvWJRymRLmLQdICJRRxPpnR/QnGKL0VgtKqI4Q4vYlLUHHK8MK
         CyhA==
X-Gm-Message-State: AOAM530paSr1HzRSiU2PdUdcnKiuaQ0U26Q/GfqmHrpzRqwJPxSawlKS
        bVnqkn3sqB1/dXKyNFf1QSKCjUhuExvvfvvzEmo=
X-Google-Smtp-Source: ABdhPJws21XxrcU1ook/7FKSc2d5qTcbsXUsY1on0tGwI27TvkhWT8ht6pKqg1fH0s1a/WkNGQ3YaIHDkTD/cRWpyN4=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr2490624wrp.332.1600917154065;
 Wed, 23 Sep 2020 20:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200923015945.47535-1-namhyung@kernel.org> <20200923015945.47535-4-namhyung@kernel.org>
 <20200923102256.GI2893484@krava>
In-Reply-To: <20200923102256.GI2893484@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 12:12:23 +0900
Message-ID: <CAM9d7ci2Arf8vNVRruF9dqOtxH4km2b1MKCVHzj8x+QazzY2mA@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf tools: Copy metric events properly when expand cgroups
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 7:23 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 23, 2020 at 10:59:43AM +0900, Namhyung Kim wrote:
>
> SNIP
>
>
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 8b6a4fa49082..dcd18ef268a1 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -3,6 +3,9 @@
> >  #include "evsel.h"
> >  #include "cgroup.h"
> >  #include "evlist.h"
> > +#include "rblist.h"
> > +#include "metricgroup.h"
> > +#include "stat.h"
> >  #include <linux/zalloc.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > @@ -193,10 +196,12 @@ int parse_cgroups(const struct option *opt, const char *str,
> >       return 0;
> >  }
> >
> > -int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> > +int evlist__expand_cgroup(struct evlist *evlist, const char *str,
> > +                       struct rblist *metric_events)
> >  {
> >       struct evlist *orig_list, *tmp_list;
> >       struct evsel *pos, *evsel, *leader;
> > +     struct rblist orig_metric_events;
> >       struct cgroup *cgrp = NULL;
> >       const char *p, *e, *eos = str + strlen(str);
> >       int ret = -1;
> > @@ -216,6 +221,8 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> >       /* save original events and init evlist */
> >       perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
> >       evlist->core.nr_entries = 0;
> > +     orig_metric_events = *metric_events;
> > +     rblist__init(metric_events);
> >
> >       for (;;) {
> >               p = strchr(str, ',');
> > @@ -255,6 +262,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> >               cgroup__put(cgrp);
> >               nr_cgroups++;
> >
> > +             perf_stat__collect_metric_expr(tmp_list);
>
> I know you added the option just for perf stat, not record,
> but the code looks generic apart from using this function

Right.  I've tried to make it generic as much as possible.
But the above code works for an evlist assuming all the
evsels are in the same cgroup as far as I can see.
So I put it here to pass the tmp_list for each cgroup
separately.

>
> I wonder if this would cause any issues if it was called in record
> context.. maybe we could just skip it in that case, but that's for
> future to worry about ;-)

Yeah, I believe we can just skip as it's all for metrics which is
used for perf stat only, I guess?

Thanks
Namhyung

>
> > +             if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
> > +                                                 &orig_metric_events) < 0)
> > +                     break;
> > +
> >               perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
> >               tmp_list->core.nr_entries = 0;
> >
> > @@ -268,6 +280,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> >  out_err:
> >       evlist__delete(orig_list);
> >       evlist__delete(tmp_list);
> > +     rblist__exit(&orig_metric_events);
> >
> >       return ret;
> >  }
>
> SNIP
>
