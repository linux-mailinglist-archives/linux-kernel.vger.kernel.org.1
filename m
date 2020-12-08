Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC052D2E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgLHPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgLHPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:20:34 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501EEC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 07:19:54 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f24so19980970ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Me1Hf/Cdi3kKip0U1Ne9HhgL9kDjgNH3pBgdMTwceuo=;
        b=yVcnWg8cYTjBfJFA8cYSxoLVrLkBgv4MV7PKXmUjaFNZBGpw8Gz+bhjqNbTxg3Gw49
         rc33XM18c1tE9/APiOrPNDLzj94JJBdEcyL1bqE5DNBWClhLS52CWEt19nOtqQyoecpx
         mCLKx5mhumj6Iwae+QTPOis/f85Fkkl5JyUm+PX1UQi0zSQkoIMcOcDh1eXZfMlms07S
         qvRHHDioV4/6JaX8ro1P/EV2TY6sqHsQyzSgt5at+T9ISl+DZ1k4alqjO1ZIMBrv2t7M
         VtJN9y48+T3/cudY+EqVttyrnUtDbldPc6gvGO65jKuyRQg9mDXj7R/Oy7e9iOf6X4tj
         nBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Me1Hf/Cdi3kKip0U1Ne9HhgL9kDjgNH3pBgdMTwceuo=;
        b=UKzAOD4e4teKHhKT3+AnxleZcUFazehIfRKYcH7/E35thmu+7U2CAhv85t+OBwjuXl
         CXBy1+NkNv6HZDBSRzbs5XNnWh1KluGQ31RXKQSHOi7AMnL9AUhYMUoBzJgV96xahTvn
         VYtdni1Kyi0HYhOJIp2I6Nzy0VFXlPaXURfWnE57iADwmDmxNPZGIk3/PP0DkSv0Aq8+
         ztHnEA2zVslsJEM1RtB/Py4jQiRAtU63hnetWqqo6+70o+0jOgyJVSMuVVoXMjALXYSn
         yV/LVoEmSpBpMh7/goBeHS/czBwr8T33Fd+/oqBT4GNcpwgnMfD7tfyrC9Mgk+rZzV7T
         /aKw==
X-Gm-Message-State: AOAM533N8aOfLEJF1dWYmLFDoLNbieKjvVVKRKNu2hUWxhZ/1/ug5nl2
        jxpNffBVew4JMLks1iHyE6JkuOSkFybDG0hgmIbeqA==
X-Google-Smtp-Source: ABdhPJzRTKVLBhWGEzAHP8+r3pHcy1PPM/fyqQrbmap1mZizTETMNvwtgKGSs3jcgpf/mMIVUdtbCDaBmWpzCgXZc68=
X-Received: by 2002:a2e:9913:: with SMTP id v19mr3955192lji.209.1607440791659;
 Tue, 08 Dec 2020 07:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net> <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
 <20201208105900.GG3371@techsingularity.net> <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
 <20201208133650.GI3371@techsingularity.net> <CAKfTPtDbUoVSvnjFrpomvTJD0jCA6vH_Y3LP=csW8fHntOG_6A@mail.gmail.com>
 <20201208135358.GJ3371@techsingularity.net> <CAKfTPtCqGXJa=GfpBZk5To-xVWVtVL8YVMab9PoxFN1=vOwTWQ@mail.gmail.com>
 <20201208151226.GK3371@techsingularity.net>
In-Reply-To: <20201208151226.GK3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 16:19:40 +0100
Message-ID: <CAKfTPtAUb50SHtDQs0xeehrPGqkyA6HqFQ3=nUbtOCGj62Fc9A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 16:12, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 08, 2020 at 03:47:40PM +0100, Vincent Guittot wrote:
> > > I considered it but made the choice to exclude the cost of cpumask_and()
> > > from the avg_scan_cost instead. It's minor but when doing the original
> >
> > At the cost of a less readable code
> >
>
> Slightly less readable, yes.
>
> > > prototype, I didn't think it was appropriate to count the cpumask
> > > clearing as part of the scan cost as it's not directly related.
> >
> > hmm... I think it is because the number of loop is directly related to
> > the allowed cpus
> >
>
> While that is true, the cost of initialising the map is constant and
> what is most important is tracking the scan cost which is variable.
> Without SIS_AVG_CPU, the cpumask init can go before SIS_PROP without any
> penalty so is this version preferable?

yes looks good to me

>
> --8<--
> sched/fair: Move avg_scan_cost calculations under SIS_PROP
>
> As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
> even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
> check and while we are at it, exclude the cost of initialising the CPU
> mask from the average scan cost.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ac7b34e7372b..5c41875aec23 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         if (!this_sd)
>                 return -1;
>
> +       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
>         if (sched_feat(SIS_PROP)) {
>                 u64 avg_cost, avg_idle, span_avg;
>
> @@ -6168,11 +6170,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         nr = div_u64(span_avg, avg_cost);
>                 else
>                         nr = 4;
> -       }
> -
> -       time = cpu_clock(this);
>
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +               time = cpu_clock(this);
> +       }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
> @@ -6181,8 +6181,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         break;
>         }
>
> -       time = cpu_clock(this) - time;
> -       update_avg(&this_sd->avg_scan_cost, time);
> +       if (sched_feat(SIS_PROP)) {
> +               time = cpu_clock(this) - time;
> +               update_avg(&this_sd->avg_scan_cost, time);
> +       }
>
>         return cpu;
>  }
