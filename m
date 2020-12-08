Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E52D2F41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgLHQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgLHQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:16:04 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ECBC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 08:15:18 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m13so4211830ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 08:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fssjOy+xvCiaGsz6X4+ho23ckT+FIMcNGo0Pr9iqsRc=;
        b=lE3FeoRaLN9AM9uOwBAUfaCJUPsO/mfmAE+fk4/pkTkOKQXJo8ciNVok+0uzUheAab
         8fyAuLiblFn1siw2qQcRTJhq4a5EpPm8GJJkkk6hqLTmsamYR5y6257YPw2ofdn9uPA4
         6htGOObXqTnRZg+ToE2SdpHWckPjCb2qUlnFgUEgXWt+LE1aV3ECH3uHjSNPFYLHsNEB
         /QLQg/U+gJRW2T/Ex2NEpQG8Wd5pS/1foxdLewG9cceQy1DZYqcXecdydSf5vweBe/i3
         PshElw8kcAONOnEpaFg2IDvi7CbWYA3aGaaUtlZ8ZQfozbRzYZ9DHsRqLDSoN3Vp5E1O
         ibQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fssjOy+xvCiaGsz6X4+ho23ckT+FIMcNGo0Pr9iqsRc=;
        b=relssRF0P+9ocoP6gcF0hC6+rbTJlZKoK7otvpoSahe3U3E02q2syPThVvffvyTWSY
         88N/HkTEZer6Khtms9YqVmXqMW5R+KrQ9lzNzn+0FGi8VLRXFcfwTuQRO4iedsp+0VMe
         Kvzs0nLHik84h7R73Am3CSf3F9qPCmZdwZErROx50Cb0FM76LsVvACeKOaOIMQd8Q8hS
         b7iW8m7YuxyvImexx4RfbX6dpttF6q+kg+YtjVhnz8ZXZ07pSrPbMWPKAHA/KWStkGqH
         pauxzorBfB8VE3j+auNUUO50cTrUbUU6nOBSlT8m2cqYivxu4+HBEm9jOVb4t3Q64pK3
         108Q==
X-Gm-Message-State: AOAM532NyWvOOSjHJLxOSySgxPmwnylQ3b/fXI6DHhq0mu3bz+D6yZu3
        KUqP1tzBxWtagydAOJGbkm1zgij5mxhI2Sr4/TzaCA==
X-Google-Smtp-Source: ABdhPJzX9acF/q0Vl4WXOYY/qadNsEYYoicjAQKDMqq+e3RkNXsqp3+XPl5sKIlOUcEzVoOcdSPzAa/xn+571tJnxTg=
X-Received: by 2002:a2e:98da:: with SMTP id s26mr11257780ljj.445.1607444112719;
 Tue, 08 Dec 2020 08:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20201208153501.1467-1-mgorman@techsingularity.net> <20201208153501.1467-5-mgorman@techsingularity.net>
In-Reply-To: <20201208153501.1467-5-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 17:15:01 +0100
Message-ID: <CAKfTPtCUJcT42+wBmnUmr7s3Z0BFf5WUknKc22eyEe+vcNQ3qw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Return an idle cpu if one is found after
 a failed search for an idle core
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
> select_idle_core is called when SMT is active and there is likely a free
> core available. It may find idle CPUs but this information is simply
> discarded and the scan starts over again with select_idle_cpu.
>
> This patch caches information on idle CPUs found during the search for
> a core and uses one if no core is found. This is a tradeoff. There may
> be a slight impact when utilisation is low and an idle core can be
> found quickly. It provides improvements as the number of busy CPUs
> approaches 50% of the domain size when SMT is enabled.
>
> With tbench on a 2-socket CascadeLake machine, 80 logical CPUs, HT enabled
>
>                           5.10.0-rc6             5.10.0-rc6
>                            schedstat          idlecandidate
> Hmean     1        500.06 (   0.00%)      505.67 *   1.12%*
> Hmean     2        975.90 (   0.00%)      974.06 *  -0.19%*
> Hmean     4       1902.95 (   0.00%)     1904.43 *   0.08%*
> Hmean     8       3761.73 (   0.00%)     3721.02 *  -1.08%*
> Hmean     16      6713.93 (   0.00%)     6769.17 *   0.82%*
> Hmean     32     10435.31 (   0.00%)    10312.58 *  -1.18%*
> Hmean     64     12325.51 (   0.00%)    13792.01 *  11.90%*
> Hmean     128    21225.21 (   0.00%)    20963.44 *  -1.23%*
> Hmean     256    20532.83 (   0.00%)    20335.62 *  -0.96%*
> Hmean     320    20334.81 (   0.00%)    20147.25 *  -0.92%*
>
> Note that there is a significant corner case. As the SMT scan may be
> terminated early, not all CPUs have been visited and select_idle_cpu()
> is still called for a full scan. This case is handled in the next
> patch.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 413d895bbbf8..ed6f45832d97 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6066,6 +6066,7 @@ void __update_idle_core(struct rq *rq)
>   */
>  static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> +       int idle_candidate = -1;
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         int core, cpu;
>
> @@ -6085,6 +6086,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>                                 idle = false;
>                                 break;
>                         }
> +
> +                       if (idle_candidate == -1 &&
> +                           cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                               idle_candidate = cpu;
> +                       }
>                 }
>
>                 if (idle)
> @@ -6098,7 +6104,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>          */
>         set_idle_cores(target, 0);
>
> -       return -1;
> +       return idle_candidate;
>  }
>
>  /*
> --
> 2.26.2
>
