Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A4726AD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgIOTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:11:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgIOTFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:05:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B182D1045;
        Tue, 15 Sep 2020 12:04:49 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4F83F718;
        Tue, 15 Sep 2020 12:04:48 -0700 (PDT)
References: <20200914100340.17608-1-vincent.guittot@linaro.org> <20200914100340.17608-4-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/fair: minimize concurrent LBs between domain level
In-reply-to: <20200914100340.17608-4-vincent.guittot@linaro.org>
Date:   Tue, 15 Sep 2020 20:04:46 +0100
Message-ID: <jhjh7ry6eup.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/09/20 11:03, Vincent Guittot wrote:
> sched domains tend to trigger simultaneously the load balance loop but
> the larger domains often need more time to collect statistics. This
> slowness makes the larger domain trying to detach tasks from a rq whereas
> tasks already migrated somewhere else at a sub-domain level. This is not
> a real problem for idle LB because the period of smaller domains will
> increase with its CPUs being busy and this will let time for higher ones
> to pulled tasks. But this becomes a problem when all CPUs are already busy
> because all domains stay synced when they trigger their LB.
>
> A simple way to minimize simultaneous LB of all domains is to decrement the
> the busy interval by 1 jiffies. Because of the busy_factor, the interval of
> larger domain will not be a multiple of smaller ones anymore.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 765be8273292..7d7eefd8e2d4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9780,6 +9780,9 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
>
>       /* scale ms to jiffies */
>       interval = msecs_to_jiffies(interval);

A comment here would be nice, I think. What about:

/*
 * Reduce likelihood of (busy) balancing at higher domains racing with
 * balancing at lower domains by preventing their balancing periods from being
 * multiples of each other.
 */

> +	if (cpu_busy)
> +		interval -= 1;
> +
>       interval = clamp(interval, 1UL, max_load_balance_interval);
>
>       return interval;
