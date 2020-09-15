Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4926B400
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgIOXOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:14:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36942 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIOOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:40:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id z4so3625063wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCTqK6P89giylYESQheZKMXrbqidQgUNJIy5l2C+Qh8=;
        b=Q1NgLoRJjdqE90Nacqh18ekeSWlRwcrwGXFPlZlfBzB/VxEkqN6nU7/W2vG03iXGBh
         p6avzTp2BWh3crzfuZvNqEUQfQG+BmTxDhNDMf5zcDHqtGO5zUaD+9mSfgXtlUWVsKcD
         2kdE92IWWFSgV0w7rHaK1nTAzIvwt88pl8iwnH4mSitbGWS06QXV3cLZwZj94TJHWWz4
         2w8UoEtTUqUokVjPxN3smDyELLItzs8Hp1SaIFK2CExVBkYP2QBY+39J0XKyx/8NZJkX
         j/bZxwTZWpltjkk2beGg4x8KLaCocaFeSTXyrj6gYII1GJwQYukLriyv2Wb31WF5eDdd
         pkoQ==
X-Gm-Message-State: AOAM532SfxV4vqE8qs0bcC33yLdah5Us5Sdgg0hjjfvwdNqbEOzVwOqH
        hzdKZsw3ZspNNNEpAK+qEXjmKLqO+zo0o16MGc4=
X-Google-Smtp-Source: ABdhPJyDWRdkFWaHVyFFdwHBUQckapGLu+U4qVHRcKbCEWA/0bQbOnmpkZtGhVFMRQg8jq+1DDS//2mnwsIK+4xBsxI=
X-Received: by 2002:adf:e481:: with SMTP id i1mr21661770wrm.391.1600180807364;
 Tue, 15 Sep 2020 07:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200915031819.386559-1-namhyung@kernel.org> <20200915031819.386559-5-namhyung@kernel.org>
 <20200915121814.GE720847@kernel.org>
In-Reply-To: <20200915121814.GE720847@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 23:39:56 +0900
Message-ID: <CAM9d7chORRmiE2R4LnzGh0uS2nKqL_tk+qxV2TfeqZctvCsJ5w@mail.gmail.com>
Subject: Re: [PATCH 04/11] perf parse-event: Fix cpu map leaks
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Sep 15, 2020 at 9:18 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 15, 2020 at 12:18:12PM +0900, Namhyung Kim escreveu:
> > Like evlist cpu map, evsel's cpu map should have proper refcount by
> > releasing the original count after creation.
>
> "releasing original count after creation"?
>
> There are two fixes here, one its legit, i.e. when failing to create
> the new evsel, if you created the perf_cpu_map, drop the refcount,
> which, in this case, will free it since perf_cpu_map__new() sets it to
> 1.
>
> But what about the other? Humm, I see, since a new refcount is being
> obtained, then we need to drop the first.
>
> This all got complicated, perhaps the following patch is simpler?
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c4d2394e2b2dc60f..3dceeacf8669bc5d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -353,18 +353,20 @@ __add_event(struct list_head *list, int *idx,
>             const char *cpu_list)
>  {
>         struct evsel *evsel;
> -       struct perf_cpu_map *cpus = pmu ? pmu->cpus :
> +       struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
>                                cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>
>         if (init_attr)
>                 event_attr_init(attr);
>
>         evsel = evsel__new_idx(attr, *idx);
> -       if (!evsel)
> +       if (!evsel) {
> +               perf_cpu_map__put(cpus);
>                 return NULL;
> +       }
>
>         (*idx)++;
> -       evsel->core.cpus   = perf_cpu_map__get(cpus);
> +       evsel->core.cpus     = cpus;
>         evsel->core.own_cpus = perf_cpu_map__get(cpus);
>         evsel->core.system_wide = pmu ? pmu->is_uncore : false;
>         evsel->auto_merge_stats = auto_merge_stats;
>
>
> ---
>
> I.e. if we're going to share pmu->cpus, grab the necessary refcount at
> that point, if we're going to create one (pmu == NULL), then
> perf_cpu_map__new() will have the refcount we need (will set it to 1).
>
> Then, if we fail to create the new evsel, we just drop the refcount we
> got either from perf_cpu_map__get(pmu->cpus) or from
> perf_cpu_map__new(cpu_list) (NULL is ok for __put() operations, that
> covers that last ': NULL').
>
> And then, when we go make evsel->core.cpus share that cpu_map, we know
> we have the necessary refcount already, right?

Indeed! This looks a lot better.  Do you want me to resend?

Thanks
Namhyung


>
> No need to later on drop the one obtained previously via:
>
>   evsel->core.cpus   = perf_cpu_map__get(cpus);
>
> And we don't need to drop it later when we want to drop the extra
> refcount it gets when pmu == NULL.
>
> - Arnaldo
