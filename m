Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C422D2F00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgLHQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgLHQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:04:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1A7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 08:03:34 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so24238162lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LnFBrCqLdwU3AM6hJ1d3uu4vr1BtqBjE7QwQU2+VSQ=;
        b=jo2nVsMrjTxBSr746SrL3BbieY9fZKGyS76NEd3u2tih/2cAJOcdBXvLZV3kl3gOHF
         logZojlcxYuY7GPbfOvt+VqM4mpOEIXHTa2SfUMzJ30GFjzR7RrnocuLTbjHNhinoopi
         t92enLcl5NebsAC1BPQsfHS8RhVN77omNZCefMnFbWubWW3Yhk0SB2FKL3BZrU3u6+wX
         c2EBqebaGYaV+iord/JI6mXrw6wem6DtzYhjr7Q8LEPPIttIjSiMKEcmDEN/BnRe1a6H
         kkAWcNh1RjyoMYgVG6dgnt/sYJj3Xeio8Npbcx1R7dUCAJ1qA1JF5hio1Evk+ZG2oMW7
         pd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LnFBrCqLdwU3AM6hJ1d3uu4vr1BtqBjE7QwQU2+VSQ=;
        b=K7JX452pOPyhTRSLCcGENczSGZH0Z5yOmengFpJvkZknOEAOJG3vOa4U8iQvlfcuTN
         W17XjrQN8/0OOXj55S9MZ5L9557Ar3lojtMnVs6jbJFjooaH02fL+irig9y/aPoMS1+V
         /qoVtUTtrmJ8KvHcKWv/qlIh07Eel/eDW5Bh0/eiZ0NVxCpRMJv2VUFNM7cpxiycq9Yq
         yFB3y5kceZhZrDktTHYr3FQgh7BUNQKd+DtcNwruJ2BgfPzBI2vAvrWpouPilFWrDGyb
         qn5yIf+mWlbUGUFUnwuGZdvdrxZv2dQbVopXrzXsWJX5nSn5arw8jv4srOWAIfIByR+h
         9/bA==
X-Gm-Message-State: AOAM533LhTP5CpWtlfvGCrcLyVgrei6u3ReBoh1e9giD2bu0utZrZ64b
        lbxmMlwISsJ8j+/O2y0fI1KmdPMDPY+SkOEvCbMgTC+0tugwmg==
X-Google-Smtp-Source: ABdhPJwTXng+7I3vBDzOLSmZhgQ0rtWuu4Fxv1dhc9vy4Biz0wsSUPYTx77ZepGbkLYt30aknG5OavFnmZj6Dgiy/zM=
X-Received: by 2002:a19:be14:: with SMTP id o20mr8130559lff.305.1607443412557;
 Tue, 08 Dec 2020 08:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20201208153501.1467-1-mgorman@techsingularity.net> <20201208153501.1467-3-mgorman@techsingularity.net>
In-Reply-To: <20201208153501.1467-3-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 17:03:21 +0100
Message-ID: <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under SIS_PROP
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

Just noticed while reviewing the patch that the above related to
this_sd can also go under sched_feat(SIS_PROP)

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
> --
> 2.26.2
>
