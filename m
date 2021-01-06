Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACE2EC032
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAFPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAFPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:14:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA75C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=98TLLVADKZ0m0Lz+ID8mq10OWU4Hy5Pg30XNRCWT+2I=; b=QZeR5a8OK3DeH6iyytK9gVERbR
        +9TZImB/vIFdoZ4BmrFHX1bZlNYEclyFi0+gdpUfvJRglKmal/QF2nHudvBnp3Suoa12vnCdzr5Jy
        2MXwVl+NgdAtQiklJWNmvIoQQLA7exw/jjhQ11YgxPBdxZdISmIUBHmx2RoRVMusMcyFCclI6qqLx
        Qc+bz9wgsJT28Ai75ssITqNhRy2Q2QzAPKx+m/mJPD6unsJS0Qk2mU6OemCaZ+LS58IyR2FH8I1j5
        w5hygHnrJYhwed2xmLKizC3txZh3zuZX82DdIy2S3khY9zHlfB9dEw7n6zGlzepi79cPvVur5asH0
        B7sk9WfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxAV5-0006qY-Ci; Wed, 06 Jan 2021 15:13:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E32883013E5;
        Wed,  6 Jan 2021 16:13:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCD05202A3CED; Wed,  6 Jan 2021 16:13:25 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:13:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/fair: reduce cases for active balance
Message-ID: <X/XTlRMiOVs7L28B@hirez.programming.kicks-ass.net>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106133419.2971-4-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 02:34:19PM +0100, Vincent Guittot wrote:
> Active balance is triggered for a number of voluntary case like misfit or
							cases
> pinned tasks cases but also after that a number of load balance failed to
								 ^attempts
> migrate a task. Remove the active load balance case for overloaded group
							 ^an ?
> as an overloaded state means that there is at least one waiting tasks. The
								  task
> threshold on the upper limit of the task's load will decrease with the
> number of failed LB until the task has migrated.

And I'm not sure I follow that last part, irrespective of spelling nits,
help?

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 43 +++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a455113b10..ee87fd6f7359 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9499,13 +9499,30 @@ asym_active_balance(struct lb_env *env)
>  }
>  
>  static inline bool
> -voluntary_active_balance(struct lb_env *env)
> +imbalanced_active_balance(struct lb_env *env)
> +{
> +	struct sched_domain *sd = env->sd;
> +
> +	/* The imbalanced case includes the case of pinned tasks preventing a fair
> +	 * distribution of the load on the system but also the even distribution of the
> +	 * threads on a system with spare capacity
> +	 */

comment style fail

> +	if ((env->migration_type == migrate_task) &&
> +		(sd->nr_balance_failed > sd->cache_nice_tries+2))

indent fail; try: set cino=(0:0

> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int need_active_balance(struct lb_env *env)
>  {
>  	struct sched_domain *sd = env->sd;
>  
>  	if (asym_active_balance(env))
>  		return 1;
>  
> +	if (imbalanced_active_balance(env))
> +		return 1;

+ whitespace

>  	/*
>  	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
>  	 * It's worth migrating the task if the src_cpu's capacity is reduced
