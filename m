Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19843024CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbhAYMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:15:29 -0500
Received: from foss.arm.com ([217.140.110.172]:46442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbhAYMLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:11:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89829139F;
        Mon, 25 Jan 2021 04:10:59 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 534B43F66E;
        Mon, 25 Jan 2021 04:10:58 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linuxarm\@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH] sched/fair: first try to fix the scheduling impact of NUMA diameter > 2
In-Reply-To: <13707f648ee547b6afe2285011c58b4f@hisilicon.com>
References: <20210115203632.34396-1-song.bao.hua@hisilicon.com> <CAKfTPtAbbMEGQjVbNw-Z3O-Bh9-JKaHy4J2snwp5RwxSNXqz-Q@mail.gmail.com> <3a718e03ebab4dafab9cca028fd94b20@hisilicon.com> <jhjk0s62m46.mognet@arm.com> <13707f648ee547b6afe2285011c58b4f@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 25 Jan 2021 12:10:53 +0000
Message-ID: <jhjwnw11ak2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21 03:13, Song Bao Hua (Barry Song) wrote:
> As long as NUMA diameter > 2, building sched_domain by sibling's child domain
> will definitely create a sched_domain with sched_group which will span
> out of the sched_domain
>                +------+         +------+        +-------+       +------+
>                | node |  12     |node  | 20     | node  |  12   |node  |
>                |  0   +---------+1     +--------+ 2     +-------+3     |
>                +------+         +------+        +-------+       +------+
>
> domain0        node0            node1            node2          node3
>
> domain1        node0+1          node0+1          node2+3        node2+3
>                                                  +
> domain2        node0+1+2                         |
>              group: node0+1                      |
>                group:node2+3 <-------------------+
>
> when node2 is added into the domain2 of node0, kernel is using the child
> domain of node2's domain2, which is domain1(node2+3). Node 3 is outside
> the span of node0+1+2.
>
> Will we move to use the *child* domain of the *child* domain of node2's
> domain2 to build the sched_group?
>
> I mean:
>                +------+         +------+        +-------+       +------+
>                | node |  12     |node  | 20     | node  |  12   |node  |
>                |  0   +---------+1     +--------+ 2     +-------+3     |
>                +------+         +------+        +-------+       +------+
>
> domain0        node0            node1          +- node2          node3
>                                                |
> domain1        node0+1          node0+1        | node2+3        node2+3
>                                                |
> domain2        node0+1+2                       |
>              group: node0+1                    |
>                group:node2 <-------------------+
>
> In this way, it seems we don't have to create a new group as we are just
> reusing the existing group?
>

One thing I've been musing over is pretty much this; that is to say we
would make all non-local NUMA sched_groups span a single node. This would
let us reuse an existing span+sched_group_capacity: the local group of that
node at its first NUMA topology level.

Essentially this means getting rid of the overlapping groups, and the
balance mask is handled the same way as for !NUMA, i.e. it's the local
group span. I've not gone far enough through the thought experiment to see
where does it miserably fall apart... It is at the very least violating the
expectation that a group span is a child domain's span - here it can be a
grand^x children domain's span.


If we take your topology, we currently have:

| tl\node | 0            | 1             | 2             | 3            |
|---------+--------------+---------------+---------------+--------------|
| NUMA0   | (0)->(1)     | (1)->(2)->(0) | (2)->(3)->(1) | (3)->(2)     |
| NUMA1   | (0-1)->(1-3) | (0-2)->(2-3)  | (1-3)->(0-1)  | (2-3)->(0-2) |
| NUMA2   | (0-2)->(1-3) | N/A           | N/A           | (1-3)->(0-2) |

With the current overlapping group scheme, we would need to make it look
like so:

| tl\node | 0             | 1             | 2             | 3             |
|---------+---------------+---------------+---------------+---------------|
| NUMA0   | (0)->(1)      | (1)->(2)->(0) | (2)->(3)->(1) | (3)->(2)      |
| NUMA1   | (0-1)->(1-2)* | (0-2)->(2-3)  | (1-3)->(0-1)  | (2-3)->(1-2)* |
| NUMA2   | (0-2)->(1-3)  | N/A           | N/A           | (1-3)->(0-2)  |

But as already discussed, that's tricky to make work. With the node-span
groups thing, we would turn this into:

| tl\node | 0          | 1             | 2             | 3          |
|---------+------------+---------------+---------------+------------|
| NUMA0   | (0)->(1)   | (1)->(2)->(0) | (2)->(3)->(1) | (3)->(2)   |
| NUMA1   | (0-1)->(2) | (0-2)->(3)    | (1-3)->(0)    | (2-3)->(1) |
| NUMA2   | (0-2)->(3) | N/A           | N/A           | (1-3)->(0) |

