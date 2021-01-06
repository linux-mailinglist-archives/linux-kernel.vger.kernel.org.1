Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA412EBAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAFHp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:45:28 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:32841 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbhAFHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:45:27 -0500
Received: by mail-lf1-f53.google.com with SMTP id l11so4652854lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGl7n31+lmcli5gt/Id1KfpdOHI+TiVqlrww2nZOPyU=;
        b=cpunOUw8z1DJWiwTdt905Ad5/Rf+/hhAI+UNuHCO6T2o5O1QKA/Y0o3UA6T0j1bLLZ
         i4bs+P3hL92IeHUKbV/qM4FOBdP+foIFfJ7qRDN+ZmTHD8ejGU8TcR7iWNkHzJKnTqZQ
         JmPsc6gjfcuvTKGSF5l2y1aMX2jbk49IoD9lqWqDSKQLbDG146fs0b9M2ZG+vJCzEoNe
         yeiByOwdcASg1hYTWbyB16d088hE3NRqPxwiZsiac3Mnx6VrzZrkKd+2nb5ibfd5KcEf
         sGkZsV4BRKZhhMpuO9s0VgL+sSorc3sEFfpqj5plbIDmrUZA1F1Kvfa2gTWWHlWDqmNU
         Oj/A==
X-Gm-Message-State: AOAM533717j75l/2zo/hWlj/paPb/rT3i9prmFf/7b+IKtfCfBK3pHAQ
        BHp2lyCLWhfBV94h3EVCg33Ux4fECJytCg58ig4=
X-Google-Smtp-Source: ABdhPJyPJ5tO3AUUzoHpZSOeQIpfj+OxkDTSopU9ROAaNwyc6HaZ8NdBbHHGrM2ID9cHHo3Ojm7MX2xrQSBPugNO7cM=
X-Received: by 2002:a2e:bc16:: with SMTP id b22mr1695325ljf.166.1609919085635;
 Tue, 05 Jan 2021 23:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-5-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-5-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:44:34 +0900
Message-ID: <CAM9d7cjnHpZ2G5rBnCZonhfeGOS9vB1nrLLvhet_XG=f7O5ysQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] perf c2c: Rename for shared cache line stats
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
> For shared cache line statistics, it relies on HITM.  We can use more
> general naming rather than only binding to HITM, so replace "hitm_stats"
> with "shared_clines_stats" in structure perf_c2c, and rename function
> resort_hitm_cb() to resort_shared_cl_cb().
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 27745340c14a..580c4ead68db 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -97,8 +97,8 @@ struct perf_c2c {
>         bool                     symbol_full;
>         bool                     stitch_lbr;
>
> -       /* HITM shared clines stats */
> -       struct c2c_stats        hitm_stats;
> +       /* Shared clines stats */

Please change it to "Shared cache line stats".

Thanks,
Namhyung


> +       struct c2c_stats        shared_clines_stats;
>         int                     shared_clines;
>
>         int                      display;
