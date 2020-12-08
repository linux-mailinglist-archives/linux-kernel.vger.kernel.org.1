Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1D2D284C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgLHJ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:58:30 -0500
Received: from foss.arm.com ([217.140.110.172]:46620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLHJ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:58:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B371FB;
        Tue,  8 Dec 2020 01:57:43 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768F23F68F;
        Tue,  8 Dec 2020 01:57:41 -0800 (PST)
Subject: Re: [PATCH 2/4] sched/fair: Do not replace recent_used_cpu with the
 new target
To:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-3-mgorman@techsingularity.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <842ef1db-49d1-7d05-997b-1562383cdd28@arm.com>
Date:   Tue, 8 Dec 2020 10:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207091516.24683-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2020 10:15, Mel Gorman wrote:
> After select_idle_sibling, p->recent_used_cpu is set to the
> new target. However on the next wakeup, prev will be the same as

I'm confused here. Isn't current->recent_used_cpu set to 'cpu =
smp_processor_id()' after sis()? Looking at v5.10-rc6.

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 23934dbac635..01b38fc17bca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6274,6 +6274,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  
>  	/* Check a recently used CPU as a potential idle candidate: */
>  	recent_used_cpu = p->recent_used_cpu;
> +	p->recent_used_cpu = prev;
>  	if (recent_used_cpu != prev &&
>  	    recent_used_cpu != target &&
>  	    cpus_share_cache(recent_used_cpu, target) &&

p->recent_used_cpu is already set to prev in this if condition.

    asym_fits_capacity(task_util, recent_used_cpu)) {
        /*
         * Replace recent_used_cpu with prev as it is a potential
         * candidate for the next wake:
         */
        p->recent_used_cpu = prev;
        return recent_used_cpu;

> @@ -6765,9 +6766,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>  		/* Fast path */
>  		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> -
> -		if (want_affine)
> -			current->recent_used_cpu = cpu;
>  	}
>  	rcu_read_unlock();
