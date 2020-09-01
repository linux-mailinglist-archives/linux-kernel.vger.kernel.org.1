Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F63258E46
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgIAMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 08:36:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47698 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgIAMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:34:30 -0400
Received: from [192.168.86.25] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 846DE20B7178;
        Tue,  1 Sep 2020 05:34:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 846DE20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598963668;
        bh=ZxwU2roOX4KeltHsFjNlJfAqlsO0/2W+7C1+GAHheYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MIIhNwpujbqkYx8Ll//w6NlyIHtZB1meJDI0HeFizvgT6XX2f1ImNgifmm66CfsuD
         WAoxwqJwPS4rTf32HHUWbcrxe9Hkx6UwdYvyXBhiaKw/kkobU+4IKo/3OCi3o6sc31
         HRXQwKeZBuBQW/uTs1jcCwEKZI++fjMH3HgSUepM=
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
To:     Joel Fernandes <joel@joelfernandes.org>, peterz@infradead.org
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
 <20200901051014.GA3993517@google.com>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <a41dac6f-6864-c215-0f7a-90f2126673a6@linux.microsoft.com>
Date:   Tue, 1 Sep 2020 08:34:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901051014.GA3993517@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 9/1/20 1:10 AM, Joel Fernandes wrote:
> 3. The 'Rescheduling siblings' loop of pick_next_task() is quite fragile. It
> calls various functions on rq->core_pick which could very well be NULL because:
> An online sibling might have gone offline before a task could be picked for it,
> or it might be offline but later happen to come online, but its too late and
> nothing was picked for it. Just ignore the siblings for which nothing could be
> picked. This avoids any crashes that may occur in this loop that assume
> rq->core_pick is not NULL.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
I like this idea, its much simpler :-)

> ---
>   kernel/sched/core.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 717122a3dca1..4966e9f14f39 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4610,13 +4610,24 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   	if (!sched_core_enabled(rq))
>   		return __pick_next_task(rq, prev, rf);
>   
> +	cpu = cpu_of(rq);
> +
> +	/* Stopper task is switching into idle, no need core-wide selection. */
I think we can come here when hotplug thread is scheduled during online, but
mask is not yet updated. Probably can add it with this comment as well.

> +	if (cpu_is_offline(cpu))
> +		return __pick_next_task(rq, prev, rf);
> +
We would need reset core_pick here I think. Something like
     if (cpu_is_offline(cpu)) {
         rq->core_pick = NULL;
         return __pick_next_task(rq, prev, rf);
     }

Without this we can end up in a crash like this:
1. Sibling of this cpu picks a task (rq_i->core_pick) and this cpu goes
     offline soon after.
2. Before this cpu comes online, sibling goes through another pick loop
     and before its IPI loop, this cpu comes online and we get an IPI.
3. So when this cpu gets into schedule, we have core_pick set and
     core_pick_seq != core_sched_seq. So we enter the fast path. But
     core_pick might no longer in this runqueue.

So, to protect this, we should reset core_pick I think. I have seen this 
crash
occasionally.

>   	/*
>   	 * If there were no {en,de}queues since we picked (IOW, the task
>   	 * pointers are all still valid), and we haven't scheduled the last
>   	 * pick yet, do so now.
> +	 *
> +	 * rq->core_pick can be NULL if no selection was made for a CPU because
> +	 * it was either offline or went offline during a sibling's core-wide
> +	 * selection. In this case, do a core-wide selection.
>   	 */
>   	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> -	    rq->core->core_pick_seq != rq->core_sched_seq) {
> +	    rq->core->core_pick_seq != rq->core_sched_seq &&
> +	    !rq->core_pick) {
Should this check be reversed? I mean, we should enter the fastpath if
we have rq->core_pick is set right?


Another unrelated, but related note :-)
Besides this, I think we need to retain on more change from the previous
patch. We would need to make core_pick_seq per sibling instead of per
core. Having it per core might lead to unfairness. For eg: When a cpu
sees that its sibling's core_pick is the one which is already running, it
will not send IPI. but core_pick remains set and core->core_pick_seq is
incremented. Now if the sibling is preempted due to a high priority task
or its time slice expired, it enters schedule. But it goes to fast path and
selects the running task there by starving the high priority task. Having
the core_pick_seq per sibling will avoid this. It might also help in some
hotplug corner cases as well.

Thanks,
Vineeth

