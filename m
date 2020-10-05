Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEC283CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgJEQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:59:30 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:35665 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgJEQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:59:29 -0400
Received: by mail-ej1-f67.google.com with SMTP id u21so13077480eja.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=9xdFXdrMJn7e4RT0XELuQJR5xwLkLE02GAd02MCi5hg=;
        b=XR300pT2O0ev70NukXxSMsfAG5hKC1u7T0i2zxKMzpbHGqZo5sFn2NCbg2WrdyuYvi
         mbHegcdXQpDXz3itvBWNnkdAM8hvAvK2HvPgrc/vWcBib11M5ytoa+t8mZpY32XStj+t
         n2obt64K4GStZV54MOf5qkNW7lRvLAa4KMwucdPJQQWAB1QN1Qss8uG5A+N0tPCdUPzS
         UT8Mcy9zvn/w9aIWkXbVElpo4T0kutRbrVZr8HDvXB7oCqdk6kwpp4oJ2YRHE6NAw8C6
         4McMftFP/1tnQ4g8Q3iJnfEWCAHz8f/NRxseDS9yNCvIYwTRAhyHLSdW1wCHyX3GfYm8
         Fqww==
X-Gm-Message-State: AOAM533vPWNEd8aiNIS4mWLHqQVUMzTpizWN6pAyqeRysMfA0xjwB0BO
        EgpwvjYVK0G3+evHd/xM7+w=
X-Google-Smtp-Source: ABdhPJzuMuHWwURAOEzsGEOe3utNQreoflFTlZr+gen8TuQEDbd1QOzdm/vuD3J/Wl5bmF9e0AYVfQ==
X-Received: by 2002:a17:906:22d8:: with SMTP id q24mr605502eja.479.1601917166686;
        Mon, 05 Oct 2020 09:59:26 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id 12sm274022edw.50.2020.10.05.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:59:25 -0700 (PDT)
References: <20200928082643.133257-1-hsiang023167@gmail.com>
 <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
 <20201002053812.GA176142@ubuntu>
 <57e6b3d3-22cd-0533-cfe7-e689c7983fcc@arm.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if
 user set to default value
In-reply-to: <57e6b3d3-22cd-0533-cfe7-e689c7983fcc@arm.com>
Message-ID: <87o8lg7gpi.derkling@matbug.net>
Date:   Mon, 05 Oct 2020 18:58:17 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yun, Dietmar,

On Mon, Oct 05, 2020 at 14:38:18 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote...

> + Patrick Bellasi <patrick.bellasi@matbug.net>
> + Qais Yousef <qais.yousef@arm.com>
>
> On 02.10.20 07:38, Yun Hsiang wrote:
>> On Wed, Sep 30, 2020 at 03:12:51PM +0200, Dietmar Eggemann wrote:
>
> [...]
>
>>> On 28/09/2020 10:26, Yun Hsiang wrote:
>>>> If the user wants to release the util clamp and let cgroup to control it,
>>>> we need a method to reset.
>>>>
>>>> So if the user set the task uclamp to the default value (0 for UCLAMP_MIN
>>>> and 1024 for UCLAMP_MAX), reset the user_defined flag to release control.
>>>>
>>>> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
>>>
>>> could you explain with a little bit more detail why you would need this
>>> feature?
>>>
>>> Currently we assume that once the per-task uclamp (user-defined) values
>>> are set, you could only change the effective uclamp values of this task
>>> by (1) moving it into another taskgroup or (2) changing the system
>>> default uclamp values.
>>>
>> 
>> Assume a module that controls group (such as top-app in android) uclamp and
>> task A in the group.
>> Once task A set uclamp, it will not be affected by the group setting.

That's not true, and Dietmar example here after is correct.

We call it uclamp since the values are clamps, which are always
aggregate somehow at different levels. IOW, a task has never a full free
choice of the final effective value.

> This depends on the uclamp values of A and /TG (the task group).
>
> Both uclamp values are max aggregated (max aggregation between
> system-wide, taskgroup and task values for UCLAMP_MIN and UCLAMP_MAX).
>
> (1) system-wide: /proc/sys/kernel/sched_util_clamp_[min,max]
>
> (2) taskgroup (hierarchy): /sys/fs/cgroup/cpu/TG/cpu.uclamp.[min,max]
>
> (3) task A:
>
> Example: [uclamp_min, uclamp_max]
>
> (1)  [1024, 1024]
>
> (2)  [25.00 (256), 75.00 (768)]
>
> (3a) [128, 512] : both values are not affected by /TG
>
> (3b) [384, 896] : both values are affected by /TG
>
>
>> If task A doesn't want to control itself anymore,

