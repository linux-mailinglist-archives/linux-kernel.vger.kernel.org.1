Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7C2B07AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKLOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:41:35 -0500
Received: from foss.arm.com ([217.140.110.172]:52110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:41:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 427FD139F;
        Thu, 12 Nov 2020 06:41:34 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DFCC3F6CF;
        Thu, 12 Nov 2020 06:41:33 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:41:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201112144131.7gqglj435bs6otwm@e107158-lin.cambridge.arm.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
 <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 18:41, Dietmar Eggemann wrote:
> On 10/11/2020 13:21, Peter Zijlstra wrote:
> > On Tue, Nov 03, 2020 at 10:37:56AM +0800, Yun Hsiang wrote:
> >> If the user wants to stop controlling uclamp and let the task inherit
> >> the value from the group, we need a method to reset.
> >>
> >> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> >> sched_setattr syscall.
> >>
> >> The policy is
> >> _CLAMP_RESET                           => reset both min and max
> >> _CLAMP_RESET | _CLAMP_MIN              => reset min value
> >> _CLAMP_RESET | _CLAMP_MAX              => reset max value
> >> _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> >>
> > 
> > The obvious alternative would be to use a magic value in
> > sched_util_{min,max} to indicate reset. After all, we strictly enforce
> > the values are inside [0,1024], which leaves us with many unused values.
> > 
> > Specifically -1 comes to mind. It would allow doing this without an
> > extra flag, OTOH the explicit flag is well, more explicit.
> > 
> > I don't have a strong preference either way, but I wanted to make sure
> > it was considered, and perhaps we can record why this isn't as nice a
> > solution, dunno.
> 
> IMHO the '-1'  magic value approach is cleaner. Did some light testing on it.

I assume we agree then that we don't want to explicitly document this quirky
feature and keep it for advanced users?

I am wary of the UAPI change that is both explicit and implicit. It explicitly
requests a reset, but implicitly requests a cgroup behavior change.

With this magic value at least we can more easily return an error if we decided
to deprecate it, which has been my main ask so far. I don't want us to end up
not being able to easily modify this code in the future.

I don't have strong opinion too though.

If you or Yun would still like to send the patch to protect
SCHED_FLAG_UTIL_CLAMP and SCHED_FLAG_ALL with __kernel__ that'd be great.

> From 2e6a64fac4f2f66a2c6246de33db22c467fa7d33 Mon Sep 17 00:00:00 2001
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Wed, 11 Nov 2020 01:14:33 +0100
> Subject: [PATCH] sched/uclamp: Allow to reset a task uclamp constraint value
> 
> In case the user wants to stop controlling a uclamp constraint value
> for a task, use the magic value -1 in sched_util_{min,max} with the
> appropriate sched_flags (SCHED_FLAG_UTIL_CLAMP_{MIN,MAX}) to indicate
> the reset.
> 
> The advantage over the 'additional flag' approach (i.e. introducing
> SCHED_FLAG_UTIL_CLAMP_RESET) is that no additional flag has to be
> exported via uapi. This avoids the need to document how this new flag
> has be used in conjunction with the existing uclamp related flags.
> 
> The following subtle issue is fixed as well. When a uclamp constraint
> value is set on a !user_defined uclamp_se it is currently first reset
> and then set.
> Fix this by AND'ing !user_defined with !SCHED_FLAG_UTIL_CLAMP which
> stands for the 'sched class change' case.
> The related condition 'if (uc_se->user_defined)' moved from
> __setscheduler_uclamp() into uclamp_reset().
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  include/uapi/linux/sched/types.h |  4 +-
>  kernel/sched/core.c              | 70 +++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 21 deletions(-)
> 
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> index c852153ddb0d..b9165f17dddc 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -115,8 +115,8 @@ struct sched_attr {
>  	__u64 sched_period;
>  
>  	/* Utilization hints */
> -	__u32 sched_util_min;
> -	__u32 sched_util_max;
> +	__s32 sched_util_min;
> +	__s32 sched_util_max;
>  
>  };
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3dc415f58bd7..caaa2a8434b9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1413,17 +1413,24 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  static int uclamp_validate(struct task_struct *p,
>  			   const struct sched_attr *attr)
>  {
> -	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
> -	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
> +	int util_min = p->uclamp_req[UCLAMP_MIN].value;
> +	int util_max = p->uclamp_req[UCLAMP_MAX].value;
>  
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> -		lower_bound = attr->sched_util_min;
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> -		upper_bound = attr->sched_util_max;
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		util_min = attr->sched_util_min;
>  


> -	if (lower_bound > upper_bound)
> -		return -EINVAL;

You removed this check and didn't replace it with equivalent one?

> -	if (upper_bound > SCHED_CAPACITY_SCALE)
> +		if (util_min < -1 || util_min > SCHED_CAPACITY_SCALE)
> +			return -EINVAL;
> +	}
> +
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		util_max = attr->sched_util_max;
> +
> +		if (util_max < -1 || util_max > SCHED_CAPACITY_SCALE)
> +			return -EINVAL;
> +	}
> +
> +	if (util_min != -1 && util_max != -1 && util_min > util_max)
>  		return -EINVAL;

Ah, it is here. Never mind.

The approach looks good to me in general.

Thanks

--
Qais Yousef
