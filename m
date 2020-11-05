Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA62A8392
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKEQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728999AbgKEQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604594037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJ+mC4V+mEqTq1fiw1AA7qF7twgxETFLfPuCAR/LhEg=;
        b=cFl1m62Sn9rgWX9626o76oieNndG/2/DKwuoYolimUk3EX1rxhr0FquJsKY3FqYt8Mjxrv
        MmgzYDAobVILQUhlG8/pLF9G+bX5KR4L8RiMoBM05xMQU/gGFsjD2+i9vPsw+GYTX1aN0J
        VySQIdVZUKUFTtqqXFzD26UYy62Xk7k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-U_V6J1tXObKlULXh0BqRlw-1; Thu, 05 Nov 2020 11:33:55 -0500
X-MC-Unique: U_V6J1tXObKlULXh0BqRlw-1
Received: by mail-qk1-f200.google.com with SMTP id i8so1254575qka.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OJ+mC4V+mEqTq1fiw1AA7qF7twgxETFLfPuCAR/LhEg=;
        b=rD0sJG+V4cZ1rJr5dzH5G53uhHdgkwC61GpGWBZ/vU6MKquaEvyPd0/9FeKG7xxCiy
         OCUyRnyt4Of4xZUce3dbUAmiIs5j+rdeKmsKvQBunZmNcvz1JDjwCbVwaJYKo8/c3npy
         4ckDnK5YxYmDZ7mKgHri3Cq1lRu+867y69jTRfLPzhuwCD5UEWhT27xLZi/oj6XcBQt5
         DFQfrGXUF+9r77imZbZg9qVArCG16Mu7JmHsgBnhXcOKqe9Ks+Rginug7FEpoICx4aW+
         /iJbdIt85Pm161FNm8V8cj0tO+oV9vbtbHKko65n8e69ByZcbhq3F2tGh9V00Tum2ZfF
         Hcrw==
X-Gm-Message-State: AOAM531Qp4WBvUcrOFkC+Y4lXpekHKrKTgTm7TpVhF0lMC3qUrg6RoQP
        jF14Mu99lSot2a3RqXj9hbW6R1RmY7hCfTRTLP7XMeC6N3eWfuwuQVe17gOJEbpTerjrsKnDwiF
        Rt6iwuzomq5tkDi3Aoim4T0q4
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr3053617qvb.10.1604594035285;
        Thu, 05 Nov 2020 08:33:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlXifEmholTjpLuerSNnV8AcwlqP3KIIRPp4xxYR2mRmwMcZ/UmeL9by34uqmDJr1KXky5uA==
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr3053580qvb.10.1604594034963;
        Thu, 05 Nov 2020 08:33:54 -0800 (PST)
Received: from x1.bristot.me (host-95-246-207-183.retail.telecomitalia.it. [95.246.207.183])
        by smtp.gmail.com with ESMTPSA id z6sm1112622qti.88.2020.11.05.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:33:54 -0800 (PST)
Subject: Re: [PATCH] sched/deadline: Fix priority inheritance with multiple
 scheduling classes
To:     Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it
References: <20201105075021.1302386-1-juri.lelli@redhat.com>
 <jhja6vvztvk.mognet@arm.com> <20201105161236.GA5522@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b279124a-d7f8-9801-8a8a-e2bced504e19@redhat.com>
Date:   Thu, 5 Nov 2020 17:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105161236.GA5522@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/20 5:12 PM, Juri Lelli wrote:
> Hi Valentin,
> 
> On 05/11/20 15:49, Valentin Schneider wrote:
>>
>> Hi Juri,
>>
>> On 05/11/20 07:50, Juri Lelli wrote:
>>> He also provided a simple reproducer creating the situation below:
>>>
>>>  So the execution order of locking steps are the following
>>>  (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
>>>  are mutexes that are enabled * with priority inheritance.)
>>>
>>>  Time moves forward as this timeline goes down:
>>>
>>>  N1              N2               D1
>>>  |               |                |
>>>  |               |                |
>>>  Lock(M1)        |                |
>>>  |               |                |
>>>  |             Lock(M2)           |
>>>  |               |                |
>>>  |               |              Lock(M2)
>>>  |               |                |
>>>  |             Lock(M1)           |
>>>  |             (!!bug triggered!) |
>>>
>>> Daniel reported a similar situation as well, by just letting ksoftirqd
>>> run with DEADLINE (and eventually block on a mutex).
>>>
>>> Problem is that boosted entities (Priority Inheritance) use static
>>> DEADLINE parameters of the top priority waiter. However, there might be
>>> cases where top waiter could be a non-DEADLINE entity that is currently
>>> boosted by a DEADLINE entity from a different lock chain (i.e., nested
>>> priority chains involving entities of non-DEADLINE classes). In this
>>> case, top waiter static DEADLINE parameters could be null (initialized
>>> to 0 at fork()) and replenish_dl_entity() would hit a BUG().
>>>
>>
>> IIUC, rt_mutex_get_top_task(N1) == N2, and N2->dl->deadline = 0, which
>> makes enqueue_task_dl() unhappy. And that happens because, unlike p->prio,
>> DL parameters aren't properly propagated through the chain(s).
> 
> Yep. Replenishment as well, as it's going to find dl_runtime == 0.
> 
>>> Fix this by keeping track of the original donor and using its parameters
>>> when a task is boosted.
>>>
>>> Reported-by: Glenn Elliott <glenn@aurora.tech>
>>> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>>>
>>> ---
>>>
>>> This is actually a v2 attempt (didn't keep $SUBJECT since it's quite
>>> different than v1 [1]) to fix this problem.
>>>
>>> v1 was admittedly pretty ugly. Hope this looks slightly better (even
>>> though there is of course overhead associated to the additional
>>> pointer).
>>>
>>> Again, the proper way to fix this is by proxy execution. But, I don't
>>> think we are yet there and this problem needs a quick band-aid.
>>>
>>> One could probably also think to complicate the present approach and
>>> actually perform accounting using donor's dynamic parameters, but I fear
>>> it would be of little benefit since it would still bring all the
>>> problems associated to affinities. So, I'd propose let's try to fix all
>>> this properly with proxy and just avoid crashes in the meantime.
>>>
>>
>> For my own sake, what affinity problems are you thinking of?
>>
>> With proxy exec we have this "funny" dance of shoving the entire blocked-on
>> chain on a single runqueue to get the right selection out of
>> pick_next_task(), and that needs to deal with affinity (i.e. move the task
>> back to a sensible rq once it becomes runnable).
>>
>> With the current PI, the waiting tasks are blocked and enqueued in the
>> pi_waiters tree, so as I see it affinity shouldn't matter; what am I
>> missing / not seeing? Is that related to bandwidth handling?
> 
> Think we might break admission control checks if donor and bosted are,
> for example, on different exclusive sets of CPUs. Guess that is a
> problem with proxy as well, though. As said in the comment above, this
> is unfortunately not much more than a band-aid. Hoping we can buy us
> some time and fix it properly with proxy.

