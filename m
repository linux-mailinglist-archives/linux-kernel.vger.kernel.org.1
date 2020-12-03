Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F59E2CDB62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLCQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLCQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:36:29 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F320C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:35:43 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f24so3176411ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osJGl4Xoo9CyrDoVMzy84sr16f90oAXVouqpEhXQLYw=;
        b=MyaVCx8py2uCLIE94kfwlUwgBPljIxNEzTcIC+9HItx2Rr4+VPAjWOqHie/PQtyTcc
         hLoPvMcXKPnwdGEs5qmM1MtnWi1jjqNFFIrTsWKK7lPgahWGBGvnsmiLZIcx9cnjoHWw
         KtfYouMtyEHn/ysmA9l9MRdOGQAbhgvzsXnam+2B0xUpVhJVonbRYz5GZ/GCypDC51Wl
         NxgQEk/1dVT2i3tDEYVw+wAuMJ9rsqm7ElDJbgiGvglam4Wmv9D72przqDsNw+4+sJsH
         55AYVRN44KMDb/BDO0daKwBaZ5jq21kX+abv+Es97CErI77pEtzE8MIwQmgtvbHSMMmL
         KVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osJGl4Xoo9CyrDoVMzy84sr16f90oAXVouqpEhXQLYw=;
        b=ewj5VQApy6rPnwlIw8NJrxL+dPUDmy8KRAb9IBt2rATT4rKVqxUhOliPPQaGO2zKHj
         y6J1gX7vc/d01WgHPEldf11RSIMic/n3RhPVHmM3H1nkhxfNXdCegZ2cPjv90thNndeF
         Olhrd6qPgpcvlnZ9TakcPdmx2u/eAd1HU4qf7M5ciAu1R26NCekMtBsPdrhvwDEG8Or2
         MBJgzdFNTtilSZ4/jHHZGyEAmFBr2hZ3zbstQuSpUNIUh0j3DzZoi2sYEwPMcJYayaHF
         e+861w9AIKXCH4uovypzNVNlnUn82J1WgrGy0zNDeFZIYKzVX132cenAHWAadpvvzfBf
         YKLg==
X-Gm-Message-State: AOAM531IroWUikeQxAIzmMSV0zVeK9iX5ZbGERF1M5L1l39F2rl8Wt5x
        EaEH7ngGCpAK6oIWTQemuyRYBHa6v75oaRbyRTft0w==
X-Google-Smtp-Source: ABdhPJy3i7djb/qinGMal/4244smC+jBUqIDKbKayaTg/+sd3SyfNscL85bbgN5LIdT9fJJFohNjqSnxhtkt2F/4xXM=
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr1512374ljp.423.1607013341934;
 Thu, 03 Dec 2020 08:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net> <20201203141124.7391-5-mgorman@techsingularity.net>
In-Reply-To: <20201203141124.7391-5-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Dec 2020 17:35:29 +0100
Message-ID: <CAKfTPtBMc=3d0nyoCt7_0s_wFyr_kUX3kET4cqesYjQQwLDhYw@mail.gmail.com>
Subject: Re: [PATCH 04/10] sched/fair: Return an idle cpu if one is found
 after a failed search for an idle core
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

On Thu, 3 Dec 2020 at 15:11, Mel Gorman <mgorman@techsingularity.net> wrote:
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
> In this particular test, the cost/benefit is marginal except
> for 64 which was a point where the machine was over 50% busy
> but not fully utilised.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fc48cc99b03d..845bc0cd9158 100644
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
> @@ -6084,7 +6085,13 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>                         schedstat_inc(this_rq()->sis_scanned);
>                         if (!available_idle_cpu(cpu)) {
>                                 idle = false;
> -                               break;
> +                               if (idle_candidate != -1)
> +                                       break;


If I get your changes correctly, it will now continue to loop on all
cpus of the smt mask to try to find an idle cpu whereas it was
breaking before as soon as a cpu was not idle. In fact, I thought that
you just wanted to be opportunistic and save a candidate but without
looping more cpus than currently.

With the change above you might end up looping all cpus of llc if
there is only one idle cpu in the llc whereas before we were looping
only 1 cpu per core at most. The bottom change makes sense but the
above on is in some way replacing completely select_idle_cpu and
bypass SIS_PROP and we should avoid that IMO

> +                       }
> +
> +                       if (idle_candidate == -1 &&
> +                           cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                               idle_candidate = cpu;
>                         }
>                 }
>
> @@ -6099,7 +6106,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
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
