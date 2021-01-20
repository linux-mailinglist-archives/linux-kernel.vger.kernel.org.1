Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E02FD1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbhATNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:12:13 -0500
Received: from foss.arm.com ([217.140.110.172]:59796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbhATMad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:30:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9747D6E;
        Wed, 20 Jan 2021 04:29:47 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3030F3F66E;
        Wed, 20 Jan 2021 04:29:46 -0800 (PST)
Subject: Re: [RFC PATCH V2 2/2] iommu: add Unisoc iommu basic driver
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Kevin Tang <kevin.tang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
References: <20210108113851.354947-1-zhang.lyra@gmail.com>
 <20210108113851.354947-3-zhang.lyra@gmail.com>
 <47f73502-15fe-5d65-6fc9-22eb078d7797@arm.com>
 <CAAfSe-vd5eRopOBZMuTi8vq1FqY1qAVSdMHscVuA+uHtL2H=gw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a2561fc-65a6-4c68-fdb7-a5b670706f43@arm.com>
Date:   Wed, 20 Jan 2021 12:29:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAAfSe-vd5eRopOBZMuTi8vq1FqY1qAVSdMHscVuA+uHtL2H=gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 11:40, Chunyan Zhang wrote:
[...]
>>> +     pgt_base_iova = dom->pgt_va +
>>> +             ((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
>>> +
>>> +     spin_lock_irqsave(&dom->pgtlock, flags);
>>> +     for (i = 0; i < page_num; i++) {
>>> +             pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
>>
>> Out of curiosity, is the pagetable walker cache-coherent, or is this
>> currently managing to work by pure chance and natural cache churn?
> 
> ->iotlb_sync_map() was implemented in this driver, I guess that has
> done what you say here?

No, sync_map only ensures that the previous (invalid) PTE isn't held in 
the IOMMU's TLB. If pgt_va is a regular page allocation then you're 
writing the new PTE to normal kernel memory, with nothing to guarantee 
that write goes any further than the CPU's L1 cache. Thus either the 
IOMMU has capable of snooping the CPU caches in order to see the updated 
PTE value (rather than refetching the stale value from DRAM), or you're 
just incredibly lucky that by the time the IOMMU *does* go to fetch the 
PTE for that address, that updated cache line has already been evicted 
out to DRAM naturally.

This is not an issue if you use the proper DMA allocator, since that 
will ensure you get a non-cacheable buffer if you need one.

Robin.
