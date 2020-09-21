Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB9271A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIUFpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:45:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIUFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:45:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id x23so10836451wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Knp9xibE5kKTDBR3yjFwgTbBNDr2LamRFnbTQlA9cI=;
        b=ZFryI8U4L6tWKVQ2j8EUd0DymtV9dgsWcYckgftHrhuVOzYKqzhOgpBPgag62xbMwF
         +twsH/fPq4fzhAZa1cbgE82XrEvmAZpheJH4HGZa7FR5297Ao5PNaPI3zs7JSG0FVWd8
         O3fPeIMKXGMw36q+rMEI0jMHQO01sWsaA5Iqx5eFreQSu3/2pGqZbuQe4o1e7qoctclR
         rI6K38tlp1ujIqrEQBXVfW81wB0icQWAa1YW+qmxsbTHI84uo7eKLEH6PxipMfka/79P
         dxxbCvS00ycjJn95BUY4xF6xh4qJlSupdH2ZUIGeMU/Ao4Bxb7MdErJYpYraxz/FHlzR
         8VYA==
X-Gm-Message-State: AOAM5311ANpaY8dGhxn1l3PppM9wmEVQVd+g1SWHkMdE13Xq9F3SXuLH
        l8XCQSvbbzuV6uTHOH9W+WI1fLk/wIUgjbx9ysipcgpM
X-Google-Smtp-Source: ABdhPJzPvrcKlIGZ+oNLJdZNKronfLueqfp4IK0R8GhL11I8B5Nh7due36Vsg1qOFb3S4mwMRehdsHlpRdAvnTduK5o=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr29332378wmt.92.1600667139618;
 Sun, 20 Sep 2020 22:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200916063129.1061487-1-namhyung@kernel.org> <20200916063129.1061487-3-namhyung@kernel.org>
 <20200918133439.GB2626435@krava>
In-Reply-To: <20200918133439.GB2626435@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Sep 2020 14:45:28 +0900
Message-ID: <CAM9d7chyg_h7aZ9ONwu7qH4mD9p=nLSrHpdubUptMk=8S7i79g@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf stat: Add --for-each-cgroup option
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

On Fri, Sep 18, 2020 at 10:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 16, 2020 at 03:31:27PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +int evlist__expand_cgroup(struct evlist *evlist, const char *str)
> > +{
> > +     struct evlist *orig_list, *tmp_list;
> > +     struct evsel *pos, *evsel, *leader;
> > +     struct cgroup *cgrp = NULL;
> > +     const char *p, *e, *eos = str + strlen(str);
> > +     int ret = -1;
> > +
> > +     if (evlist->core.nr_entries == 0) {
> > +             fprintf(stderr, "must define events before cgroups\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     orig_list = evlist__new();
> > +     tmp_list = evlist__new();
> > +     if (orig_list == NULL || tmp_list == NULL) {
> > +             fprintf(stderr, "memory allocation failed\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* save original events and init evlist */
> > +     perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
> > +     evlist->core.nr_entries = 0;
> > +
> > +     for (;;) {
> > +             p = strchr(str, ',');
> > +             e = p ? p : eos;
> > +
> > +             /* allow empty cgroups, i.e., skip */
> > +             if (e - str) {
> > +                     /* termination added */
> > +                     char *name = strndup(str, e - str);
> > +                     if (!name)
> > +                             break;
> > +
> > +                     cgrp = cgroup__new(name);
> > +                     free(name);
> > +                     if (cgrp == NULL)
> > +                             break;
> > +             } else {
> > +                     cgrp = NULL;
> > +             }
> > +
> > +             leader = NULL;
> > +             evlist__for_each_entry(orig_list, pos) {
> > +                     evsel = evsel__clone(pos);
>
> missing check on evsel == NULL

Will check.

Thanks
Namhyung


> > +                     cgroup__put(evsel->cgrp);
> > +                     evsel->cgrp = cgroup__get(cgrp);
> > +
> > +                     if (evsel__is_group_leader(pos))
> > +                             leader = evsel;
> > +                     evsel->leader = leader;
> > +
> > +                     evlist__add(tmp_list, evsel);
> > +             }
> > +             /* cgroup__new() has a refcount, release it here */
> > +             cgroup__put(cgrp);
> > +             nr_cgroups++;
> > +
> > +             perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
> > +             tmp_list->core.nr_entries = 0;
> > +
> > +             if (!p) {
> > +                     ret = 0;
> > +                     break;
> > +             }
> > +             str = p+1;
> > +     }
> > +     evlist__delete(orig_list);
> > +     evlist__delete(tmp_list);
> > +
> > +     return ret;
> > +}
>
> SNIP
>
