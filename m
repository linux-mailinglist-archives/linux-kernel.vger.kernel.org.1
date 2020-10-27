Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA75629BB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808802AbgJ0QWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:22:39 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37197 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758183AbgJ0P6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:58:23 -0400
Received: by mail-pj1-f67.google.com with SMTP id lt2so963853pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SoTaUfKUJiDUW2h9mVvR0z/C6fXDGCdxxD7m50xJHb8=;
        b=rybjDI81CxzKYzrASZ5gv2AhvfYB5PzaVZC9/2aiQonUm5lgOrk+EaY3p4Z8h1zsPb
         k5Dkt9Gi3ZQpr3+JaIyFzHb3C/PUR5vKuKM2XB4WPxkd8eoSEDlHwPQ9QXeIQDj00Yvj
         XNydCwLLfiNi1gLL5bfDTPVNHGaZISJfcBnG8r30HZZqpIds8u0+lxzqSHy17xmAoV04
         8iCx+tJxTrJFvXIOhg6FGAh85pzmuPP/1pMH6/GmTx1umS3H4tLulbOWYaSXCr2fJn9J
         L/E8CVV+4lRQR+aEc5oUHx21LJ7mtfDeCeytEFOIe50U/nHwbD7AYdqIava2UhsivQpQ
         rujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SoTaUfKUJiDUW2h9mVvR0z/C6fXDGCdxxD7m50xJHb8=;
        b=TW0CqycXbu+5cjwEPiws/1W+e7zDkUyOkju2Co8qSJdCjE0iFcpm59O6pbovB36CcY
         vttbHiI/XuNsoqZ2aImXCk7NX9DE6phtGRKJuPbZyp7AgPJeds0XvigLQWwW7zYpYMzF
         SbScJ5CmlK+ksGBIJjwXqNnJjSQDc7ublA6ybubthJVh6ub4iuOLRyYd3klPmLJE1Pj5
         t9mSHw1BIUN9QkCYBZJSELwypBrlHzG1WD4MJCFyleFW+OsFY4M52JFtI6y9TnFmwUlF
         JaNg+0IyJfqBPoa09b9bXVHOMMIEGRLO1a2hoEA3b+TsaLtR5GFLPHpJKRy3RdqAAtzM
         YUDA==
X-Gm-Message-State: AOAM530vSgHbhkVZavYmsgf+m+AIdOJ9AE409AOqTB2onv7zGtmVbhu/
        4df9jmrRkbhX47JptaCQsig=
X-Google-Smtp-Source: ABdhPJz3Mhrkhhf6pw0Fakr4CvuPUHpSyI4t16gepWBLRKml1tb0WsR1Rp2tFfUCg6IfOtauFBvkeA==
X-Received: by 2002:a17:902:8605:b029:d5:a6dc:ad0a with SMTP id f5-20020a1709028605b02900d5a6dcad0amr2996510plo.56.1603814302199;
        Tue, 27 Oct 2020 08:58:22 -0700 (PDT)
Received: from ubuntu (1-171-243-36.dynamic-ip.hinet.net. [1.171.243.36])
        by smtp.gmail.com with ESMTPSA id a11sm2623072pfn.125.2020.10.27.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 08:58:21 -0700 (PDT)
