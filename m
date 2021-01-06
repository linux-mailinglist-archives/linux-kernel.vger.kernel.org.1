Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9059B2EBAA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbhAFHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:39:13 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43363 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbhAFHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:39:13 -0500
Received: by mail-lf1-f49.google.com with SMTP id 23so4466813lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TRKa4pAKx6fWOxTQunzS3oJ6Irdi2HFXNPa2soJ2mI=;
        b=o0IaDD6kou92i9uTj5yihtkD6seSy4F4nYqlMnfyrfGTJQE3c1k3jZbuCLBDetZvbC
         hUkPA0CuiO6hv1c16n3niuBmKFiB9+G63rr7JZCAsHHpvqxJPIJ7zLQvfv/mNYlKNQiK
         c2dXMdc/jr8MNZMdtg4Bj+fUSq3xYjCTuafd4F4Z23FLPZXFlmusI+6nw2NhAKzqaW0z
         KyOySuWAgUQBrBVpUl474sjRIqug0BHHelVIq7V/ObGbycgbjW30KZWhW5xjgsUMqjI7
         jDkNQ80lQkCaJ7FHSP7LDSQMBw5bAFqIE7ooOQNMx8Wp3qDvt50cPHVtTdV5+v44oACh
         OsVg==
X-Gm-Message-State: AOAM5338BOpxYNGCYauRn+3At/BW4qDMB95FJeErnlx53UXHeMrT4DTz
        wVq+3YUUL5132OQJBlQZ4dfTH1JcwXBo//GcD/U=
X-Google-Smtp-Source: ABdhPJxsgWI9E17tiZm4MdIVtGFaNGNCjdrizPG1Jc2MHpKSDKkyMrCMaVa15IuzQdHAuxnyJ5Z4dnBfOkYOcyutFqE=
X-Received: by 2002:a19:8584:: with SMTP id h126mr1335226lfd.152.1609918710779;
 Tue, 05 Jan 2021 23:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20201213133850.10070-1-leo.yan@linaro.org> <20201213133850.10070-3-leo.yan@linaro.org>
In-Reply-To: <20201213133850.10070-3-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 6 Jan 2021 16:38:19 +0900
Message-ID: <CAM9d7ch+N++TDvq57+f6VwCx66YBtU4dNc-MdbsVEkTmoM0_0w@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] perf c2c: Add dimensions for load hit
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
> Add dimensions for load hit and its percentage calculation, which is to
> be displayed in the single cache line output.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-c2c.c | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 3d5a2dc8b4fd..00014e3d81fa 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1052,6 +1052,58 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>         return per_left - per_right;
>  }
>
> +static double percent_ld_hit(struct c2c_hist_entry *c2c_he)
> +{
> +       struct c2c_hists *hists;
> +       int tot, st;
> +
> +       hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
> +
> +       st  = TOT_LD_HIT(&c2c_he->stats);
> +       tot = TOT_LD_HIT(&hists->stats);
> +
> +       return percent(st, tot);

It's not clear to me what's different than percent_tot_ld_hit().

Thanks,
Namhyung



> +}
> +
> +static int
> +percent_ld_hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                    struct hist_entry *he)
> +{
> +       struct c2c_hist_entry *c2c_he;
> +       int width = c2c_width(fmt, hpp, he->hists);
> +       char buf[10];
> +       double per;
> +
> +       c2c_he = container_of(he, struct c2c_hist_entry, he);
> +       per = percent_ld_hit(c2c_he);
> +       return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
> +}
> +
> +static int
> +percent_ld_hit_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +                    struct hist_entry *he)
> +{
> +       return percent_color(fmt, hpp, he, percent_ld_hit);
> +}
> +
> +static int64_t
> +percent_ld_hit_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
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
> +       per_left  = percent_ld_hit(c2c_left);
> +       per_right = percent_ld_hit(c2c_right);
> +
> +       return per_left - per_right;
> +}
> +
>  static int
>  percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>                            struct hist_entry *he)
> @@ -1417,6 +1469,14 @@ static struct c2c_dimension dim_cl_rmt_hitm = {
>         .width          = 7,
>  };
>
> +static struct c2c_dimension dim_cl_tot_ld_hit = {
> +       .header         = HEADER_SPAN("--- Load ---", "Hit", 1),
> +       .name           = "cl_tot_ld_hit",
> +       .cmp            = tot_ld_hit_cmp,
> +       .entry          = tot_ld_hit_entry,
> +       .width          = 7,
> +};
> +
>  static struct c2c_dimension dim_cl_lcl_hitm = {
>         .header         = HEADER_SPAN_LOW("Lcl"),
>         .name           = "cl_lcl_hitm",
> @@ -1570,6 +1630,15 @@ static struct c2c_dimension dim_percent_tot_ld_hit = {
>         .width          = 8,
>  };
>
> +static struct c2c_dimension dim_percent_ld_hit = {
> +       .header         = HEADER_SPAN("--  Load Refs --", "Hit", 1),
> +       .name           = "percent_ld_hit",
> +       .cmp            = percent_ld_hit_cmp,
> +       .entry          = percent_ld_hit_entry,
> +       .color          = percent_ld_hit_color,
> +       .width          = 7,
> +};
> +
>  static struct c2c_dimension dim_percent_stores_l1hit = {
>         .header         = HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
>         .name           = "percent_stores_l1hit",
> @@ -1715,6 +1784,7 @@ static struct c2c_dimension *dimensions[] = {
>         &dim_rmt_hitm,
>         &dim_cl_lcl_hitm,
>         &dim_cl_rmt_hitm,
> +       &dim_cl_tot_ld_hit,
>         &dim_tot_stores,
>         &dim_stores_l1hit,
>         &dim_stores_l1miss,
> @@ -1731,6 +1801,7 @@ static struct c2c_dimension *dimensions[] = {
>         &dim_percent_hitm,
>         &dim_percent_rmt_hitm,
>         &dim_percent_lcl_hitm,
> +       &dim_percent_ld_hit,
>         &dim_percent_tot_ld_hit,
>         &dim_percent_stores_l1hit,
>         &dim_percent_stores_l1miss,
> --
> 2.17.1
>
