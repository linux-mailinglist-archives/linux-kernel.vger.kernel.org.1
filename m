Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F32AFF47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKLFp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgKLFoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 00:44:54 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 21:44:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so3508396pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 21:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Wrc8fiOuZuXNhL9f/svgjNc/c8x+1+TBbfywF036g8=;
        b=MQQqnLvBftHCd1FuGxyTbfHb860FMPoBMVR7ahUHQ6DoMzCZaEHvpZeN9naV/pNTPH
         CFTIynWOxYXM/u33qSJktyfSyXPW5Oa1YazC9X8trfncnfskLZWO0UTTHUFTYBsgsUdb
         5f5Cf9NyKGSgrLWHNSA7Vikldysgyna9lMTZR87mRxbQrqir9F5aIDJI/Ot5wcJ5bIQI
         Q3gkLhhKech6ErlAwks6gS7xMG2r/EHQdGCzFIvOx4CHqy1uViG71r7LGc+L1klxxLdf
         lc/u4616rx+YQawZro2amrTZkOEk+1l819822V/cCMtiESNNpcKofhwEY+nL8wkgVXSd
         1VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Wrc8fiOuZuXNhL9f/svgjNc/c8x+1+TBbfywF036g8=;
        b=kldrrd7lKBQsocHGQm/VT5t6R58FomPeM4Hkg1zpSQBD9h6nxiS6/1hs6qRiHVqEfL
         hk1YfsMEbf4VsPVgH24CK1JOZ6Vfk1JD26mASf4x2RJAIB8OAOfiNmiXsmYfG2RtGqyg
         WTeh/qCNEKhhklknJtkOiBGEtdYcULvN4nucDk1jtkuCcGlRin2YbDhADx7xN/GLiHV/
         cm2N04cUyCd1hJu5sh0qGT/Uxk3YUM77egSDbtfqhwxSEHcRBWi+qT1nYoZtrkCERMGL
         Ge9pBWM1R9QscEfe0rvu1g3UoF5J26s+qlyXPIxIz8YSYpvvZcoN+hYNIkIVd3bQkOYh
         GTew==
X-Gm-Message-State: AOAM531d94q9AbfV1Uu6ZOQxutBEWZnZvJ/IEQl0ELkiVIrdqoUCuQfQ
        AZ5YYd4lbmKiUl/Gir6/XX0=
X-Google-Smtp-Source: ABdhPJxa9te4lf7Pd/y3s50Z5+lm5obDt0AnqwGi0wBM52hGt6QYBLxTvwH/7tx4/0dK9DO+9Uh36g==
X-Received: by 2002:a62:19c6:0:b029:18b:5c6a:2ae6 with SMTP id 189-20020a6219c60000b029018b5c6a2ae6mr26055115pfz.14.1605159893469;
        Wed, 11 Nov 2020 21:44:53 -0800 (PST)
Received: from ubuntu (42-73-56-209.emome-ip.hinet.net. [42.73.56.209])
        by smtp.gmail.com with ESMTPSA id e8sm4622027pjr.30.2020.11.11.21.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 21:44:52 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:44:45 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201112054445.GA1257287@ubuntu>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
 <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
 <20201111180441.GJ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111180441.GJ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 07:04:41PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 06:41:07PM +0100, Dietmar Eggemann wrote:
> > diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> > index c852153ddb0d..b9165f17dddc 100644
> > --- a/include/uapi/linux/sched/types.h
> > +++ b/include/uapi/linux/sched/types.h
> > @@ -115,8 +115,8 @@ struct sched_attr {
> >  	__u64 sched_period;
> >  
> >  	/* Utilization hints */
> > -	__u32 sched_util_min;
> > -	__u32 sched_util_max;
> > +	__s32 sched_util_min;
> > +	__s32 sched_util_max;
> 
> So that's UAPI, not sure we can change the type here.

+1
I am also concerned about changing UAPI.
But if we can chage sched_util_{min/max} to __s32, use -1 to reset is better than
adding flags.

> 
> >  };
> >  
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3dc415f58bd7..caaa2a8434b9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1413,17 +1413,24 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  static int uclamp_validate(struct task_struct *p,
> >  			   const struct sched_attr *attr)
> >  {
> > -	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
> > -	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
> > +	int util_min = p->uclamp_req[UCLAMP_MIN].value;
> > +	int util_max = p->uclamp_req[UCLAMP_MAX].value;
> >  
> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> > -		lower_bound = attr->sched_util_min;
> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> > -		upper_bound = attr->sched_util_max;
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +		util_min = attr->sched_util_min;
> >  
> > -	if (lower_bound > upper_bound)
> > -		return -EINVAL;
> > -	if (upper_bound > SCHED_CAPACITY_SCALE)
> > +		if (util_min < -1 || util_min > SCHED_CAPACITY_SCALE)
> > +			return -EINVAL;
> > +	}
> > +
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +		util_max = attr->sched_util_max;
> > +
> > +		if (util_max < -1 || util_max > SCHED_CAPACITY_SCALE)
> > +			return -EINVAL;
> > +	}
> 
> Luckily we can write that range as a single branch like:
> 
> 	if (util_{min,max} + 1 > SCHED_CAPACITY_SCALE+1)
> 
> which assumes u32 :-)
> 
> > +
> > +	if (util_min != -1 && util_max != -1 && util_min > util_max)
> >  		return -EINVAL;
> 
> I think that will compile as is, otherwise write it like ~0u, which is
> the same bit pattern.
> 
