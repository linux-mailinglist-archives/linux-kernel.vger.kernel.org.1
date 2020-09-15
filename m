Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93D26ACFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgIOTG2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 15:06:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgIOTEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:04:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7D8101E;
        Tue, 15 Sep 2020 12:04:40 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA0CE3F718;
        Tue, 15 Sep 2020 12:04:38 -0700 (PDT)
References: <20200914100340.17608-1-vincent.guittot@linaro.org> <20200914100340.17608-3-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/fair: reduce minimal imbalance threshold
In-reply-to: <20200914100340.17608-3-vincent.guittot@linaro.org>
Date:   Tue, 15 Sep 2020 20:04:33 +0100
Message-ID: <jhjimce6ev2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/09/20 11:03, Vincent Guittot wrote:
> The 25% default imbalance threshold for DIE and NUMA domain is large
> enough to generate significant unfairness between threads. A typical
> example is the case of 11 threads running on 2x4 CPUs. The imbalance of
> 20% between the 2 groups of 4 cores is just low enough to not trigger
> the load balance between the 2 groups. We will have always the same 6
> threads on one group of 4 CPUs and the other 5 threads on the other
> group of CPUS. With a fair time sharing in each group, we ends up with
> +20% running time for the group of 5 threads.
>

AIUI this is the culprit:

                if (100 * busiest->avg_load <=
                                env->sd->imbalance_pct * local->avg_load)
                        goto out_balanced;

As in your case imbalance_pct=120 becomes the tipping point.

Now, ultimately this would need to scale based on the underlying topology,
right? If you have a system with 2x32 cores running {33 threads, 34
threads}, the tipping point becomes imbalance_pct≈103; but then since you
have this many more cores, it is somewhat questionable.

> Consider decreasing the imbalance threshold for overloaded case where we
> use the load to balance task and to ensure fair time sharing.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9079d865a935..1a84b778755d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1337,7 +1337,7 @@ sd_init(struct sched_domain_topology_level *tl,
>               .min_interval		= sd_weight,
>               .max_interval		= 2*sd_weight,
>               .busy_factor		= 32,
> -		.imbalance_pct		= 125,
> +		.imbalance_pct		= 117,
>
>               .cache_nice_tries	= 0,
