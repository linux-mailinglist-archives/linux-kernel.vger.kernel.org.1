Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F383A2EC033
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbhAFPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:14:26 -0500
Received: from foss.arm.com ([217.140.110.172]:42478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbhAFPOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:14:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417F8D6E;
        Wed,  6 Jan 2021 07:13:40 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C80233F719;
        Wed,  6 Jan 2021 07:13:38 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/3] sched/fair: skip idle cfs_rq
In-Reply-To: <20210106133419.2971-2-vincent.guittot@linaro.org>
References: <20210106133419.2971-1-vincent.guittot@linaro.org> <20210106133419.2971-2-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 06 Jan 2021 15:13:31 +0000
Message-ID: <jhj1rey3xpg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/21 14:34, Vincent Guittot wrote:
> Don't waste time checking whether an idle cfs_rq could be the busiest
> queue. Furthermore, this can end up selecting a cfs_rq with a high load
> but being idle in case of migrate_load.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Makes sense to me.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..5428b8723e61 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9389,8 +9389,11 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		if (rt > env->fbq_type)
>  			continue;
>  
> -		capacity = capacity_of(i);
>  		nr_running = rq->cfs.h_nr_running;
> +		if (!nr_running)
> +			continue;
> +
> +		capacity = capacity_of(i);
>  
>  		/*
>  		 * For ASYM_CPUCAPACITY domains, don't pick a CPU that could
> -- 
> 2.17.1
