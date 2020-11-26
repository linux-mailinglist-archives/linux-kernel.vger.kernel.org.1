Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477B72C57F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbgKZPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:19:34 -0500
Received: from foss.arm.com ([217.140.110.172]:36320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389756AbgKZPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:19:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC2631B;
        Thu, 26 Nov 2020 07:19:32 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47AEB3F71F;
        Thu, 26 Nov 2020 07:19:30 -0800 (PST)
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
References: <20201120090628.6566-1-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cbc9763b-aa7e-aea9-2a21-315dfdd2c407@arm.com>
Date:   Thu, 26 Nov 2020 15:19:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201120090628.6566-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-20 09:06, Yong Wu wrote:
> Currently direct_mapping always use the smallest pgsize which is SZ_4K
> normally to mapping. This is unnecessary. we could gather the size, and
> call iommu_map then, iommu_map could decide how to map better with the
> just right pgsize.
> 
>  From the original comment, we should take care overlap, otherwise,
> iommu_map may return -EEXIST. In this overlap case, we should map the
> previous region before overlap firstly. then map the left part.
> 
> Each a iommu device will call this direct_mapping when its iommu
> initialize, This patch is effective to improve the boot/initialization
> time especially while it only needs level 1 mapping.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/iommu.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index df87c8e825f7..854a8fcb928d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -737,6 +737,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   	/* We need to consider overlapping regions for different devices */
>   	list_for_each_entry(entry, &mappings, list) {
>   		dma_addr_t start, end, addr;
> +		size_t unmapped_sz = 0;
>   
>   		if (domain->ops->apply_resv_region)
>   			domain->ops->apply_resv_region(dev, domain, entry);
> @@ -752,10 +753,25 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   			phys_addr_t phys_addr;
>   
>   			phys_addr = iommu_iova_to_phys(domain, addr);
> -			if (phys_addr)
> +			if (phys_addr == 0) {
> +				unmapped_sz += pg_size; /* Gather the size. */
>   				continue;
> +			}

I guess the reason we need to validate every page is because they may 
already have been legitimately mapped if someone else's reserved region 
overlaps - is it worth explicitly validating that, i.e. bail out if 
something's gone wrong enough that phys_addr != addr?

Other than the naming issue (I agree that map_size is a far, far better 
choice), I don't have any strong opinions about the rest of the 
implementation - I've written enough variations of this pattern to know 
that there's just no "nice" way to do it in C; all you can do is shuffle 
the clunkiness around :)

Robin.

>   
> -			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
> +			if (unmapped_sz) {
> +				/* Map the region before the overlap. */
> +				ret = iommu_map(domain, start, start,
> +						unmapped_sz, entry->prot);
> +				if (ret)
> +					goto out;
> +				start += unmapped_sz;
> +				unmapped_sz = 0;
> +			}
> +			start += pg_size;
> +		}
> +		if (unmapped_sz) {
> +			ret = iommu_map(domain, start, start, unmapped_sz,
> +					entry->prot);
>   			if (ret)
>   				goto out;
>   		}
> 
