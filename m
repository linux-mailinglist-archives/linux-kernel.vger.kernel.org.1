Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254012FFAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbhAVCyD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 21:54:03 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2958 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAVCx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:53:59 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMP1H0NwXz5K3l;
        Fri, 22 Jan 2021 10:52:03 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 10:53:11 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 22 Jan 2021 10:53:10 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Fri, 22 Jan 2021 10:53:10 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH] sched/fair: first try to fix the scheduling impact of
 NUMA diameter > 2
Thread-Topic: [RFC PATCH] sched/fair: first try to fix the scheduling impact
 of NUMA diameter > 2
Thread-Index: AQHW637fjqpbim3xqkeVVnSjjCpCl6osuNCAgACFa/CABKc0gIABDrlQ
Date:   Fri, 22 Jan 2021 02:53:10 +0000
Message-ID: <7be92b98620c48a0b9fa2fd1d697776a@hisilicon.com>
References: <20210115203632.34396-1-song.bao.hua@hisilicon.com>
 <CAKfTPtAbbMEGQjVbNw-Z3O-Bh9-JKaHy4J2snwp5RwxSNXqz-Q@mail.gmail.com>
 <3a718e03ebab4dafab9cca028fd94b20@hisilicon.com> <jhjk0s62m46.mognet@arm.com>
In-Reply-To: <jhjk0s62m46.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.167]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Friday, January 22, 2021 7:15 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Vincent Guittot
> <vincent.guittot@linaro.org>
> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> Dietmar Eggemann <dietmar.eggemann@arm.com>; Morten Rasmussen
> <morten.rasmussen@arm.com>; linux-kernel <linux-kernel@vger.kernel.org>; Mel
> Gorman <mgorman@suse.de>; linuxarm@openeuler.org
> Subject: RE: [RFC PATCH] sched/fair: first try to fix the scheduling impact
> of NUMA diameter > 2
> 
> 
> Hi,
> 
> On 18/01/21 11:25, Song Bao Hua wrote:
> >> -----Original Message-----
> >> From: Vincent Guittot [mailto:vincent.guittot@linaro.org]
> >> Sent: Tuesday, January 19, 2021 12:14 AM
> >> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> >> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> >> Dietmar Eggemann <dietmar.eggemann@arm.com>; Morten Rasmussen
> >> <morten.rasmussen@arm.com>; Valentin Schneider
> <valentin.schneider@arm.com>;
> >> linux-kernel <linux-kernel@vger.kernel.org>; Mel Gorman <mgorman@suse.de>;
> >> linuxarm@openeuler.org
> >> Subject: Re: [RFC PATCH] sched/fair: first try to fix the scheduling impact
> >> of NUMA diameter > 2
> >>
> >> On Fri, 15 Jan 2021 at 21:42, Barry Song <song.bao.hua@hisilicon.com> wrote:
> >> >
> >> > This patch is a follow-up of the 3-hops issue reported by Valentin Schneider:
> >> > [1] https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com/
> >> > [2]
> >>
> https://lore.kernel.org/lkml/20201110184300.15673-1-valentin.schneider@arm
> >> .com/
> >> >
> >> > Here is a brief summary of the background:
> >> > For a NUMA system with 3-hops, sched_group for NUMA 2-hops could be not
> a
> >> > subset of sched_domain.
> >> > For example, for a system with the below topology(two cpus in each NUMA
> >> > node):
> >> > node   0   1   2   3
> >> >   0:  10  12  20  22
> >> >   1:  12  10  22  24
> >> >   2:  20  22  10  12
> >> >   3:  22  24  12  10
> >> >
> >> > For CPU0, domain-2 will span 0-5, but its group will span 0-3, 4-7.
> >> > 4-7 isn't a subset of 0-5.
> >> >
> >> > CPU0 attaching sched-domain(s):
> >> >  domain-0: span=0-1 level=MC
> >> >   groups: 0:{ span=0 cap=989 }, 1:{ span=1 cap=1016 }
> >> >   domain-1: span=0-3 level=NUMA
> >> >    groups: 0:{ span=0-1 cap=2005 }, 2:{ span=2-3 cap=2028 }
> >> >    domain-2: span=0-5 level=NUMA
> >> >     groups: 0:{ span=0-3 cap=4033 }, 4:{ span=4-7 cap=3909 }
> >> >  ERROR: groups don't span domain->span
> >> >     domain-3: span=0-7 level=NUMA
> >> >      groups: 0:{ span=0-5 mask=0-1 cap=6062 }, 6:{ span=4-7 mask=6-7
> cap=3928 }
> >> >
> >> > All other cpus also have the same issue: sched_group could be not a subset
> >> > of sched_domain.
> >> >
> >> > Here I am trying to figure out the scheduling impact of this issue from
> >> > two aspects:
> >> > 1. find busiest cpu in load_balance
> >> > 2. find idlest cpu in fork/exec/wake balance
> >>
> >> Would be better to fix the error in the sched domain topology instead
> >> of hacking the load balance to compensate the topology problem
> >
> > I think Valentin Schneider has tried to do that before, but failed. This will
> > add some new groups which won't be managed by current update_group_capacity()?
> > @Valentine, would you like to share more details?
> >
> 
> Sorry for being late to the party, this is gnarly stuff and I can't dive
> back into it without spending some time staring at my notes and diagrams...
> I did indeed try to fix the group construction, thinking it would "just" be
> a matter of changing one mask into another, but it turned out to be quite
> trickier.
> 
> Let's go back to https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com/
> 
> Right now, for that #Case study w/ QEMU platform, we get:
> 
>   CPU0-domain1: span=0-2
>     group0: span=0-2, mask=0
>     group2: span=1-3, mask=2 # CPU3 shouldn't be included
>   CPU1-domain1: span=0-3
>     group1: span=0-2, mask=1
>     group3: span=2-3, mask=3
>   CPU2-domain1: span=0-3
>     group2: span=1-3, mask=2
>     group0: span=0-1, mask=0
>   CPU3-domain1: span=0-2
>     group3: span=2-3, mask=3
>     group1: span=0-2, mask=1 # CPU0 shouldn't be included
> 
> We would want to "fix" this into:
> 
>   CPU0-domain1
>     group0: span=0-2, mask=0
>   - group2: span=1-3, mask=2
>   + group?: span=1-2, mask=??
>   CPU1-domain1
>     group1: span=0-2, mask=1
>     group3: span=2-3, mask=3
>   CPU2-domain1
>     group2: span=1-3, mask=2
>     group0: span=0-1, mask=0
>   CPU3-domain1
>     group3: span=2-3, mask=3
>   - group1: span=0-2, mask=1
>   + group?: span=1-2, mask=??
> 
> Note the '?' for the group ID and for the group balance mask. What I tried
> to hint at when writing this is that, right now, there is no sane ID nor
> balance mask to give to those "new" groups.
> 
> The group ID is supposed to be the CPU owning the sched_group_capacity
> structure for the unique group span, which right now is the first CPU in
> the balance mask - I recommend reading the comments atop
> group_balance_cpu(), build_balance_mask() and get_group().
> 
> Here, we would end up with 5 unique group spans despite only having 4 CPUs:
> our allocation scheme doesn't hold up anymore. This stems from the way we
> allocate our topology data: we have a percpu slot per topology level.
> 
> Furthermore, these "new" groups won't be the local group of any CPU,
> which means update_group_capacity() will never visit them - their capacity
> will never be updated.
> 
> 
> Here are some possible ways forward:
> - Have extra storage in struct sd_data for sched_group_capacity of those
>   new, non-local groups. There might be topologies where you'll need to
>   store more than one such group per CPU in there.
> - During load balance stats update, update the local group *and* all of
>   those new, non-local ones.
> 
> Conceptually I think this is what would be required, but it does feel very
> duct-tape-y...

