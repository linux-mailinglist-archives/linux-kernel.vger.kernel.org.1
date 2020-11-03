Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFF12A46CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgKCNsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:48:30 -0500
Received: from foss.arm.com ([217.140.110.172]:49210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgKCNsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:48:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F321106F;
        Tue,  3 Nov 2020 05:48:11 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7022A3F718;
        Tue,  3 Nov 2020 05:48:10 -0800 (PST)
Date:   Tue, 3 Nov 2020 13:48:08 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     dietmar.eggemann@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201103134808.27xi27xodj6dvlt2@e107158-lin.cambridge.arm.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201103134644.rafsqisz7fxopo5n@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103134644.rafsqisz7fxopo5n@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, +Juri for real this time.

On 11/03/20 13:46, Qais Yousef wrote:
> Hi Yun
> 
> +Juri (A question for you below)
> 
> On 11/03/20 10:37, Yun Hsiang wrote:
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
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  include/uapi/linux/sched.h |  7 +++--
> >  kernel/sched/core.c        | 59 ++++++++++++++++++++++++++++----------
> >  2 files changed, 49 insertions(+), 17 deletions(-)
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
> 
> The new flag needs documentation about how it should be used. It has a none
> obvious policy that we can't expect users to just get it.
> 
> >  
> >  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> >  				 SCHED_FLAG_KEEP_PARAMS)
> >  
> >  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> > -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> > +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> > +				 SCHED_FLAG_UTIL_CLAMP_RESET)
> 
> Either do this..
> 
> >  
> >  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
> >  			 SCHED_FLAG_RECLAIM		| \
> >  			 SCHED_FLAG_DL_OVERRUN		| \
> >  			 SCHED_FLAG_KEEP_ALL		| \
> > -			 SCHED_FLAG_UTIL_CLAMP)
> > +			 SCHED_FLAG_UTIL_CLAMP		| \
> > +			 SCHED_FLAG_UTIL_CLAMP_RESET)
> 
> Or this.
> 
> I checked glibc and it seems they don't use the sched.h from linux and more
> surprisingly they don't seem to have a wrapper for sched_setattr(). bionic libc
> from Android does take sched.h from linux, but didn't find any user. So we
> might be okay with modifying these here.
> 
> I still would like us to document better what we expect from these defines.
> Are they for internal kernel use or really for user space? If the former we
> should take them out of here. If the latter, then adding the RESET is dangerous
> as it'll cause an observable change in behavior; that is if an application was
> using SCHED_FLAG_ALL or SCHED_FLAG_UTIL_CLAMP to update the UTIL_MIN/MAX of
> a task, existing binaries will find out now that instead of modifying the value
> they're actually resetting them.
> 
> Juri, it seems you originally introduced SCHED_FLAG_ALL. I assume this was some
> sort of shorthand for user space, not the kernel?
> 
> If the latter, I think we should move SCHED_FLAG_ALL and SCHED_FLAG_UTIL_CLAMP
> to core.c and hope no one is already relying on them.
> 
> >  
> >  #endif /* _UAPI_LINUX_SCHED_H */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 8160ab5263f8..6ae463b64834 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1004,7 +1004,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
> >  	return uclamp_idle_value(rq, clamp_id, clamp_value);
> >  }
> >  
> > -static void __uclamp_update_util_min_rt_default(struct task_struct *p)
> > +static inline void __uclamp_update_util_min_rt_default(struct task_struct *p)
> 
> Seems unrelated change. Worth a mention in the commit message at least.
> 
> >  {
> >  	unsigned int default_util_min;
> >  	struct uclamp_se *uc_se;
> > @@ -1413,8 +1413,14 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  static int uclamp_validate(struct task_struct *p,
> >  			   const struct sched_attr *attr)
> >  {
> > -	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
> > -	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
> > +	unsigned int lower_bound, upper_bound;
> > +
> > +	/* Do not check uclamp attributes values in reset case. */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
> > +		return 0;
> > +
> > +	lower_bound = p->uclamp_req[UCLAMP_MIN].value;
> > +	upper_bound = p->uclamp_req[UCLAMP_MAX].value;
> >  
> >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> >  		lower_bound = attr->sched_util_min;
> > @@ -1438,20 +1444,43 @@ static int uclamp_validate(struct task_struct *p,
> >  	return 0;
> >  }
> >  
> > +static int uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
> 
> Add the policy part of the commit message as a documentation to this function
> please.
> 
> ie:
> 
> 	/*
> 	 * The policy is
> 	 * _CLAMP_RESET                           => reset both min and max
> 	 * _CLAMP_RESET | _CLAMP_MIN              => reset min value
> 	 * _CLAMP_RESET | _CLAMP_MAX              => reset max value
> 	 * _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> 	 */
> 
> > +{
> > +	/* No _UCLAMP_RESET flag set: do not reset */
> > +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
> > +		return false;
> > +
> > +	/* Only _UCLAMP_RESET flag set: reset both clamps */
> > +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
> > +		return true;
> > +
> > +	/* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
> > +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
> > +		return true;
> > +
> > +	/* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
> > +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static void __setscheduler_uclamp(struct task_struct *p,
> >  				  const struct sched_attr *attr)
> >  {
> >  	enum uclamp_id clamp_id;
> >  
> >  	/*
> > -	 * On scheduling class change, reset to default clamps for tasks
> > -	 * without a task-specific value.
> > +	 * Reset to default clamps on forced _UCLAMP_RESET (always) and
> > +	 * for tasks without a task-specific value (on scheduling class change).
> >  	 */
> >  	for_each_clamp_id(clamp_id) {
> > +		unsigned int clamp_value;
> >  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> >  
> >  		/* Keep using defined clamps across class changes */
> > -		if (uc_se->user_defined)
> > +		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
> > +				uc_se->user_defined)
> >  			continue;
> >  
> >  		/*
> > @@ -1459,24 +1488,24 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  		 * at runtime.
> >  		 */
> >  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > -			__uclamp_update_util_min_rt_default(p);
> > +			clamp_value = sysctl_sched_uclamp_util_min_rt_default;
> >  		else
> > -			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
> > +			clamp_value = uclamp_none(clamp_id);
> >  
> > +		uclamp_se_set(uc_se, clamp_value, false);
> 
> This is another unrelated change. Add a comment in the commit message at least
> please.
> 
> >  	}
> >  
> > -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> > +	if (likely(!(attr->sched_flags && SCHED_FLAG_UTIL_CLAMP)) ||
> > +		attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
> >  		return;
> >  
> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> > -			      attr->sched_util_min, true);
> > -	}
> > +				attr->sched_util_min, true);
> >  
> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> > -			      attr->sched_util_max, true);
> > -	}
> > +				attr->sched_util_max, true);
> 
> These two hunks seem unrelated too. Multi line statement should still have
> braces AFAIK. Why change it?
> 
> Generally personally I am not fond of mixing 'cleanup' and modifications.
> Especially when they are unrelated. They come across as churn to me but
> I won't insist on removing/splitting them but at least document them in the
> commit message with good reasons please.
> 
> Thanks
> 
> --
> Qais Yousef
> 
> >  }
> >  
> >  static void uclamp_fork(struct task_struct *p)
> > -- 
> > 2.25.1
> > 
