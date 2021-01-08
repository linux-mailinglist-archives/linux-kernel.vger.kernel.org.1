Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C22EF347
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbhAHNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbhAHNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:42:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FEC0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:41:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 23so22922115lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZPKWY5arQcMoCFtNfmWGsoYldwdKKEvubloyRBdTZs=;
        b=pQ/Xf0dZM32HRfQVzoiKC/dg3v4xREgtTnHlolz16nvPKiFM+RU2O3B03/WYfmm4+O
         nyL4w7iRF0AgE19I8ovdGhlbtNKcZPzvo1oanIJyfirrQ8PxZJkcHgjvcgP3FFmmPZAX
         Q09ppwsy3qEHDVMxGVp15yVXjiABe+tswfwReQIwysk0zYL8rpPTrfkUjqksV/rZOeIW
         M1r3E2rzWUS/RjzWCSbjvSRN625Ut3sSmBUGQCsM4Ge4Bv919PRB3A5aAvGvQ7NOqVfa
         LPMeSy6k4R147sCPAkcSLFbqgPaHRRvrywuEtbz2OUTX2sdn0EHVknWefiV4txu16N/r
         NsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZPKWY5arQcMoCFtNfmWGsoYldwdKKEvubloyRBdTZs=;
        b=jIMLD8AmBq+CVwHoL3vjYH/W9AgSplTiwWoUN+zMyzNdM5tIHSVjWoUMWk/HRyLtiw
         70rFtbhp4r7MlzzaQOaT7pyZwMLYBCICi0RsYsOhas0Ey3Q5JnZiSR1Qf7H6GykJCxCW
         f8IA//dM3JPW6OblSb6EsEZ74IsP/wWMRXaImX6cNA1Ra1FHrVvxLNeLyQVuaamZU2wg
         FEFAjAAwgaSOvD1FdfXINoosPlVhe0qdeRoK+e2524qvzzh/C+Wgz82i68ecPl0iMCE6
         gKWsrt3LSgt0PXflqf4vJhBlYi0n92fYTTREsSOvv2pA96OCyyrNG0Jj6MPJ1wwev+bA
         gDWA==
X-Gm-Message-State: AOAM531pM2c6j9spjme7xagsO8f8szDnybyBo2bJwGdcGIKiL9KvpT3u
        6Y7BwXQoKU73MR/sDAiphZL3EbWFe0FgzZ7xo4JPvw==
X-Google-Smtp-Source: ABdhPJwIK20hmhV3alsdW69F03W2tJwgN9l5/SXTfYMtcl4fyOmKtxNHe0IicvQGagQ/KjGaCpjWEqwrvys+1sTLJ3Y=
X-Received: by 2002:a19:2d0a:: with SMTP id k10mr1814341lfj.286.1610113290898;
 Fri, 08 Jan 2021 05:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com> <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
In-Reply-To: <20210108102738.GB3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Jan 2021 14:41:19 +0100
Message-ID: <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost accounting
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 11:27, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 15, 2020 at 08:59:11AM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 15, 2020 at 11:36:35AM +0800, Li, Aubrey wrote:
> > > On 2020/12/15 0:48, Peter Zijlstra wrote:
> > > > We compute the average cost of the total scan, but then use it as a
> > > > per-cpu scan cost when computing the scan proportion. Fix this by
> > > > properly computing a per-cpu scan cost.
> > > >
> > > > This also fixes a bug where we would terminate early (!--nr, case) and
> > > > not account that cost at all.
> > >
> > > I'm a bit worried this may introduce a regression under heavy load.
> > > The overhead of adding another cpu_clock() and calculation becomes
> > > significant when sis_scan is throttled by nr.
> >
> > The thing is, the code as it exists today makes no sense what so ever.
> > It's plain broken batshit.
> >
> > We calculate the total scanning time (irrespective of how many CPUs we
> > touched), and then use that calculate the number of cpus to scan. That's
> > just daft.
> >
> > After this patch we calculate the avg cost of scanning 1 cpu and use
> > that to calculate how many cpus to scan. Which is coherent and sane.
> >
> > Maybe it can be improved, but that's a completely different thing.
>
> In general I agree with everything you said so lets talk about the last
> sentence.
>
> 1. avg_scan_cost is now based on the average scan cost of a rq but
>    avg_idle is still scaled to the domain size. This is a bit problematic
>    because it's comparing scan cost of a single rq with the estimated
>    average idle time of a domain. As a result, the scan depth can be much
>    larger than it was before the patch and led to some regressions.

Point 1 makes sense to me too

>
> 2. Accounting for the scan cost of success makes sense but there is a
>    big difference between a scan that finds an idle CPU and one that fails.
>    For failures, the scan cost is wasted CPU time where as a success
>    means that an uncontested CPU is used. This can cause a search to be
>    truncated earlier than it should be when the domain is lightly loaded.

But I'm not sure to catch your problem with point 2.
track the average cost to scan one rq so looping all rqs are only few
should not impact (much) the avg_scan_cost

Trying to bias the avg_scan_cost with:  loops <<= 2;
will just make avg_scan_cost lost any kind of meaning because it
doesn't reflect the avg cost of scanning a rq anymore

>
> The patch below attempts to deal with both of those points. The
> remaining difficulty is the "fuzz" factor which is necessary to bring
> large avg_idle values into a reasonable range for comparing against
> avg_scan_cost. The max avg_idle value can be anything but generally the
> ceiling is 2*sysctl_sched_migration_cost. I didn't quickly spot a good way
> of mapping avg_idle to a range between 0 and sd->span_weight.  The obvious
> one was (weight*avg_idle/(2*sched_migration_cost)) but it did not work very
> well as avg_scan_cost accounts for the full cost of accessing a remote rq.
> However, this could be revisited later after this series is sorted out.
>
> Anyway, for the enumerated concerns, how about this on top for your
> first patch? It seemed to work well for a few workloads on 3 machines
> at least and I'd like to nail this down before considering the remaining
> patches. The first run indicated that the first patch offset some of the
> benefits of the other patches.
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 65a2f208ada8..1e04a250e8ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6156,7 +6156,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
>         if (sched_feat(SIS_PROP)) {
> -               u64 avg_cost, avg_idle, span_avg;
> +               u64 avg_cost, avg_idle;
>
>                 /*
>                  * Due to large variance we need a large fuzz factor;
> @@ -6164,25 +6164,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                  */
>                 avg_idle = this_rq()->avg_idle / 512;
>                 avg_cost = this_sd->avg_scan_cost + 1;
> -
> -               span_avg = sd->span_weight * avg_idle;
> -               if (span_avg > 4*avg_cost)
> -                       nr = div_u64(span_avg, avg_cost);
> -               else
> +               nr = div_u64(avg_idle, avg_cost);
> +               if (nr < 4)
>                         nr = 4;
>
>                 time = cpu_clock(this);
>         }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
> +                       /* Adjust cost of a successful scan */
> +                       loops <<= 2;
> +
>                         break;
> +               }
>
> -               if (loops >= nr) {
> +               if (++loops >= nr) {
>                         cpu = -1;
>                         break;
>                 }
> -               loops++;
>         }
>
>         if (sched_feat(SIS_PROP)) {
>
> --
> Mel Gorman
> SUSE Labs
