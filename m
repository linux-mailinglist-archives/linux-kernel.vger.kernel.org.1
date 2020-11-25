Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA12C4567
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgKYQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:38:26 -0500
Received: from foss.arm.com ([217.140.110.172]:58478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731365AbgKYQi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:38:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A0631B;
        Wed, 25 Nov 2020 08:38:25 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBEA3F7BB;
        Wed, 25 Nov 2020 08:38:22 -0800 (PST)
Subject: Re: [PATCH v2 3/6] iommu/mediatek: Add iotlb_sync_map to sync whole
 the iova range
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
 <20201119061836.15238-4-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <751e08a1-d3c3-29f9-5c62-560370ac0703@arm.com>
Date:   Wed, 25 Nov 2020 16:38:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 06:18, Yong Wu wrote:
> Remove IO_PGTABLE_QUIRK_TLBI_ON_MAP to avoid tlb sync for each a small
> chunk memory, Use the new iotlb_sync_map to tlb_sync once for whole the
> iova range of iommu_map.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> After reading msm_iommu.c, It looks IO_PGTABLE_QUIRK_TLBI_ON_MAP can be
> removed.
> ---
>   drivers/iommu/mtk_iommu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c072cee532c2..8c2d4a225666 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -323,7 +323,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>   	dom->cfg = (struct io_pgtable_cfg) {
>   		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
>   			IO_PGTABLE_QUIRK_NO_PERMS |
> -			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
>   			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
>   		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
>   		.ias = 32,
> @@ -454,6 +453,14 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   				       data);
>   }
>   
> +static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size)
> +{
> +	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +
> +	mtk_iommu_tlb_flush_range_sync(iova, size, size, dom->data);

So we have a conflict/dependency against the MT8192 series here - I 
guess we need to make a decision up-front about which series should go 
first. Other than that, though:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +}
> +
>   static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>   					  dma_addr_t iova)
>   {
> @@ -540,6 +547,7 @@ static const struct iommu_ops mtk_iommu_ops = {
>   	.unmap		= mtk_iommu_unmap,
>   	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
>   	.iotlb_sync	= mtk_iommu_iotlb_sync,
> +	.iotlb_sync_map	= mtk_iommu_sync_map,
>   	.iova_to_phys	= mtk_iommu_iova_to_phys,
>   	.probe_device	= mtk_iommu_probe_device,
>   	.release_device	= mtk_iommu_release_device,
> 
