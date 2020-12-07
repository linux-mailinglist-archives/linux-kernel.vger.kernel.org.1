Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064422D1468
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLGPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLGPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:07:41 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884F4C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:06:55 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 23so5538180lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EHGNTCOqzQDyDF6Ur2z/ZJXaKN5/flAOrEQJLIGkas=;
        b=dOdm47wrW/xk1WQytScoi3uZ/jXVg/t3v4NQrzedMCfdC1qhjLI/DLllqCSNcXIGwn
         UxpzdAZx3CnDdyjvoW0AEeoCGz96MphzHymNzH93l2C7EDsoQzOYiIg9ujnfndBJvGEF
         2sb1HbMRbKApf6cdV0EhBPl57Z11L4rRWaUPHQLUHlV1KdFwW6CLg5h0/q6Wou31Ec4h
         grFaYOU741QAx7NGheIQDANcoR3C1IWXA+HBdhMzFqEKd2FkTMkDP459YmljQejUmy1F
         eOlqsg0nJaIPfseK0souZK7N/p7pzIt5jGpXBcQxY3+ScVmmii78v8xuIMNS/tOnjoZ7
         6SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EHGNTCOqzQDyDF6Ur2z/ZJXaKN5/flAOrEQJLIGkas=;
        b=E6uF3HmbRwG4mJy0GKJv14x/BA23NpMbOH1EP4JJqf2e85tPafy+DNFD+iRZvEpqr+
         brL0bcmE+X60ciG9YPcGTW8r+g6KGK3PvVxqYBcE4nDlC2vRknL8gCENh9zcGQC0juDB
         n3daCiglba8inHUd3TNXwQP0S6XE1eEtdcwPs5SQqxdoC8NQ5Jgl79z3nwvByU7WMvIP
         HQ82mmgSwegRvjkxEJPvQPx9BpsjojmoHZGyciZoxTE1lpLLRLZBpM78QV2SvbTkUE72
         aBhh2C7u3mWmOWO1vQ7ya/h69oEaB60KH0c6fXPQsPIRMLKv0GswJdBy78W3gmMW/N6q
         Fy8g==
X-Gm-Message-State: AOAM531zl3ga7+wmxdS/SOPHgi7LqFGnC/Yp8gSzQtNoSnojrcVwznOc
        IHlEzfJSFaX1THGESsLVF681BSbMJMqu2BSD4iAIbQ==
X-Google-Smtp-Source: ABdhPJwVF+q0c8iKtovxIeXUdaUK0b2r1vxzSM00uRv4mEoishAR27aRI/4b20wfEXxQH+5ps1UObtvCeBGhzIyHWcU=
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr8669565lfl.385.1607353614005;
 Mon, 07 Dec 2020 07:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net> <20201207091516.24683-4-mgorman@techsingularity.net>
In-Reply-To: <20201207091516.24683-4-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Dec 2020 16:06:42 +0100
Message-ID: <CAKfTPtDYvOraCUjs94UCVSOjmJxxJhsF3t1ZNb_h+vSeOC0+VA@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/fair: Return an idle cpu if one is found after
 a failed search for an idle core
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

On Mon, 7 Dec 2020 at 10:15, Mel Gorman <mgorman@techsingularity.net> wrote:
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
> index 01b38fc17bca..00c3b526a5bd 100644
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
