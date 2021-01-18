Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25D82FA94B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436818AbhARSwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:52:10 -0500
Received: from foss.arm.com ([217.140.110.172]:42142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404111AbhARSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:42:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5894131B;
        Mon, 18 Jan 2021 10:41:32 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77F8E3F719;
        Mon, 18 Jan 2021 10:41:29 -0800 (PST)
Subject: Re: [PATCH v4 4/7] iommu: Switch gather->end to the inclusive end
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com, Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
 <20210107122909.16317-5-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9e49206b-0762-9451-a5ab-9cd7ad5959e0@arm.com>
Date:   Mon, 18 Jan 2021 18:41:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210107122909.16317-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-07 12:29, Yong Wu wrote:
> Currently gather->end is "unsigned long" which may be overflow in
> arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
> Although it doesn't affect the size(end - start), it affects the checking
> "gather->end < end"
> 
> This patch changes this "end" to the real end address
> (end = start + size - 1). Correspondingly, update the length to
> "end - start + 1".
> 
> Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   drivers/iommu/mtk_iommu.c                   | 2 +-
>   drivers/iommu/tegra-gart.c                  | 2 +-
>   include/linux/iommu.h                       | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ca7415d785d..c70d6e79f534 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2280,7 +2280,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   
> -	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start,
> +	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start + 1,
>   			       gather->pgsize, true, smmu_domain);
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index f579fc21971e..66a00a2cb445 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -443,7 +443,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   				 struct iommu_iotlb_gather *gather)
>   {
>   	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> -	size_t length = gather->end - gather->start;
> +	size_t length = gather->end - gather->start + 1;
>   
>   	if (gather->start == ULONG_MAX)
>   		return;
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 05e8e19b8269..6f130e51f072 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -270,7 +270,7 @@ static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
>   static void gart_iommu_sync(struct iommu_domain *domain,
>   			    struct iommu_iotlb_gather *gather)
>   {
> -	size_t length = gather->end - gather->start;
> +	size_t length = gather->end - gather->start + 1;

TBH I don't think there's any need to bother doing precise calculations 
on effectively-uninitialised data (this driver doesn't even do 
address-based invalidation, let alone use the gather mechanism). In fact 
it might make sense to flip things around and define gart_iommu_sync_map 
in terms of gart_iommu_sync now just so there's one less unused argument 
to make up. However we can always do cleanup on top, and right now I'm 
more interested in getting these changes landed, so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	gart_iommu_sync_map(domain, gather->start, length);
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9ce0aa9e236b..ae8eddd4621b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -170,7 +170,7 @@ enum iommu_dev_features {
>    * struct iommu_iotlb_gather - Range information for a pending IOTLB flush
>    *
>    * @start: IOVA representing the start of the range to be flushed
> - * @end: IOVA representing the end of the range to be flushed (exclusive)
> + * @end: IOVA representing the end of the range to be flushed (inclusive)
>    * @pgsize: The interval at which to perform the flush
>    *
>    * This structure is intended to be updated by multiple calls to the
> @@ -539,7 +539,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   					       struct iommu_iotlb_gather *gather,
>   					       unsigned long iova, size_t size)
>   {
> -	unsigned long start = iova, end = start + size;
> +	unsigned long start = iova, end = start + size - 1;
>   
>   	/*
>   	 * If the new page is disjoint from the current range or is mapped at
> 
