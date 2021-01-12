Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053552F34F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405490AbhALQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:01:49 -0500
Received: from foss.arm.com ([217.140.110.172]:48940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404233AbhALQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:01:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734941FB;
        Tue, 12 Jan 2021 08:01:02 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 239213F719;
        Tue, 12 Jan 2021 08:01:01 -0800 (PST)
Subject: Re: [PATCH v2 0/5] Optimize iommu_map_sg() performance
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
        joro@8bytes.org
Cc:     pdaly@codeaurora.org, pratikp@codeaurora.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
Date:   Tue, 12 Jan 2021 16:00:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 14:54, Isaac J. Manjarres wrote:
> The iommu_map_sg() code currently iterates through the given
> scatter-gather list, and in the worst case, invokes iommu_map()
> for each element in the scatter-gather list, which calls into
> the IOMMU driver through an indirect call. For an IOMMU driver
> that uses a format supported by the io-pgtable code, the IOMMU
> driver will then call into the io-pgtable code to map the chunk.
> 
> Jumping between the IOMMU core code, the IOMMU driver, and the
> io-pgtable code and back for each element in a scatter-gather list
> is not efficient.
> 
> Instead, add a map_sg() hook in both the IOMMU driver ops and the
> io-pgtable ops. iommu_map_sg() can then call into the IOMMU driver's
> map_sg() hook with the entire scatter-gather list, which can call
> into the io-pgtable map_sg() hook, which can process the entire
> scatter-gather list, signficantly reducing the number of indirect
> calls, and jumps between these layers, boosting performance.

Out of curiosity, how much of the difference is attributable to actual 
indirect call overhead vs. the additional massive reduction in visits to 
arm_smmu_rpm_{get,put} that you fail to mention? There are ways to 
optimise indirect calling that would benefit *all* cases, rather than 
just one operation for one particular driver.

> On a system that uses the ARM SMMU driver, and the ARM LPAE format,
> the current implementation of iommu_map_sg() yields the following
> latencies for mapping scatter-gather lists of various sizes. These
> latencies are calculated by repeating the mapping operation 10 times:
> 
>      size        iommu_map_sg latency
>        4K            0.624 us
>       64K            9.468 us
>        1M          122.557 us
>        2M          239.807 us
>       12M         1435.979 us
>       24M         2884.968 us
>       32M         3832.979 us
> 
> On the same system, the proposed modifications yield the following
> results:
> 
>      size        iommu_map_sg latency
>        4K            3.645 us
>       64K            4.198 us
>        1M           11.010 us
>        2M           17.125 us
>       12M           82.416 us
>       24M          158.677 us
>       32M          210.468 us
> 
> The procedure for collecting the iommu_map_sg latencies is
> the same in both experiments. Clearly, reducing the jumps
> between the different layers in the IOMMU code offers a
> signficant performance boost in iommu_map_sg() latency.

Presumably those are deliberately worst-case numbers? After all, a 32MB 
scatterlist *could* incur less overhead than a 64KB one if things line 
up just right (still 16 ->map calls, but each with one fewer level of 
pagetable to traverse). TBH I find the significant regression of the 4KB 
case the most interesting - what's going on there?

My main reservation here is that we get an explosion of duplicate copies 
of almost the same code, and it's code that's just non-trivial enough to 
start being bug-prone. And it's all still only for one specific 
operation - your argument about calling through multiple layers for each 
element applies just as much to iommu_map() itself, so why aren't we 
trying to make more fundamental improvements with wider benefits? Indeed 
I can't imagine the existing iommu_map_sg() loop really adds significant 
overhead compared to a single iommu_map() call that results in the 
equivalent set of ->map calls to the driver.

At a glance, I reckon that simply extending the internal ->map and 
->unmap interfaces to encode a number of consecutive identical pages 
would already get us a large chunk of the way there; then we'd be in a 
better place to consider options for the io-pgtable interface.

Robin.

> Changes since v1:
> 
> -Fixed an off by one error in arm_[lpae/v7s]_map_by_pgsize
> when checking if the IOVA and physical address ranges being
> mapped are within the appropriate limits.
> -Added Sai Prakash Ranjan's "Tested-by" tag.
> 
> Thanks,
> Isaac
> 
> Isaac J. Manjarres (5):
>    iommu/io-pgtable: Introduce map_sg() as a page table op
>    iommu/io-pgtable-arm: Hook up map_sg()
>    iommu/io-pgtable-arm-v7s: Hook up map_sg()
>    iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>    iommu/arm-smmu: Hook up map_sg()
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 19 ++++++++
>   drivers/iommu/io-pgtable-arm-v7s.c    | 90 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/io-pgtable-arm.c        | 86 +++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c                 | 25 ++++++++--
>   include/linux/io-pgtable.h            |  6 +++
>   include/linux/iommu.h                 | 13 +++++
>   6 files changed, 234 insertions(+), 5 deletions(-)
> 
