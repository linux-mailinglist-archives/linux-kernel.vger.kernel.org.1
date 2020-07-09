Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38C21A0F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgGINe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 09:34:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgGINe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:34:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B291FB;
        Thu,  9 Jul 2020 06:34:58 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15A453FA00;
        Thu,  9 Jul 2020 06:34:51 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20200702144258.19326-1-vincent.guittot@linaro.org>
 <4198cf3d-308e-feee-91c3-2edfd1748b4c@arm.com>
 <CAKfTPtBeRXCEWB3dTC8uOqbQ5xaZqQTAeG1EVGEk+pJcYz00sw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9a282390-1c81-0e77-9567-116c8777f7b5@arm.com>
Date:   Thu, 9 Jul 2020 15:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBeRXCEWB3dTC8uOqbQ5xaZqQTAeG1EVGEk+pJcYz00sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 11:47, Vincent Guittot wrote:
> On Wed, 8 Jul 2020 at 11:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 02/07/2020 16:42, Vincent Guittot wrote:
>>> task_h_load() can return 0 in some situations like running stress-ng
>>> mmapfork, which forks thousands of threads, in a sched group on a 224 cores
>>> system. The load balance doesn't handle this correctly because
>>
>> I guess the issue here is that 'cfs_rq->h_load' in
>>
>> task_h_load() {
>>     struct cfs_rq *cfs_rq = task_cfs_rq(p);
>>     ...
>>     return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
>>                     cfs_rq_load_avg(cfs_rq) + 1);
>> }
>>
>> is still ~0 (or at least pretty small) compared to se.avg.load_avg being
>> 1024 and cfs_rq_load_avg(cfs_rq) n*1024 in these lb occurrences.
>>
>>> env->imbalance never decreases and it will stop pulling tasks only after
>>> reaching loop_max, which can be equal to the number of running tasks of
>>> the cfs. Make sure that imbalance will be decreased by at least 1.

Looks like it's bounded by sched_nr_migrate (32 on my E5-2690 v2).

env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);

[...]

>> I assume that this is related to the LKP mail
> 
> I have found this problem while studying the regression raised in the
> email below but it doesn't fix it. At least, it's not enough
> 
>>
>> https://lkml.kernel.org/r/20200421004749.GC26573@shao2-debian ?

I see. It also happens with other workloads but it's most visible
at the beginning of a workload (fork).

Still on E5-2690 v2 (2*2*10, 40 CPUs):

In the taskgroup cfs_rq->h_load is ~ 1024/40 = 25 so this leads to
task_h_load = 0 with cfs_rq->avg.load_avg 40 times higher than the
individual task load (1024).

One incarnation of 20 loops w/o any progress (that's w/o your patch).

With loop='loop/loop_break/loop_max'
and load='p->se.avg.load_avg/cfs_rq->h_load/cfs_rq->avg.load_avg'

Jul  9 10:41:18 e105613-lin kernel: [73.068844] [stress-ng-mmapf 2907] SMT CPU37->CPU17 imb=8 loop=1/32/32 load=1023/23/43006
Jul  9 10:41:18 e105613-lin kernel: [73.068873] [stress-ng-mmapf 3501] SMT CPU37->CPU17 imb=8 loop=2/32/32 load=1022/23/41983
Jul  9 10:41:18 e105613-lin kernel: [73.068890] [stress-ng-mmapf 2602] SMT CPU37->CPU17 imb=8 loop=3/32/32 load=1023/23/40960
...
Jul  9 10:41:18 e105613-lin kernel: [73.069136] [stress-ng-mmapf 2520] SMT CPU37->CPU17 imb=8 loop=18/32/32 load=1023/23/25613
Jul  9 10:41:18 e105613-lin kernel: [73.069144] [stress-ng-mmapf 3107] SMT CPU37->CPU17 imb=8 loop=19/32/32 load=1021/23/24589
Jul  9 10:41:18 e105613-lin kernel: [73.069149] [stress-ng-mmapf 2672] SMT CPU37->CPU17 imb=8 loop=20/32/32 load=1024/23/23566
...

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>







