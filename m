Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3673D2FFFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbhAVKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:12:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbhAVKG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:06:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46FE111D4;
        Fri, 22 Jan 2021 02:05:30 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A2B3F719;
        Fri, 22 Jan 2021 02:05:28 -0800 (PST)
Subject: Re: 5.11-rc4+git: Shortest NUMA path spans too many nodes
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
References: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee>
 <jhjmtx22uv7.mognet@arm.com> <8797fd78-4367-bc5c-3a35-43c544c745e4@linux.ee>
 <jhjh7na2lsj.mognet@arm.com> <f0818204-66d1-bf01-062e-0aeec9ce806d@arm.com>
 <353d255769b6463c862993e2329a9a8d@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <99ecee86-8d96-c1e2-5b38-8f3dfcc38bd1@arm.com>
Date:   Fri, 22 Jan 2021 11:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <353d255769b6463c862993e2329a9a8d@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 22:17, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>> Sent: Friday, January 22, 2021 7:54 AM
>> To: Valentin Schneider <valentin.schneider@arm.com>; Meelis Roos
>> <mroos@linux.ee>; LKML <linux-kernel@vger.kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>; Vincent Guittot
>> <vincent.guittot@linaro.org>; Song Bao Hua (Barry Song)
>> <song.bao.hua@hisilicon.com>; Mel Gorman <mgorman@suse.de>
>> Subject: Re: 5.11-rc4+git: Shortest NUMA path spans too many nodes
>>
>> On 21/01/2021 19:21, Valentin Schneider wrote:
>>> On 21/01/21 19:39, Meelis Roos wrote:

[...]

>> # cat /sys/devices/system/node/node*/distance
>> 10 12 12 14 14 14 14 16
>> 12 10 14 12 14 14 12 14
>> 12 14 10 14 12 12 14 14
>> 14 12 14 10 12 12 14 14
>> 14 14 12 12 10 14 12 14
>> 14 14 12 12 14 10 14 12
>> 14 12 14 14 12 14 10 12
>> 16 14 14 14 14 12 12 10
>>
>> The '16' seems to be the culprit. How does such a topo look like?

Maybe like this:

      _________
      |       |
    .-6   0   4-.
    |  \ / \ /  |
    |   1   2   |
    |   \    \  |
    --7  3----5 |
      |  |____|_|
      |_______|

> 
> Once we get a topology like this:
> 
> 
>          +------+         +------+        +-------+       +------+
>          | node |         |node  |        | node  |       |node  |
>          |      +---------+      +--------+       +-------+      |
>          +------+         +------+        +-------+       +------+
> 
> We can reproduce this issue. 
> For example, every cpu with the below numa_distance can have 
> "groups don't span domain->span":
> node   0   1   2   3
>   0:  10  12  20  22
>   1:  12  10  22  24
>   2:  20  22  10  12
>   3:  22  24  12  10
                             2     20     2
So this should look like: 1 --- 0 ---- 2 --- 3
