Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C487729D829
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgJ1WaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733237AbgJ1WaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:30:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81236C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:30:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j7so1206028oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xoNLZX2kytDJAG6iyD8pKQCpvw3szuuKK9Fr+QAvEWc=;
        b=FQZDGrfBDWDkcwdparwGbXBQ46zLdbW0AOJtGjJAFkdBAXXVGQKZB8B+zQxK+E1+rX
         3A5KzGKKafeNqdPXocmQY9RwuTLje/H64ns3fND5IU7gKiUuTMHP2a0tBBUFtYWVuj40
         gUGUcVm+qaVRoSJQ0iaoc9VKCnklMpYDP8L3Umc3bTzrpBwY7gsY69dXvhcKKe7mB8Eu
         SFsK4Hl37evix0hYcqPtDxO48qZTXu3uhCF2gMKDEj/aI6ZWFvinA7dgjiRKo6l3MeC0
         +pdIi+P8TMtXzAP60BKZCB3qxIUdaNbHTZAaHcz8kanrryeJari4M4jkWJ/1DYejfzVM
         MPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xoNLZX2kytDJAG6iyD8pKQCpvw3szuuKK9Fr+QAvEWc=;
        b=fXyatKNxNKhu2juA8ppGIqPsthR+/hNJi71stbu3EQ6WLACJyR1VdM2z8Rqi6aB1LM
         GvzkHUy5Px4kYNqX1nFy7rLhe56sREGWwDl4CoWmuJLN0EXPDniHC3x2qb2uAd3H43Xg
         fNTlmYhBov0g3k5Nx/4N9ckXd1LaZlNukOn+Dc/nCajJjZc44a2VppVHxWdEMU56Wj1u
         VNA2IsH0mkzmAt7UgPMCgGC304AFhgBMsFnpanhAcBoMccTHqf1g0EhoXqNwUdb/+9Sm
         jZm3GDnAoyEY6wCyeVOIYyCFMBO92sVpajv/Jxjx2TOiwDkFrZWmY50rW2+YS3V+TTJl
         Vfew==
X-Gm-Message-State: AOAM531mCsYWlFRsrP/NwyFLO5hlWg85pfUOozvv9N9TfHbD6nSKeC5c
        nbwULFtNvu4aqImtYRMTwtgeOTKmF0zZya+P
X-Google-Smtp-Source: ABdhPJxUKGelLT+Cany3mDQ89agWyQCjeIib2RcSM12VKUk9k6zM7ad0MFP7iTd6LG85jKNirDjlHA==
X-Received: by 2002:a17:90b:797:: with SMTP id l23mr295029pjz.136.1603910510757;
        Wed, 28 Oct 2020 11:41:50 -0700 (PDT)
Received: from ubuntu (1-171-243-36.dynamic-ip.hinet.net. [1.171.243.36])
        by smtp.gmail.com with ESMTPSA id e7sm271786pfn.180.2020.10.28.11.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:41:49 -0700 (PDT)
Date:   Thu, 29 Oct 2020 02:41:43 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201028184143.GA886080@ubuntu>
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
 <20201027155813.GA818508@ubuntu>
 <87v9eumzic.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9eumzic.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Wed, Oct 28, 2020 at 11:11:07AM +0100, Patrick Bellasi wrote:
