Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A524C2AA790
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgKGTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:15:07 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB7C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 11:15:06 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id w7so1090660pjy.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XuMf2vFa/wCJRuA/paCOhnoDGUc7DcVDOIyqAxrZ82s=;
        b=swgn45qmMV3SRMHHxSBIfzzBxqpmGpX44XtAMqVfpjK40rQv9E7vnz0AKF+wctyrmN
         Zs8fA8vID3sxdSmbX35GiYeBrPWRy25vNBarMWEAuyRthpApN0HKbMchSdoh51H6JNRU
         dTG1mts3ybln23lyOiATaGMfHkDjTEbEOfm8N9oIQGPHxz2q3ITuMU4IFPyqlZG3q3b0
         XK9INXw+Vmx1phnkekDPptJNkLyVtkxQ38GesfLNGFmunMc1SK0c589Pk2PeDskrwwWz
         +vIJXAJRv8QVlMGyalEW+phoH3gE30H36sQJbaiYo3FG1V/098AEESztDepmj/SX/1u6
         pkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XuMf2vFa/wCJRuA/paCOhnoDGUc7DcVDOIyqAxrZ82s=;
        b=rrUUCkTIUguSTFNcbi9rrkJeFp9wooE05tFo4PdeC2+s8Hkilu8gFUpo7DzarCR7YP
         dZX+kNaqh4TfC4iJ0sd4Cxfa+XY0LXu66RiPHfeCW/6TcVKqDgD/UQbyCopb4pXHBcB7
         zKZmqwl4qp140PcAvf4GUqZPY+UaoYB5bsx9dBaPomHGm8SVymkvndZLZR1czHFvdtq+
         84UT8dwste3D+mPmC6tnpetmrUtRGLBdUMW6n87j5QHh8PRO19abSsUk5JccRYyTrBlc
         gAiTOfTrzy7ka4/JxCqV1gzIum4EYxXL90XUYPoPSz7wAzr1Zkqlrftk1WnUob3kRMcz
         Fzaw==
X-Gm-Message-State: AOAM53113vYr/GCLEipejviPCrpYYdvfiUfwkIrs5//F6xXXQgjR7QY/
        +RI3UMnDf582WUq/XQN3TJU=
X-Google-Smtp-Source: ABdhPJwxguO33J3tWasa75gUAMYkiVd1pDVX+cDgSWjYJsOrgAS8AJI3VhjqSyoPlm3ujnCv/NVMpw==
X-Received: by 2002:a17:90a:bc4c:: with SMTP id t12mr5015511pjv.163.1604776505457;
        Sat, 07 Nov 2020 11:15:05 -0800 (PST)
Received: from ubuntu (1-171-247-95.dynamic-ip.hinet.net. [1.171.247.95])
        by smtp.gmail.com with ESMTPSA id e8sm5862777pfn.175.2020.11.07.11.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 11:15:04 -0800 (PST)
Date:   Sun, 8 Nov 2020 03:15:01 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     dietmar.eggemann@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201107191501.GB1056076@ubuntu>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <87blgag4an.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blgag4an.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Fri, Nov 06, 2020 at 11:36:48AM +0100, Patrick Bellasi wrote:
> 
> Hi Yun,
> thanks for keep improving this.
> 
> I'm replying here but still considering all other reviewers comments.
> 
> Best,
> Patrick
> 
> On Tue, Nov 03, 2020 at 03:37:56 +0100, Yun Hsiang <hsiang023167@gmail.com> wrote...
> 
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
> 
> This documentation should be added to the uapi header and, most
> importantly, in:
>   include/uapi/linux/sched/types.h
> where the documentation for struct sched_attr is provided.
> 
> 
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
> >  
> >  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> >  				 SCHED_FLAG_KEEP_PARAMS)
> >  
> 
> (Related to the following discussion point)
> What about adding in a comment here to call out that the following
> definitions are "internal only"?
> Moreover, we could probably wrap the following two define within an
> #ifdef __KERNEL__/#endif block
> 
> 
> Something like:
> 
> + /*
> + * The following definitions are internal only, do not use them to set
> + * set_{set,get}attr() params. Use instead a valid combination of the
> + * flags defined above.
> + */
> + #ifdef __KERNEL__
> 
> >  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> > -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> > +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> > +				 SCHED_FLAG_UTIL_CLAMP_RESET)
> 
> We need the _RESET flag only here (not below), since this is a UCLAMP
> feature and it's worth/useful to have a single "all uclamp flags"
> definition...
> 
> >  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
> >  			 SCHED_FLAG_RECLAIM		| \
> >  			 SCHED_FLAG_DL_OVERRUN		| \
> >  			 SCHED_FLAG_KEEP_ALL		| \
> > -			 SCHED_FLAG_UTIL_CLAMP)
> > +			 SCHED_FLAG_UTIL_CLAMP		| \
> > +			 SCHED_FLAG_UTIL_CLAMP_RESET)
> 
> ... i.e., you can drop the chunk above.

