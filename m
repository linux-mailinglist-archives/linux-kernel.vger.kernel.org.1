Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFC28CBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgJMK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:29:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbgJMK34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:29:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4122031B;
        Tue, 13 Oct 2020 03:29:55 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E8F3F66B;
        Tue, 13 Oct 2020 03:29:54 -0700 (PDT)
Date:   Tue, 13 Oct 2020 11:29:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, dietmar.eggemann@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201013102951.orcr6m4q2cb7y6zx@e107158-lin>
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <87blh6iljc.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blh6iljc.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 10:21, Patrick Bellasi wrote:
> 
> Hi Yun,
> thanks for sharing this new implementation.
> 
> On Mon, Oct 12, 2020 at 18:31:40 +0200, Yun Hsiang <hsiang023167@gmail.com> wrote...
> 
> > If the user wants to stop controlling uclamp and let the task inherit
> > the value from the group, we need a method to reset.
> >
> > Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> > sched_setattr syscall.
> 
> Looks like what you say here is not what you code, since you actually
> add two new flags, _RESET_{MIN,MAX}.
> 
> I think we value instead a simple user-space interface where just the
> additional one flag _RESET should be good enough.
> 
> > Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> > ---
> >  include/uapi/linux/sched.h |  9 ++++++++-
> >  kernel/sched/core.c        | 16 ++++++++++++----
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 3bac0a8ceab2..a12e88c362d8 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -132,6 +132,9 @@ struct clone_args {
> >  #define SCHED_FLAG_KEEP_PARAMS		0x10
> >  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
> >  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> > +#define SCHED_FLAG_UTIL_CLAMP_RESET_MIN	0x80
> > +#define SCHED_FLAG_UTIL_CLAMP_RESET_MAX	0x100
> 
> What about adding just SCHED_FLAG_UTIL_CLAMP_RESET 0x08 ...
> 
> >  
> >  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> >  				 SCHED_FLAG_KEEP_PARAMS)
> > @@ -139,10 +142,14 @@ struct clone_args {
> >  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> >  				 SCHED_FLAG_UTIL_CLAMP_MAX)
> 
> ... making it part of SCHED_FLAG_UTIL_CLAMP ...
> 
> >  
> > +#define SCHED_FLAG_UTIL_CLAMP_RESET (SCHED_FLAG_UTIL_CLAMP_RESET_MIN | \
> > +					SCHED_FLAG_UTIL_CLAMP_RESET_MAX)
> > +
> >  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
> >  			 SCHED_FLAG_RECLAIM		| \
> >  			 SCHED_FLAG_DL_OVERRUN		| \
> >  			 SCHED_FLAG_KEEP_ALL		| \
> > -			 SCHED_FLAG_UTIL_CLAMP)
> > +			 SCHED_FLAG_UTIL_CLAMP		| \
> > +			 SCHED_FLAG_UTIL_CLAMP_RESET)
> 
> 
> ... and use it in conjunction with the existing _CLAMP_{MIN,MAX} to know
> which clamp should be reset?

I think the RESET should restore *both* MIN and MAX and reset the user_defined
flag. Since the latter is the main purpose of this interface, I don't think you
can reset the user_defined flag without resetting both MIN and MAX to
uclamp_none[UCLAMP_MIN/MAX].

> 
> >  #endif /* _UAPI_LINUX_SCHED_H */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9a2fbf98fd6f..ed4cb412dde7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1207,15 +1207,22 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  		uclamp_se_set(uc_se, clamp_value, false);
> >  	}
> >  
> > -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> > +	if (likely(!(attr->sched_flags &
> > +			(SCHED_FLAG_UTIL_CLAMP | SCHED_FLAG_UTIL_CLAMP_RESET))))
> >  		return;
> 
> This check will not be changed, while we will have to add a bypass in
> uclamp_validate().
> 
> >  
> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET_MIN) {
> > +		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> > +			      0, false);
> > +	} else if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> >  			      attr->sched_util_min, true);
> >  	}
> >
> 
> These checks also will have to be updated to check _RESET and
> _{MIN,MAX} combinations.
> 
> Bonus point would be to be possible to pass in just the _RESET flag if
> we want to reset both clamps. IOW, passing in _RESET only should be
> consumed as if we passed in _RESET|_MIN|_MAX.
> 
> Caveat, RT tasks have got a special 'reset value' for _MIN.
> We should check and ensure __uclamp_update_uti_min_rt_default() is
> property called for those tasks, which likely will require some
> additional refactoring :/

Hmm I am probably missing something. But if the SCHED_FLAG_UTIL_CLAMP_RESET is
set, just reset uc_se->user_defined in the loop in __setscheduler_uclamp().
This should take care of doing the reset properly then. Including for RT tasks.

So IMO you just need a single SCHED_FLAG_UTIL_CLAMP_RESET that if set in the
attr, you just execute that loop in __setscheduler_uclamp() + reset
uc_se->user_defined.

It should be invalid to pass the SCHED_FLAG_UTIL_CLAMP_RESET with
SCHED_FLAG_UTIL_CLAMP_MIN/MAX. Both have contradictory meaning IMO.
If user passes both we should return an EINVAL error.

Thanks

--
Qais Yousef
