Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB53031F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 03:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbhAYQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:48:18 -0500
Received: from foss.arm.com ([217.140.110.172]:51440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbhAYQqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:46:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CFCD1042;
        Mon, 25 Jan 2021 08:45:48 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49B83F68F;
        Mon, 25 Jan 2021 08:45:46 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "mgorman\@suse.de" <mgorman@suse.de>
Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for the deduplicating sort
In-Reply-To: <jhj1re92wqm.mognet@arm.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com> <20210122123943.1217-2-valentin.schneider@arm.com> <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com> <jhj1re92wqm.mognet@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 25 Jan 2021 16:45:41 +0000
Message-ID: <jhjtur50xu2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21 09:26, Valentin Schneider wrote:
> On 25/01/21 02:23, Song Bao Hua (Barry Song) wrote:
>
>> with the below topology:
>> qemu-system-aarch64 -M virt -nographic \
>>  -smp cpus=8 \
>>  -numa node,cpus=0-1,nodeid=0 \
>>  -numa node,cpus=2-3,nodeid=1 \
>>  -numa node,cpus=4-5,nodeid=2 \
>>  -numa node,cpus=6-7,nodeid=3 \
>>  -numa dist,src=0,dst=1,val=12 \
>>  -numa dist,src=0,dst=2,val=20 \
>>  -numa dist,src=0,dst=3,val=22 \
>>  -numa dist,src=1,dst=2,val=22 \
>>  -numa dist,src=2,dst=3,val=12 \
>>  -numa dist,src=1,dst=3,val=24 \
>>
>>
>> The panic address is *1294:
>>
>>                         if (sdd->sd) {
>>     1280:       f9400e61        ldr     x1, [x19, #24]
>>     1284:       b4000201        cbz     x1, 12c4 <build_sched_domains+0x414>
>>                                 sd = *per_cpu_ptr(sdd->sd, j);
>>     1288:       93407eb7        sxtw    x23, w21
>>     128c:       aa0103e0        mov     x0, x1
>>     1290:       f8777ac2        ldr     x2, [x22, x23, lsl #3]
>>     *1294:       f8626800        ldr     x0, [x0, x2]
>>                                 if (sd && (sd->flags & SD_OVERLAP))
>>     1298:       b4000120        cbz     x0, 12bc <build_sched_domains+0x40c>
>>     129c:       b9403803        ldr     w3, [x0, #56]
>>     12a0:       365800e3        tbz     w3, #11, 12bc
>> <build_sched_domains+0x40c>
>>                                         free_sched_groups(sd->groups, 0);
>>     12a4:       f9400800        ldr     x0, [x0, #16]
>>         if (!sg)
>>
>
> Thanks for giving it a shot, let me run that with your topology and see
> where I end up.
>

I can't seem to reproduce this - your topology is actually among the ones
I tested this against.

Applying this patch obviously doesn't get rid of the group span issue, but
it does remove this warning:

[    0.354806] ERROR: Node-0 not representative
[    0.354806]
[    0.355223]   10 12 20 22
[    0.355475]   12 10 22 24
[    0.355648]   20 22 10 12
[    0.355814]   22 24 12 10

I'm running this based on tip/sched/core:

  65bcf072e20e ("sched: Use task_current() instead of 'rq->curr == p'")