To be precise, in this case we should say: "if a task don't want to give
up anymore".

Indeed, the base idea is that a task can always and only
"ask for less". What it really gets (effective value) is the minimum
among its request, what the group allows and the system wide value on
top, i.e ref [4,5]:

   eff_value = MIN(system-wide, MIN(tg, task))


>> it can not go back to the initial state to let the module(group) control.
>
> In case A changes its values e.g. from 3a to 3b it will go back to be
> controlled by /TG again (like it was when it had no user defined
> values).

True, however it's also true that strictly speaking once a task has
defined a per-task value, we will always aggregate/clamp that value wrt
to TG and SystemWide value.

>> But the other tasks in the group will be affected by the group.

This is not clear to me.

All tasks in a group will be treated independently. All the tasks are
subject to the same _individual_ aggregation/clamping policy.

> Yes, in case they have no user defined values or have values greater
> than the one of /TG.
>
>> The policy might be
>> 1) if the task wants to control it's uclamp, use task uclamp value

Again, worth to stress, a task has _never_ full control of it's clamp.
Precisely, a task has the freedom to always ask less than what it's
enforced at TG/System level.

IOW, task-specific uclamp values support only a "nice" policy, where a
task can only give up something. Either be _less_ boosted or _more_
capped, which in both cases corresponds to asking for _less_ CPU
bandwidth.

>> (but under group uclamp constraint)
>
> That would be example 3a.
>
>> 2) if the task doesn't want to control it's uclamp, use group uclamp value.
>
> That would be example 3b.
>
>> If the policy is proper, we need a reset method for per-task uclamp.
>> 
>>>> ---
>>>>  kernel/sched/core.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 9a2fbf98fd6f..fa63d70d783a 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -1187,6 +1187,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>>>  				  const struct sched_attr *attr)
>>>>  {
>>>>  	enum uclamp_id clamp_id;
>>>> +	bool user_defined;
>>>>  
>>>>  	/*
>>>>  	 * On scheduling class change, reset to default clamps for tasks
>>>> @@ -1210,14 +1211,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>>>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>>>>  		return;
>>>>  
>>>> +	user_defined = attr->sched_util_min == 0 ? false : true;
>
> In case we would need a way to reset user defined values, using 0 and
> 1024 for this is problematic because both are valid uclamp values.
> But I'm pretty sure you can avoid this by using the max aggregation
> between A and /TG to turn task uclamp values on or off.
> This is obviously also true when A moves from /TG into another taskgroup
> with appropriate uclamp values.
>
> [...]

All the above considered, I think there is still an argument for what
Yun is asking.

It's true that in principle, for example, a task can just set its
util_min=1024 to always get the maximum boost value allowed by its
current TG. However, that would probably not work very well if the task
is then moved to the root group, where by default we allow 1024.

It's a sort of corner case, true, but it's there. :)

If we want to fix this case, thus allowing a task to "get back"
its original state with user_define=false, however we should NOT
play with the clamp values and confusing their semantic.

A possible alternative would be to add in a new possible value for
sched_attr::sched_flags [1] to be used via sched_setparam() syscall,
e.g. a SCHED_FLAG_UTIL_CLAMP_RESET flag similar to [2].
Such a flag can be consumed in __setscheduler_uclamp() [3] to reset the
user defined status.

Best,
Patrick


[1] https://elixir.bootlin.com/linux/v5.9-rc8/source/include/uapi/linux/sched/types.h#L104
[2] https://elixir.bootlin.com/linux/v5.9-rc8/source/include/uapi/linux/sched.h#L133
[3] https://elixir.bootlin.com/linux/v5.9-rc8/source/kernel/sched/core.c#L1445
[4] https://elixir.bootlin.com/linux/v5.9-rc8/source/kernel/sched/core.c#L1108
[5] https://elixir.bootlin.com/linux/v5.9-rc8/source/kernel/sched/core.c#L1086

