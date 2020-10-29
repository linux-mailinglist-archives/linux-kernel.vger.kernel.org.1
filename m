Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7129EBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgJ2MiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:38:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgJ2MiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:38:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB5F413A1;
        Thu, 29 Oct 2020 05:38:04 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33E33F719;
        Thu, 29 Oct 2020 05:38:03 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Yun Hsiang <hsiang023167@gmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
 <20201027155813.GA818508@ubuntu> <87v9eumzic.derkling@matbug.net>
 <20201028184143.GA886080@ubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c59f7c85-59a2-488b-ce51-b3abee506dac@arm.com>
Date:   Thu, 29 Oct 2020 13:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028184143.GA886080@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2020 19:41, Yun Hsiang wrote:
> Hi Patrick,
> 
> On Wed, Oct 28, 2020 at 11:11:07AM +0100, Patrick Bellasi wrote:

[...]

>> On Tue, Oct 27, 2020 at 16:58:13 +0100, Yun Hsiang <hsiang023167@gmail.com> wrote...
>>
>>> Hi Diet mar,
>>> On Mon, Oct 26, 2020 at 08:00:48PM +0100, Dietmar Eggemann wrote:
>>>> On 26/10/2020 16:45, Yun Hsiang wrote:

[...]

>>>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

>>>> +static bool uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
>>>> +{
>>
>> Maybe we can add in some comments?
>>
> I'll add these comment.

Yeah, why not.

>>         /* No _UCLAMP_RESET flag set: do not reset */
>>>> +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
>>>> +		return false;
>>>> +
>>
>>         /* Only _UCLAMP_RESET flag set: reset both clamps */
>>>> +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
>>>> +		return true;
>>>> +
>>         /* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
>>>> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
>>>> +		return true;
>>>> +
>>
>>         /* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
>>>> +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
>>>> +		return true;
>>
>> Since the evaluation ordering is important, do we have to better
>> _always_ use a READ_ONCE() for all flags accesses above, to ensure it is
>> preserved?
>>
> 
> Is this mean that we want to use READ_ONCE to avoid compiler reordering these
> conditions?

Why would you need a READ_ONCE() on flags here?

[...]

>>>>  		/* Keep using defined clamps across class changes */
>>>> -		if (uc_se->user_defined)
>>>> +		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
>>>> +		    uc_se->user_defined) {
>>>>  			continue;
>>>> +		}
>>
>> I think we miss to reset the user_defined flag here.
>>
>> What about replacing the above chunk with:
>>
>>                 if (uclamp_reset(clamp_id, attr->sched_flags))
>>                         uc_se->user_defined = false;
>>                 if (uc-se->user_defined)
>>                         continue;
>>
>> ?
> 
> user_defined flag will be reset later by uclamp_se_set(uc_se, value,
> false). But I agree to split it to two condition because it seems
> clearer.

IMHO it's more elegant to use uclamp_reset() in the condition next to
uc-se->user_defined and let uclamp_se_set() set uc-se->user_defined to
false later.

>>>>  		/*
>>>>  		 * RT by default have a 100% boost value that could be modified
>>>>  		 * at runtime.
>>>>  		 */
>>>>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
>>>> -			__uclamp_update_util_min_rt_default(p);
>>>> +			value = sysctl_sched_uclamp_util_min_rt_default;
>>
>> By removing this usage of __uclamp_updadate_util_min_rt_default(p),
>> the only other usage remaining is the call from:
>>    uclamp_udpate_util_min_rt_default().
>>
>> What about an additional cleanup by in-lining the only surviving usage?

Don't see why not.

>>>>  		else
>>>> -			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
>>>> +			value = uclamp_none(clamp_id);
>>>>  
>>>> +		uclamp_se_set(uc_se, value, false);
>>>>  	}
>>>>  
>>>> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>>>> +	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) ||
>>>> +	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET) {
>>
>> The likely() above should not wrap both conditions to be effective?
> 
> Got it.

I thought the likely is for no uclamp activities, i.e. policy change.
And a uclamp reset is different to a policy change. But is this likely too?
