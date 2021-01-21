Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01D2FF330
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbhAUSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:30:47 -0500
Received: from foss.arm.com ([217.140.110.172]:43236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389511AbhAUSPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:15:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE8711B3;
        Thu, 21 Jan 2021 10:14:39 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65A3D3F66E;
        Thu, 21 Jan 2021 10:14:38 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        "linuxarm\@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH] sched/fair: first try to fix the scheduling impact of NUMA diameter > 2
In-Reply-To: <3a718e03ebab4dafab9cca028fd94b20@hisilicon.com>
References: <20210115203632.34396-1-song.bao.hua@hisilicon.com> <CAKfTPtAbbMEGQjVbNw-Z3O-Bh9-JKaHy4J2snwp5RwxSNXqz-Q@mail.gmail.com> <3a718e03ebab4dafab9cca028fd94b20@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 18:14:33 +0000
Message-ID: <jhjk0s62m46.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 18/01/21 11:25, Song Bao Hua wrote:
>> -----Original Message-----
>> From: Vincent Guittot [mailto:vincent.guittot@linaro.org]
>> Sent: Tuesday, January 19, 2021 12:14 AM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
>> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
>> Dietmar Eggemann <dietmar.eggemann@arm.com>; Morten Rasmussen
>> <morten.rasmussen@arm.com>; Valentin Schneider <valentin.schneider@arm.com>;
>> linux-kernel <linux-kernel@vger.kernel.org>; Mel Gorman <mgorman@suse.de>;
>> linuxarm@openeuler.org
>> Subject: Re: [RFC PATCH] sched/fair: first try to fix the scheduling impact
>> of NUMA diameter > 2
>>
>> On Fri, 15 Jan 2021 at 21:42, Barry Song <song.bao.hua@hisilicon.com> wrote:
>> >
>> > This patch is a follow-up of the 3-hops issue reported by Valentin Schneider:
>> > [1] https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com/
>> > [2]
>> https://lore.kernel.org/lkml/20201110184300.15673-1-valentin.schneider@arm
>> .com/
>> >
>> > Here is a brief summary of the background:
>> > For a NUMA system with 3-hops, sched_group for NUMA 2-hops could be not a
>> > subset of sched_domain.
>> > For example, for a system with the below topology(two cpus in each NUMA
>> > node):
>> > node   0   1   2   3
>> >   0:  10  12  20  22
>> >   1:  12  10  22  24
>> >   2:  20  22  10  12
>> >   3:  22  24  12  10
>> >
>> > For CPU0, domain-2 will span 0-5, but its group will span 0-3, 4-7.
>> > 4-7 isn't a subset of 0-5.
>> >
>> > CPU0 attaching sched-domain(s):
>> >  domain-0: span=0-1 level=MC
>> >   groups: 0:{ span=0 cap=989 }, 1:{ span=1 cap=1016 }
>> >   domain-1: span=0-3 level=NUMA
>> >    groups: 0:{ span=0-1 cap=2005 }, 2:{ span=2-3 cap=2028 }
>> >    domain-2: span=0-5 level=NUMA
>> >     groups: 0:{ span=0-3 cap=4033 }, 4:{ span=4-7 cap=3909 }
>> >  ERROR: groups don't span domain->span
>> >     domain-3: span=0-7 level=NUMA
>> >      groups: 0:{ span=0-5 mask=0-1 cap=6062 }, 6:{ span=4-7 mask=6-7 cap=3928 }
>> >
>> > All other cpus also have the same issue: sched_group could be not a subset
>> > of sched_domain.
>> >
>> > Here I am trying to figure out the scheduling impact of this issue from
>> > two aspects:
>> > 1. find busiest cpu in load_balance
>> > 2. find idlest cpu in fork/exec/wake balance
>>
>> Would be better to fix the error in the sched domain topology instead
>> of hacking the load balance to compensate the topology problem
>
> I think Valentin Schneider has tried to do that before, but failed. This will
> add some new groups which won't be managed by current update_group_capacity()?
> @Valentine, would you like to share more details?
>

Sorry for being late to the party, this is gnarly stuff and I can't dive
back into it without spending some time staring at my notes and diagrams...
I did indeed try to fix the group construction, thinking it would "just" be
a matter of changing one mask into another, but it turned out to be quite
trickier.

Let's go back to https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com/

Right now, for that #Case study w/ QEMU platform, we get:

  CPU0-domain1: span=0-2
    group0: span=0-2, mask=0
    group2: span=1-3, mask=2 # CPU3 shouldn't be included
  CPU1-domain1: span=0-3
    group1: span=0-2, mask=1
    group3: span=2-3, mask=3
  CPU2-domain1: span=0-3
    group2: span=1-3, mask=2
    group0: span=0-1, mask=0
  CPU3-domain1: span=0-2
    group3: span=2-3, mask=3
    group1: span=0-2, mask=1 # CPU0 shouldn't be included

We would want to "fix" this into:

  CPU0-domain1
    group0: span=0-2, mask=0
  - group2: span=1-3, mask=2
  + group?: span=1-2, mask=??
  CPU1-domain1
    group1: span=0-2, mask=1
    group3: span=2-3, mask=3
  CPU2-domain1
    group2: span=1-3, mask=2
    group0: span=0-1, mask=0
  CPU3-domain1
    group3: span=2-3, mask=3
  - group1: span=0-2, mask=1
  + group?: span=1-2, mask=??

Note the '?' for the group ID and for the group balance mask. What I tried
to hint at when writing this is that, right now, there is no sane ID nor
balance mask to give to those "new" groups.

The group ID is supposed to be the CPU owning the sched_group_capacity
structure for the unique group span, which right now is the first CPU in
the balance mask - I recommend reading the comments atop
group_balance_cpu(), build_balance_mask() and get_group().

Here, we would end up with 5 unique group spans despite only having 4 CPUs:
our allocation scheme doesn't hold up anymore. This stems from the way we
allocate our topology data: we have a percpu slot per topology level.

Furthermore, these "new" groups won't be the local group of any CPU,
which means update_group_capacity() will never visit them - their capacity
will never be updated.


Here are some possible ways forward:
- Have extra storage in struct sd_data for sched_group_capacity of those
  new, non-local groups. There might be topologies where you'll need to
  store more than one such group per CPU in there.
- During load balance stats update, update the local group *and* all of
  those new, non-local ones.

Conceptually I think this is what would be required, but it does feel very
duct-tape-y...

> On the other hand, another purpose of this RFC is that I also want to dig into
> more details about how the 3-hops issue could affect the behavior of scheduler.
> In Valentine's original thread, I think we haven't figured out how the issue
> will really impact scheduling.
>

I think the long story short was that since you can end up with groups
spanning CPUs farther away than what the domain represents, the load
balance stats computation (to figure out which busiest group to pull from)
can and will be skewered.

There are safeguards to prevent pulling from outside the domain span, but
that doesn't protect the stats.
