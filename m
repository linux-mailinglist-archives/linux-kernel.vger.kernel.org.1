Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120FD28CCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgJMLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:47:50 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37894 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJMLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:47:50 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so27817816ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 04:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=i6F3ntqpv7+kG4Lj/AZ48KfYE2KTrNQ6TzJRQGKnSs8=;
        b=KH7zukDc/RcdPRVcqfjKHdHWGLUYv8reN0rdN9+QBoxcyvijn7rRkULQFAnvudj8Ss
         zZtZW3XjgC8b0KFtYfEJUeRwJxQItW5Pb+I0oq3L1+LxffAcJVQ68Waz3jLRMbHfV8ex
         KiNTSjqu11ceZU+fPTI0uR9qOyyYNFoYOSytIUFjCILaLfPucLxiJ63CR2pcc10ne6F8
         s67YMxjeRUSThwICY+OivTnYxJuYnrKelCO6DaEs9+AvjdUTMmeAmmLaeuBhqpcowV07
         jT4sLUT+KWryRbcxeTcFRgnpi25rPbDAshrflLnX+hzzrFXyn6ztdgMvLk+7Y1akfVld
         zY1A==
X-Gm-Message-State: AOAM531em8QPwF5ZKqVqdi+kW6aBKR3otaNu8z5Oyn2E4fhK99/U53Gu
        RQOlBog43EAgBImDWOwrKf1yeqEAwsVZOqhD
X-Google-Smtp-Source: ABdhPJyJ1+Jgp7cKIYPl4y1+vg4+fr4KN5mt1PoocxykwSUsSeGD9VP7d8Yq/s0hz9qypQPQu1aFHQ==
X-Received: by 2002:a17:906:cca9:: with SMTP id or9mr32013632ejb.451.1602589665391;
        Tue, 13 Oct 2020 04:47:45 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id m6sm13289444ejl.94.2020.10.13.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 04:47:44 -0700 (PDT)
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <87blh6iljc.derkling@matbug.net>
 <20201013102951.orcr6m4q2cb7y6zx@e107158-lin>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, dietmar.eggemann@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
In-reply-to: <20201013102951.orcr6m4q2cb7y6zx@e107158-lin>
Message-ID: <875z7eic14.derkling@matbug.net>
Date:   Tue, 13 Oct 2020 13:46:31 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 13, 2020 at 12:29:51 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> On 10/13/20 10:21, Patrick Bellasi wrote:
>> 

[...]

>> > +#define SCHED_FLAG_UTIL_CLAMP_RESET (SCHED_FLAG_UTIL_CLAMP_RESET_MIN | \
>> > +					SCHED_FLAG_UTIL_CLAMP_RESET_MAX)
>> > +
>> >  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>> >  			 SCHED_FLAG_RECLAIM		| \
>> >  			 SCHED_FLAG_DL_OVERRUN		| \
>> >  			 SCHED_FLAG_KEEP_ALL		| \
>> > -			 SCHED_FLAG_UTIL_CLAMP)
>> > +			 SCHED_FLAG_UTIL_CLAMP		| \
>> > +			 SCHED_FLAG_UTIL_CLAMP_RESET)
>> 
>> 
>> ... and use it in conjunction with the existing _CLAMP_{MIN,MAX} to know
>> which clamp should be reset?
>
> I think the RESET should restore *both* MIN and MAX and reset the user_defined
> flag. Since the latter is the main purpose of this interface, I don't think you
> can reset the user_defined flag without resetting both MIN and MAX to
> uclamp_none[UCLAMP_MIN/MAX].

We can certainly set one clamp and not the other, and indeed the
user_defined flag is per-clamp_id, thus we can reset one clamp while
still keeping user-defined the other one.


>> >  #endif /* _UAPI_LINUX_SCHED_H */
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 9a2fbf98fd6f..ed4cb412dde7 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -1207,15 +1207,22 @@ static void __setscheduler_uclamp(struct task_struct *p,
>> >  		uclamp_se_set(uc_se, clamp_value, false);
>> >  	}
>> >  
>> > -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>> > +	if (likely(!(attr->sched_flags &
>> > +			(SCHED_FLAG_UTIL_CLAMP | SCHED_FLAG_UTIL_CLAMP_RESET))))
>> >  		return;
>> 
>> This check will not be changed, while we will have to add a bypass in
>> uclamp_validate().
>> 
>> >  
>> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET_MIN) {
>> > +		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>> > +			      0, false);
>> > +	} else if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>> >  			      attr->sched_util_min, true);
>> >  	}
>> >
>> 
>> These checks also will have to be updated to check _RESET and
>> _{MIN,MAX} combinations.
>> 
>> Bonus point would be to be possible to pass in just the _RESET flag if
>> we want to reset both clamps. IOW, passing in _RESET only should be
>> consumed as if we passed in _RESET|_MIN|_MAX.
>> 
>> Caveat, RT tasks have got a special 'reset value' for _MIN.
>> We should check and ensure __uclamp_update_uti_min_rt_default() is
>> property called for those tasks, which likely will require some
>> additional refactoring :/
>
> Hmm I am probably missing something. But if the SCHED_FLAG_UTIL_CLAMP_RESET is
> set, just reset uc_se->user_defined in the loop in __setscheduler_uclamp().
> This should take care of doing the reset properly then. Including for
> RT tasks.

Yes and no. Yes because in principle we can just reset the flag for a
clamp_id without updating the request values, as it is done by the
snippets above, and the internals should work.

However, we will end up reporting the old values when reading from
user-space. We should better check all those reporting code paths or...
just update the requested values as Yun is proposing above.

I like better Yun approach so that we keep internal data structures
aligned with features.

> So IMO you just need a single SCHED_FLAG_UTIL_CLAMP_RESET that if set in the
> attr, you just execute that loop in __setscheduler_uclamp() + reset
> uc_se->user_defined.
>
> It should be invalid to pass the SCHED_FLAG_UTIL_CLAMP_RESET with
> SCHED_FLAG_UTIL_CLAMP_MIN/MAX. Both have contradictory meaning IMO.
> If user passes both we should return an EINVAL error.

Passing in  _CLAMP_RESET|_CLAMP_MIN will mean reset the min value while
keeping the max at whatever it is. I think there could be cases where
this support could be on hand.

However, as in my previous email, by passing in only _CLAMP_RESET, we
should go an reset both.

