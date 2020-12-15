Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038D2DB323
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgLOR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:58:17 -0500
Received: from foss.arm.com ([217.140.110.172]:54978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbgLOR56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:57:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B2430E;
        Tue, 15 Dec 2020 09:57:08 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3D8A3F66E;
        Tue, 15 Dec 2020 09:57:04 -0800 (PST)
Subject: Re: [PATCH] fair/util_est: Separate util_est_dequeue() for
 cfs_rq_util_change
To:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuewen Yan <Xuewen.Yan@unisoc.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
References: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
 <2edefcc7-ccea-5665-728e-5b86ac413629@arm.com>
 <CAB8ipk-z0e5XnkR__vW9+NAz_rFDpC3odLnPEthWZoHKVRSYWg@mail.gmail.com>
 <f7eb8636-2c15-58ef-d328-f879f16f498b@arm.com>
 <CAKfTPtBRid+d1bkd4eEXmB_zuF3OgWODD-HipuvpJk9jg6UqMg@mail.gmail.com>
 <CAB8ipk9O8E3q3cFwbKfcEnkOPXW-aT452yn1gie+yLBiDCcCrg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <762eea44-282b-b000-cfec-f5df4d24fa29@arm.com>
Date:   Tue, 15 Dec 2020 18:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk9O8E3q3cFwbKfcEnkOPXW-aT452yn1gie+yLBiDCcCrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2020 13:56, Xuewen Yan wrote:
> On Tue, Dec 15, 2020 at 5:39 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Mon, 14 Dec 2020 at 19:46, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 11/12/2020 13:03, Ryan Y wrote:

[...]

>>> It's true that 'sugov_get_util() -> cpu_util_cfs()' can use
>>> rq->cfs.avg.util_est.enqueued before _task_util_est(p) is subtracted
>>> from it.
>>>
>>> But isn't rq->cfs.avg.util_est.enqueued (in this case 601) always close
>>> to rq->cfs.avg.util_avg (597) since the task was just running?
>>> The cfs_rq utilization contains a blocked (sleeping) task.
>>
>> There will be a difference if the task alternates long and short runs
>> in which case util_avg is lower than util_est. But even in this case,
>> the freq will be update at next enqueue/dequeue/tick.
>> The only real case could be when cpu goes idle in shallow state (WFI)
>> which is impacted by the freq/voltage. But even in this case, the
>> situation should not be long
>>
>> That being said, I agree that the value used by schedutil is not
>> correct at dequeue

Ok, makes sense.

> Hi Dietmar,
> 
> as Vincent said, like the following scenario:
>                running                              sleep
> running        sleep
> |---------------------------------------|
>   |--------|
> 
>                   ^^
> at the ^^ time, the util_avg is lower than util_est.
> we hope that the CPU frequency would be reduced as soon as possible after
> the task is dequeued. But the issue affects the sensitivity of cpu
> frequency reduce.
> worse, since the time, if there is no task enqueue or other scenarios where the
> load is updated, the cpu may always maintain a high frequency.
> 
> if keep the util_est_dequeue as it is, are there other concerns,
> or this patch would affect other places of system?

I see. So essentially this could have an effect in task ramp-down and ramp-up scenarios.

periodic ramp-down task [8/16 -> 4/16 -> 1/16ms], 3 consecutive dequeue_task_fair():  

task0-0-1690  [000] 43.677788: sched_pelt_se:      cpu=0 path=(null) comm=task0-0 pid=1690 load=283 runnable=283 util=283 update_time=43333963776
task0-0-1690  [000] 43.677792: sched_pelt_cfs:     cpu=0 path=/ load=283 runnable=283 util=283 update_time=43333963776
task0-0-1690  [000] 43.677798: bprint:             sugov_get_util: CPU0 rq->cfs.avg.util_avg=283 rq->cfs.avg.util_est.enqueued=249
task0-0-1690  [000] 43.677803: sched_util_est_cfs: cpu=0 path=/ enqueued=0 ewma=0 util=283
task0-0-1690  [000] 43.677805: sched_util_est_se:  cpu=0 path=(null) comm=task0-0 pid=1690 enqueued=283 ewma=283 util=283
task0-0-1690  [000] 43.677810: bprint:             dequeue_task_fair: CPU0 [task0-0 1690] rq->cfs.avg.util_avg=[270->283] rq->cfs.avg.util_est.enqueued=[249->0]

task0-0-1690  [000] 43.698764: sched_pelt_se:      cpu=0 path=(null) comm=task0-0 pid=1690 load=247 runnable=248 util=248 update_time=43363011584
task0-0-1690  [000] 43.698768: sched_pelt_cfs:     cpu=0 path=/ load=248 runnable=248 util=248 update_time=43363011584
--> task0-0-1690  [000] 43.698774: bprint:             sugov_get_util: CPU0 rq->cfs.avg.util_avg=248 rq->cfs.avg.util_est.enqueued=283 <-- !!!
task0-0-1690  [000] 43.698778: sched_util_est_cfs: cpu=0 path=/ enqueued=0 ewma=0 util=248
task0-0-1690  [000] 43.698780: sched_util_est_se:  cpu=0 path=(null) comm=task0-0 pid=1690 enqueued=249 ewma=274 util=248
task0-0-1690  [000] 43.698785: bprint:             dequeue_task_fair: CPU0 [task0-0 1690] rq->cfs.avg.util_avg=[228->248] rq->cfs.avg.util_est.enqueued=[283->0]


task0-0-1690  [000] 43.714120: sched_pelt_se:      cpu=0 path=(null) comm=task0-0 pid=1690 load=183 runnable=183 util=183 update_time=43384443904
task0-0-1690  [000] 43.714125: sched_pelt_cfs:     cpu=0 path=/ load=183 runnable=183 util=183 update_time=43384443904
--> task0-0-1690  [000] 43.714131: bprint:             sugov_get_util: CPU0 rq->cfs.avg.util_avg=183 rq->cfs.avg.util_est.enqueued=275 <-- !!!
task0-0-1690  [000] 43.714135: sched_util_est_cfs: cpu=0 path=/ enqueued=0 ewma=0 util=183
task0-0-1690  [000] 43.714138: sched_util_est_se:  cpu=0 path=(null) comm=task0-0 pid=1690 enqueued=183 ewma=251 util=183
task0-0-1690  [000] 43.714142: bprint:             dequeue_task_fair: CPU0 [task0-0 1690] rq->cfs.avg.util_avg=[163->183] rq->cfs.avg.util_est.enqueued=[275->0]
