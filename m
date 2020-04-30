Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61E1BFDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD3OSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:18:46 -0400
Received: from foss.arm.com ([217.140.110.172]:55924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3OSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:18:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387BC1063;
        Thu, 30 Apr 2020 07:18:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1CAD3F68F;
        Thu, 30 Apr 2020 07:18:43 -0700 (PDT)
References: <20200424041832.11364-1-hdanton@sina.com> <20200424043650.14940-1-hdanton@sina.com> <20200430121301.3460-1-hdanton@sina.com> <da5bf72d-1d50-5c5c-3bdb-113ed555dd10@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] sched: set new prio after checking schedule policy
In-reply-to: <da5bf72d-1d50-5c5c-3bdb-113ed555dd10@arm.com>
Date:   Thu, 30 Apr 2020 15:18:41 +0100
Message-ID: <jhjv9lhcb0e.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/04/20 15:06, Dietmar Eggemann wrote:
>>>> +		newprio = NICE_TO_PRIO(attr->sched_nice);
>>>
>>> This is new, however AFAICT it doesn't change anything for CFS (or about to
>>> be) tasks since what matters is calling check_class_changed() further down.
>>
>> Yes it's only used by rt_effective_prio().
>>
>
> Looks like changing a SCHED_NORMAL to a SCHED_BATCH task will create a different
> queue_flags value.
>
> # chrt -p $$
> pid 2803's current scheduling policy: SCHED_OTHER
> pid 2803's current scheduling priority: 0
>
> # chrt -b -p 0 $$
>
> ...
> [bash 2803] policy=3 oldprio=120 newprio=[99->120] new_effective_prio=[99->120] queue_flags=[0xe->0xa]
> [bash 2803] queued=0 running=0
> ...
>
> But since in this example 'queued=0' it has no further effect here.
>
> Why is SCHED_NORMAL/SCHED_BATCH (fair_policy()) now treated differently than SCHED_IDLE?
>
> # chrt -i -p 0 $$
>
> ...
> [bash 2803] policy=5 newprio=99 oldprio=120 new_effective_prio=99 queue_flags=0xe
> [bash 2803] queued=0 running=0
> ...


Good catch; I suppose we'll want to special case SCHED_IDLE (IIRC should
map to nice 20).

As you pointed out, right now the newprio computation for CFS tasks is
kinda bonkers, so it seems we'll almost always clear DEQUEUE_MOVE from
queue_flags for them.

For CFS, not having DEQUEUE_MOVE here would lead to not calling
update_min_vruntime() on the dequeue. I'm not sure how much it matters in
this one case - I don't expect sched_setscheduler() calls to be *too*
frequent, and that oughta be fixed by the next entity_tick()) - but that is
an actual change.