> 
> Hi Dietmar, Yun,
> I hope I'm not too late before v4 posting ;)
> 
> I think the overall approach is sound, I just added in a couple of
> cleanups and a possible fix (user_defined reset).
> 
> Best,
> Patrick
> 
> 
> On Tue, Oct 27, 2020 at 16:58:13 +0100, Yun Hsiang <hsiang023167@gmail.com> wrote...
> 
> > Hi Diet mar,
> > On Mon, Oct 26, 2020 at 08:00:48PM +0100, Dietmar Eggemann wrote:
> >> On 26/10/2020 16:45, Yun Hsiang wrote:
> 
> [...]
> 
> >> I thought about something like this. Only lightly tested. 
> >> 
> >> ---8<---
> >> 
> >> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> Date: Mon, 26 Oct 2020 13:52:23 +0100
> >> Subject: [PATCH] SCHED_FLAG_UTIL_CLAMP_RESET
> >> 
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> ---
> >>  include/uapi/linux/sched.h |  4 +++-
> >>  kernel/sched/core.c        | 31 +++++++++++++++++++++++++++----
> >>  2 files changed, 30 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> >> index 3bac0a8ceab2..0dd890822751 100644
> >> --- a/include/uapi/linux/sched.h
> >> +++ b/include/uapi/linux/sched.h
> >> @@ -132,12 +132,14 @@ struct clone_args {
> >>  #define SCHED_FLAG_KEEP_PARAMS		0x10
> >>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
> >>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> >> +#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
> >>  
> >>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> >>  				 SCHED_FLAG_KEEP_PARAMS)
> >>  
> >>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> >> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> >> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> >> +				 SCHED_FLAG_UTIL_CLAMP_RESET)
> >>  
> >>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
> >>  			 SCHED_FLAG_RECLAIM		| \
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 3dc415f58bd7..717b1cf5cf1f 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -1438,6 +1438,23 @@ static int uclamp_validate(struct task_struct *p,
> >>  	return 0;
> >>  }
> >>  
> >> +static bool uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
> >> +{
> 
> Maybe we can add in some comments?
>
I'll add these comment.
> 
>         /* No _UCLAMP_RESET flag set: do not reset */
> >> +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
> >> +		return false;
> >> +
> 
>         /* Only _UCLAMP_RESET flag set: reset both clamps */
> >> +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
> >> +		return true;
> >> +
>         /* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
> >> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
> >> +		return true;
> >> +
> 
>         /* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
> >> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
> >> +		return true;
> 
> Since the evaluation ordering is important, do we have to better
> _always_ use a READ_ONCE() for all flags accesses above, to ensure it is
> preserved?
>

Is this mean that we want to use READ_ONCE to avoid compiler reordering these
conditions?

> >> +
> >> +	return false;
> >> +}
> >> +
> >>  static void __setscheduler_uclamp(struct task_struct *p,
> >>  				  const struct sched_attr *attr)
> >>  {
> >> @@ -1449,24 +1466,30 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >>  	 */
> 
> Perhaps we should update the comment above this loop with something
> like:
> 
>         /*
>          * Reset to default clamps on forced _UCLAMP_RESET (always) and
>          * for tasks without a task-specific value (on scheduling class change).
>          */
> >>  	for_each_clamp_id(clamp_id) {
> >>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> >> +		unsigned int value;
> >>  
> >>  		/* Keep using defined clamps across class changes */
> >> -		if (uc_se->user_defined)
> >> +		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
> >> +		    uc_se->user_defined) {
> >>  			continue;
> >> +		}
> 
> I think we miss to reset the user_defined flag here.
> 
> What about replacing the above chunk with:
> 
>                 if (uclamp_reset(clamp_id, attr->sched_flags))
>                         uc_se->user_defined = false;
>                 if (uc-se->user_defined)
>                         continue;
> 
> ?

user_defined flag will be reset later by uclamp_se_set(uc_se, value,
false). But I agree to split it to two condition because it seems
clearer.

> 
> 
> >>  
> >>  		/*
> >>  		 * RT by default have a 100% boost value that could be modified
> >>  		 * at runtime.
> >>  		 */
> >>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> >> -			__uclamp_update_util_min_rt_default(p);
> >> +			value = sysctl_sched_uclamp_util_min_rt_default;
> 
> By removing this usage of __uclamp_updadate_util_min_rt_default(p),
> the only other usage remaining is the call from:
>    uclamp_udpate_util_min_rt_default().
> 
> What about an additional cleanup by in-lining the only surviving usage?
> 
> 
> >>  		else
> >> -			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
> >> +			value = uclamp_none(clamp_id);
> >>  
> >> +		uclamp_se_set(uc_se, value, false);
> >>  	}
> >>  
> >> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> >> +	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) ||
> >> +	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET) {
> 
> The likely() above should not wrap both conditions to be effective?

Got it.
> 
> >>  		return;
> >> +	}
> >>  
> >>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
