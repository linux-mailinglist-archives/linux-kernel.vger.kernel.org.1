Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62880302F13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbhAYWbJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 17:31:09 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2966 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbhAYVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:36:50 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DPjnL08cFz5KCg;
        Tue, 26 Jan 2021 05:34:46 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 26 Jan 2021 05:35:57 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 26 Jan 2021 05:35:57 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 26 Jan 2021 05:35:57 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
Thread-Topic: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
Thread-Index: AQHW8LvLAz5G3mjdME+poUenwzVodao3mZgg///3IYCAAHq7gIAA0qKA
Date:   Mon, 25 Jan 2021 21:35:56 +0000
Message-ID: <ff1e47829eac4278a3489c46c39873c8@hisilicon.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com>
 <20210122123943.1217-2-valentin.schneider@arm.com>
 <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com> <jhj1re92wqm.mognet@arm.com>
 <jhjtur50xu2.mognet@arm.com>
In-Reply-To: <jhjtur50xu2.mognet@arm.com>
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
> Sent: Tuesday, January 26, 2021 5:46 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> linux-kernel@vger.kernel.org
> Cc: mingo@kernel.org; peterz@infradead.org; vincent.guittot@linaro.org;
> dietmar.eggemann@arm.com; morten.rasmussen@arm.com; mgorman@suse.de
> Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
> the deduplicating sort
> 
> On 25/01/21 09:26, Valentin Schneider wrote:
> > On 25/01/21 02:23, Song Bao Hua (Barry Song) wrote:
> >
> >> with the below topology:
> >> qemu-system-aarch64 -M virt -nographic \
> >>  -smp cpus=8 \
> >>  -numa node,cpus=0-1,nodeid=0 \
> >>  -numa node,cpus=2-3,nodeid=1 \
> >>  -numa node,cpus=4-5,nodeid=2 \
> >>  -numa node,cpus=6-7,nodeid=3 \
> >>  -numa dist,src=0,dst=1,val=12 \
> >>  -numa dist,src=0,dst=2,val=20 \
> >>  -numa dist,src=0,dst=3,val=22 \
> >>  -numa dist,src=1,dst=2,val=22 \
> >>  -numa dist,src=2,dst=3,val=12 \
> >>  -numa dist,src=1,dst=3,val=24 \
> >>
> >>
> >> The panic address is *1294:
> >>
> >>                         if (sdd->sd) {
> >>     1280:       f9400e61        ldr     x1, [x19, #24]
> >>     1284:       b4000201        cbz     x1, 12c4 <build_sched_domains+0x414>
> >>                                 sd = *per_cpu_ptr(sdd->sd, j);
> >>     1288:       93407eb7        sxtw    x23, w21
> >>     128c:       aa0103e0        mov     x0, x1
> >>     1290:       f8777ac2        ldr     x2, [x22, x23, lsl #3]
> >>     *1294:       f8626800        ldr     x0, [x0, x2]
> >>                                 if (sd && (sd->flags & SD_OVERLAP))
> >>     1298:       b4000120        cbz     x0, 12bc <build_sched_domains+0x40c>
> >>     129c:       b9403803        ldr     w3, [x0, #56]
> >>     12a0:       365800e3        tbz     w3, #11, 12bc
> >> <build_sched_domains+0x40c>
> >>                                         free_sched_groups(sd->groups, 0);
> >>     12a4:       f9400800        ldr     x0, [x0, #16]
> >>         if (!sg)
> >>
> >
> > Thanks for giving it a shot, let me run that with your topology and see
> > where I end up.
> >
> 
> I can't seem to reproduce this - your topology is actually among the ones
> I tested this against.
> 
> Applying this patch obviously doesn't get rid of the group span issue, but
> it does remove this warning:
> 
> [    0.354806] ERROR: Node-0 not representative
> [    0.354806]
> [    0.355223]   10 12 20 22
> [    0.355475]   12 10 22 24
> [    0.355648]   20 22 10 12
> [    0.355814]   22 24 12 10
> 
> I'm running this based on tip/sched/core:
> 
>   65bcf072e20e ("sched: Use task_current() instead of 'rq->curr == p'")
I was using 5.11-rc1. One thing I'd like to mention is that:

For the below topology:
+-------+          +-----+
| node1 |  20      |node2|
|       +----------+     |
+---+---+          +-----+
    |                  |12
12  |                  |
+---+---+          +---+-+
|       |          |node3|
| node0 |          |     |
+-------+          +-----+

with node0-node2 as 22, node0-node3 as 24, node1-node3 as 22.

I will get the below sched_domains_numa_distance[]:
10, 12, 22, 24
As you can see there is *no* 20. So the node1 and node2 will
only get two-level numa sched_domain:


But for the below topology:
+-------+          +-----+
| node0 |  20      |node2|
|       +----------+     |
+---+---+          +-----+
    |                  |12
12  |                  |
+---+---+          +---+-+
|       |          |node3|
| node1 |          |     |
+-------+          +-----+

with node1-node2 as 22, node1-node3 as 24,node0-node3 as 22.

I will get the below sched_domains_numa_distance[]:
10, 12, 20, 22, 24

What I have seen is the performance will be better if we
drop the 20 as we will get a sched_domain hierarchy with less
levels, and two intermediate nodes won't have the group span
issue.

Thanks
Barry

