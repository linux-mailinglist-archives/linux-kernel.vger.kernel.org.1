Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A874C2B8A13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 03:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgKSC0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 21:26:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7651 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgKSC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 21:26:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cc3Sb3j63z15Jv3;
        Thu, 19 Nov 2020 10:25:51 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 10:25:57 +0800
Subject: Re: workqueue: Only kick a worker after thawed or for an unbound
 workqueue
To:     Lai Jiangshan <jiangshanlai@gmail.com>
CC:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <aaa87d62-b89d-e241-1a6e-01176694616f@huawei.com>
 <CAJhGHyBCs17Q=iQBfTJ-4Ls7egpa_70aEx0Ym_-oCt2vXKkSOg@mail.gmail.com>
 <6e174c9f-5436-7d1c-0443-3ca21ff8dad7@huawei.com>
 <d6a8ef8e-e483-9edd-89e6-49bd32f5fbbe@huawei.com>
 <CAJhGHyAobg-rGDoutN1L6xqLEu_wUhYcEA7Xwx9GcxU3G2ThJg@mail.gmail.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <50c66213-87c5-71c9-7dc5-1653a1bacc50@huawei.com>
Date:   Thu, 19 Nov 2020 10:25:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJhGHyAobg-rGDoutN1L6xqLEu_wUhYcEA7Xwx9GcxU3G2ThJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/19 9:58, Lai Jiangshan wrote:
> On Wed, Nov 18, 2020 at 5:05 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>>
>>
>>
>> On 2020/11/18 14:26, Yunfeng Ye wrote:
>>>
>>>
>>> On 2020/11/18 12:06, Lai Jiangshan wrote:
>>>> On Tue, Nov 17, 2020 at 3:33 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>>>>>
>>>>> In realtime scenario, We do not want to have interference on the
>>>>> isolated cpu cores. but when invoking alloc_workqueue() for percpu wq
>>>>> on the housekeeping cpu, it kick a kworker on the isolated cpu.
>>>>>
>>>>>   alloc_workqueue
>>>>>     pwq_adjust_max_active
>>>>>       wake_up_worker
>>>>>
>>>>> The comment in pwq_adjust_max_active() said:
>>>>>   "Need to kick a worker after thawed or an unbound wq's
>>>>>    max_active is bumped"
>>>>>
>>>>> So it is unnecessary to kick a kworker for percpu wq's when
>>>>> alloc_workqueue. this patch only kick a worker after thawed or for an
>>>>> unbound workqueue.
>>>>>
>>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>>> ---
>>>>>  kernel/workqueue.c | 18 +++++++++++++-----
>>>>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>>>>> index c41c3c17b86a..80f7bbd4889f 100644
>>>>> --- a/kernel/workqueue.c
>>>>> +++ b/kernel/workqueue.c
>>>>> @@ -3696,14 +3696,16 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
>>>>>  }
>>>>>
>>>>>  /**
>>>>> - * pwq_adjust_max_active - update a pwq's max_active to the current setting
>>>>> + * pwq_adjust_max_active_and_kick - update a pwq's max_active to the current setting
>>>>>   * @pwq: target pool_workqueue
>>>>> + * @force_kick: force to kick a worker
>>>>>   *
>>>>>   * If @pwq isn't freezing, set @pwq->max_active to the associated
>>>>>   * workqueue's saved_max_active and activate delayed work items
>>>>>   * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
>>>>>   */
>>>>> -static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>>>>> +static void pwq_adjust_max_active_and_kick(struct pool_workqueue *pwq,
>>>>> +                                       bool force_kick)
>>>>>  {
>>>>>         struct workqueue_struct *wq = pwq->wq;
>>>>>         bool freezable = wq->flags & WQ_FREEZABLE;
>>>>> @@ -3733,9 +3735,10 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>>>>>
>>>>>                 /*
>>>>>                  * Need to kick a worker after thawed or an unbound wq's
>>>>> -                * max_active is bumped.  It's a slow path.  Do it always.
>>>>> +                * max_active is bumped.
>>>>
>>>>
>>>> Hello
>>>>
>>>> Thanks for reporting the problem.
>>>>
>>>> But I don't like to add an argument. The waking up is called
>>>> always just because it was considered no harm and it is slow
>>>> path. But it can still be possible to detect if the waking up
>>>> is really needed based on the actual activation of delayed works.
>>>>
>>>> The previous lines are:
>>>>
>>>>                 while (!list_empty(&pwq->delayed_works) &&
>>>>                        pwq->nr_active < pwq->max_active)
>>>>                         pwq_activate_first_delayed(pwq);
>>>>
>>>> And you can record the old pwq->nr_active before these lines:
>>>>
>>>>                 int old_nr_active = pwq->nr_active;
>>>>
>>>>                 while (!list_empty(&pwq->delayed_works) &&
>>>>                        pwq->nr_active < pwq->max_active)
>>>>                         pwq_activate_first_delayed(pwq);
>>>>
>>>>                 /* please add more comments here, see 951a078a5 */
>>>>                 if (old_nr_active < pwq->nr_active) {
>>>>                         if (!old_nr_active || (wq->flags & WQ_UNBOUND))
>>>>                                 wake_up_worker(pwq->pool);
>>>>                 }
>>>>
>>> Ok, I will send a patch v2.
>>> Thanks.
>>>
>> I think it is unnecessary to distinguish the percpu or unbound's wq,
>> kick a worker always based on the actual activation of delayed works.
>>
>> Look like this:
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index c41c3c17b86a..cd551dcb2cc9 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -3725,17 +3725,23 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>>          * is updated and visible.
>>          */
>>         if (!freezable || !workqueue_freezing) {
>> +               bool kick = false;
>> +
>>                 pwq->max_active = wq->saved_max_active;
>>
>>                 while (!list_empty(&pwq->delayed_works) &&
>> -                      pwq->nr_active < pwq->max_active)
>> +                      pwq->nr_active < pwq->max_active) {
>>                         pwq_activate_first_delayed(pwq);
>> +                       kick = true;
>> +               }
>>
>>                 /*
>>                  * Need to kick a worker after thawed or an unbound wq's
>> -                * max_active is bumped.  It's a slow path.  Do it always.
>> +                * max_active is bumped. It's a slow path. Do it always
>> +                * based on the actual activation of delayed works.
>>                  */
>> -               wake_up_worker(pwq->pool);
>> +               if (kick)
>> +                       wake_up_worker(pwq->pool);
>>         } else {
>>                 pwq->max_active = 0;
>>         }
>>
>> Is it OK?
>> Thanks.
> 
> 
> It is OK, since it is a slow path. Please also add
> comments to the code for reasons not to wake up in
> some cases as described in your previous comments.
> 
Ok, thanks.

