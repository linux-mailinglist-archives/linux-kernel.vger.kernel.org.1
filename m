Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67C2CC224
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbgLBQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbgLBQXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:23:53 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:23:12 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d8so5723854lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkzWh1n8apsb00YEXyZll9FC6kSVnRaWL8x+YUkOQho=;
        b=KZLPsRnOwomBLzlBoH7n1dnG+b0g/3ya9uDJsTghBWnNcTc54eODzPHInC0a9fMP3x
         hxxf3Lal0n0O0WTvUY5coWMubP9nC7hhs+JmiO2Xe/T6eurKm6CYlcn4bXldUPrKcqyz
         rpL/AlwSXaRadcySApnPZPAJtf1km/Smoml0kiiNE8SevdK8Uco4dMDq0PebTQoLDllY
         AoQ/pw/svxuApE0wJft3EMaWcv/AlKpk1BWON9m/ZJX3JXPoo7ftAjqG749EzsbAc9sa
         BQkS5QUfjDF1HTF7ZNFrv0kTfIFcWEMmGHnJsSY/dBcPVNSTin/T9NysuSMuDuvYRTye
         +gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkzWh1n8apsb00YEXyZll9FC6kSVnRaWL8x+YUkOQho=;
        b=t+FY+Ax4zcQpAKAXU3WNkeXfP+/3XFPbTcASNqve7mQkm0RjcKELa8zVz6HI/P3ja1
         a8hEAJW/uUq8GSPIgHNE9CA2rkfAyanKGpF603rASvepI660uwe1jD2SqgFqS6Tvwwyi
         044x9NpS4JfFDSna/vzWxq6VpwP/29cK+IpxfeVZBE7YX/Q8fzS/Sxebnu/yTmUWbX5t
         Pf+NcAsZG9urLFvRQomzfYrfbbj3KyHzbdEOgqrw5e1Mr1m9B8KSoMa9cTYuco2C6vp3
         80Hu2sVVDpjL6i7aVjZR33KatnEEbxmJFdDxLZix9i5NmZtnf42ZgrstD7VnIyX92dat
         Xvew==
X-Gm-Message-State: AOAM532y2SMTf8/9YsCt0jUbKGi/mqkBGSw4j4blhG70eE4baIgEShJt
        wCDGAVUydYiWF3iPLaQOoTJy+uvLl6lTY7Qjw79uXg==
X-Google-Smtp-Source: ABdhPJy1wBO7dMTMSToBdakmqd/AJ3DKQw5y4MinYynDNQJQSV3VhmUF5TYxs39dXwiKO0mNDD53TkoKGL3s48ztXZw=
X-Received: by 2002:a19:8347:: with SMTP id f68mr1679092lfd.83.1606926191127;
 Wed, 02 Dec 2020 08:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20201125090923.GA3723@shao2-debian> <6fef3fc7-be18-92e5-c622-add6decb88c4@linux.intel.com>
 <20201126121351.GJ3371@techsingularity.net> <b45171de-cb74-bf35-91bf-967dbd5567d1@linux.intel.com>
In-Reply-To: <b45171de-cb74-bf35-91bf-967dbd5567d1@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Dec 2020 17:22:59 +0100
Message-ID: <CAKfTPtCydzVv45qbsDTG2XDS=4EF4KuuYg5mjnDDF_81B5p2kA@mail.gmail.com>
Subject: Re: [sched/fair] 8d86968ac3: netperf.Throughput_tps -29.5% regression
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <rong.a.chen@intel.com>,
        0day robot <lkp@intel.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jiang Biao <benbjiang@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 15:30, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> Hi Mel,
>
> On 2020/11/26 20:13, Mel Gorman wrote:
> > On Thu, Nov 26, 2020 at 02:57:07PM +0800, Li, Aubrey wrote:
> >> Hi Robot,
> >>
> >> On 2020/11/25 17:09, kernel test robot wrote:
> >>> Greeting,
> >>>
> >>> FYI, we noticed a -29.5% regression of netperf.Throughput_tps due to commit:
> >>>
> >>>
> >>> commit: 8d86968ac36ea5bff487f70b5ffc252a87d44c51 ("[RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for task wakeup")
> >>> url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20201118-115145
> >>> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576
> >>
> >> I tried to replicate this on my side on a 192 threads(with SMT) machine as well and didn't see the regression.
> >>
> >> nr_threads           v5.9.8          +patch
> >> 96(50%)                      1 (+/- 2.499%)  1.007672(+/- 3.0872%)
> >>
> >> I also tested another 100% case and see similar improvement as what I saw on uperf benchmark
> >>
> >> nr_threads           v5.9.8          +patch
> >> 192(100%)            1 (+/- 45.32%)  1.864917(+/- 23.29%)
> >>
> >> My base is v5.9.8 BTW.
> >>
> >>>     ip: ipv4
> >>>     runtime: 300s
> >>>     nr_threads: 50%
> >>>     cluster: cs-localhost
> >>>     test: UDP_RR
> >>>     cpufreq_governor: performance
> >>>     ucode: 0x5003003
> >>>
> >
> > Note that I suspect that regressions with this will be tricky to reproduce
> > because it'll depend on the timing of when the idle mask gets updated. With
> > this configuration there are 50% "threads" which likely gets translates
> > into 1 client/server per thread or 100% of CPUs active but as it's a
> > ping-pong workload, the pairs are rapidly idling for very short periods.
>
> I tried to replicate this regression but no solid fruit found. I tried 30 times
> 300s 50%.netperf running, all the data are better than the default data. The only
> interesting thing I found is an option CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y,
> but it performs different on different machines. In case anything I missed,
> do you have any suggestions to replicate this regression?
>
> >
> > If the idle mask is not getting cleared then select_idle_cpu() is
> > probably returning immediately. select_idle_core() is almost certainly
> > failing so that just leaves select_idle_smt() to find a potentially idle
> > CPU. That's a limited search space so tasks may be getting stacked and
> > missing CPUs that are idling for short periods.
>
> Vincent suggested we decouple idle cpumask from short idle(stop tick) and
> set it every time the CPU enters idle, I'll make this change in V6.

This v6 behavior is much more conservative regarding the idle  cpumask
and should restore the regression that appeared with V4

>
> >
> > On the flip side, I expect cases like hackbench to benefit because it
> > can saturate a machine to such a degree that select_idle_cpu() is a waste
> > of time.
>
> Yes, I believe that's also why I saw uperf/netperf improvement at high
> load levels.
>
> >
> > That said, I haven't followed the different versions closely. I know v5
> > got a lot of feedback so will take a closer look at v6. Fundamentally
> > though I expect that using the idle mask will be a mixed bag. At low
> > utilisation or over-saturation, it'll be a benefit. At the point where
> > the machine is almost fully busy, some workloads will benefit (lightly
> > communicating workloads that occasionally migrate) and others will not
> > (ping-pong workloads looking for CPUs that are idle for very brief
> > periods).
>
> Do you have any interested workload [matrix] I can do the measurement?
>
> >
> > It's tricky enough that it might benefit from a sched_feat() check that
> > is default true so it gets tested. For regressions that show up, it'll
> > be easy enough to ask for the feature to be disabled to see if it fixes
> > it. Over time, that might give an idea of exactly what sort of workloads
> > benefit and what suffers.
>
> Okay, I'll add a sched_feat() for this feature.
>
> >
> > Note that the cost of select_idle_cpu() can also be reduced by enabling
> > SIS_AVG_CPU so it would be interesting to know if the idle mask is superior
> > or inferior to SIS_AVG_CPU for workloads that show regressions.
> >
>
> Thanks,
> -Aubrey
