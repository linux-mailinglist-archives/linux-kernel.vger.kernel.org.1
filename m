Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB37729512A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503232AbgJUQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:56:09 -0400
Received: from foss.arm.com ([217.140.110.172]:37780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395372AbgJUQ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:56:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 764FF31B;
        Wed, 21 Oct 2020 09:56:08 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24073F719;
        Wed, 21 Oct 2020 09:56:03 -0700 (PDT)
Subject: Re: [PATCH 2/4] iommu/mediatek: Add iotlb_sync_range() support
To:     Chao Hao <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Jun Wen <jun.wen@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mingyuan Ma <mingyuan.ma@mediatek.com>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
 <20201019113100.23661-3-chao.hao@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7fbe0305-91e4-949e-7d84-bf91e81d6b27@arm.com>
Date:   Wed, 21 Oct 2020 17:55:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019113100.23661-3-chao.hao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-19 12:30, Chao Hao wrote:
> MTK_IOMMU driver writes one page entry and does tlb flush at a time
> currently. More optimal would be to aggregate the writes and flush
> BUS buffer in the end.

That's exactly what iommu_iotlb_gather_add_page() is meant to achieve. 
Rather than jumping straight into hacking up a new API to go round the 
back of the existing API design, it would be far better to ask the 
question of why that's not behaving as expected.

> For 50MB buffer mapping, if mtk_iommu driver use iotlb_sync_range()
> instead of tlb_add_range() and tlb_flush_walk/leaf(), it can increase
> 50% performance or more(depending on size of every page size) in
> comparison to flushing after each page entry update. So we prefer to
> use iotlb_sync_range() to replace iotlb_sync(), tlb_add_range() and
> tlb_flush_walk/leaf() for MTK platforms.

In the case of mapping, it sounds like what you actually want to do is 
hook up .iotlb_sync_map and generally make IO_PGTABLE_QUIRK_TLBI_ON_MAP 
cleverer, because the current implementation is as dumb as it could 
possibly be. In fact if we simply passed an address range to 
.iotlb_sync_map, io-pgtable probably wouldn't need to be involved at all 
any more.

Robin.

> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 785b228d39a6..d3400c15ff7b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -224,6 +224,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   	}
>   }
>   
> +static void __mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size)
> +{
> +	mtk_iommu_tlb_flush_range_sync(iova, size, 0, NULL)
> +}
> +
>   static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>   					    unsigned long iova, size_t granule,
>   					    void *cookie)
> @@ -536,6 +541,7 @@ static const struct iommu_ops mtk_iommu_ops = {
>   	.map		= mtk_iommu_map,
>   	.unmap		= mtk_iommu_unmap,
>   	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
> +	.iotlb_sync_range = __mtk_iommu_tlb_flush_range_sync,
>   	.iotlb_sync	= mtk_iommu_iotlb_sync,
>   	.iova_to_phys	= mtk_iommu_iova_to_phys,
>   	.probe_device	= mtk_iommu_probe_device,
> 
