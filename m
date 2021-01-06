Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DC2EBAD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhAFHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:53:15 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46794 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbhAFHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:53:10 -0500
Received: by mail-lf1-f46.google.com with SMTP id y19so4470443lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M55FgBSzuq1qYp5wZz+TWubiV5/UNYhWSQu4F0zVd90=;
        b=qtVQbrh9l3n0nAiLJs1Z5mSOVoTygD73umyeqtoMkn6YhF8BJJoKxWF3q+6goAy4kb
         BL9ghOojhHdcH8oTAz0PXZN5A+n8tYKyt6vXRmDNST2nFs7cqEytaQUn5DgmsXH4CoxM
         +uT6gT/4KXJjGXVZaPXj4Ir0l2F3xzgFRvjyX6D/GGXEpf8PltDv6Hgu/EFS7AXsTwe7
         JgMF0atnuJArNRTpufKJcTuseQtCFaK+acvAYpWFD/hilwET4icX2Kj9d1uj+I54UiP/
         tJrWPhAzDlDHl3suZSnkZkRqIwgZsc7kyt3ungt7PllaJUCQ8mA7bpIYh8qtjmOlV3br
         bidw==
X-Gm-Message-State: AOAM530TTqRZCNLATrAHoxnmNU7LHPyJPP0lFn8tdzRmKZ3k889rKUnK
        aJrMGbCrCVnZGK0YrD9aghlvQD8vHgjcWlZnyvU=
X-Google-Smtp-Source: ABdhPJzu8BDuioXiSQtXbvDBi+Myw/syuJy3Jq/NtBVjyDhUqZTZ9q+MpTG6baAyqBqItjGOi/412awzpY3Ww2Ss+qc=
X-Received: by 2002:a19:6459:: with SMTP id b25mr1286979lfj.635.1609919546652;
 Tue, 05 Jan 2021 23:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-11-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-11-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:52:15 +0900
Message-ID: <CAM9d7cj=SDLyCgBOKfEX91s7VrWbJZa-Qn+8SuE+rzC+vGGs_A@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] perf c2c: Sort on all cache hit for load operations
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
> Except the existed three display options 'tot', 'rmt', 'lcl', this patch
> adds option 'all' so can sort on the all cache hit for load operation.
> This new introduced option can be a choice for profiling cache false
> sharing if the memory event doesn't contain HITM tags.
>
> For displaying with option 'all', the "Shared Data Cache Line Table" and
> "Shared Cache Line Distribution Pareto" both have difference comparing
> to other three display options.
>
> For the "Shared Data Cache Line Table", instead of sorting HITM metrics,
> it sorts with the metrics "tot_ld_hit" and "percent_tot_ld_hit".  If
> without HITM metrics, users can analyze the load hit statistics for all
> cache levels, so the dimensions of total load hit is used to replace
> HITM dimensions.
>
> For Pareto, every single cache line shows the metrics "cl_tot_ld_hit"
> and "cl_tot_ld_miss" instead of "cl_rmt_hitm" and "percent_lcl_hitm",
> and the single cache line view is sorted by metrics "tot_ld_hit".
>
> As result, we can get the 'all' display as follows:
>
>   # perf c2c report -d all --coalesce tid,pid,iaddr,dso --stdio
>
>   [...]
>
>   =================================================
>              Shared Data Cache Line Table
>   =================================================
>   #
>   #        ----------- Cacheline ----------  Load Hit  Load Hit    Total    Total    Total  ---- Stores ----  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt       Pct     Total  records    Loads   Stores    L1Hit   L1Miss       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  ........  ........  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0x556f25dff100     0    1895    75.73%      4591     7840     4591     3249     2633      616      849     2734       67        58      883         0        0         0         0
>         1      0x556f25dff080     0       1    13.10%       794      794      794        0        0        0      164      486       28        20       96         0        0         0         0
>         2      0x556f25dff0c0     0       1    10.01%       607      607      607        0        0        0      107        5        5       488        2         0        0         0         0
>
>   =================================================
>         Shared Cache Line Distribution Pareto
>   =================================================
>   #
>   #        --  Load Refs --  -- Store Refs --  --------- Data address ---------                                                   ---------- cycles ----------    Total       cpu                                  Shared
>   #   Num      Hit     Miss   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid                 Tid        Code address  rmt hitm  lcl hitm      load  records       cnt               Symbol             Object                  Source:Line  Node
>   # .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ..................  ........  ........  ........  .......  ........  ...................  .................  ...........................  ....
>   #
>     -------------------------------------------------------------
>         0     4591        0     2633      616      0x556f25dff100
>     -------------------------------------------------------------
>             20.52%    0.00%    0.00%    0.00%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc1d         0      2200      1276      942         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>             19.82%    0.00%   38.06%    0.00%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc16         0      2190      1130     1912         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
>             18.25%    0.00%   56.63%    0.00%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc16         0      2173      1074     2329         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:145   0
>             18.23%    0.00%    0.00%    0.00%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc1d         0      2013      1220      837         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>              0.00%    0.00%    3.11%   59.90%                 0x0     0       1    28079    28081:lock_th         0x556f25bfdc28         0         0         0      451         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>              0.00%    0.00%    2.20%   40.10%                 0x0     0       1    28079    28082:lock_th         0x556f25bfdc28         0         0         0      305         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:146   0
>             12.00%    0.00%    0.00%    0.00%                0x20     0       1    28079    28083:reader_thd      0x556f25bfdc73         0       159       107      551         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
>             11.17%    0.00%    0.00%    0.00%                0x20     0       1    28079    28084:reader_thd      0x556f25bfdc73         0       148       108      513         1  [.] read_write_func  false_sharing.exe  false_sharing_example.c:155   0
>
>   [...]
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 139 ++++++++++++++++++++++++++++-----------
>  1 file changed, 101 insertions(+), 38 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 9342c30d86ee..0df4a4a30f7a 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[SNIP]
> @@ -2502,12 +2528,21 @@ static void print_pareto(FILE *out)
>         int ret;
>         const char *cl_output;
>
> -       cl_output = "cl_num,"
> -                   "cl_rmt_hitm,"
> -                   "cl_lcl_hitm,"
> -                   "cl_stores_l1hit,"
> -                   "cl_stores_l1miss,"
> -                   "dcacheline";
> +       if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
> +           c2c.display == DISPLAY_RMT)
> +               cl_output = "cl_num,"
> +                           "cl_rmt_hitm,"
> +                           "cl_lcl_hitm,"
> +                           "cl_stores_l1hit,"
> +                           "cl_stores_l1miss,"
> +                           "dcacheline";
> +       else /* c2c.display == DISPLAY_ALL */
> +               cl_output = "cl_num,"
> +                           "cl_tot_ld_hit,"
> +                           "cl_tot_ld_miss,"
> +                           "cl_stores_l1hit,"
> +                           "cl_stores_l1miss,"
> +                           "dcacheline";

