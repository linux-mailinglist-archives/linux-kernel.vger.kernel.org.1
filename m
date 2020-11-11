Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B352AF7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKKSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgKKSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:05:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6315C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P16FHAb3A4K3ENj/hrLU4GXYLbiPalcs86Yi2WMI2eY=; b=KSrP7M7uBk+P2PqH5o5SAgPiBP
        kLPtQxCkWxr0r/ShpK1GZzfDdbwgPsPG+wO1/R6flMpPUNieRLFZMt0Uz62ZNWTLyKoNYV6GmJtGZ
        1bjTJ4Cn4JR/xwsCmpYH/Tbu99u50ryBHpGCogWfiKQS5PeG73eE+GW6rt8KyPp4O0NwKLFhThfqx
        wEtSs1fy9YoWu7H/wCAwSBtqS4aiRuflJ2OOIbuqbTKniEWCkDS89OdwEKNGvmwtiZ8PCIFph32kK
        9FJXQkQzTBgeHiLeROYsTUwp0dyJ02Pm9weS7Jt9c9vik3ecsL4vVa2cIfGBfOenqaD8HVZudhmOJ
        UijpnExA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcuU6-0007By-6L; Wed, 11 Nov 2020 18:04:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9739D301E02;
        Wed, 11 Nov 2020 19:04:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D31F20A2A303; Wed, 11 Nov 2020 19:04:41 +0100 (CET)
Date:   Wed, 11 Nov 2020 19:04:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201111180441.GJ2628@hirez.programming.kicks-ass.net>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
 <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 06:41:07PM +0100, Dietmar Eggemann wrote:
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

So that's UAPI, not sure we can change the type here.

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

Luckily we can write that range as a single branch like:

	if (util_{min,max} + 1 > SCHED_CAPACITY_SCALE+1)

which assumes u32 :-)

> +
> +	if (util_min != -1 && util_max != -1 && util_min > util_max)
>  		return -EINVAL;

I think that will compile as is, otherwise write it like ~0u, which is
the same bit pattern.

