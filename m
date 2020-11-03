Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA172A4D99
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKCR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:56:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3037 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbgKCR4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:56:47 -0500
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B50EB525C26A7AD26979;
        Tue,  3 Nov 2020 17:56:45 +0000 (GMT)
Received: from [10.47.5.37] (10.47.5.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 17:56:44 +0000
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot
 fills
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
Date:   Tue, 3 Nov 2020 17:56:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.5.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> To summarize, the issue is that as time goes by, the CPU rcache and depot
>> rcache continue to grow. As such, IOVA RB tree access time also continues
>> to grow.
> 

Hi Robin,

> I'm struggling to see how this is not simply indicative of a leak
> originating elsewhere. 

It sounds like one, but I don't think it is.

> For the number of magazines to continually grow,
> it means IOVAs *of a particular size* are being freed faster than they
> are being allocated, while the only place that ongoing allocations
> should be coming from is those same magazines!

But that is not the nature of how the IOVA caching works. The cache size 
is not defined by how DMA mappings we may have at a given moment in time 
or maximum which we did have at a point earlier. It just grows to a 
limit to where all CPU and global depot rcaches fill.

Here's an artificial example of how the rcache can grow, but I hope can 
help illustrate:
- consider a process which wants many DMA mapping active at a given 
point in time
- if we tie to cpu0, cpu0 rcache will grow to 128 * 2
- then tie to cpu1, cpu1 rcache will grow to 128 * 2, so total CPU 
rcache = 2 * 128 * 2. CPU rcache for cpu0 is not flushed - there is no 
maintenance for this.
- then tie to cpu2, cpu2 rcache will grow to 128 * 2, so total CPU 
rcache = 3 * 128 * 2
- then cpu3, cpu4, and so on.
- We can do this for all CPUs in the system, so total CPU rcache grows 
from zero -> #CPUs * 128 * 2. Yet no DMA mapping leaks.

Something similar can happen in normal use, where the scheduler 
relocates processes all over the CPUs in the system as time goes by, 
which causes the total rcache size to continue to grow. And in addition 
to this, the global depot continues to grow very slowly as well. But 
when it does fill (the global depot, that is), and we start to free 
magazines to make space – as is current policy - that's very slow and 
causes the performance drop.

> 
> Now indeed that could happen over the short term if IOVAs are allocated
> and freed again in giant batches larger than the total global cache
> capacity, but that would show a cyclic behaviour - when activity starts,
> everything is first allocated straight from the tree, then when it ends
> the caches would get overwhelmed by the large burst of freeing and start
> having to release things back to the tree, but eventually that would
> stop once everything *is* freed, then when activity begins again the
> next round of allocating would inherently clear out all the caches
> before going anywhere near the tree. 

But there is no clearing. A CPU will keep the IOVA cached indefinitely, 
even when there is no active DMA mapping present at all.

> To me the "steady decline"
> behaviour suggests that someone somewhere is making DMA unmap calls with
> a smaller size than they were mapped with (you tend to notice it quicker
> the other way round due to all the device errors and random memory
> corruption) - in many cases that would appear to work out fine from the
> driver's point of view, but would provoke exactly this behaviour in the
> IOVA allocator.
> 

Thanks,
John