I agree with Juri that the current approach is known to be broken,
and that the proxy execution seems to be the mechanisms to go to
try to address these problems. However, this will take some time.

Meanwhile, this patch that Juri proposes fixes problem
in the current mechanism - using the same approach (and breaking
in a known way :D).

A proper way to handle the priority inversion with a disjoint
set of CPUs is something that will also be an issue with proxy
execution. But that is an even more complex topic :-(.

So, IMHO, Juri's patch works well to avoid a crash,
making the system to behave as we expected (even if
we know that we cannot expect too much).

> 
>>> 1 - 20191112075056.19971-1-juri.lelli@redhat.com
>>> ---
>>>  include/linux/sched.h   |  9 +++++
>>>  kernel/sched/core.c     | 13 ++++++--
>>>  kernel/sched/deadline.c | 74 ++++++++++++++++++++---------------------
>>>  3 files changed, 56 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index 063cd120b459..db29ab492181 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -571,6 +571,15 @@ struct sched_dl_entity {
>>>        * time.
>>>        */
>>>       struct hrtimer inactive_timer;
>>> +
>>> +#ifdef CONFIG_RT_MUTEXES
>>> +	/*
>>> +	 * Priority Inheritance. When a DEADLINE scheduling entity is boosted
>>> +	 * pi_se points to the donor, otherwise points to the dl_se it belongs
>>> +	 * to (the original one/itself).
>>> +	 */
>>> +	struct sched_dl_entity *pi_se;
>>> +#endif
>>>  };
>>>
>>>  #ifdef CONFIG_UCLAMP_TASK
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 6f533bb7d3b9..e10aba6c363d 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4908,19 +4908,26 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>>>                   (pi_task && dl_prio(pi_task->prio) &&
>>>                    dl_entity_preempt(&pi_task->dl, &p->dl))) {
>>>                       p->dl.dl_boosted = 1;
>>> +			p->dl.pi_se = pi_task->dl.pi_se;
>>>                       queue_flag |= ENQUEUE_REPLENISH;
>>> -		} else
>>> +		} else {
>>>                       p->dl.dl_boosted = 0;
>>> +			p->dl.pi_se = &p->dl;
>>> +		}
>>>               p->sched_class = &dl_sched_class;
>>>       } else if (rt_prio(prio)) {
>>> -		if (dl_prio(oldprio))
>>> +		if (dl_prio(oldprio)) {
>>>                       p->dl.dl_boosted = 0;
>>> +			p->dl.pi_se = &p->dl;
>>> +		}
>>>               if (oldprio < prio)
>>>                       queue_flag |= ENQUEUE_HEAD;
>>>               p->sched_class = &rt_sched_class;
>>>       } else {
>>> -		if (dl_prio(oldprio))
>>> +		if (dl_prio(oldprio)) {
>>>                       p->dl.dl_boosted = 0;
>>> +			p->dl.pi_se = &p->dl;
>>> +		}
>>
>> With this change, do we still need sched_dl_entity.dl_boosted? AIUI this
>> could become
>>
>>   bool is_dl_boosted(struct sched_dl_entity *dl_se)
>>   {
>>           return pi_of(dl_se) != dl_se;
>>   }
> 
> Makes sense to me. I'll add this change as a separate patch if the rest
> makes sense to people as well. :-)

+1

-- Daniel

> 
> Thanks for the quick review!
> 
> Best,
> Juri
> 

