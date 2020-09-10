Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38434263C88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 07:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgIJFil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 01:38:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40426 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIJFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:38:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so4452166wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0IKk5A8Ddwe1I0cps4iohkJjESUAHH8DibnzKq3xHg=;
        b=Us52DaG3tYY3p/kYl89dlFjh+i3aC+ln9diEXQlikUoDlK0Ck+Dp981uzbiHBUwVqm
         2JKHNZqdY70jBIeCC/z+zz3S6FCr+2Aw30tV1Cg/0Uca79l1ucmcA5GkAmgCoINpK2D6
         a6H9CAoF8mxzRVCaPAh+mXgl13LUGjb2lk06/GFts4mcRVR1TYfGzGXrugYg2iJ3HC+f
         VaWgiVUrH/CcdWEZwj4Eh9IDD2c6jQCK7on2YWsL/2g8nIF2m3muj4kmIvubnFvKAoTn
         IJsJeWZS/RNZOf5Lh2IHEAHf+52kN7EbXq+8ScehuQlrxMkC+rxUNiZ3/2Bxxg7GdI5Z
         KjiA==
X-Gm-Message-State: AOAM5339buEy4kqh+jORmjc8th/VmPIV+To3j6Hu/wDaHJ9nAjTb90Ba
        SmhwZK8kIqKUpDF5Uw9DHqoo9svNt4xv7WTgVWF9OqDBEVs=
X-Google-Smtp-Source: ABdhPJySeSnbY2+3kQdt0814xx3nSlNoSOCyp1iMBcpX/TclXX/XV+fNq1AkFEyn2CB7iiTjJ4rID85OvuKm8GrpHMQ=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr6966177wmt.92.1599716315707;
 Wed, 09 Sep 2020 22:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200910032632.511566-1-irogers@google.com>
In-Reply-To: <20200910032632.511566-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 14:38:24 +0900
Message-ID: <CAM9d7cjhExNbkUwbg8vVAAj3KSOoJFVTRmG+28S8H9=0pCb4xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf stat: Remove dead code
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Sep 10, 2020 at 12:26 PM Ian Rogers <irogers@google.com> wrote:
>
> No need to set os.evsel twice.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Btw, I think setting the 'out' variable can be moved out of the loop.

Thanks
Namhyung

> ---
>  tools/perf/util/stat-display.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 493ec372fdec..4b57c0c07632 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -946,7 +946,6 @@ static void print_metric_headers(struct perf_stat_config *config,
>                 out.print_metric = print_metric_header;
>                 out.new_line = new_line_metric;
>                 out.force_header = true;
> -               os.evsel = counter;
>                 perf_stat__print_shadow_stats(config, counter, 0,
>                                               0,
>                                               &out,
> --
> 2.28.0.526.ge36021eeef-goog
>
