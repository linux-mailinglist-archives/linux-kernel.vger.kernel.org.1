Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE172C4560
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgKYQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:37:54 -0500
Received: from foss.arm.com ([217.140.110.172]:58420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgKYQhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:37:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 514B331B;
        Wed, 25 Nov 2020 08:37:53 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFA53F7BB;
        Wed, 25 Nov 2020 08:37:50 -0800 (PST)
Subject: Re: [PATCH v2 1/6] iommu: Move iotlb_sync_map out from __iommu_map
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, jun.wen@mediatek.com
References: <20201119061836.15238-1-yong.wu@mediatek.com>
 <20201119061836.15238-2-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cf0f81dd-e240-965b-5c75-914d3d48eb27@arm.com>
Date:   Wed, 25 Nov 2020 16:37:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 06:18, Yong Wu wrote:
> In the end of __iommu_map, It alway call iotlb_sync_map.
> This patch moves iotlb_sync_map out from __iommu_map since it is
> unnecessary to call this for each sg segment especially iotlb_sync_map
> is flush tlb all currently.

I don't see a way to avoid the boilerplate that wouldn't end up making 
things even more ugly and complicated, so:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/iommu.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8c470f451a32..decef851fa3a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2407,9 +2407,6 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		size -= pgsize;
>   	}
>   
> -	if (ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> -
>   	/* unroll mapping in case something went wrong */
>   	if (ret)
>   		iommu_unmap(domain, orig_iova, orig_size - size);
> @@ -2422,15 +2419,29 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
> +	const struct iommu_ops *ops = domain->ops;
> +	int ret;
> +
>   	might_sleep();
> -	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	if (ret == 0 && ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_map);
>   
>   int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
> -	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +	const struct iommu_ops *ops = domain->ops;
> +	int ret;
> +
> +	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +	if (ret == 0 && ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_map_atomic);
>   
> @@ -2514,6 +2525,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			     struct scatterlist *sg, unsigned int nents, int prot,
>   			     gfp_t gfp)
>   {
> +	const struct iommu_ops *ops = domain->ops;
>   	size_t len = 0, mapped = 0;
>   	phys_addr_t start;
>   	unsigned int i = 0;
> @@ -2544,6 +2556,8 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			sg = sg_next(sg);
>   	}
>   
> +	if (ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
>   	return mapped;
>   
>   out_err:
> 