Date:   Tue, 27 Oct 2020 23:58:13 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201027155813.GA818508@ubuntu>
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Mon, Oct 26, 2020 at 08:00:48PM +0100, Dietmar Eggemann wrote:
> On 26/10/2020 16:45, Yun Hsiang wrote:
> > Hi Dietmar,
> > 
> > On Mon, Oct 26, 2020 at 10:47:11AM +0100, Dietmar Eggemann wrote:
> >> On 25/10/2020 08:36, Yun Hsiang wrote:
> >>> If the user wants to stop controlling uclamp and let the task inherit
> >>> the value from the group, we need a method to reset.
> >>>
> >>> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> >>> sched_setattr syscall.
> >>>
> >>> The policy is
> >>> _CLAMP_RESET                           => reset both min and max
> >>> _CLAMP_RESET | _CLAMP_MIN              => reset min value
> >>> _CLAMP_RESET | _CLAMP_MAX              => reset max value
> >>> _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> >>>
> >>> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> >>
> >> [...]
> >>
> >>> @@ -1451,7 +1464,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >>>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> >>>  
> >>>  		/* Keep using defined clamps across class changes */
> >>> -		if (uc_se->user_defined)
> >>> +		if (flags != SCHED_FLAG_UTIL_CLAMP_RESET &&
> >>> +				uc_se->user_defined)
> >>>  			continue;
> >>
> >> With:
> >>
> >> (1) _CLAMP_RESET                           => reset both min and max
> >> (2) _CLAMP_RESET | _CLAMP_MIN              => reset min value
> >> (3) _CLAMP_RESET | _CLAMP_MAX              => reset max value
> >> (4) _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> >>
> >> If you reset an RT task with (1) you don't reset its uclamp.min value.
> >>
> >> __uclamp_update_util_min_rt_default(p) doesn't know about
> >> SCHED_FLAG_UTIL_CLAMP_RESET. It only knows user_defined and will bail early.
> >>
> > 
> > Sorry I didn't notice __uclamp_update_util_min_rt_default will return
> > directly if user_defined is set, I'll fix it.
> > 
> >> [...]
> >>
> >>> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> >>> +	if (likely(!flags || flags == SCHED_FLAG_UTIL_CLAMP_RESET))
> >>>  		return;
> >>>  
> >>> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >>> +	if (flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >>> +		if (reset) {
> >>> +			clamp_value = __default_uclamp_value(p, UCLAMP_MIN);
> >>> +			user_defined = false;
> >>> +		} else {
> >>> +			clamp_value = attr->sched_util_min;
> >>> +			user_defined = true;
> >>> +		}
> >>
> >> Why do you reset for (1) in the for_each_clamp_id(clamp_id) loop and for
> >> (2)-(4) in the if (flags & SCHED_FLAG_UTIL_CLAMP_MXX) condition?
> >>
> >> You could reset (1)-(4) in the for_each_clamp_id(clamp_id) loop? In this
> >> case you wouldn't need __default_uclamp_value().
> > 
> > Do you mean adding these code in for_each_clamp_id(clamp_id) loop?
> > 
> > if (clamp_id == UCLAMP_MIN) {
> > 	if (flags == SCHED_FLAG_UTIL_CLAMP_RESET || 
> > 		(reset && (flags || SCHED_FLAG_UTIL_CLAMP_MIN)) ||
> > 		!se->user_defined) {
> > 		if (task_rt(p)) {
> > 			clamp_value = sysctl_sched_uclamp_util_min_rt_default
> > 		} else {
> > 			clamp_value = uclamp_none(clamp_id);
> > 		}
> > 	} else 
> > 		continue;
> > }
> > /* similar code for UCLAMP_MAX */
> > ...
> > uclamp_se_set(uc_se, clamp_value, false);
> > 
> > It seems more clear.
> > If you think this one is better, I'll use this method and send patch V4.
> 
> I thought about something like this. Only lightly tested. 
> 
> ---8<---
> 
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Mon, 26 Oct 2020 13:52:23 +0100
> Subject: [PATCH] SCHED_FLAG_UTIL_CLAMP_RESET
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  include/uapi/linux/sched.h |  4 +++-
>  kernel/sched/core.c        | 31 +++++++++++++++++++++++++++----
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 3bac0a8ceab2..0dd890822751 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -132,12 +132,14 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
>  
>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> +				 SCHED_FLAG_UTIL_CLAMP_RESET)
>  
>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>  			 SCHED_FLAG_RECLAIM		| \
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3dc415f58bd7..717b1cf5cf1f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1438,6 +1438,23 @@ static int uclamp_validate(struct task_struct *p,
>  	return 0;
>  }
>  
> +static bool uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
> +{
> +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
> +		return false;
> +
> +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
> +		return true;
> +
> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
> +		return true;
> +
> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void __setscheduler_uclamp(struct task_struct *p,
>  				  const struct sched_attr *attr)
>  {
> @@ -1449,24 +1466,30 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	 */
>  	for_each_clamp_id(clamp_id) {
>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> +		unsigned int value;
>  
>  		/* Keep using defined clamps across class changes */
> -		if (uc_se->user_defined)
> +		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
> +		    uc_se->user_defined) {
>  			continue;
> +		}
>  
>  		/*
>  		 * RT by default have a 100% boost value that could be modified
>  		 * at runtime.
>  		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			__uclamp_update_util_min_rt_default(p);
> +			value = sysctl_sched_uclamp_util_min_rt_default;
>  		else
> -			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
> +			value = uclamp_none(clamp_id);
>  
> +		uclamp_se_set(uc_se, value, false);
>  	}
>  
> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> +	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) ||
> +	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET) {
>  		return;
> +	}
>  
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],

Got it. This is much better. I'll test and send patch V4.
Thank for review and suggestions!

> -- 
> 2.17.1
> 
> 
> 

Best Regards,
Yun
