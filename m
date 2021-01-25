Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036CF302E90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbhAYWAt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 17:00:49 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4149 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732651AbhAYV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:56:37 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DPkDD5PmYzY27d;
        Tue, 26 Jan 2021 05:54:36 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 26 Jan 2021 05:55:41 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 26 Jan 2021 05:55:40 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 26 Jan 2021 05:55:40 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH] sched/fair: first try to fix the scheduling impact of
 NUMA diameter > 2
Thread-Topic: [RFC PATCH] sched/fair: first try to fix the scheduling impact
 of NUMA diameter > 2
Thread-Index: AQHW637fjqpbim3xqkeVVnSjjCpCl6osuNCAgACFa/CABKc0gIABDrlQgAS9Q8CAABe8gIABJa7w
Date:   Mon, 25 Jan 2021 21:55:40 +0000
Message-ID: <803c439c1d1f435bb22a6ef6c0c2d99e@hisilicon.com>
References: <20210115203632.34396-1-song.bao.hua@hisilicon.com>
 <CAKfTPtAbbMEGQjVbNw-Z3O-Bh9-JKaHy4J2snwp5RwxSNXqz-Q@mail.gmail.com>
 <3a718e03ebab4dafab9cca028fd94b20@hisilicon.com> <jhjk0s62m46.mognet@arm.com>
 <13707f648ee547b6afe2285011c58b4f@hisilicon.com> <jhjwnw11ak2.mognet@arm.com>
In-Reply-To: <jhjwnw11ak2.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Tuesday, January 26, 2021 1:11 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Vincent Guittot
> <vincent.guittot@linaro.org>; Mel Gorman <mgorman@suse.de>
> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> Dietmar Eggemann <dietmar.eggemann@arm.com>; Morten Rasmussen
> <morten.rasmussen@arm.com>; linux-kernel <linux-kernel@vger.kernel.org>;
> linuxarm@openeuler.org
> Subject: RE: [RFC PATCH] sched/fair: first try to fix the scheduling impact
> of NUMA diameter > 2
> 
> On 25/01/21 03:13, Song Bao Hua (Barry Song) wrote:
> > As long as NUMA diameter > 2, building sched_domain by sibling's child domain
> > will definitely create a sched_domain with sched_group which will span
> > out of the sched_domain
> >                +------+         +------+        +-------+       +------+
> >                | node |  12     |node  | 20     | node  |  12   |node  |
> >                |  0   +---------+1     +--------+ 2     +-------+3     |
> >                +------+         +------+        +-------+       +------+
> >
> > domain0        node0            node1            node2          node3
> >
> > domain1        node0+1          node0+1          node2+3        node2+3
> >                                                  +
> > domain2        node0+1+2                         |
> >              group: node0+1                      |
> >                group:node2+3 <-------------------+
> >
> > when node2 is added into the domain2 of node0, kernel is using the child
> > domain of node2's domain2, which is domain1(node2+3). Node 3 is outside
> > the span of node0+1+2.
> >
> > Will we move to use the *child* domain of the *child* domain of node2's
> > domain2 to build the sched_group?
> >
> > I mean:
> >                +------+         +------+        +-------+       +------+
> >                | node |  12     |node  | 20     | node  |  12   |node  |
> >                |  0   +---------+1     +--------+ 2     +-------+3     |
> >                +------+         +------+        +-------+       +------+
> >
> > domain0        node0            node1          +- node2          node3
> >                                                |
> > domain1        node0+1          node0+1        | node2+3        node2+3
> >                                                |
> > domain2        node0+1+2                       |
> >              group: node0+1                    |
> >                group:node2 <-------------------+
> >
> > In this way, it seems we don't have to create a new group as we are just
> > reusing the existing group?
> >
> 
> One thing I've been musing over is pretty much this; that is to say we
> would make all non-local NUMA sched_groups span a single node. This would
> let us reuse an existing span+sched_group_capacity: the local group of that
> node at its first NUMA topology level.
> 
> Essentially this means getting rid of the overlapping groups, and the
> balance mask is handled the same way as for !NUMA, i.e. it's the local
> group span. I've not gone far enough through the thought experiment to see
> where does it miserably fall apart... It is at the very least violating the
> expectation that a group span is a child domain's span - here it can be a
> grand^x children domain's span.
> 
> 
> If we take your topology, we currently have:
> 
> | tl\node | 0            | 1             | 2             | 3            |
> |---------+--------------+---------------+---------------+--------------|
> | NUMA0   | (0)->(1)     | (1)->(2)->(0) | (2)->(3)->(1) | (3)->(2)     |
> | NUMA1   | (0-1)->(1-3) | (0-2)->(2-3)  | (1-3)->(0-1)  | (2-3)->(0-2) |
> | NUMA2   | (0-2)->(1-3) | N/A           | N/A           | (1-3)->(0-2) |
> 
> With the current overlapping group scheme, we would need to make it look
> like so:
> 
> | tl\node | 0             | 1             | 2             | 3             |
> |---------+---------------+---------------+---------------+---------------
> |
> | NUMA0   | (0)->(1)      | (1)->(2)->(0) | (2)->(3)->(1) | (3)->(2)      |
> | NUMA1   | (0-1)->(1-2)* | (0-2)->(2-3)  | (1-3)->(0-1)  | (2-3)->(1-2)* |
> | NUMA2   | (0-2)->(1-3)  | N/A           | N/A           | (1-3)->(0-2)  |
> 
> But as already discussed, that's tricky to make work. With the node-span
> groups thing, we would turn this into:
> 
> | tl\node | 0          | 1             | 2             | 3          |
> |---------+------------+---------------+---------------+------------|
> | NUMA0   | (0)->(1)   | (1)->(2)->(0) | (2)->(3)->(1) | (3)->(2)   |
> | NUMA1   | (0-1)->(2) | (0-2)->(3)    | (1-3)->(0)    | (2-3)->(1) |
> | NUMA2   | (0-2)->(3) | N/A           | N/A           | (1-3)->(0) |

Actually I didn't mean going that far. What I was thinking is that
we only fix the sched_domain while sched_group isn't a subset of
sched_domain. For those sched_domains which haven't the group span
issue, we just don't touch it. For NUMA1, we change like your diagram,
but NUMA2 won't be changed. The concept is like:

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1040,6 +1040,19 @@ build_overlap_sched_groups(struct sched_domain
*sd, int cpu)
                }

                sg_span = sched_group_span(sg);
+#if 1
+               if (sibling->child && !cpumask_subset(sg_span, span)) {
+                       sg = build_group_from_child_sched_domain(sibling->child, cpu);
+                       ...
+                       sg_span = sched_group_span(sg);
+               }
+#endif
                cpumask_or(covered, covered, sg_span);

Thanks
Barry
