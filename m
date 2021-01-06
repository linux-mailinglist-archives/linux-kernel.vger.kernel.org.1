Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246762EBA9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbhAFHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:38:56 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43297 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbhAFHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:38:56 -0500
Received: by mail-lf1-f50.google.com with SMTP id 23so4465256lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaWTaPrKuGxHLuSrbUx16JWxvYDa2A8QxmGFK1NeFiM=;
        b=TvRcgoYqxUJwfe60gdumv9/eaEDvank9zwkNcbKEIxBZfpjy+YRZOAS4UL7gpcm49i
         zHWyqY4rafFEI8tN/PDEHZH4XAkGw0waKdIFinRa0810FCIt5Kg+lIe5Z7fHJAikbUlU
         8ETZPQ4Umljr0p4Hj7BwPxoZwnQBtbc/tgiuguocveFogtR0dD8dDtOkM3FZ4G3w8Lzk
         H7BPJBfJJgI9E2tPrP+29nqa3yWyfYli5grTcZoPYXAH/YZ7GWiTAcR5A4QNOijsPNXv
         az+YhXsbMBUYSb8boMHgHWlAG4U0mZeRmN5VDHVgQ1GKyv9/Wb8bBq/CcRG1ovSz+pic
         AfmQ==
X-Gm-Message-State: AOAM531T+Bp3IFawBxcSatRHDduI8iSYbVSgg6fXhCF+77lRg92pf7PG
        6x6UeYeX2vMR4nmZ41BAfDgB4RPRi0UZwA891u0=
X-Google-Smtp-Source: ABdhPJx6g6Y2i2yiUSowj2mrEa/feVeQGJ4bqEvDRwwY2SzJn0rG+OIaGwm9FxrDJQWOVjOs6+rD+AWy4eK6RwTsltw=
X-Received: by 2002:a19:cc10:: with SMTP id c16mr1351606lfg.112.1609918693196;
 Tue, 05 Jan 2021 23:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-2-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-2-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:38:01 +0900
Message-ID: <CAM9d7cjMHcz_hunqKLtuKCK2BaX7NzXfE1tWCiSTxEEHz8_Jbg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] perf c2c: Add dimensions for total load hit
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

Hi,

On Sun, Dec 13, 2020 at 10:39 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> Arm SPE trace data doesn't support HITM, but we still want to explore
> "perf c2c" tool to analyze cache false sharing.  If without HITM tag,
> the tool cannot give out accurate result for cache false sharing, a
> candidate solution is to sort the total load operations and connect with
> the threads info, e.g. if multiple threads hit the same cache line for
> many times, this can give out the hint that it's likely to cause cache
> false sharing issue.
>
> Unlike having HITM tag, the proposed solution is not accurate and might
> introduce false positive reporting, but it's a pragmatic approach for
> detecting false sharing if memory event doesn't support HITM.
>
> To sort with the cache line hit, this patch adds dimensions for total
> load hit and the associated percentage calculation.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 112 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c5babeaa3b38..3d5a2dc8b4fd 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -615,6 +615,47 @@ tot_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>         return tot_hitm_left - tot_hitm_right;
>  }
>
> +#define TOT_LD_HIT(stats)              \
> +       ((stats)->ld_fbhit +            \
> +        (stats)->ld_l1hit +            \
> +        (stats)->ld_l2hit +            \
> +        (stats)->ld_llchit +           \
> +        (stats)->lcl_hitm +            \
> +        (stats)->rmt_hitm +            \
> +        (stats)->rmt_hit)

It doesn't need to be a macro, why not use a static inline function?

Thanks,
Namhyung