Yep. kernel is building sched_groups of domain[n] by using the child domains
domain[n-1] of those cpus in the span of domain[n]. 
so the new groups added by you don't have same span with the child domain
domain[n-1]. This kind of groups will be quite weird and need be maintained
separately.

> 
> > On the other hand, another purpose of this RFC is that I also want to dig
> into
> > more details about how the 3-hops issue could affect the behavior of scheduler.
> > In Valentine's original thread, I think we haven't figured out how the issue
> > will really impact scheduling.
> >
> 
> I think the long story short was that since you can end up with groups
> spanning CPUs farther away than what the domain represents, the load
> balance stats computation (to figure out which busiest group to pull from)
> can and will be skewered.

Yes. My patch mentioned two places where load balance stats are skewered.

1. find_busiest_group() in load_balance()
Just in case domain span is 0-3, one of its groups has span 2-5.
4 and 5 don't belong to the domain 0-3.

While calculating the load of group, update_sg_lb_stats() will do
(the sum of cpu2 and cpu3)/(capacity of the whole group cpu2-5). 

So the load of group2-5 will be underestimated. my patch moved to
do this:
(the sum of cpu2 and cpu3)/(the sum of capacity of cpu2-3)

It actually gets a relatively correct load of cpu2-3 which is a
part of group 2-5. If this "half" group has high load, another
group still have chance to pull task from cpu2 and cpu3.

2. find_idlest_group() in select_task_rq_fair()
This is mainly for placing a new forked/exec-ed task on an idle cpu.

In this path, I found there is totally no safeguard to prevent pushing
task to outside the domain span. And the load calculation will count all
cpus in the group which has cpu outside the domain.
(the sum of cpu2,3,4,5)/(capacity of the whole group cpu2-5)

What I have done here is moving to do load stats update in
update_sg_wakeup_stats() by:
(the sum of cpu2 and cpu3)/(the sum of capacity of cpu2-3)

and add a safeguard to prevent pushing task to cpu 4-5.

> 
> There are safeguards to prevent pulling from outside the domain span, but
> that doesn't protect the stats.

I did see pulling task won't go outside the domain in find_busiest_queue().
But since the load calculation is wrong, task pulling could happen in the
wrong direction.

Thanks
Barry


