Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71414274C78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgIVWvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:51:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35587 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIVWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so5000047wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM4FuUUThgGr/nHgvLB12fnWHlJG+spkwb3OFZY6Qa0=;
        b=oUi0ZLJNHyQxQI9tA2ZYqBD831EATmC8AU7JBlhFY2E+1RJTxGT4xaPHpXDrxS0x5K
         rFHXOqL9JjhOTX/Kkx12ht8UjvQ35kqeZB6nkhCPouo/k9ZO8GcRIJCLSs+F38vd8z26
         6K3aRIOg1BicBeaajVa8I+n2Oi0MpjDMejNtNJNI3+JVwh2Ja+gRqqQQ3DnLn8LHV57F
         CS3TUT3TW67rO0P3pwo1MK9WVVjonQGQfTBywm45cpTaMXUqpDGWoCi6NuKgFeHw+yqT
         iNaZ8MZjxF6akWmoLcQNbEb7CDoUXpsj06REv6+5MQQRWJ1Fud5sSQWcHoWrZeffBHMO
         rABg==
X-Gm-Message-State: AOAM531rHDEUjuQ9vl7dmEsEXJ+tDvZeEzx+5snTvQfuPbi/vmpW1Pmd
        8KvRwmJSSoLEWRoWo3eNIwNWQuciU2kHtTlu+is=
X-Google-Smtp-Source: ABdhPJyudrv5/Mhq8Ed18r1aqmKDvGf3tRaOR0WUlvXswyDhqG5r2+bMjbR9hPp9oOSOKkjxDCjP8LYNsJ7p/ywr3Tg=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr3282156wmb.70.1600815104011;
 Tue, 22 Sep 2020 15:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200921094610.83736-1-namhyung@kernel.org> <20200921094610.83736-3-namhyung@kernel.org>
 <20200922214033.GD2893484@krava>
In-Reply-To: <20200922214033.GD2893484@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 07:51:33 +0900
Message-ID: <CAM9d7ciL7LmpFyxxD20q+6JM4pE1T9hsMKvOtv-s1r+EamCDpQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf stat: Add --for-each-cgroup option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 6:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 21, 2020 at 06:46:07PM +0900, Namhyung Kim wrote:
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
> > +                             goto out_err;
> > +
> > +                     cgrp = cgroup__new(name);
> > +                     free(name);
> > +                     if (cgrp == NULL)
> > +                             goto out_err;
> > +             } else {
> > +                     cgrp = NULL;
> > +             }
> > +
> > +             leader = NULL;
> > +             evlist__for_each_entry(orig_list, pos) {
> > +                     evsel = evsel__clone(pos);
> > +                     if (evsel == NULL)
> > +                             goto out_err;
> > +
> > +                     cgroup__put(evsel->cgrp);
> > +                     evsel->cgrp = cgroup__get(cgrp);
> > +
> > +                     if (evsel__is_group_leader(pos))
> > +                             leader = evsel;
> > +                     evsel->leader = leader;
>
> hum, will this work if there's standalone event after group? like:
>
>   {cycles,instructions},cache-misses
>
> cache-misses will get cycles as group leader no?

AFAIK non-group events are treated as a leader of its own group.
So evsel__is_group_leader() will return true for cache-misses.

Thanks
Namhyung

>
> > +
> > +                     evlist__add(tmp_list, evsel);
> > +             }
> > +             /* cgroup__new() has a refcount, release it here */
> > +             cgroup__put(cgrp);
> > +             nr_cgroups++;
>
> SNIP
>
