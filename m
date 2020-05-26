Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9191BDB44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD2MBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 08:01:06 -0400
Received: from foss.arm.com ([217.140.110.172]:37838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgD2MBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:01:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB321063;
        Wed, 29 Apr 2020 05:01:05 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6583F73D;
        Wed, 29 Apr 2020 05:01:04 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com> <20200428050242.17717-2-swood@redhat.com> <jhjftcns35d.mognet@arm.com> <2a30101cc0adb63ee7ce7b32119579d78de24b71.camel@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from finish_task_switch()
Message-ID: <jhjtv12pklx.mognet@arm.com>
In-reply-to: <2a30101cc0adb63ee7ce7b32119579d78de24b71.camel@redhat.com>
Date:   Wed, 29 Apr 2020 13:00:58 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/04/20 23:33, Scott Wood wrote:
> On Tue, 2020-04-28 at 22:37 +0100, Valentin Schneider wrote:
>> On 28/04/20 06:02, Scott Wood wrote:
>> > Thus, newidle_balance() is entered with interrupts enabled, which allows
>> > (in the next patch) enabling interrupts when the lock is dropped.
>> >
>> > Signed-off-by: Scott Wood <swood@redhat.com>
>> > ---
>> >  kernel/sched/core.c  |  7 ++++---
>> >  kernel/sched/fair.c  | 45 ++++++++++++++++----------------------------
>> >  kernel/sched/sched.h |  6 ++----
>> >  3 files changed, 22 insertions(+), 36 deletions(-)
>> >
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 9a2fbf98fd6f..0294beb8d16c 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct
>> > task_struct *prev)
>> >       }
>> >
>> >       tick_nohz_task_switch();
>> > +
>> > +	if (is_idle_task(current))
>> > +		newidle_balance();
>> > +
>>
>> This means we must go through a switch_to(idle) before figuring out we
>> could've switched to a CFS task, and do it then. I'm curious to see the
>> performance impact of that.
>
> Any particular benchmark I should try?
>

I'm going to be very original and suggest hackbench :-)

That would just be the first stop however, you would also want to try
something less wakeup-intensive, maybe sysbench and the like - I'm thinking
if you spawn ~1.5*nr_cpu_ids CPU-hogs, you'll hit that double switch fairly
easily.

And then there's always the big boys benchmarks like specjbb and co - I'd
suggest having a look at Mel's mmtests.
