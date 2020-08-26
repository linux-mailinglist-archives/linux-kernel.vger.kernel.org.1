Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A26252F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgHZNQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:16:32 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59488 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729177AbgHZNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:16:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6w.nFU_1598447788;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6w.nFU_1598447788)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 21:16:28 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
 <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
 <20200826110015.GO22869@dhcp22.suse.cz>
 <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
 <20200826120740.GP22869@dhcp22.suse.cz>
 <19eb48db-7d5e-0f55-5dfc-6a71274fd896@linux.alibaba.com>
 <20200826124810.GQ22869@dhcp22.suse.cz>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <061e8600-e162-6ac9-2f4f-bf161435a5b2@linux.alibaba.com>
Date:   Wed, 26 Aug 2020 21:16:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826124810.GQ22869@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/26 下午8:48, Michal Hocko wrote:
> On Wed 26-08-20 20:21:39, xunlei wrote:
>> On 2020/8/26 下午8:07, Michal Hocko wrote:
>>> On Wed 26-08-20 20:00:47, xunlei wrote:
>>>> On 2020/8/26 下午7:00, Michal Hocko wrote:
>>>>> On Wed 26-08-20 18:41:18, xunlei wrote:
>>>>>> On 2020/8/26 下午4:11, Michal Hocko wrote:
>>>>>>> On Wed 26-08-20 15:27:02, Xunlei Pang wrote:
>>>>>>>> We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
>>>>>>>> the target memcg doesn't have any reclaimable memory.
>>>>>>>
>>>>>>> Do you have any scenario when this happens or is this some sort of a
>>>>>>> test case?
>>>>>>
>>>>>> It can happen on tiny guest scenarios.
>>>>>
>>>>> OK, you made me more curious. If this is a tiny guest and this is a hard
>>>>> limit reclaim path then we should trigger an oom killer which should
>>>>> kill the offender and that in turn bail out from the try_charge lopp
>>>>> (see should_force_charge). So how come this repeats enough in your setup
>>>>> that it causes soft lockups?
>>>>>
>>>>
>>>> should_force_charge() is false, the current trapped in endless loop is
>>>> not the oom victim.
>>>
>>> How is that possible? If the oom killer kills a task and that doesn't
>>> resolve the oom situation then it would go after another one until all
>>> tasks are killed. Or is your task living outside of the memcg it tries
>>> to charge?
>>>
>>
>> All tasks are in memcgs. Looks like the first oom victim is not finished
>> (unable to schedule), later mem_cgroup_oom()->...->oom_evaluate_task()
>> will set oc->chosen to -1 and abort.
> 
> This shouldn't be possible for too long because oom_reaper would
> make it invisible to the oom killer so it should proceed. Also
> mem_cgroup_out_of_memory takes a mutex and that is an implicit
> scheduling point already.
> 
> Which kernel version is this?
> 

I reproduced it on "5.9.0-rc2".

oom_reaper also can't get scheduled because of 1-cpu, and the mutex
uses might_sleep() which is noop in case of "CONFIG_PREEMPT_VOLUNTARY is
not set" I mentioned in the commit log.

> And just for the clarification. I am not against the additional
> cond_resched. That sounds like a good thing in general because we do
> want to have a predictable scheduling during reclaim which is
> independent on reclaimability as much as possible. But I would like to
> drill down to why you are seeing the lockup because those shouldn't
> really happen.
> 
