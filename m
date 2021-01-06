Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B932EBAAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAFHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:48:44 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45447 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:48:43 -0500
Received: by mail-lf1-f46.google.com with SMTP id x20so4484537lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY8rQMdkez82SvmQKDstko0q63KXZmXlI+Jjtgb+LpU=;
        b=GssgNY6lMQS8QvIbSn6GH0i3WSwg4JgdVi8IqGqLSmPG+2DLyTL5DC3//9K0wsvVrb
         1P1/R2VsaAaKDZf08BJFugyKF/CCPPdqVw+qZX5nvherOywavCqbPXH6tSJnGzGpLgnL
         ZuO0GTz+X5ztH07utDaKy0mQy0lsM5LpdhAWr1QYqfUrH7lZ2boVT/m6kCw0g9PhhKnw
         Rp/jHPIYIJDPS9xklHJWRZWeGS7mo2meFC2PmWrRYoEqR+9UzCs905XV9V/yEIqrl1Ra
         Am2oKmlvBWgmqrDQbojnHzp+OK+7CWbdw4ODTdvgUwFjPeZKOLKKwZv6f5AsMZrCyFIr
         Xi9A==
X-Gm-Message-State: AOAM530jMRxwntTRH+1PWVa1sNRZKakWTvv9FDF7qIo78D7jUqVQ7tez
        DiAkWiUo0aQTVWUIcj7XwgwWvHgdu7vxnzjT+XU=
X-Google-Smtp-Source: ABdhPJyd4B3ex8ITA65izmoN4uUWfoFVK+/mbD85dIRf0nZL6ldTPZV0dpwXb7uucRJ/6Slc9kVgnbqSvnoVOVQkqp8=
X-Received: by 2002:a19:3f47:: with SMTP id m68mr1409903lfa.494.1609919281088;
 Tue, 05 Jan 2021 23:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-8-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-8-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:47:49 +0900
Message-ID: <CAM9d7cj4z6KxYLS1Envcsir9wBJgHujXq3-86PEGk-7zAbyvsQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] perf c2c: Refactor node display macro
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
> The macro DISPLAY_HITM() is used to calculate HITM percentage introduced
> by every node and it's shown for the node info.
>
> This patch refactors the macro, it is renamed it as DISPLAY_METRICS().
> And the parameters is changed for passing the metric's statistic value
> and the sum value, this is flexsible for later's extension, e.g. it's
> easier to be used for metrics which combines multiple fields from
> structure c2c_stats.

Same as the previous one.

Thanks,
Namhyung


>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f11c3c84bb2b..50018bfb1089 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1324,23 +1324,26 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
>                         ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
>                         advance_hpp(hpp, ret);
>
> -               #define DISPLAY_HITM(__h)                                               \
> -                       if (c2c_he->stats.__h> 0) {                                     \
> +               #define DISPLAY_METRICS(val, sum)                                       \
> +               {                                                                       \
> +                       if ((sum) > 0) {                                                \
>                                 ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",        \
> -                                               percent(stats->__h, c2c_he->stats.__h));\
> +                                               percent((val), (sum)));                 \
>                         } else {                                                        \
>                                 ret = scnprintf(hpp->buf, hpp->size, "%6s ", "n/a");    \
> -                       }
> +                       }                                                               \
> +               }
>
>                         switch (c2c.display) {
>                         case DISPLAY_RMT:
> -                               DISPLAY_HITM(rmt_hitm);
> +                               DISPLAY_METRICS(stats->rmt_hitm, c2c_he->stats.rmt_hitm);
>                                 break;
>                         case DISPLAY_LCL:
> -                               DISPLAY_HITM(lcl_hitm);
> +                               DISPLAY_METRICS(stats->lcl_hitm, c2c_he->stats.lcl_hitm);
>                                 break;
>                         case DISPLAY_TOT:
> -                               DISPLAY_HITM(tot_hitm);
> +                               DISPLAY_METRICS(stats->tot_hitm, c2c_he->stats.tot_hitm);
> +                               break;
>                         default:
>                                 break;
>                         }
> --
> 2.17.1
>
