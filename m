Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36DE3001D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbhAVLoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:44:08 -0500
Received: from foss.arm.com ([217.140.110.172]:42094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbhAVLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:17:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC74611D4;
        Fri, 22 Jan 2021 03:17:06 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958533F719;
        Fri, 22 Jan 2021 03:17:05 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
Subject: RE: 5.11-rc4+git: Shortest NUMA path spans too many nodes
In-Reply-To: <9d6c6d3ba6ac4272bf844034da4653fe@hisilicon.com>
References: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee> <jhjmtx22uv7.mognet@arm.com> <8797fd78-4367-bc5c-3a35-43c544c745e4@linux.ee> <jhjh7na2lsj.mognet@arm.com> <f0818204-66d1-bf01-062e-0aeec9ce806d@arm.com> <353d255769b6463c862993e2329a9a8d@hisilicon.com> <99ecee86-8d96-c1e2-5b38-8f3dfcc38bd1@arm.com> <9d6c6d3ba6ac4272bf844034da4653fe@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 22 Jan 2021 11:16:28 +0000
Message-ID: <jhjeeid2pdf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/21 11:09, Song Bao Hua (Barry Song) wrote:
>> -----Original Message-----
>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>> > For example, every cpu with the below numa_distance can have
>> > "groups don't span domain->span":
>> > node   0   1   2   3
>> >   0:  10  12  20  22
>> >   1:  12  10  22  24
>> >   2:  20  22  10  12
>> >   3:  22  24  12  10
>>                              2     20     2
>> So this should look like: 1 --- 0 ---- 2 --- 3
>
> Yes. So here we are facing another problem:
> kernel/sched/topology.c has an assumption that:
> node_distance(0,j) includes all distances in
> node_distance(i,j).
>
> void sched_init_numa(void)
> {
>       ...
>        *
>        * Assumes node_distance(0,j) includes all distances in
>        * node_distance(i,j) in order to avoid cubic time.
>        */
>       next_distance = curr_distance;
>       for (i = 0; i < nr_node_ids; i++) {
>               for (j = 0; j < nr_node_ids; j++) {
>                       for (k = 0; k < nr_node_ids; k++)
> }
>
> but obviously we are not this case. Right now, we are getting
> some performance decrease due to this, probably I'll start another
> thread for it.
>

It's not too difficult to solve that one; I must still have a patch laying
somewhere using a bitmap - this relies on the ACPI spec stating distance
values are 8bit, which gives us a reasonable bound for the bitmap size.

Let me fish this out.

> Thanks
> Barry