Nit: You can keep the default value as is, and add an if statement
just for the DISPLAY_ALL.

>
>         perf_hpp_list__init(&hpp_list);
>         ret = hpp_list__parse(&hpp_list, cl_output, NULL);
> @@ -2543,7 +2578,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
>                 fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
>                 first = false;
>         }
> -       fprintf(out, "  Cachelines sort on                : %s HITMs\n",
> +       fprintf(out, "  Cachelines sort on                : %s\n",
>                 display_str[c2c.display]);
>         fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
>  }
> @@ -2700,7 +2735,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
>  {
>         scnprintf(bf, size,
>                   "Shared Data Cache Line Table     "
> -                 "(%lu entries, sorted on %s HITMs)",
> +                 "(%lu entries, sorted on %s)",
>                   browser->nr_non_filtered_entries,
>                   display_str[c2c.display]);
>         return 0;
> @@ -2906,6 +2941,8 @@ static int setup_display(const char *str)
>                 c2c.display = DISPLAY_RMT;
>         else if (!strcmp(display, "lcl"))
>                 c2c.display = DISPLAY_LCL;
> +       else if (!strcmp(display, "all"))
> +               c2c.display = DISPLAY_ALL;
>         else {
>                 pr_err("failed: unknown display type: %s\n", str);
>                 return -1;
> @@ -2952,10 +2989,12 @@ static int build_cl_output(char *cl_sort, bool no_source)
>         }
>
>         if (asprintf(&c2c.cl_output,
> -               "%s%s%s%s%s%s%s%s%s%s",
> +               "%s%s%s%s%s%s%s%s%s%s%s",
>                 c2c.use_stdio ? "cl_num_empty," : "",
> -               "percent_rmt_hitm,"
> -               "percent_lcl_hitm,"
> +               c2c.display == DISPLAY_ALL ? "percent_ld_hit,"
> +                                            "percent_ld_miss," :
> +                                            "percent_rmt_hitm,"
> +                                            "percent_lcl_hitm,",
>                 "percent_stores_l1hit,"
>                 "percent_stores_l1miss,"
>                 "offset,offset_node,dcacheline_count,",
> @@ -2984,6 +3023,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
>  static int setup_coalesce(const char *coalesce, bool no_source)
>  {
>         const char *c = coalesce ?: coalesce_default;
> +       const char *sort_str = NULL;
>
>         if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
>                 return -ENOMEM;
> @@ -2991,12 +3031,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>         if (build_cl_output(c2c.cl_sort, no_source))
>                 return -1;
>
> -       if (asprintf(&c2c.cl_resort, "offset,%s",
> -                    c2c.display == DISPLAY_TOT ?
> -                    "tot_hitm" :
> -                    c2c.display == DISPLAY_RMT ?
> -                    "rmt_hitm,lcl_hitm" :
> -                    "lcl_hitm,rmt_hitm") < 0)
> +       if (c2c.display == DISPLAY_TOT)
> +               sort_str = "tot_hitm";
> +       else if (c2c.display == DISPLAY_RMT)
> +               sort_str = "rmt_hitm,lcl_hitm";
> +       else if (c2c.display == DISPLAY_LCL)
> +               sort_str = "lcl_hitm,rmt_hitm";
> +       else if (c2c.display == DISPLAY_ALL)
> +               sort_str = "tot_ld_hit";
> +
> +       if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
>                 return -ENOMEM;
>
>         pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
> @@ -3131,20 +3175,37 @@ static int perf_c2c__report(int argc, const char **argv)
>                 goto out_mem2node;
>         }
>
> -       output_str = "cl_idx,"
> -                    "dcacheline,"
> -                    "dcacheline_node,"
> -                    "dcacheline_count,"
> -                    "percent_hitm,"
> -                    "tot_hitm,lcl_hitm,rmt_hitm,"
> -                    "tot_recs,"
> -                    "tot_loads,"
> -                    "tot_stores,"
> -                    "stores_l1hit,stores_l1miss,"
> -                    "ld_fbhit,ld_l1hit,ld_l2hit,"
> -                    "ld_lclhit,lcl_hitm,"
> -                    "ld_rmthit,rmt_hitm,"
> -                    "dram_lcl,dram_rmt";
> +       if (c2c.display == DISPLAY_TOT || c2c.display == DISPLAY_LCL ||
> +           c2c.display == DISPLAY_RMT)
> +               output_str = "cl_idx,"
> +                            "dcacheline,"
> +                            "dcacheline_node,"
> +                            "dcacheline_count,"
> +                            "percent_hitm,"
> +                            "tot_hitm,lcl_hitm,rmt_hitm,"
> +                            "tot_recs,"
> +                            "tot_loads,"
> +                            "tot_stores,"
> +                            "stores_l1hit,stores_l1miss,"
> +                            "ld_fbhit,ld_l1hit,ld_l2hit,"
> +                            "ld_lclhit,lcl_hitm,"
> +                            "ld_rmthit,rmt_hitm,"
> +                            "dram_lcl,dram_rmt";
> +       else /* c2c.display == DISPLAY_ALL */
> +               output_str = "cl_idx,"
> +                            "dcacheline,"
> +                            "dcacheline_node,"
> +                            "dcacheline_count,"
> +                            "percent_tot_ld_hit,"
> +                            "tot_ld_hit,"
> +                            "tot_recs,"
> +                            "tot_loads,"
> +                            "tot_stores,"
> +                            "stores_l1hit,stores_l1miss,"
> +                            "ld_fbhit,ld_l1hit,ld_l2hit,"
> +                            "ld_lclhit,lcl_hitm,"
> +                            "ld_rmthit,rmt_hitm,"
> +                            "dram_lcl,dram_rmt";

Ditto.

Thanks,
Namhyung


>
>         if (c2c.display == DISPLAY_TOT)
>                 sort_str = "tot_hitm";
> @@ -3152,6 +3213,8 @@ static int perf_c2c__report(int argc, const char **argv)
>                 sort_str = "rmt_hitm";
>         else if (c2c.display == DISPLAY_LCL)
>                 sort_str = "lcl_hitm";
> +       else if (c2c.display == DISPLAY_ALL)
> +               sort_str = "tot_ld_hit";
>
>         c2c_hists__reinit(&c2c.hists, output_str, sort_str);
>
> --
> 2.17.1
>
