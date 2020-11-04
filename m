Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E92A60D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKDJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:45:13 -0500
Received: from foss.arm.com ([217.140.110.172]:33986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgKDJpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:45:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55166139F;
        Wed,  4 Nov 2020 01:45:12 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDA043F66E;
        Wed,  4 Nov 2020 01:45:10 -0800 (PST)
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Qais Yousef <qais.yousef@arm.com>,
        Yun Hsiang <hsiang023167@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, kernel test robot <lkp@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201103134644.rafsqisz7fxopo5n@e107158-lin.cambridge.arm.com>
 <20201103134808.27xi27xodj6dvlt2@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e4889208-ff6d-e087-6aeb-26ad98d426fc@arm.com>
Date:   Wed, 4 Nov 2020 10:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103134808.27xi27xodj6dvlt2@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 14:48, Qais Yousef wrote:
> Oops, +Juri for real this time.
> 
> On 11/03/20 13:46, Qais Yousef wrote:
>> Hi Yun
>>
>> +Juri (A question for you below)
>>
>> On 11/03/20 10:37, Yun Hsiang wrote:

[...]

>>>  include/uapi/linux/sched.h |  7 +++--
>>>  kernel/sched/core.c        | 59 ++++++++++++++++++++++++++++----------
>>>  2 files changed, 49 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
>>> index 3bac0a8ceab2..6c823ddb1a1e 100644
>>> --- a/include/uapi/linux/sched.h
>>> +++ b/include/uapi/linux/sched.h
>>> @@ -132,17 +132,20 @@ struct clone_args {
>>>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>>>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>>>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
>>> +#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
>>
>> The new flag needs documentation about how it should be used. It has a none
>> obvious policy that we can't expect users to just get it.

See (1) further below.

>>>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>>>  				 SCHED_FLAG_KEEP_PARAMS)
>>>  
>>>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
>>> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
>>> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
>>> +				 SCHED_FLAG_UTIL_CLAMP_RESET)
>>
>> Either do this..
>>
>>>  
>>>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
>>>  			 SCHED_FLAG_RECLAIM		| \
>>>  			 SCHED_FLAG_DL_OVERRUN		| \
>>>  			 SCHED_FLAG_KEEP_ALL		| \
>>> -			 SCHED_FLAG_UTIL_CLAMP)
>>> +			 SCHED_FLAG_UTIL_CLAMP		| \
>>> +			 SCHED_FLAG_UTIL_CLAMP_RESET)
>>
>> Or this.
>>
>> I checked glibc and it seems they don't use the sched.h from linux and more
>> surprisingly they don't seem to have a wrapper for sched_setattr(). bionic libc
>> from Android does take sched.h from linux, but didn't find any user. So we
>> might be okay with modifying these here.

Schould be package linux-libc-dev. Debian 10 (buster-backports)
5.8.10-1~bpo10+1 contains the uclamp bits as well.

/usr/include/linux/sched/types.h
/usr/include/linux/sched.h

/usr/include/linux/sched.h contains SCHED_FLAG_UTIL_CLAMP and
SCHED_FLAG_ALL.

But there is no glibc wrapper for sched_[sg]etattr so syscall wrapping
is still needed.

>> I still would like us to document better what we expect from these defines.
>> Are they for internal kernel use or really for user space? If the former we
>> should take them out of here. If the latter, then adding the RESET is dangerous
>> as it'll cause an observable change in behavior; that is if an application was
>> using SCHED_FLAG_ALL or SCHED_FLAG_UTIL_CLAMP to update the UTIL_MIN/MAX of
>> a task, existing binaries will find out now that instead of modifying the value
>> they're actually resetting them.

I doubt that any application uses SCHED_FLAG_ALL so far since it already
mixes e.g. DL and UCLAMP stuff. AFAIK the only tools supporting uclamp
so far is rt-app and uclampset, which both use their own files for DL
and uclamp definition.

[..]

>> Add the policy part of the commit message as a documentation to this function
>> please.
>>
>> ie:
>>
>> 	/*
>> 	 * The policy is
>> 	 * _CLAMP_RESET                           => reset both min and max
>> 	 * _CLAMP_RESET | _CLAMP_MIN              => reset min value
>> 	 * _CLAMP_RESET | _CLAMP_MAX              => reset max value
>> 	 * _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
>> 	 */
>>

(1) Related to documentation, wouldn't it be better to document in
include/uapi/linux/sched.h, i.e. where the flags are defined, so it gets
exported via linux-libc-dev?
Like it's done for struct sched_attr members in
include/uapi/linux/sched/types.h.

[...]

>>> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>>> +	if (likely(!(attr->sched_flags && SCHED_FLAG_UTIL_CLAMP)) ||
>>> +		attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
>>>  		return;

Another multi line statement so the 'return' could go with braces.

>>>  
>>> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>>> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
>>>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>>> -			      attr->sched_util_min, true);
>>> -	}
>>> +				attr->sched_util_min, true);
>>>  
>>> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
>>> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
>>>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
>>> -			      attr->sched_util_max, true);
>>> -	}
>>> +				attr->sched_util_max, true);
>>
>> These two hunks seem unrelated too. Multi line statement should still have
>> braces AFAIK. Why change it?

+1

[...]
