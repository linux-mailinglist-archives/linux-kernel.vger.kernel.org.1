Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4992FA946
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407816AbhARSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:50:36 -0500
Received: from foss.arm.com ([217.140.110.172]:42250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407723AbhARSpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:45:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4908BD6E;
        Mon, 18 Jan 2021 10:44:59 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F54D3F719;
        Mon, 18 Jan 2021 10:44:55 -0800 (PST)
Subject: Re: [PATCH v4 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
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
 <20210107122909.16317-7-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <57eb2ea5-f44c-9828-cbd4-9cb2af877ad8@arm.com>
Date:   Mon, 18 Jan 2021 18:44:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210107122909.16317-7-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-07 12:29, Yong Wu wrote:
> In current iommu_unmap, this code is:
> 
> 	iommu_iotlb_gather_init(&iotlb_gather);
> 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> 	iommu_iotlb_sync(domain, &iotlb_gather);
> 
> We could gather the whole iova range in __iommu_unmap, and then do tlb
> synchronization in the iommu_iotlb_sync.
> 
> This patch implement this, Gather the range in mtk_iommu_unmap.
> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> could be regardless of granule size.
> 
> In this way, gather->start is impossible ULONG_MAX, remove the checking.
> 
> This patch aims to do tlb synchronization *once* in the iommu_unmap.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 66a00a2cb445..d3b8a1649093 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -430,7 +430,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>   			      struct iommu_iotlb_gather *gather)
>   {
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	unsigned long end = iova + size - 1;
>   
> +	if (gather->start > iova)
> +		gather->start = iova;
> +	if (gather->end < end)
> +		gather->end = end;
>   	return dom->iop->unmap(dom->iop, iova, size, gather);
>   }
>   
> @@ -445,9 +450,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>   	size_t length = gather->end - gather->start + 1;
>   
> -	if (gather->start == ULONG_MAX)
> -		return;
> -
>   	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
>   				       data);
>   }
> 
