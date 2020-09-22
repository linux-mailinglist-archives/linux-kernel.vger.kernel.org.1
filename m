Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1148C274C66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIVWqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:46:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40660 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:46:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so4967850wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uZg2J9KOhndD83S+iNJXBcu6Uv5cmddMHtS3+Zrhqg=;
        b=ORs2W/srapFbBk0+AkfbBmYhgfIWqtRpIsyn0XHJU8lnBeOuJ2BWRXTRPu1rB3q2To
         9qj3nUGyK/PJcOV8lL9p57KD3YYGVlwBSCD6D4RHuL3EN9ozJ0fExPjjsBRnAcYaiMos
         tGR7IrGblF5fKtizl7DuosSZq/U2dBc7R6fGAgrLcP0nYB0EYdWLANSiBJ29+fBYs1LD
         l3S0lLtWlWChj61A6/y67ERMQ+hrKoFA1XzJfYhIo5mNpEU9LqToduZh/i62vIXHuOT5
         p+BSgOkvHGzBIg4fVtd1w4OeD7xK2WJyl5qQPsUEcZFLKRyP5A/Xyn0c3g4WwZOvU7Rw
         3UQw==
X-Gm-Message-State: AOAM530adVzO1p3lgP5aSkWyJcM13zV0IQ1AIYcfdJfGXl59fpabGVWO
        cfJYbbm1F/CHeUuaZ736a+iyZajcjUf2BN+l9uU=
X-Google-Smtp-Source: ABdhPJxyjd/19lMCQMhW7QvpGIOeSEy1ebjlyGqXkTqqJysJe96Oz+CIGh+0eMaP85UvHtdHK0wtJS6CHQ3Tr1Sd0u0=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3388096wmt.92.1600814802583;
 Tue, 22 Sep 2020 15:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200921094610.83736-1-namhyung@kernel.org> <20200921094610.83736-4-namhyung@kernel.org>
 <20200922212931.GC2893484@krava>
In-Reply-To: <20200922212931.GC2893484@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 07:46:31 +0900
Message-ID: <CAM9d7ciAHddoDjNH5GhBDGaXe5xY8Lhaq0YdthPjBW0csZ-ing@mail.gmail.com>
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

On Wed, Sep 23, 2020 at 6:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 21, 2020 at 06:46:08PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > @@ -260,6 +267,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> >               cgroup__put(cgrp);
> >               nr_cgroups++;
> >
> > +             perf_stat__collect_metric_expr(tmp_list);
> > +             if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
> > +                                                 &orig_metric_events) < 0)
> > +                     break;
> > +
> >               perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
> >               tmp_list->core.nr_entries = 0;
> >
> > @@ -273,6 +285,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> >  out_err:
> >       evlist__delete(orig_list);
> >       evlist__delete(tmp_list);
> > +     rblist__exit(&orig_metric_events);
> >
> >       return ret;
> >  }
> > diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> > index 32893018296f..eea6df8ee373 100644
> > --- a/tools/perf/util/cgroup.h
> > +++ b/tools/perf/util/cgroup.h
> > @@ -22,9 +22,11 @@ struct cgroup *cgroup__get(struct cgroup *cgroup);
> >  void cgroup__put(struct cgroup *cgroup);
> >
> >  struct evlist;
> > +struct rblist;
> >
> >  struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
> > -int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups);
> > +int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
> > +                       struct rblist *metric_events);
> >
> >  void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index ee7b576d3b12..424209c4bcd2 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -1964,3 +1964,14 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> >
> >       return err;
> >  }
> > +
> > +struct evsel *evlist__get_evsel(struct evlist *evlist, int idx)
>
> perhaps evlist__find_evsel is better name?
> we have get/put names for functions changing refcount

Looks better, will change.

Thanks
Namhyung

>
> > +{
> > +     struct evsel *evsel;
> > +
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             if (evsel->idx == idx)
> > +                     return evsel;
> > +     }
> > +     return NULL;
> > +}
>
> SNIP
>