Yes, this chunk is redundant.

> 
> + #endif /* __KERNEL__ */
> 
> Regarding Qais comment, I had the same Dietmar's thought: I doubt there
> are apps using _FLAGS_ALL from userspace. For DL tasks, since they
> cannot fork, it makes no sense to specify, for example
> _RESET_ON_FORK|_RECLAIM. For CFS/RT tasks, where UCLAMP is supported, it
> makes no sense to specify DL flags.
> 
> It's true however that having this def here when it's supposed to be
> used only internally, can be kind of "confusing", but it's also useful
> to keep the definition aligned with the flags defined above.
> The ifdef wrapping proposed above should make this even more explicit.
> 
> Perhaps we can also better call this out also with an additional note
> right after:
> 
>   https://elixir.bootlin.com/linux/v5.9.6/source/include/uapi/linux/sched/types.h#L43
> 
> In that file, I believe the "Task Utilization Attributes" section can
> also be improved by adding a description of the _UCLAMP flags semantics.

I think SCHED_FLAG_ALL is for internal kernel use. So I agree with not
exporting it to user.

For the "Task Utilization Attributes" section, should I send a patch to
add some descriptions for _UCLAMP_{MIN/MAX} first?

> 
> 
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
> >  {
> 
> Again, IMO, this is _not_ an unrelated change at all. Actually, I still
> would like to do one step more and inline this function in the _only
> place_ where it's used. Qais arguments for not doing that where [1]:
> 
>   Updating the default rt value is done from different contexts. Hence
>   it is important to document the rules under which this update must
>   happen and ensure the update happens through a common path.
> 
> I don't see why these arguments are not satisfied when we inline, e.g.
> 
> ---8<---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..369074154e1d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1004,25 +1004,9 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
>         return uclamp_idle_value(rq, clamp_id, clamp_value);
>  }
>  
> -static void __uclamp_update_util_min_rt_default(struct task_struct *p)
> -{
> -       unsigned int default_util_min;
> -       struct uclamp_se *uc_se;
> -
> -       lockdep_assert_held(&p->pi_lock);
> -
> -       uc_se = &p->uclamp_req[UCLAMP_MIN];
> -
> -       /* Only sync if user didn't override the default */
> -       if (uc_se->user_defined)
> -               return;
> -
> -       default_util_min = sysctl_sched_uclamp_util_min_rt_default;
> -       uclamp_se_set(uc_se, default_util_min, false);
> -}
> -
>  static void uclamp_update_util_min_rt_default(struct task_struct *p)
>  {
> +       struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
>         struct rq_flags rf;
>         struct rq *rq;
>  
> @@ -1031,7 +1015,11 @@ static void uclamp_update_util_min_rt_default(struct task_struct *p)
>  
>         /* Protect updates to p->uclamp_* */
>         rq = task_rq_lock(p, &rf);
> -       __uclamp_update_util_min_rt_default(p);
> +
> +       /* Only sync if user didn't override the default */
> +       if (!uc_se->user_defined)
> +               uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt_default, false);
> +
>         task_rq_unlock(rq, p, &rf);
>  }
> ---8<---
> 
> [1] https://lore.kernel.org/lkml/20201028182946.6qfmt7q35ewrjjua@e107158-lin/

I can split this modification to a different patch. 

> 
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
> > +{
> > +	/* No _UCLAMP_RESET flag set: do not reset */
> 
>               ^^^^^^^^^^^^^
> Maybe better using the full flag name for all these?
> 

Got it!

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
> 
> I was suggesting maybe we need READ_ONCE() in the if above but did not
> addressed previous Dietmar's question [2] on why.
> 
> The function above has a correct semantics only when the ordering of the
> if statement is strictly observed.
> 
> Now, since we don't have any data dependency on the multiple if cases,
> are we sure an overzealous compiler will never come up with some
> "optimized reordering" of the checks required?
> 
> IOW, if the compiler could scramble the checks on an optimization, we
> would get a wrong semantics which is also very difficult do debug.
> Hence the idea to use READ_ONCE, to both tell the compiler to not
> even attempt reordering those checks and also to better document the
> code about the importance of the ordering on those checks.
> 
> Is now more clear? Does that makes sense?

I can undertand what your worries. But I'm not sure is it really needed.
If there is no other concern I can add it.

> 
> [2] https://lore.kernel.org/lkml/c59f7c85-59a2-488b-ce51-b3abee506dac@arm.com/
> 
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
> >  	}
> >  
> > -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> > +	if (likely(!(attr->sched_flags && SCHED_FLAG_UTIL_CLAMP)) ||
> > +		attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
> >  		return;
> 
> Parenthesis required for multi-line is statements.

Sorry for wrong coding style. I'll fix it.

> 
> Following chucks not required.

I'll drop these chunks.

> 
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
> >  }
> >  
> >  static void uclamp_fork(struct task_struct *p)
> 
