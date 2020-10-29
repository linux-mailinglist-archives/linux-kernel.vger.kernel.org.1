Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196C029EC64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgJ2NCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgJ2NCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:02:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:02:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e15so2283219pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sz7n398cwBKh7JjqOtf7ES2DXfMLFKKgqnEGds9IebI=;
        b=EeLgfN65lnNMZmXJAKojPCDSL0HfEy/1atH5jyC4MELn7XRCglx9dQ83CM7HnuI2Nf
         90N1GolfK6OW+KnsXnafIc1RrRwhx+BGAkwpMHVAaQ93r/IIm9tWKJ/FTDtgZW6Lc/uD
         a0HhEp5cvpaCVxckkxmMyNrCizMNaG++9JlvvVCo6i1MlnncD0wH/w/VzMHP2/JJxMBc
         0yXWYrkyvapbPHnHwOf6tflZED988lbmjusvqf5Dorz43ilW2R3q7KiG7Lr4TYL/5EZV
         cgqRnEPzKV5B4XrBpjnr8KQEVeS29fzDmVaNAPjxcPsM8PzFLWxYsx6i4HWWBT2pvbP6
         /aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sz7n398cwBKh7JjqOtf7ES2DXfMLFKKgqnEGds9IebI=;
        b=jrrrunxGH+VszvxW/GGnFHLfMPXRAWH3FfCGzpXdqMUxzmW6x1AtMCn3wjK4c0qWhG
         ffVshYoblNlgagwwjFqTgiq+CEgoDbiN3ZRUGG/kewvkJD8wMvD2SInyAZjVMZN7Xgu0
         S521UqJYgCuMRNOVdKnq28/P5/OYjd3XtzuLW7RQPFQsYwzyMPQnDVjf5cZOEeD0Zk6i
         hdOWLEiAi1ff6Vk6mXH85FgPjwCiYeh1cZAjQ9TpCNkaYT9q/JwWlhjhCumAbkwMA3D4
         nYQh1UGQ8pnjTYBUn3esUDhueXN4bukZkUKb6ZCOgDvH3PIfv96zt0WKNjbFRGgH6L1b
         /r4Q==
X-Gm-Message-State: AOAM531PwMQJtu0eFjs3dMdzA5rkfAjxRHsfO2qU4Pug/IaXRcaPdjMh
        EykZ8rRxp6eRjm8Ho1OGr7E=
X-Google-Smtp-Source: ABdhPJxOYNs/gax03hNkvflsN1Qy3TB7AlwFP/YxeyWaP/GS1n9tXoNbY3o6ipiqG+ThWaco8wY1Xg==
X-Received: by 2002:a63:165d:: with SMTP id 29mr3993326pgw.391.1603976570986;
        Thu, 29 Oct 2020 06:02:50 -0700 (PDT)
Received: from ubuntu (1-171-243-36.dynamic-ip.hinet.net. [1.171.243.36])
        by smtp.gmail.com with ESMTPSA id bo16sm3184480pjb.41.2020.10.29.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:02:50 -0700 (PDT)
Date:   Thu, 29 Oct 2020 21:02:43 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     dietmar.eggemann@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201029130243.GA897607@ubuntu>
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <20201029110818.alrviwwljxnegmip@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029110818.alrviwwljxnegmip@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Thu, Oct 29, 2020 at 11:08:18AM +0000, Qais Yousef wrote:
> Hi Yun
> 
> Sorry for chipping in late.
> 
> On 10/25/20 15:36, Yun Hsiang wrote:
> > If the user wants to stop controlling uclamp and let the task inherit
> > the value from the group, we need a method to reset.
> > 
> > Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> > sched_setattr syscall.
> > 
> > The policy is
> > _CLAMP_RESET                           => reset both min and max
> > _CLAMP_RESET | _CLAMP_MIN              => reset min value
> > _CLAMP_RESET | _CLAMP_MAX              => reset max value
> > _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> > 
> > Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> > ---
> >  include/uapi/linux/sched.h |  7 +++++--
> >  kernel/sched/core.c        | 41 +++++++++++++++++++++++++++++++-------
> >  2 files changed, 39 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 3bac0a8ceab2..6c823ddb1a1e 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -132,17 +132,20 @@ struct clone_args {
> >  #define SCHED_FLAG_KEEP_PARAMS		0x10
> >  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
> >  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> > +#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
> >  
> >  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> >  				 SCHED_FLAG_KEEP_PARAMS)
> >  
> >  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> > -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> > +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> > +				 SCHED_FLAG_UTIL_CLAMP_RESET)
> 
> Is it safe to change this define in a uapi header without a potential
> consequence?
> 
> FWIW I still have concerns about this approach. We're doing a reset to control
> cgroup behavior, I don't see any correlation between the two. Besides the
> difference between RESET and setting uclamp_min=0 without RESET is not obvious
> nor intuitive for someone who didn't look at the code.
> 
> I propose something like the below which is more explicit about what is being
> requested and delivered here. And if we decide to deprecate this behavior,
> it'd be much easier to just ignore this flag.
> 
> You must set this flag with your uclamp request to retain the cgroup
> inheritance behavior. If the flag is not set, we automatically clear it.

