Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43829DB85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbgJ2ACA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:02:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39675 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJ2AB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:01:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id m16so1158017ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=fXCMewML1R44X9ELdtxmrAR2fEXSSjSMh1z8WcI8TOE=;
        b=CZ/s4sn7JJUct8NBai9kw+fJBz8jexdKJXD86nrWnYYB3C0g8SF4PM4v+GCSonVqMt
         7UayKNEoCCG1bSL4CD0Hz0TA+kKLcElhztUaLQDWcLDySpEmb9LS9vsRx2u9XQkWF9Dm
         f6KVbsE1iv0SXW7U3xtokOyl3b8UTq+ehskkiilr6jxG9fmDd3c6WPyBIt72GQdKeCHw
         rf/Z5JjL8kkjon1YpCSIsweFJhzkUJ/Upwa26qluUsiXsaeKBgbjHBNcRqZJV8ewAbv/
         RGyezr+MItOyR+XHQQcYaZ+4uegiJcjegY5HHMBG2M+YSnBBycqyFJysPnEVxL1leLeF
         u9pA==
X-Gm-Message-State: AOAM530bvFv/d95nG0NXzTFKnP+f8xOeQ8qiFZrXvYeoJ3NeeXvb1/1l
        o6cji/gRCDfNjmoEpnAoX4tR3k2QR8+YN9H/
X-Google-Smtp-Source: ABdhPJzto0yxapQSHMpCqgTr8htQUA5n7x4VR9wP2l3a2iVO5TDvbv2WIEStegHxeUa2gG8JsUhL5Q==
X-Received: by 2002:a17:906:3852:: with SMTP id w18mr6511843ejc.551.1603879950884;
        Wed, 28 Oct 2020 03:12:30 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id hh17sm2682649ejb.125.2020.10.28.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 03:12:30 -0700 (PDT)
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
 <20201027155813.GA818508@ubuntu>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
In-reply-to: <20201027155813.GA818508@ubuntu>
Message-ID: <87v9eumzic.derkling@matbug.net>
Date:   Wed, 28 Oct 2020 11:11:07 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dietmar, Yun,
I hope I'm not too late before v4 posting ;)

I think the overall approach is sound, I just added in a couple of
cleanups and a possible fix (user_defined reset).

Best,
Patrick


On Tue, Oct 27, 2020 at 16:58:13 +0100, Yun Hsiang <hsiang023167@gmail.com> wrote...

> Hi Diet mar,
> On Mon, Oct 26, 2020 at 08:00:48PM +0100, Dietmar Eggemann wrote:
>> On 26/10/2020 16:45, Yun Hsiang wrote:

[...]

>> I thought about something like this. Only lightly tested. 
>> 
>> ---8<---
>> 
>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Date: Mon, 26 Oct 2020 13:52:23 +0100
>> Subject: [PATCH] SCHED_FLAG_UTIL_CLAMP_RESET
>> 
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>  include/uapi/linux/sched.h |  4 +++-
>>  kernel/sched/core.c        | 31 +++++++++++++++++++++++++++----
>>  2 files changed, 30 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
>> index 3bac0a8ceab2..0dd890822751 100644
>> --- a/include/uapi/linux/sched.h
>> +++ b/include/uapi/linux/sched.h
>> @@ -132,12 +132,14 @@ struct clone_args {
>>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
>> +#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
>>  
>>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>>  				 SCHED_FLAG_KEEP_PARAMS)
>>  
>>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
>> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
>> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
>> +				 SCHED_FLAG_UTIL_CLAMP_RESET)
>>  
>>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>>  			 SCHED_FLAG_RECLAIM		| \
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3dc415f58bd7..717b1cf5cf1f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1438,6 +1438,23 @@ static int uclamp_validate(struct task_struct *p,
>>  	return 0;
>>  }
>>  
>> +static bool uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
>> +{

Maybe we can add in some comments?

        /* No _UCLAMP_RESET flag set: do not reset */
>> +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
>> +		return false;
>> +

        /* Only _UCLAMP_RESET flag set: reset both clamps */
>> +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
>> +		return true;
>> +
        /* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
>> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
>> +		return true;
>> +

        /* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
>> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
>> +		return true;

Since the evaluation ordering is important, do we have to better
_always_ use a READ_ONCE() for all flags accesses above, to ensure it is
preserved?

>> +
>> +	return false;
>> +}
>> +
>>  static void __setscheduler_uclamp(struct task_struct *p,
>>  				  const struct sched_attr *attr)
>>  {
>> @@ -1449,24 +1466,30 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>  	 */

Perhaps we should update the comment above this loop with something
like:

        /*
         * Reset to default clamps on forced _UCLAMP_RESET (always) and
         * for tasks without a task-specific value (on scheduling class change).
         */
>>  	for_each_clamp_id(clamp_id) {
>>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
>> +		unsigned int value;
>>  
>>  		/* Keep using defined clamps across class changes */
>> -		if (uc_se->user_defined)
>> +		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
>> +		    uc_se->user_defined) {
>>  			continue;
>> +		}

I think we miss to reset the user_defined flag here.

What about replacing the above chunk with:

                if (uclamp_reset(clamp_id, attr->sched_flags))
                        uc_se->user_defined = false;
                if (uc-se->user_defined)
                        continue;

?


>>  
>>  		/*
>>  		 * RT by default have a 100% boost value that could be modified
>>  		 * at runtime.
>>  		 */
>>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
>> -			__uclamp_update_util_min_rt_default(p);
>> +			value = sysctl_sched_uclamp_util_min_rt_default;

By removing this usage of __uclamp_updadate_util_min_rt_default(p),
the only other usage remaining is the call from:
   uclamp_udpate_util_min_rt_default().

What about an additional cleanup by in-lining the only surviving usage?


>>  		else
>> -			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
>> +			value = uclamp_none(clamp_id);
>>  
>> +		uclamp_se_set(uc_se, value, false);
>>  	}
>>  
>> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>> +	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) ||
>> +	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET) {

The likely() above should not wrap both conditions to be effective?

>>  		return;
>> +	}
>>  
>>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
