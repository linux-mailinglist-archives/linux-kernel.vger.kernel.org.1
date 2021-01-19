Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B052FC536
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbhASX6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:58:01 -0500
Received: from foss.arm.com ([217.140.110.172]:60096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395011AbhASNzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:55:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC465D6E;
        Tue, 19 Jan 2021 05:54:33 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D669F3F719;
        Tue, 19 Jan 2021 05:54:32 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is pinned
In-Reply-To: <CAKfTPtD+wU9-UitvnBmZFeAgXbsDO+qcsv-hYr0xxuewB_Kp+A@mail.gmail.com>
References: <20210119120755.2425264-1-qais.yousef@arm.com> <CAKfTPtD+wU9-UitvnBmZFeAgXbsDO+qcsv-hYr0xxuewB_Kp+A@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 19 Jan 2021 13:54:30 +0000
Message-ID: <jhjmtx53ucp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/21 14:34, Vincent Guittot wrote:
> On Tue, 19 Jan 2021 at 13:08, Qais Yousef <qais.yousef@arm.com> wrote:
>>
>> If the task is pinned to a cpu, setting the misfit status means that
>> we'll unnecessarily continuously attempt to migrate the task but fail.
>>
>> This continuous failure will cause the balance_interval to increase to
>> a high value, and eventually cause unnecessary significant delays in
>> balancing the system when real imbalance happens.
>>
>> Caught while testing uclamp where rt-app calibration loop was pinned to
>> cpu 0, shortly after which we spawn another task with high util_clamp
>> value. The task was failing to migrate after over 40ms of runtime due to
>> balance_interval unnecessary expanded to a very high value from the
>> calibration loop.
>>
>> Not done here, but it could be useful to extend the check for pinning to
>> verify that the affinity of the task has a cpu that fits. We could end
>> up in a similar situation otherwise.
>>
>> Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
>> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
>> ---
>>  kernel/sched/fair.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 197a51473e0c..9379a481dd8c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4060,7 +4060,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>>         if (!static_branch_unlikely(&sched_asym_cpucapacity))
>>                 return;
>>
>> -       if (!p) {
>> +       if (!p || p->nr_cpus_allowed == 1) {
>
> Side question: What happens if there is 2 misfit tasks and the current
> one is pinned but not the other waiting one
>

update_misfit_status() is called either on the current task (at tick) or
on the task picked by pick_next_task_fair() - i.e. CFS current or
about-to-be-current.

So if you have 2 CPU hogs enqueued on a single LITTLE, and one of them
is pinned, the other one will be moved away either via regular load
balance, or via misfit balance sometime after it's picked as the next
task to run.

Admittedly that second case suffers from unfortunate timing mostly
related to the load balance interval. There was an old patch in the
Android stack that would reduce the balance interval upon detecting a
misfit task to "accelerate" its upmigration; this might need to be
revisited...

>>                 rq->misfit_task_load = 0;
>>                 return;
>>         }
>> --
>> 2.25.1
>>
