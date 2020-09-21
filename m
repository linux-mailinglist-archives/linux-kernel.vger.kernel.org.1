Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0569F271AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIUGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:34:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39983 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgIUGe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:34:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id j2so11432182wrx.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Tvr9efTQIoHqgeaBZSiK3D68PqY1DgJ9JT/UbbWNyE=;
        b=jfZMd+UnEvOumQkmt9IPdnnlKMK/b8B0jS/M1kcLFvp6JCTFutzUjKRSPzyPISbWI5
         xGBrvnJJ+YqXGqnX1YRK7BWkmSU2cv0ylYvL0I8uF1xPum3XcoUw0CK4cvotKsenoxu8
         2GkJCusbLdKF5KLiLhZRZ8FxRb5MYR0/RExGUHG/gZ1WCuSuUR3I27RJPkXztNjsS2dG
         +fE71FnrVzxN91HT3CA3qZjaaBKGMSD4taYsVXY263edCHffLWF0aFz8VbNOuT6DYrV5
         dNI5sUzIk7nkFQENsOog6YvjCVLd/Q8rJIlSsa6wiXU+M4Ar1xFrxLb4WhRrkJOCPnMN
         QY3g==
X-Gm-Message-State: AOAM532pKYnXxjaCL+IHWwEVxpeT/IccEyNEwebe893Op7c7rfhfCcIM
        t0iuOZYpGZthmawOw3fGEc+GGlpWmuD4NMi/LeKofED+
X-Google-Smtp-Source: ABdhPJxOXYl2SemyS3dAeJT7fIH9M4pl+bRvz9PmDU4TD7GRUONCM+FTTjKunmTOZa7fpY1GeggGnA0bUi02R0ZFlzI=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr50807495wra.21.1600670093732;
 Sun, 20 Sep 2020 23:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200909055849.469612-1-namhyung@kernel.org> <20200909055849.469612-3-namhyung@kernel.org>
In-Reply-To: <20200909055849.469612-3-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Sep 2020 15:34:42 +0900
Message-ID: <CAM9d7cgh_O0bB8G8261AqLR7PO5vr-ethwc4LFvFU_1FCEa73Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Add 'pfm' to list libpfm4 events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can you please take a look at this?

Thanks
Namhyung


