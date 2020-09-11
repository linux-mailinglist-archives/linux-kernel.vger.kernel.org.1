Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A898265796
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 05:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIKDii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 23:38:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgIKDiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:38:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id e11so3163972wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubpubHMmpIK4k+lKnVJwMufxG2srCcv3kA9sPBkOZNQ=;
        b=DfTxxLZS13eXx6aNlJiQZd68PoqODMbA/uKDPgKlawzFSqM/b8LWj9Cgh4rVVYiazn
         HQXVlFnamqZ0JG9g4CuvPF+fNSi/htavkPdwJIIUWyGiyu1enS2d4QpFByJ80wtvQdkb
         aw2B86hOab9IDNJ55GQw7iFp8hXl4mV1Oh+pyx/nVoPLWeJDJmGqcV5VShXSrrHLg4MN
         p5tmDiU/ordYEoigJs1JokD+RMcW0DVPJzdABzJo0jCPb3pvn8upRzHfXFxzAL48jWMQ
         flvv7UugbKrGHH/oyWJhyQ9tEUs/wPT3iPUOkk4kZe4eZu5jtdzaUywWJPk0ygb2lN8+
         HwBQ==
X-Gm-Message-State: AOAM531gVTWV8k1OUZamxgsigBVIw+AghiFiBk74LYz8B1kvwk5yOvWt
        G7bgKDrvx9wEj/+qU3HmOvIHJilnBJgTSvSVqbI=
X-Google-Smtp-Source: ABdhPJx4fBS16ussmvLUlYyfdsg1yC2CywxxdPPdPG27b9awQkH8C+NFSa9OZGZzyRNvuQ4MaA76bTC36+zs2JVUoiM=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr55243wmt.92.1599795479622;
 Thu, 10 Sep 2020 20:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134501.11352-1-kan.liang@linux.intel.com> <20200910134501.11352-4-kan.liang@linux.intel.com>
In-Reply-To: <20200910134501.11352-4-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 11 Sep 2020 12:37:48 +0900
Message-ID: <CAM9d7ci1p1Ej-9=RuJLHJWQ76GR6gjHS2Y=rsQQ0LhNW5YKUBg@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] perf stat: Support new per thread TopDown metrics
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 10, 2020 at 10:48 PM <kan.liang@linux.intel.com> wrote:
>
> From: Andi Kleen <ak@linux.intel.com>
>
> Icelake has support for reporting per thread TopDown metrics.
> These are reported differently than the previous TopDown support,
> each metric is standalone, but scaled to pipeline "slots".
> We don't need to do anything special for HyperThreading anymore.
> Teach perf stat --topdown to handle these new metrics and
> print them in the same way as the previous TopDown metrics.
> The restrictions of only being able to report information per core is
> gone.
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  7 +-
>  tools/perf/builtin-stat.c              | 30 ++++++++-
>  tools/perf/util/stat-shadow.c          | 89 ++++++++++++++++++++++++++
>  tools/perf/util/stat.c                 |  4 ++
>  tools/perf/util/stat.h                 |  8 +++
>  5 files changed, 134 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index c9bfefc051fb..e803dbdc88a8 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -357,6 +357,11 @@ if the workload is actually bound by the CPU and not by something else.
>  For best results it is usually a good idea to use it with interval
>  mode like -I 1000, as the bottleneck of workloads can change often.
>
> +This enables --metric-only, unless overridden with --no-metric-only.
> +
> +The following restrictions only apply to older Intel CPUs and Atom,
> +on newer CPUs (IceLake and later) TopDown can be collected for any thread:
> +
>  The top down metrics are collected per core instead of per
>  CPU thread. Per core mode is automatically enabled
>  and -a (global monitoring) is needed, requiring root rights or
> @@ -368,8 +373,6 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
>  for best results. Otherwise the bottlenecks may be inconsistent
>  on workload with changing phases.
>
> -This enables --metric-only, unless overridden with --no-metric-only.
> -
>  To interpret the results it is usually needed to know on which
>  CPUs the workload runs on. If needed the CPUs can be forced using
>  taskset.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5583e22ca808..6290da5bd142 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -128,6 +128,15 @@ static const char * topdown_attrs[] = {
>         NULL,
>  };
>
> +static const char *topdown_metric_attrs[] = {
> +       "slots",
> +       "topdown-retiring",
> +       "topdown-bad-spec",
> +       "topdown-fe-bound",
> +       "topdown-be-bound",
> +       NULL,
> +};
> +
>  static const char *smi_cost_attrs = {
>         "{"
>         "msr/aperf/,"
> @@ -1691,6 +1700,24 @@ static int add_default_attributes(void)
>                 char *str = NULL;
>                 bool warn = false;
>
> +               if (!force_metric_only)
> +                       stat_config.metric_only = true;
> +
> +               if (topdown_filter_events(topdown_metric_attrs, &str, 1) < 0) {
> +                       pr_err("Out of memory\n");
> +                       return -1;
> +               }
> +               if (topdown_metric_attrs[0] && str) {
> +                       if (!stat_config.interval && !stat_config.metric_only) {
> +                               fprintf(stat_config.output,
> +                                       "Topdown accuracy may decrease when measuring long periods.\n"
> +                                       "Please print the result regularly, e.g. -I1000\n");
> +                       }
> +                       goto setup_metrics;
> +               }
> +
> +               str = NULL;

zfree(&str) ?

Thanks
Namhyung


> +
>                 if (stat_config.aggr_mode != AGGR_GLOBAL &&
>                     stat_config.aggr_mode != AGGR_CORE) {
>                         pr_err("top down event configuration requires --per-core mode\n");
> @@ -1702,8 +1729,6 @@ static int add_default_attributes(void)
>                         return -1;
>                 }
>
> -               if (!force_metric_only)
> -                       stat_config.metric_only = true;
>                 if (topdown_filter_events(topdown_attrs, &str,
>                                 arch_topdown_check_group(&warn)) < 0) {
>                         pr_err("Out of memory\n");
> @@ -1712,6 +1737,7 @@ static int add_default_attributes(void)
>                 if (topdown_attrs[0] && str) {
>                         if (warn)
>                                 arch_topdown_group_warn();
> +setup_metrics:
>                         err = parse_events(evsel_list, str, &errinfo);
>                         if (err) {
>                                 fprintf(stderr,
