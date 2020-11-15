Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD42B3230
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 06:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKOFFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 00:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgKOFFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 00:05:33 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBB5C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 21:05:31 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id oc3so2411577pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 21:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p2CT0QSk2zlqu7H7KYUt8j9GpKmH7CpzPkYXyTfRlnM=;
        b=nGZ3UQNrFdHvJpkPImmDwDCk09VzhzA9TRENAS/NOFjXp/TFi6XmCu/Fey+9mskq+Q
         OSrYxhX56Ed5fpldvXa87j6qsgra6mpJOGwS5i7nMsFqtDh9BvTcjOzLEBZFnZtX7/R6
         lNhrr2DQmH1M+LoMvS5Lnoa/pKGmiYmjtvfcyDPjzs9aeZNr/Pf79O6O8z+MzYZXtyuf
         NBONqQa55VBxtnXcB1aeqIOYJS1beWVB+qvm33CyTL80U745tLtestiCq6/0ywROtE2z
         aztQ5/LHTAQE9Z0E1zcFblPa9PgU4wPzsJktIn0oEzgrZROk4cjctW0LRayklWbActvQ
         HWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2CT0QSk2zlqu7H7KYUt8j9GpKmH7CpzPkYXyTfRlnM=;
        b=cAuFIFLOC9iiPmzhe30YxMns2q9BMRyQBlrbDKwd9UMEDlXKcLKihpjyhJ+d2Qprhl
         BeXhbSXP833Arzd+CX8etybALkMZHdPf7Qbed5TVyRHxx5oYyNl4DANBnfctLEqMV4lu
         NfevJUJFj+04j+yGmvB+Oy3rYj2O7B9Zu363xTTEDNc8JhfLO4BUKZ6qf1KaA6nRm/Lt
         W4mZNbdkRWhBNlDrG9QLxsHATKjiunzjZL3xBM8EsbKF3BsCG95w1eKBDNIn6T63yUG8
         MGUBu8CrX1uN+MyKWvOpm1jiR9iKo4ULvQHKUCI1XzjS32FXxe+g3LpqK6df97AtnLG6
         JuwA==
X-Gm-Message-State: AOAM532igDS3UMqAs+dFkyY46qvdGCgFk2reSdTauQ6TuJepk7T1rDTj
        bjcjLt4dh15j/GStVv78uI0=
X-Google-Smtp-Source: ABdhPJzq2vU1KMFgoTH2N2QvkV0emkXnFoO9d42kUETJgcW4PeIogm0i5SYK2creMAH22TfzBIOAnw==
X-Received: by 2002:a17:902:be06:b029:d3:e6c5:52a0 with SMTP id r6-20020a170902be06b02900d3e6c552a0mr8274364pls.77.1605416730640;
        Sat, 14 Nov 2020 21:05:30 -0800 (PST)
Received: from ubuntu (111-243-118-92.dynamic-ip.hinet.net. [111.243.118.92])
        by smtp.gmail.com with ESMTPSA id n10sm2816406pgb.45.2020.11.14.21.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 21:05:29 -0800 (PST)
Date:   Sun, 15 Nov 2020 13:05:21 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2] sched/uclamp: Allow to reset a task uclamp constraint
 value
Message-ID: <20201115050521.GA1390370@ubuntu>
References: <20201113113454.25868-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113113454.25868-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,
On Fri, Nov 13, 2020 at 12:34:54PM +0100, Dietmar Eggemann wrote:
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

I think this is great, thanks!
Reviewed-by: Yun Hsiang <hsiang023167@gmail.com>

> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
> 
> v1 [1] -> v2:
> 
> 1) Removed struct sched_attr (UAPI) change.
> 
> 2) Use single branch range check in uclamp_validate().
> 
> [1] https://lkml.kernel.org/r/f3b59aad-3d5d-039b-205d-024308b609a1@arm.com
> 
>  include/uapi/linux/sched/types.h |  2 +
>  kernel/sched/core.c              | 70 +++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> index c852153ddb0d..f2c4589d4dbf 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -96,6 +96,8 @@ struct sched_param {
>   * on a CPU with a capacity big enough to fit the specified value.
>   * A task with a max utilization value smaller than 1024 is more likely
>   * scheduled on a CPU with no more capacity than the specified value.
> + *
> + * A task utilization boundary can be reset by setting the attribute to -1.
>   */
>  struct sched_attr {
>  	__u32 size;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3dc415f58bd7..a4805747b304 100644
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
> +		if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)
> +			return -EINVAL;
> +	}
> +
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		util_max = attr->sched_util_max;
> +
> +		if (util_max + 1 > SCHED_CAPACITY_SCALE + 1)
> +			return -EINVAL;
> +	}
> +
> +	if (util_min != -1 && util_max != -1 && util_min > util_max)
>  		return -EINVAL;
>  
>  	/*
> @@ -1438,20 +1445,41 @@ static int uclamp_validate(struct task_struct *p,
>  	return 0;
>  }
>  
> +static bool uclamp_reset(const struct sched_attr *attr,
> +			 enum uclamp_id clamp_id,
> +			 struct uclamp_se *uc_se)
> +{
> +	/* Reset on sched class change for a non user-defined clamp value. */
> +	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) &&
> +	    !uc_se->user_defined)
> +		return true;
> +
> +	/* Reset on sched_util_{min,max} == -1. */
> +	if (clamp_id == UCLAMP_MIN &&
> +	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
> +	    attr->sched_util_min == -1) {
> +		return true;
> +	}
> +
> +	if (clamp_id == UCLAMP_MAX &&
> +	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
> +	    attr->sched_util_max == -1) {
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void __setscheduler_uclamp(struct task_struct *p,
>  				  const struct sched_attr *attr)
>  {
>  	enum uclamp_id clamp_id;
>  
> -	/*
> -	 * On scheduling class change, reset to default clamps for tasks
> -	 * without a task-specific value.
> -	 */
>  	for_each_clamp_id(clamp_id) {
>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> +		unsigned int value;
>  
> -		/* Keep using defined clamps across class changes */
> -		if (uc_se->user_defined)
> +		if (!uclamp_reset(attr, clamp_id, uc_se))
>  			continue;
>  
>  		/*
> @@ -1459,21 +1487,25 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  		 * at runtime.
>  		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			__uclamp_update_util_min_rt_default(p);
> +			value = sysctl_sched_uclamp_util_min_rt_default;
>  		else
> -			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
> +			value = uclamp_none(clamp_id);
> +
> +		uclamp_se_set(uc_se, value, false);
>  
>  	}
>  
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
> +	    attr->sched_util_min != -1) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
>  	}
>  
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
> +	    attr->sched_util_max != -1) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>  			      attr->sched_util_max, true);
>  	}
> -- 
> 2.17.1
> 

Best Regards,
Yun