On Wed, Sep 9, 2020 at 2:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Print libpfm4 events with 'perf list pfm' command like others.
> When libpfm4 support is not enabled, it'd print nothing.
> Also it support glob pattern matching for event name.
>
>   $ perf list pfm
>
>   List of pre-defined events (to be used in --pfm-events):
>
>   ix86arch:
>     UNHALTED_CORE_CYCLES
>       [count core clock cycles whenever the clock signal ...
>     INSTRUCTION_RETIRED
>       [count the number of instructions at retirement. ...
>     ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 10ab5e40a34f..167868053fe0 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -14,6 +14,7 @@
>  #include "util/pmu.h"
>  #include "util/debug.h"
>  #include "util/metricgroup.h"
> +#include "util/pfm.h"
>  #include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
>  #include <stdio.h>
> @@ -42,7 +43,7 @@ int cmd_list(int argc, const char **argv)
>                 OPT_END()
>         };
>         const char * const list_usage[] = {
> -               "perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]",
> +               "perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|pfm|event_glob]",
>                 NULL
>         };
>
> @@ -53,7 +54,7 @@ int cmd_list(int argc, const char **argv)
>
>         setup_pager();
>
> -       if (!raw_dump && pager_in_use())
> +       if (!raw_dump && pager_in_use() && (argc != 1 || strcmp(argv[0], "pfm")))
>                 printf("\nList of pre-defined events (to be used in -e):\n\n");
>
>         if (argc == 0) {
> @@ -89,6 +90,8 @@ int cmd_list(int argc, const char **argv)
>                         metricgroup__print(true, false, NULL, raw_dump, details_flag);
>                 else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
>                         metricgroup__print(false, true, NULL, raw_dump, details_flag);
> +               else if (strcmp(argv[i], "pfm") == 0)
> +                       print_libpfm_events(NULL, raw_dump, long_desc_flag);
>                 else if ((sep = strchr(argv[i], ':')) != NULL) {
>                         int sep_idx;
>
> @@ -120,6 +123,7 @@ int cmd_list(int argc, const char **argv)
>                         print_tracepoint_events(NULL, s, raw_dump);
>                         print_sdt_events(NULL, s, raw_dump);
>                         metricgroup__print(true, true, s, raw_dump, details_flag);
> +                       print_libpfm_events(s, raw_dump, long_desc_flag);
>                         free(s);
>                 }
>         }
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 772f1057647f..ae8ab930a792 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2593,7 +2593,7 @@ static struct option __record_options[] = {
>                      "number of threads to run for event synthesis"),
>  #ifdef HAVE_LIBPFM
>         OPT_CALLBACK(0, "pfm-events", &record.evlist, "event",
> -               "libpfm4 event selector. use 'perf list' to list available events",
> +               "libpfm4 event selector. use 'perf list pfm' to list available events",
>                 parse_libpfm_events_option),
>  #endif
>         OPT_CALLBACK(0, "control", &record.opts, "fd:ctl-fd[,ack-fd]",
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 483a28ef4ec4..a672d2b68e8a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1166,7 +1166,7 @@ static struct option stat_options[] = {
>                     "threads of same physical core"),
>  #ifdef HAVE_LIBPFM
>         OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
> -               "libpfm4 event selector. use 'perf list' to list available events",
> +               "libpfm4 event selector. use 'perf list pfm' to list available events",
>                 parse_libpfm_events_option),
>  #endif
>         OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd]",
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 7c64134472c7..d6adc7d34210 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1578,7 +1578,7 @@ int cmd_top(int argc, const char **argv)
>                     "Enable LBR callgraph stitching approach"),
>  #ifdef HAVE_LIBPFM
>         OPT_CALLBACK(0, "pfm-events", &top.evlist, "event",
> -               "libpfm4 event selector. use 'perf list' to list available events",
> +               "libpfm4 event selector. use 'perf list pfm' to list available events",
>                 parse_libpfm_events_option),
>  #endif
>         OPTS_EVSWITCH(&top.evswitch),
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c4d2394e2b2d..2d426a4f3bc7 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2899,7 +2899,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
>
>         metricgroup__print(true, true, NULL, name_only, details_flag);
>
> -       print_libpfm_events(name_only, long_desc);
> +       print_libpfm_events(NULL, name_only, long_desc);
>  }
>
>  int parse_events__is_hardcoded_term(struct parse_events_term *term)
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index d735acb6c29c..26ae2c8c0932 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -12,6 +12,7 @@
>  #include "util/parse-events.h"
>  #include "util/pmu.h"
>  #include "util/pfm.h"
> +#include "util/string2.h"
>
>  #include <string.h>
>  #include <linux/kernel.h>
> @@ -227,7 +228,7 @@ print_libpfm_events_raw(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
>                 printf("%s::%s\n", pinfo->name, info->name);
>  }
>
> -void print_libpfm_events(bool name_only, bool long_desc)
> +void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc)
>  {
>         pfm_event_info_t info;
>         pfm_pmu_info_t pinfo;
> @@ -265,6 +266,9 @@ void print_libpfm_events(bool name_only, bool long_desc)
>                         if (ret != PFM_SUCCESS)
>                                 continue;
>
> +                       if (event_glob && !strglobmatch_nocase(info.name, event_glob))
> +                               continue;
> +
>                         if (!name_only && !printed_pmu) {
>                                 printf("%s:\n", pinfo.name);
>                                 printed_pmu = true;
> diff --git a/tools/perf/util/pfm.h b/tools/perf/util/pfm.h
> index 7d70dda87012..036e2d97b260 100644
> --- a/tools/perf/util/pfm.h
> +++ b/tools/perf/util/pfm.h
> @@ -13,7 +13,7 @@
>  int parse_libpfm_events_option(const struct option *opt, const char *str,
>                         int unset);
>
> -void print_libpfm_events(bool name_only, bool long_desc);
> +void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc);
>
>  #else
>  #include <linux/compiler.h>
> @@ -26,7 +26,8 @@ static inline int parse_libpfm_events_option(
>         return 0;
>  }
>
> -static inline void print_libpfm_events(bool name_only __maybe_unused,
> +static inline void print_libpfm_events(const char *event_glob __maybe_unused,
> +                                      bool name_only __maybe_unused,
>                                        bool long_desc __maybe_unused)
>  {
>  }
> --
> 2.28.0.526.ge36021eeef-goog
>
