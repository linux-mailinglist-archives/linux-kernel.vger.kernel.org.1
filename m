Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5522835DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJEMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:38:23 -0400
Received: from foss.arm.com ([217.140.110.172]:46324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgJEMiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A47A8106F;
        Mon,  5 Oct 2020 05:38:21 -0700 (PDT)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4FC73F70D;
        Mon,  5 Oct 2020 05:38:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if user
 set to default value
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>
References: <20200928082643.133257-1-hsiang023167@gmail.com>
 <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
 <20201002053812.GA176142@ubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <57e6b3d3-22cd-0533-cfe7-e689c7983fcc@arm.com>
Date:   Mon, 5 Oct 2020 14:38:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002053812.GA176142@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Patrick Bellasi <patrick.bellasi@matbug.net>
+ Qais Yousef <qais.yousef@arm.com>

On 02.10.20 07:38, Yun Hsiang wrote:
> On Wed, Sep 30, 2020 at 03:12:51PM +0200, Dietmar Eggemann wrote:

[...]

>> On 28/09/2020 10:26, Yun Hsiang wrote:
>>> If the user wants to release the util clamp and let cgroup to control it,
>>> we need a method to reset.
>>>
>>> So if the user set the task uclamp to the default value (0 for UCLAMP_MIN
>>> and 1024 for UCLAMP_MAX), reset the user_defined flag to release control.
>>>
>>> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
>>
>> could you explain with a little bit more detail why you would need this
>> feature?
>>
>> Currently we assume that once the per-task uclamp (user-defined) values
>> are set, you could only change the effective uclamp values of this task
>> by (1) moving it into another taskgroup or (2) changing the system
>> default uclamp values.
>>
> 
> Assume a module that controls group (such as top-app in android) uclamp and
> task A in the group.
> Once task A set uclamp, it will not be affected by the group setting.

This depends on the uclamp values of A and /TG (the task group).

Both uclamp values are max aggregated (max aggregation between
system-wide, taskgroup and task values for UCLAMP_MIN and UCLAMP_MAX).

(1) system-wide: /proc/sys/kernel/sched_util_clamp_[min,max]

(2) taskgroup (hierarchy): /sys/fs/cgroup/cpu/TG/cpu.uclamp.[min,max]

(3) task A:

Example: [uclamp_min, uclamp_max]

(1)  [1024, 1024]

(2)  [25.00 (256), 75.00 (768)]

(3a) [128, 512] : both values are not affected by /TG

(3b) [384, 896] : both values are affected by /TG


> If task A doesn't want to control itself anymore,
> it can not go back to the initial state to let the module(group) control.

In case A changes its values e.g. from 3a to 3b it will go back to be
controlled by /TG again (like it was when it had no user defined values).

> But the other tasks in the group will be affected by the group.

Yes, in case they have no user defined values or have values greater
than the one of /TG.

> The policy might be
> 1) if the task wants to control it's uclamp, use task uclamp value
> (but under group uclamp constraint)

That would be example 3a.

> 2) if the task doesn't want to control it's uclamp, use group uclamp value.

That would be example 3b.

> If the policy is proper, we need a reset method for per-task uclamp.
> 
>>> ---
>>>  kernel/sched/core.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 9a2fbf98fd6f..fa63d70d783a 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -1187,6 +1187,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>>  				  const struct sched_attr *attr)
>>>  {
>>>  	enum uclamp_id clamp_id;
>>> +	bool user_defined;
>>>  
>>>  	/*
>>>  	 * On scheduling class change, reset to default clamps for tasks
>>> @@ -1210,14 +1211,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>>>  		return;
>>>  
>>> +	user_defined = attr->sched_util_min == 0 ? false : true;

In case we would need a way to reset user defined values, using 0 and
1024 for this is problematic because both are valid uclamp values.
But I'm pretty sure you can avoid this by using the max aggregation
between A and /TG to turn task uclamp values on or off.
This is obviously also true when A moves from /TG into another taskgroup
with appropriate uclamp values.

[...]
