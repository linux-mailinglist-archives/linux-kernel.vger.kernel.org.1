Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43B62D9F82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441015AbgLNSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:47:42 -0500
Received: from foss.arm.com ([217.140.110.172]:51770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440537AbgLNSrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:47:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A8B1FB;
        Mon, 14 Dec 2020 10:46:21 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD3C23F66E;
        Mon, 14 Dec 2020 10:46:17 -0800 (PST)
Subject: Re: [PATCH] fair/util_est: Separate util_est_dequeue() for
 cfs_rq_util_change
To:     Ryan Y <xuewen.yan94@gmail.com>
Cc:     patrick.bellasi@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Xuewen Yan <Xuewen.Yan@unisoc.com>,
        Ryan Y <xuewyan@foxmail.com>, zhang.lyra@gmail.com,
        Ke.Wang@unisoc.com
References: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
 <2edefcc7-ccea-5665-728e-5b86ac413629@arm.com>
 <CAB8ipk-z0e5XnkR__vW9+NAz_rFDpC3odLnPEthWZoHKVRSYWg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f7eb8636-2c15-58ef-d328-f879f16f498b@arm.com>
Date:   Mon, 14 Dec 2020 19:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk-z0e5XnkR__vW9+NAz_rFDpC3odLnPEthWZoHKVRSYWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2020 13:03, Ryan Y wrote:
> Hi Dietmar,
> 
> Yes! That's exactly what I meant.
> 
>> The issue is that sugov_update_[shared\|single] -> sugov_get_util() ->
>> cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued value?
> 
> well, because of this, when the p dequeued, _task_util_est(p) should be
> subtracted before cfs_rq_util_change().
> however, the original util_est_dequeue() dequeue the util_est and update
> the
> p->se.avg.util_est together.
> so I separate the original util_est_dequeue() to deal with the issue.

OK, I see.

I ran a testcase '50% periodic task 'task0-0' (8ms/16ms)' with
PELT + proprietary trace events within dequeue_task_fair() call:

task0-0-1710 [002] 218.215535: sched_pelt_se:      cpu=2 path=(null) comm=task0-0 pid=1710 load=596 runnable=597 util=597 update_time=218123022336
task0-0-1710 [002] 218.215536: sched_pelt_cfs:     cpu=2 path=/ load=597 runnable=597 util=597 update_time=218123022336
task0-0-1710 [002] 218.215538: bprint:             sugov_get_util: CPU2 rq->cfs.avg.util_avg=597 rq->cfs.avg.util_est.enqueued=601
task0-0-1710 [002] 218.215540: sched_util_est_cfs: cpu=2 path=/ enqueued=0 ewma=0 util=597
task0-0-1710 [002] 218.215542: bprint:             dequeue_task_fair: CPU2 [task0-0 1710] rq->cfs.avg.util_avg=[576->597] rq->cfs.avg.util_est.enqueued=[601->0]

It's true that 'sugov_get_util() -> cpu_util_cfs()' can use
rq->cfs.avg.util_est.enqueued before _task_util_est(p) is subtracted
from it.

But isn't rq->cfs.avg.util_est.enqueued (in this case 601) always close
to rq->cfs.avg.util_avg (597) since the task was just running?
The cfs_rq utilization contains a blocked (sleeping) task.

If I would run with your patch cpu_util_cfs() would chose between 597 and 0
whereas without it does between 597 and 601.

Do you have a specific use case in mind? Or even test results showing a benefit
of your patch?

> Dietmar Eggemann <dietmar.eggemann@arm.com> 于2020年12月11日周五 下午7:30写道：
> 
>> Hi Yan,
>>
>> On 09/12/2020 11:44, Xuewen Yan wrote:
>>> when a task dequeued, it will update it's util, and cfs_rq_util_change
>>> would check rq's util, if the cfs_rq->avg.util_est.enqueued is bigger
>>> than  cfs_rq->avg.util_avg, but because the cfs_rq->avg.util_est.enqueued
>>> didn't be decreased, this would cause bigger cfs_rq_util by mistake,
>>> as a result, cfs_rq_util_change may change freq unreasonablely.
>>>
>>> separate the util_est_dequeue() into util_est_dequeue() and
>>> util_est_update(), and dequeue the _task_util_est(p) before update util.
>>
>> The issue is that sugov_update_[shared\|single] -> sugov_get_util() ->
>> cpu_util_cfs() operates on an old  cfs_rq->avg.util_est.enqueued value?
>>
>> cpu_util_cfs()
>>
>>     if (sched_feat(UTIL_EST))
>>         util = max_t(util, READ_ONCE(rq->cfs.avg.util_est.enqueued))
>>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> dequeue_task_fair() (w/ your patch, moving (1) before (2))
>>
>>     /* (1) update cfs_rq->avg.util_est.enqueued */
>>     util_est_dequeue()
>>
>>     /* (2) potential p->se.avg.util_avg update */
>>     /* 2 for loops */
>>     for_each_sched_entity()
>>
>>         /* this can only lead to a freq change for a root cfs_rq */
>>         (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
>>          -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]
>>
>>     /* (3) potential update p->se.avg.util_est */
>>     util_est_update()
>>
>>
>> We do need (3) after (2) because of:
>>
>> util_est_update()
>>     ...
>>     ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED); task_util
>>     ...           ^^^^^^^^^^^^^
>>                   p->se.avg.util_avg
>>
>>
>> Did I get this right?
>>
>> [...]
