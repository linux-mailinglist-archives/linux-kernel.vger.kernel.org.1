Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064542D2F34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgLHQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgLHQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:13:56 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4133EC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 08:13:16 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t22so20388089ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkQDFtS2p5U84JemgJMkV8dw3Gxwd4lRuZhCZshwQFc=;
        b=NzOub13HrLShnK7PITsRVdLQXYgUORIA5WOsJQysQ5QsGkr4kZUwCeCb+c0oI6bwNh
         ZNZIQzzYNdyqbXGBs2q1P78blDmtjwSrr6aMpwisIPqokcWhkKsncaVdUgSfmOavrwUC
         GwU5fE54m+lc+/z1lLhjILU6NZ3TbKuWmdFaemy84lpw5En3hTdBj+o3mMWTFEmJ3KNZ
         L1tTVGWuxm2X0naEo8RZCPbj19i3h+ihkTnmV6BIerFiulCwhzdVMaFp8VpoV+WcqJmX
         LirlV6Lhu2GbgOiiIWd5xP3Z9j4yD/TKodytE1GoeMYpvLiZ+2GXJnMxk9h/WDQMTdrA
         devw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkQDFtS2p5U84JemgJMkV8dw3Gxwd4lRuZhCZshwQFc=;
        b=m6Jkd7CRf/RqQxjoOS9oYtgpGsefXoNI7eigx+XJm0AdTRdkddxnawmJaNrm7kOvcd
         ySyXNHY27biSCk0hfcaueyMwV3eoPgbIFguFALsQtsS2WaeH5KQqHfKXUHUJuah/dlhI
         CRLfcZDIiuAtsIaAJklH3miF85d05LFmg3yShhlKFE+vFlR52qWLMzsoMCdQFtpMRUvM
         30gRhj4TzqMOUxav4in7/l9e4tYJiKMh+rlGm849x/iTJGwfHYd3ESIUgEL/s/LDyKPO
         8xDSstlCoVZfNJRoC+xTVu3gGsptdTO+AjIl3ulxB54SXmTuP4b6IOOIS6ZyFLb7xfgb
         kwOQ==
X-Gm-Message-State: AOAM531bu6nOz+w/swrmGuzq2HBaTb6hY38ijpGFs5UEhtCmStdBoyrM
        xw7UKTQxqZ1NhIJvB+Zt07Mw+Li3rXUaTCji3VFTKA==
X-Google-Smtp-Source: ABdhPJzVTRX3YV/6OK5Va85svb/40NTJVWAhtA9+BxwWz3EaCZkJsKf6cO+hcrX9ReyFhR8WiNpBmANuqdMgaWdVy1A=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr6198753ljk.299.1607443993318;
 Tue, 08 Dec 2020 08:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20201208153501.1467-1-mgorman@techsingularity.net> <20201208153501.1467-2-mgorman@techsingularity.net>
In-Reply-To: <20201208153501.1467-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 17:13:01 +0100
Message-ID: <CAKfTPtCQr-Djbkf-S5aq+bvuemp1hDznVC+0zPHithgHA6tbDg@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 16:35, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> SIS_AVG_CPU was introduced as a means of avoiding a search when the
> average search cost indicated that the search would likely fail. It
> was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
> select_idle_cpu() more aggressive") and later replaced with a proportional
> search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
> scale select_idle_cpu()").
>
> While there are corner cases where SIS_AVG_CPU is better, it has now been
> disabled for almost three years. As the intent of SIS_PROP is to reduce
> the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
> on SIS_PROP as a throttling mechanism.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c     | 20 +++++++++-----------
>  kernel/sched/features.h |  1 -
>  2 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 98075f9ea9a8..ac7b34e7372b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6145,7 +6145,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         struct sched_domain *this_sd;
> -       u64 avg_cost, avg_idle;
>         u64 time;
>         int this = smp_processor_id();
>         int cpu, nr = INT_MAX;
> @@ -6154,18 +6153,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         if (!this_sd)
>                 return -1;
>
> -       /*
> -        * Due to large variance we need a large fuzz factor; hackbench in
> -        * particularly is sensitive here.
> -        */
> -       avg_idle = this_rq()->avg_idle / 512;
> -       avg_cost = this_sd->avg_scan_cost + 1;
> +       if (sched_feat(SIS_PROP)) {
> +               u64 avg_cost, avg_idle, span_avg;
>
> -       if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
> -               return -1;
> +               /*
> +                * Due to large variance we need a large fuzz factor;
> +                * hackbench in particularly is sensitive here.
> +                */
> +               avg_idle = this_rq()->avg_idle / 512;
> +               avg_cost = this_sd->avg_scan_cost + 1;
>
> -       if (sched_feat(SIS_PROP)) {
> -               u64 span_avg = sd->span_weight * avg_idle;
> +               span_avg = sd->span_weight * avg_idle;
>                 if (span_avg > 4*avg_cost)
>                         nr = div_u64(span_avg, avg_cost);
>                 else
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 68d369cba9e4..e875eabb6600 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -54,7 +54,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
>  /*
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>   */
> -SCHED_FEAT(SIS_AVG_CPU, false)
>  SCHED_FEAT(SIS_PROP, true)
>
>  /*
> --
> 2.26.2
>
