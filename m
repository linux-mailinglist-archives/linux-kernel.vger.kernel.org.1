Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9626D2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQFTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 01:19:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQFTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:19:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id g4so572328wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 22:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHpuAUTaCPXW51YTfA4N1UnGTafHFhHpoxgaMPqjs9s=;
        b=Gpg6BsK889xdMQGVHQfOPjZuH8zFGPgixZK1fBYs6+epjmp/29B31SsiSUtaK0QXBj
         PWnGHprinHIcRo9UrMKkwYp+a1jpgmqfbWvAjL5jLCwJ13MHkNFTVbH/UJ2DZJPoCmaY
         A2HoODwZXqcIvtA5+as46UQLGHNXEob8Qj+rOcGw5Mf6SLhcirlMvEqkEGc4T3W5ZYBs
         HwnNdlD6JL8jHZN2lraYzkwahQ7I2jOjWibmsAczRATWTl0IIPSxVLSJTdgB+gYdxfOn
         /o6p2rVi9zVviLglEnXZprD002oDPxQGYyLhkamjeZVKRP4/qXg/iCfFsDcQl1v9C8HV
         7PBw==
X-Gm-Message-State: AOAM532UHY79JJM6GDL5hPNrtwOuILU0Rq3q9fZHuaodA4/YUhQSt7/4
        asN2DZeBSLBQsrRaE8hWxPA6VXd4xM1yrRPuCEM=
X-Google-Smtp-Source: ABdhPJzJDTidFp6JFJYume7QQwdNTaBasc1JO9NMDh0McBwDKZXyYbdqUGBbMMRUDU84gGSQXqeodjxsbIuLUKX0k0w=
X-Received: by 2002:adf:a418:: with SMTP id d24mr22277038wra.80.1600319988591;
 Wed, 16 Sep 2020 22:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200917024421.46973-1-liwei391@huawei.com>
In-Reply-To: <20200917024421.46973-1-liwei391@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 14:19:37 +0900
Message-ID: <CAM9d7cgDK6n1=k+45PmdjtFf48oPRYx+rjMKWx0aiVWjyD3trg@mail.gmail.com>
Subject: Re: [PATCH] perf metric: Code cleanup with map_for_each_event()
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>, guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 17, 2020 at 11:45 AM Wei Li <liwei391@huawei.com> wrote:
>
> Since we have introduced map_for_each_event() to walk the 'pmu_events_map',
> clean up metricgroup__print() and metricgroup__has_metric() with it.
>
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

A nit-pick below:


> ---
>  tools/perf/util/metricgroup.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8831b964288f..3734cbb2c456 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -26,6 +26,17 @@
>  #include "util.h"
>  #include <asm/bug.h>
>
> +#define map_for_each_event(__pe, __idx, __map)                         \
> +       for (__idx = 0, __pe = &__map->table[__idx];                    \
> +            __pe->name || __pe->metric_group || __pe->metric_name;     \
> +            __pe = &__map->table[++__idx])
> +
> +#define map_for_each_metric(__pe, __idx, __map, __metric)              \
> +       map_for_each_event(__pe, __idx, __map)                          \
> +               if (__pe->metric_expr &&                                \
> +                   (match_metric(__pe->metric_group, __metric) ||      \
> +                    match_metric(__pe->metric_name, __metric)))
> +

You may consider adding a declaration of match_metric() here.
Right now, all users are below the function so it's ok but
having the macro here can enable future addition above IMHO.

Thanks
Namhyung


>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
>                                          bool create)
> @@ -475,12 +486,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>         groups.node_new = mep_new;
>         groups.node_cmp = mep_cmp;
>         groups.node_delete = mep_delete;
> -       for (i = 0; ; i++) {
> +       map_for_each_event(pe, i, map) {
>                 const char *g;
> -               pe = &map->table[i];
>
> -               if (!pe->name && !pe->metric_group && !pe->metric_name)
> -                       break;
>                 if (!pe->metric_expr)
>                         continue;
>                 g = pe->metric_group;
> @@ -745,17 +753,6 @@ static int __add_metric(struct list_head *metric_list,
>         return 0;
>  }
>
> -#define map_for_each_event(__pe, __idx, __map)                         \
> -       for (__idx = 0, __pe = &__map->table[__idx];                    \
> -            __pe->name || __pe->metric_group || __pe->metric_name;     \
> -            __pe = &__map->table[++__idx])
> -
> -#define map_for_each_metric(__pe, __idx, __map, __metric)              \
> -       map_for_each_event(__pe, __idx, __map)                          \
> -               if (__pe->metric_expr &&                                \
> -                   (match_metric(__pe->metric_group, __metric) ||      \
> -                    match_metric(__pe->metric_name, __metric)))
> -
>  static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
>  {
>         struct pmu_event *pe;
> @@ -1092,11 +1089,7 @@ bool metricgroup__has_metric(const char *metric)
>         if (!map)
>                 return false;
>
> -       for (i = 0; ; i++) {
> -               pe = &map->table[i];
> -
> -               if (!pe->name && !pe->metric_group && !pe->metric_name)
> -                       break;
> +       map_for_each_event(pe, i, map) {
>                 if (!pe->metric_expr)
>                         continue;
>                 if (match_metric(pe->metric_name, metric))
> --
> 2.17.1
>
