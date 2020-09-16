Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9945126BF66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIPIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:34:17 -0400
Received: from foss.arm.com ([217.140.110.172]:56338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgIPIeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:34:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53501045;
        Wed, 16 Sep 2020 01:34:07 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5A63F718;
        Wed, 16 Sep 2020 01:34:06 -0700 (PDT)
References: <20200914100340.17608-1-vincent.guittot@linaro.org> <20200914100340.17608-5-vincent.guittot@linaro.org> <jhjft7i6euf.mognet@arm.com> <CAKfTPtBmNF8WrXLrnQow037bk=7z285ub7yLp2KdFQcJK1fsUw@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: reduce busy load balance interval
In-reply-to: <CAKfTPtBmNF8WrXLrnQow037bk=7z285ub7yLp2KdFQcJK1fsUw@mail.gmail.com>
Date:   Wed, 16 Sep 2020 09:34:04 +0100
Message-ID: <jhjbli65ddv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/09/20 08:02, Vincent Guittot wrote:
> On Tue, 15 Sep 2020 at 21:04, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>>
>> On 14/09/20 11:03, Vincent Guittot wrote:
>> > The busy_factor, which increases load balance interval when a cpu is busy,
>> > is set to 32 by default. This value generates some huge LB interval on
>> > large system like the THX2 made of 2 node x 28 cores x 4 threads.
>> > For such system, the interval increases from 112ms to 3584ms at MC level.
>> > And from 228ms to 7168ms at NUMA level.
>> >
>> > Even on smaller system, a lower busy factor has shown improvement on the
>> > fair distribution of the running time so let reduce it for all.
>> >
>>
>> ISTR you mentioned taking this one step further and making
>> (interval * busy_factor) scale logarithmically with the number of CPUs to
>> avoid reaching outrageous numbers. Did you experiment with that already?
>
> Yes I have tried the logarithmically scale but It didn't give any
> benefit compared to this solution for the fairness problem but
> impacted other use cases because it impacts idle interval and it also
> adds more constraints in the computation of the interval and
> busy_factor because we can end up with the same interval for 2
> consecutive levels .
>

Right, I suppose we could frob a topology level index in there to prevent
that if we really wanted to...

> That being said, it might be useful for other cases but i haven't look
> further for this
>

Fair enough!

>>
>> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > ---
>> >  kernel/sched/topology.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> > index 1a84b778755d..a8477c9e8569 100644
>> > --- a/kernel/sched/topology.c
>> > +++ b/kernel/sched/topology.c
>> > @@ -1336,7 +1336,7 @@ sd_init(struct sched_domain_topology_level *tl,
>> >       *sd = (struct sched_domain){
>> >               .min_interval           = sd_weight,
>> >               .max_interval           = 2*sd_weight,
>> > -             .busy_factor            = 32,
>> > +             .busy_factor            = 16,
>> >               .imbalance_pct          = 117,
>> >
>> >               .cache_nice_tries       = 0,
