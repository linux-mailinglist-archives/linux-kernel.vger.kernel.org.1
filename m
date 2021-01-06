Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511F82EBAA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbhAFHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:47:54 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40207 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAFHry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:47:54 -0500
Received: by mail-lf1-f46.google.com with SMTP id m12so4554494lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHIIs0kA+PhcyDq6i5Q+pTYkIe6zZ4pBlyld72Kz97Y=;
        b=ubXAqb8HDGcOAunp6atzHOyYN5lKm/tpRRjtvNIDrF35WUxltFxq71hk+UQfjf3vqo
         DpoYxLaFP90AsKnuklHcrA0/ubEGIOHW9YMKFdXWk6V5kQ9YQ7z9p4AvmkT9C6WB4wES
         qxOZvU8qcakqC7osp4rmjRwDMlNeibAIfq+pzV0paBmIyDhA7ZfnqwOA2lfIScSbsaBd
         Odnb6F2DG2SjdtBmSwdTPWYcT2JoUTcVxqHc5XAtYvka9E5tBgOXoURZkDrFvtDxGLk2
         IWTOI9t+YtiYENzYGW5NsmxO484GxYUeASLo2YLZSyoAWj3YCRYT4xSIvuUw/0NlPLCk
         K2ng==
X-Gm-Message-State: AOAM5303G7q3S9tMB0Kk/aHoBgbETtoA1uLZHMamO7i4crfudkQHy9tc
        5D+EafGe0iHiIyRLAGlppgWP4UHBG5aqB7YNDvk=
X-Google-Smtp-Source: ABdhPJwRRIR7LQcmaObKX1C4G1NDauzvxujf0TKiqYD+/AmMxgfvf+h0oOaxlMhoKC/ZZ5onlX47W4+MMetj8TfxMI8=
X-Received: by 2002:a2e:908:: with SMTP id 8mr1631810ljj.52.1609919231911;
 Tue, 05 Jan 2021 23:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-7-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-7-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:47:00 +0900
Message-ID: <CAM9d7cgg07RCthbLohwDiw4yvTdzR9ZZfRpZ5PgEg24EQiz_Ow@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] perf c2c: Refactor display filter macro
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> When sort on the respective metrics (lcl_hitm, rmt_hitm, tot_hitm),
> macro FILTER_HITM is to filter out the cache line entries if its
> overhead is less than 1%.
>
> This patch is to refactor macro FILTER_HITM.  It uses more gernal name
> FILTER_DISPLAY to replace the old name; and refines its parameter,
> rather than passing field name for the data structure, it changes to
> pass the cache line's statistic value and the sum value, this is more
> flexsible, e.g. if consider to extend for sorting on all load hits
> which combines multiple fields from structure c2c_stats.

As it doesn't use field names anymore, I think it's better to change it to
a static function.

Thanks,
Namhyung


>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 5cd30c083d6c..f11c3c84bb2b 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2151,24 +2151,27 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
>
>         c2c_he = container_of(he, struct c2c_hist_entry, he);
>
> -#define FILTER_HITM(__h)                                               \
> -       if (stats->__h) {                                               \
> -               ld_dist = ((double)c2c_he->stats.__h / stats->__h);     \
> +#define FILTER_DISPLAY(val, sum)                                       \
> +{                                                                      \
> +       if ((sum)) {                                                    \
> +               ld_dist = ((double)(val) / (sum));                      \
>                 if (ld_dist < DISPLAY_LINE_LIMIT)                       \
>                         he->filtered = HIST_FILTER__C2C;                \
>         } else {                                                        \
>                 he->filtered = HIST_FILTER__C2C;                        \
> -       }
> +       }                                                               \
> +}
>
>         switch (c2c.display) {
>         case DISPLAY_LCL:
> -               FILTER_HITM(lcl_hitm);
> +               FILTER_DISPLAY(c2c_he->stats.lcl_hitm, stats->lcl_hitm);
>                 break;
>         case DISPLAY_RMT:
> -               FILTER_HITM(rmt_hitm);
> +               FILTER_DISPLAY(c2c_he->stats.rmt_hitm, stats->rmt_hitm);
>                 break;
>         case DISPLAY_TOT:
> -               FILTER_HITM(tot_hitm);
> +               FILTER_DISPLAY(c2c_he->stats.tot_hitm, stats->tot_hitm);
> +               break;
>         default:
>                 break;
>         }
> --
> 2.17.1
>