>>
>>>>
>>>> Thanks for your work.
>>>> Lai.
>>>>
>>>>>                  */
>>>>> -               wake_up_worker(pwq->pool);
>>>>> +               if (force_kick || (wq->flags & WQ_UNBOUND))
>>>>> +                       wake_up_worker(pwq->pool);
>>>>>         } else {
>>>>>                 pwq->max_active = 0;
>>>>>         }
>>>>> @@ -3743,6 +3746,11 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>>>>>         raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
>>>>>  }
>>>>>
>>>>> +static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>>>>> +{
>>>>> +       pwq_adjust_max_active_and_kick(pwq, false);
>>>>> +}
>>>>> +
>>>>>  /* initialize newly alloced @pwq which is associated with @wq and @pool */
>>>>>  static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
>>>>>                      struct worker_pool *pool)
>>>>> @@ -5252,7 +5260,7 @@ void thaw_workqueues(void)
>>>>>         list_for_each_entry(wq, &workqueues, list) {
>>>>>                 mutex_lock(&wq->mutex);
>>>>>                 for_each_pwq(pwq, wq)
>>>>> -                       pwq_adjust_max_active(pwq);
>>>>> +                       pwq_adjust_max_active_and_kick(pwq, true);
>>>>>                 mutex_unlock(&wq->mutex);
>>>>>         }
>>>>>
>>>>> --
>>>>> 2.18.4
>>>> .
>>>>
> .
> 