> +
> +static int tot_ld_hit_entry(struct perf_hpp_fmt *fmt,
> +                           struct perf_hpp *hpp,
> +                           struct hist_entry *he)
> +{
> +       struct c2c_hist_entry *c2c_he;
> +       int width = c2c_width(fmt, hpp, he->hists);
> +       unsigned int tot_hit;
> +
> +       c2c_he = container_of(he, struct c2c_hist_entry, he);
> +       tot_hit = TOT_LD_HIT(&c2c_he->stats);
> +
> +       return scnprintf(hpp->buf, hpp->size, "%*u", width, tot_hit);
> +}
> +
> +static int64_t tot_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +                             struct hist_entry *left,
> +                             struct hist_entry *right)
> +{
> +       struct c2c_hist_entry *c2c_left;
> +       struct c2c_hist_entry *c2c_right;
> +       uint64_t tot_hit_left;
> +       uint64_t tot_hit_right;
> +
> +       c2c_left  = container_of(left, struct c2c_hist_entry, he);
> +       c2c_right = container_of(right, struct c2c_hist_entry, he);
> +
> +       tot_hit_left  = TOT_LD_HIT(&c2c_left->stats);
> +       tot_hit_right = TOT_LD_HIT(&c2c_right->stats);
> +
> +       return tot_hit_left - tot_hit_right;
> +}
> +
>  #define STAT_FN_ENTRY(__f)                                     \
>  static int                                                     \
>  __f ## _entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,  \
> @@ -860,6 +901,58 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>         return per_left - per_right;
>  }
>
> +static double percent_tot_ld_hit(struct c2c_hist_entry *c2c_he)
> +{
> +       struct c2c_hists *hists;
> +       int tot = 0, st = 0;
> +
> +       hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
> +
> +       st  = TOT_LD_HIT(&c2c_he->stats);
> +       tot = TOT_LD_HIT(&hists->stats);
> +
> +       return tot ? (double) st * 100 / tot : 0;
> +}
> +
> +static int
> +percent_tot_ld_hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                        struct hist_entry *he)
> +{
> +       struct c2c_hist_entry *c2c_he;
> +       int width = c2c_width(fmt, hpp, he->hists);
> +       char buf[10];
> +       double per;
> +
> +       c2c_he = container_of(he, struct c2c_hist_entry, he);
> +       per = percent_tot_ld_hit(c2c_he);
> +       return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
> +}
> +
> +static int
> +percent_tot_ld_hit_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                        struct hist_entry *he)
> +{
> +       return percent_color(fmt, hpp, he, percent_tot_ld_hit);
> +}
> +
> +static int64_t
> +percent_tot_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> +                  struct hist_entry *left, struct hist_entry *right)
> +{
> +       struct c2c_hist_entry *c2c_left;
> +       struct c2c_hist_entry *c2c_right;
> +       double per_left;
> +       double per_right;
> +
> +       c2c_left  = container_of(left, struct c2c_hist_entry, he);
> +       c2c_right = container_of(right, struct c2c_hist_entry, he);
> +
> +       per_left  = percent_tot_ld_hit(c2c_left);
> +       per_right = percent_tot_ld_hit(c2c_right);
> +
> +       return per_left - per_right;
> +}
> +
>  static struct c2c_stats *he_stats(struct hist_entry *he)
>  {
>         struct c2c_hist_entry *c2c_he;
> @@ -1412,6 +1505,14 @@ static struct c2c_dimension dim_ld_rmthit = {
>         .width          = 8,
>  };
>
> +static struct c2c_dimension dim_tot_ld_hit = {
> +       .header         = HEADER_BOTH("Load Hit", "Total"),
> +       .name           = "tot_ld_hit",
> +       .cmp            = tot_ld_hit_cmp,
> +       .entry          = tot_ld_hit_entry,
> +       .width          = 8,
> +};
> +
>  static struct c2c_dimension dim_tot_recs = {
>         .header         = HEADER_BOTH("Total", "records"),
>         .name           = "tot_recs",
> @@ -1460,6 +1561,15 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
>         .width          = 7,
>  };
>
> +static struct c2c_dimension dim_percent_tot_ld_hit = {
> +       .header         = HEADER_BOTH("Load Hit", "Pct"),
> +       .name           = "percent_tot_ld_hit",
> +       .cmp            = percent_tot_ld_hit_cmp,
> +       .entry          = percent_tot_ld_hit_entry,
> +       .color          = percent_tot_ld_hit_color,
> +       .width          = 8,
> +};
> +
>  static struct c2c_dimension dim_percent_stores_l1hit = {
>         .header         = HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
>         .name           = "percent_stores_l1hit",
> @@ -1615,11 +1725,13 @@ static struct c2c_dimension *dimensions[] = {
>         &dim_ld_l2hit,
>         &dim_ld_llchit,
>         &dim_ld_rmthit,
> +       &dim_tot_ld_hit,
>         &dim_tot_recs,
>         &dim_tot_loads,
>         &dim_percent_hitm,
>         &dim_percent_rmt_hitm,
>         &dim_percent_lcl_hitm,
> +       &dim_percent_tot_ld_hit,
>         &dim_percent_stores_l1hit,
>         &dim_percent_stores_l1miss,
>         &dim_dram_lcl,
> --
> 2.17.1
>