I think this behavior may not meet android requirement. Becasue in
android there is group like top-app. And we want to boost the
group by setting group uclamp_min. If group inheritance is explicit, we
need to set this flag for all the tasks in top-app. This might be
costly.

> 
> Only compile tested.
> 
> Thanks
> 
> --
> Qais Yousef
> 
> 
> --------->8-----------
> 
> From fe48fde7dea582b3b075e80e6936e1199f24363d Mon Sep 17 00:00:00 2001
> From: Qais Yousef <qais.yousef@arm.com>
> Date: Wed, 28 Oct 2020 22:36:26 +0000
> Subject: [PATCH] sched/uclamp: Add new flag to control cgroup behavior
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  include/linux/sched.h      |  1 +
>  include/uapi/linux/sched.h |  6 ++++++
>  kernel/sched/core.c        | 25 ++++++++++++++++---------
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index afe01e232935..6eb35dfaa893 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -604,6 +604,7 @@ struct uclamp_se {
>  	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
>  	unsigned int active		: 1;
>  	unsigned int user_defined	: 1;
> +	unsigned int follow_cgroup	: 1;
>  };
>  #endif /* CONFIG_UCLAMP_TASK */
>  
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 3bac0a8ceab2..33ff716a7574 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -132,6 +132,12 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +/*
> + * Control whether a task follows/inherits the cgroup uclamp.min/max or not.
> + * By default this flag is set for all tasks. Any explicit modification to a
> + * task's UCLAMP_MIN/MAX must set this flag to retain the bahavior.
> + */
> +#define SCHED_FLAG_UTIL_FOLLOW_CGROUP	0x80
>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..1c77d6b8bd96 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1083,7 +1083,7 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  		return uc_req;
>  
>  	uc_max = task_group(p)->uclamp[clamp_id];
> -	if (uc_req.value > uc_max.value || !uc_req.user_defined)
> +	if (uc_req.value > uc_max.value || uc_req.follow_cgroup)
>  		return uc_max;
>  #endif
>  
> @@ -1446,6 +1446,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  				  const struct sched_attr *attr)
>  {
>  	enum uclamp_id clamp_id;
> +	bool follow_cgroup;
>  
>  	/*
>  	 * On scheduling class change, reset to default clamps for tasks
> @@ -1472,14 +1473,18 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> +	follow_cgroup = attr->sched_flags & SCHED_FLAG_UTIL_FOLLOW_CGROUP;
> +
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> -		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> -			      attr->sched_util_min, true);
> +		struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> +		uc_se->follow_cgroup = follow_cgroup;
> +		uclamp_se_set(uc_se, attr->sched_util_min, true);
>  	}
>  
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> -		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> -			      attr->sched_util_max, true);
> +		struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MAX];
> +		uc_se->follow_cgroup = follow_cgroup;
> +		uclamp_se_set(uc_se, attr->sched_util_max, true);
>  	}
>  }
>  
> @@ -1498,8 +1503,9 @@ static void uclamp_fork(struct task_struct *p)
>  		return;
>  
>  	for_each_clamp_id(clamp_id) {
> -		uclamp_se_set(&p->uclamp_req[clamp_id],
> -			      uclamp_none(clamp_id), false);
> +		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> +		uc_se->follow_cgroup = true;
> +		uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
>  	}
>  }
>  
> @@ -1532,8 +1538,9 @@ static void __init init_uclamp(void)
>  		init_uclamp_rq(cpu_rq(cpu));
>  
>  	for_each_clamp_id(clamp_id) {
> -		uclamp_se_set(&init_task.uclamp_req[clamp_id],
> -			      uclamp_none(clamp_id), false);
> +		struct uclamp_se *uc_se = &init_task.uclamp_req[clamp_id];
> +		uc_se->follow_cgroup = true;
> +		uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
>  	}
>  
>  	/* System defaults allow max clamp values for both indexes */
> -- 
> 2.25.1
