Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC86271A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIUFod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:44:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIUFod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:44:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4so11316234wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJ4P5pR2yGLBwLUxsXpYjCmQsuTGka8kWArHDi0T1OQ=;
        b=B8BvQBt+mvziuvstHucOfheHwYKKXmcdFBmWHlCPcHyD5tMTrVNP0qgugHc6z6h/Bk
         aPXJ1a/Hdh/u8Kw696LpsSOqFYfLRFCbEBwLfZjUompuoh0WV8UwDFq19mz7l2LWVHQH
         jx7O1Aatu1EJCD3fk+Yc6UfHA4Se+tFge/2XebZHuCgcuE2YgPZaFwXv+CwYngHx4knI
         oQxrZ39nmhjead0PvVO4O0l2r1nXsGuvqZtG6SxHcKVJGg4sV/TKa02T32fHFnwI/8H3
         b1x2ENb2oEBKHJWiLq1IZbvvAGoVkXihXtSXY5jTwPqV0LUAFt64CKnipG35wJDPuXMb
         1N9w==
X-Gm-Message-State: AOAM531/HL4immHmram5P9C0jcjwui1Jp3e4x+iV7zvMDyrgOXbkSfPl
        2igEPMDvWrmqONgQO79Qot4jkrGC7owdZkCYgNo=
X-Google-Smtp-Source: ABdhPJxl/+VDlOBl8CrrVCmLERe34t6IWnNgPJDhqLjVjNGZg+ACcznJWhXqvKjU47Hv7HkT54oTMQ72Hd4YjjwwYw4=
X-Received: by 2002:adf:a418:: with SMTP id d24mr42707050wra.80.1600667071013;
 Sun, 20 Sep 2020 22:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200916063129.1061487-1-namhyung@kernel.org> <20200916063129.1061487-2-namhyung@kernel.org>
 <20200918133145.GA2626435@krava>
In-Reply-To: <20200918133145.GA2626435@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Sep 2020 14:44:20 +0900
Message-ID: <CAM9d7cgwDTTy82wg63HY5gTSy-q75BZj+2CF7DQg4czqvLEPBQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf evsel: Add evsel__clone() function
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

Hi Jiri,

On Fri, Sep 18, 2020 at 10:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 16, 2020 at 03:31:26PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +struct evsel *evsel__clone(struct evsel *orig)
> > +{
> > +     struct evsel *evsel;
> > +     struct evsel_config_term *pos, *tmp;
> > +
> > +     BUG_ON(orig->core.fd);
> > +     BUG_ON(orig->counts);
> > +     BUG_ON(orig->priv);
> > +     BUG_ON(orig->per_pkg_mask);
> > +
> > +     /* cannot handle BPF objects for now */
> > +     if (orig->bpf_obj)
> > +             return NULL;
> > +
> > +     evsel = evsel__new(&orig->core.attr);
> > +     if (evsel == NULL)
> > +             return NULL;
> > +
> > +     evsel->core.cpus = perf_cpu_map__get(orig->core.cpus);
> > +     evsel->core.own_cpus = perf_cpu_map__get(orig->core.own_cpus);
> > +     evsel->core.threads = perf_thread_map__get(orig->core.threads);
> > +     evsel->core.nr_members = orig->core.nr_members;
> > +     evsel->core.system_wide = orig->core.system_wide;
> > +
> > +     if (orig->name)
> > +             evsel->name = strdup(orig->name);
> > +     if (orig->group_name)
> > +             evsel->group_name = strdup(orig->group_name);
> > +     if (orig->pmu_name)
> > +             evsel->pmu_name = strdup(orig->pmu_name);
> > +     if (orig->filter)
> > +             evsel->filter = strdup(orig->filter);
>
> we should check those strdup results

ok.

>
> > +     evsel->cgrp = cgroup__get(orig->cgrp);
> > +     evsel->tp_format = orig->tp_format;
> > +     evsel->handler = orig->handler;
> > +     evsel->leader = orig->leader;
> > +
> > +     evsel->max_events = orig->max_events;
> > +     evsel->tool_event = orig->tool_event;
> > +     evsel->unit = orig->unit;
> > +     evsel->scale = orig->scale;
> > +     evsel->snapshot = orig->snapshot;
> > +     evsel->per_pkg = orig->per_pkg;
> > +     evsel->percore = orig->percore;
> > +     evsel->precise_max = orig->precise_max;
> > +     evsel->use_uncore_alias = orig->use_uncore_alias;
> > +     evsel->is_libpfm_event = orig->is_libpfm_event;
> > +
> > +     evsel->exclude_GH = orig->exclude_GH;
> > +     evsel->sample_read = orig->sample_read;
> > +     evsel->auto_merge_stats = orig->auto_merge_stats;
> > +     evsel->collect_stat = orig->collect_stat;
> > +     evsel->weak_group = orig->weak_group;
>
> so all those evsel's members are possibly defined in parse time right?
> perhaps we should separate them in the struct? and make some note about
> evsel__clone function that new members should be considered for copy
> in evsel__close.. or something like that

Sounds good.

>
> > +
> > +     list_for_each_entry(pos, &orig->config_terms, list) {
> > +             tmp = malloc(sizeof(*tmp));
> > +             if (tmp == NULL) {
> > +                     evsel__delete(evsel);
> > +                     evsel = NULL;
> > +                     break;
> > +             }
> > +
> > +             *tmp = *pos;
> > +             if (tmp->free_str) {
> > +                     tmp->val.str = strdup(pos->val.str);
> > +                     if (tmp->val.str == NULL) {
> > +                             evsel__delete(evsel);
> > +                             evsel = NULL;
> > +                             free(tmp);
> > +                             break;
> > +                     }
> > +             }
> > +             list_add_tail(&tmp->list, &evsel->config_terms);
> > +     }
>
> could this go in separate function? copy_terms

Will do.

Thanks
Namhyung

>
> > +
> > +     return evsel;
> > +}
> > +
> >  /*
> >   * Returns pointer with encoded error via <linux/err.h> interface.
> >   */
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 35e3f6d66085..507c31d6a389 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -169,6 +169,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
> >       return evsel__new_idx(attr, 0);
> >  }
> >
> > +struct evsel *evsel__clone(struct evsel *orig);
> >  struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
> >
> >  /*
> > --
> > 2.28.0.618.gf4bc123cb7-goog
> >
>
