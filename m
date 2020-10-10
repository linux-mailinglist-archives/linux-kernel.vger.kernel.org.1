Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2928A2E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbgJJW7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 10 Oct 2020 18:59:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbgJJWEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:04:35 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id BD45E2692650A23E888A;
        Sun, 11 Oct 2020 06:04:30 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sun, 11 Oct 2020 06:04:30 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 11 Oct 2020 06:04:29 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 11 Oct 2020 06:04:30 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Mel Gorman <mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [RFC] sched/numa: don't move tasks to idle numa nodes while src
 node has very light load?
Thread-Topic: [RFC] sched/numa: don't move tasks to idle numa nodes while src
 node has very light load?
Thread-Index: AdaFDgJxar2HSiPxTFetuIpaUOKfaP//hoAA/8sGblA=
Date:   Sat, 10 Oct 2020 22:04:30 +0000
Message-ID: <457f8c41f2e0411e8e6253437aa31d74@hisilicon.com>
References: <e7b7462375de4175a83ece3b60bab899@hisilicon.com>
 <20200907124216.GE3179@techsingularity.net>
In-Reply-To: <20200907124216.GE3179@techsingularity.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mel Gorman [mailto:mgorman@techsingularity.net]
> Sent: Tuesday, September 8, 2020 12:42 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Mel Gorman <mgorman@suse.de>; mingo@redhat.com;
> peterz@infradead.org; juri.lelli@redhat.com; vincent.guittot@linaro.org;
> dietmar.eggemann@arm.com; bsegall@google.com;
> linux-kernel@vger.kernel.org; Peter Zijlstra <a.p.zijlstra@chello.nl>; Valentin
> Schneider <valentin.schneider@arm.com>; Phil Auld <pauld@redhat.com>;
> Hillf Danton <hdanton@sina.com>; Ingo Molnar <mingo@kernel.org>;
> Linuxarm <linuxarm@huawei.com>; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>
> Subject: Re: [RFC] sched/numa: don't move tasks to idle numa nodes while src
> node has very light load?
> 
> On Mon, Sep 07, 2020 at 12:00:10PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > Hi All,
> > In case we have a numa system with 4 nodes and in each node we have 24
> cpus, and all of the 96 cores are idle.
> > Then we start a process with 4 threads in this totally idle system.
> > Actually any one of the four numa nodes should have enough capability to
> run the 4 threads while they can still have 20 idle CPUS after that.
> > But right now the existing code in CFS load balance will spread the 4 threads
> to multiple nodes.
> > This results in two negative side effects:
> > 1. more numa nodes are awaken while they can save power in lowest
> frequency and halt status
> > 2. cache coherency overhead between numa nodes
> >
> > A proof-of-concept patch I made to "fix" this issue to some extent is like:
> >
> 
> This is similar in concept to a patch that did something similar except
> in adjust_numa_imbalance(). It ended up being great for light loads like
> simple communicating pairs but fell apart for some HPC workloads when
> memory bandwidth requirements increased. Ultimately it was dropped until

Yes. There is a tradeoff between higher memory bandwidth and lower communication
overhead for things like bus latency, cache coherence. For kernel scheduler, it actually
doesn't know the requirement of applications. It doesn't know whether the application
is sensitive to memory bandwidth or sensitive to cache coherence unless applications
tell it by APIs like mempolicy().

It seems we can get the perf profiling data as the input for scheduler. If perf finds
the application needs lots of memory bandwidth, we spread it in more numa nodes.
Otherwise, if perf finds application gets low IPC due to cache coherence, we try to
put them in a numa node. Maybe it is too difficult for kernel, but if we could have
an userspace scheduler which call taskset, numactl based on perf profiling,  it seems
the userspace scheduler can schedule applications more precisely based on the
characteristics of applications?

> the NUMA/CPU load balancing was reconciled so may be worth a revisit. At
> the time, it was really problematic once a one node was roughly 25% CPU
> utilised on a 2-socket machine with hyper-threading enabled. The patch may
> still work out but it would need wider testing. Within mmtests, the NAS
> workloads for D-class on a 2-socket machine varying the number of parallel
> tasks/processes are used should be enough to determine if the patch is
> free from side-effects for one machine. It gets problematic for different
> machine sizes as the point where memory bandwidth is saturated varies.
> group_weight/4 might be fine on one machine as a cut-off and a problem
> on a larger machine with more cores -- I hit that particular problem
> when one 2 socket machine with 48 logical CPUs was fine but a different
> machine with 80 logical CPUs regressed.

Different machines have different memory bandwidth and different numa topology.
If it is too tough to figure out a proper value to make everyone happy, would you think
if we can provide a sysctl or bootargs for this so that users can adjust the cut-off based
on their own test and profiling?

> 
> I'm not saying the patch is wrong, just that patches in general for this
> area (everyone, not just you) need fairly broad testing.
> 

Thanks
Barry

