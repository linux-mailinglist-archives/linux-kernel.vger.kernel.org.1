Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05192D987D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407918AbgLNNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:02:17 -0500
Received: from foss.arm.com ([217.140.110.172]:47166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407907AbgLNNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:02:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092FF1FB;
        Mon, 14 Dec 2020 05:01:28 -0800 (PST)
Received: from [10.57.33.60] (unknown [10.57.33.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7313F66B;
        Mon, 14 Dec 2020 05:01:26 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ba14be47-6c77-94d6-9904-b4679e62091b@arm.com>
Date:   Mon, 14 Dec 2020 13:01:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-13 16:32, Heiner Kallweit wrote:
> Zillions of drivers use the unlikely() hint when checking the result of
> dma_mapping_error(). This is an inline function anyway, so we can move
> the hint into this function and remove it from drivers.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

FWIW I consider this case similar to the same hint in WARN_ON() and 
friends - it's a pretty severe condition that should never be expected 
to be hit in normal operation, so it's entirely logical for it to be 
implicitly unlikely. I struggle to imagine any case that would 
specifically *not* want that (or worse, want to hint it as likely). Some 
DMA API backends may spend considerable time trying as hard as possible 
to make a mapping work before eventually admitting defeat, so the idea 
of ever trying to optimise at the driver level for failure in hot paths 
just makes no sense.

Thanks,
Robin.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> Split the big patch into the change for dma-mapping.h and follow-up
> patches per subsystem that will go through the trees of the respective
> maintainers.
> ---
>   include/linux/dma-mapping.h | 2 +-
>   kernel/dma/map_benchmark.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2e49996a8..6177e20b5 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   {
>   	debug_dma_mapping_error(dev, dma_addr);
>   
> -	if (dma_addr == DMA_MAPPING_ERROR)
> +	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>   		return -ENOMEM;
>   	return 0;
>   }
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index b1496e744..901420a5d 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
>   
>   		map_stime = ktime_get();
>   		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
> -		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> +		if (dma_mapping_error(map->dev, dma_addr)) {
>   			pr_err("dma_map_single failed on %s\n",
>   				dev_name(map->dev));
>   			ret = -ENOMEM;
> 
