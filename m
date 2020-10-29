Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48729F078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgJ2Pub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:50:31 -0400
Received: from foss.arm.com ([217.140.110.172]:39766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgJ2Pub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:50:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 340B231B;
        Thu, 29 Oct 2020 08:50:30 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7543F66E;
        Thu, 29 Oct 2020 08:50:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Qais Yousef <qais.yousef@arm.com>,
        Yun Hsiang <hsiang023167@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <20201029110818.alrviwwljxnegmip@e107158-lin>
 <20201029130243.GA897607@ubuntu>
 <20201029130649.h4wm2ak5j7zkgb3s@e107158-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f17f145a-7247-e4f2-635c-22951678f00c@arm.com>
Date:   Thu, 29 Oct 2020 16:50:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029130649.h4wm2ak5j7zkgb3s@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2020 14:06, Qais Yousef wrote:
> On 10/29/20 21:02, Yun Hsiang wrote:
>> Hi Qais,
>>
>> On Thu, Oct 29, 2020 at 11:08:18AM +0000, Qais Yousef wrote:
>>> Hi Yun
>>>
>>> Sorry for chipping in late.
>>>
>>> On 10/25/20 15:36, Yun Hsiang wrote:

[...]

>>>>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
>>>> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
>>>> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
>>>> +				 SCHED_FLAG_UTIL_CLAMP_RESET)
>>>
>>> Is it safe to change this define in a uapi header without a potential
>>> consequence?

AFAICS, there're 3 occurrences, besides the one in
__setscheduler_uclamp(), in which we use SCHED_FLAG_UTIL_CLAMP.

1) call uclamp_validate() in __sched_setscheduler()

2) jump to 'change' label in __sched_setscheduler()

3) check that the uattr->size is SCHED_ATTR_SIZE_VER1 in
   sched_copy_attr()

2) and 3) require SCHED_FLAG_UTIL_CLAMP_RESET to be part of
SCHED_FLAG_UTIL_CLAMP but IMHO 1) needs this change:

@@ -1413,8 +1413,14 @@ int sysctl_sched_uclamp_handler(struct ctl_table
*table, int write,
 static int uclamp_validate(struct task_struct *p,
                           const struct sched_attr *attr)
 {
-       unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
-       unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+       unsigned int lower_bound, upper_bound;
+
+       /* Do not check uclamp attributes values in reset case. */
+       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
+               return 0;
+
+       lower_bound = p->uclamp_req[UCLAMP_MIN].value;
+       upper_bound = p->uclamp_req[UCLAMP_MAX].value;

        if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
                lower_bound = attr->sched_util_min;

Otherwise a bogus sa.sched_util_min or sa.sched_util_max with
SCHED_FLAG_UTIL_CLAMP_RESET could return -EINVAL.

>>> FWIW I still have concerns about this approach. We're doing a reset to control
>>> cgroup behavior, I don't see any correlation between the two. Besides the
>>> difference between RESET and setting uclamp_min=0 without RESET is not obvious
>>> nor intuitive for someone who didn't look at the code.
>>>
>>> I propose something like the below which is more explicit about what is being
>>> requested and delivered here. And if we decide to deprecate this behavior,
>>> it'd be much easier to just ignore this flag.
>>>
>>> You must set this flag with your uclamp request to retain the cgroup
>>> inheritance behavior. If the flag is not set, we automatically clear it.
>>
>> I think this behavior may not meet android requirement. Becasue in
>> android there is group like top-app. And we want to boost the
>> group by setting group uclamp_min. If group inheritance is explicit, we
>> need to set this flag for all the tasks in top-app. This might be
>> costly.
> 
> You will not have to set it for every task. It's on by default like it works
> now. This behavior doesn't change.
> 
> But if you change the uclamp value of a task but still want it to continue to
> inherit the cgroup values if it's attached to one, you must set this flag when
> changing the uclamp value.

I'm not really fond of this idea because:

(1) explicit cgroup(-behavior) related settings through a per-task user
    interface.

(2) uclamp reset makes already sense in the !CONFIG_UCLAMP_TASK_GROUP
    case. A task can reset its uclamp values here as well, and then
    'inheriting' the system defaults again. Already mentioned in
    https://lkml.kernel.org/r/87362ihxvw.derkling@matbug.net

[...]
