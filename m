Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1130F2C4568
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgKYQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:38:39 -0500
Received: from foss.arm.com ([217.140.110.172]:58526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbgKYQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:38:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF38131B;
        Wed, 25 Nov 2020 08:38:38 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE6E3F7BB;
        Wed, 25 Nov 2020 08:38:36 -0800 (PST)
Subject: Re: [PATCH v2 4/6] iommu: Add granule_ignore when tlb gather
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
 <20201119061836.15238-5-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <49bae447-d662-e6cf-7500-ab78e3b75dc4@arm.com>
Date:   Wed, 25 Nov 2020 16:38:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 06:18, Yong Wu wrote:
> Add a granule_ignore option when tlb gather for some HW which don't care
> about granule when it flush tlb.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   include/linux/iommu.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 794d4085edd3..1aad32238510 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -171,6 +171,7 @@ enum iommu_dev_features {
>    * @start: IOVA representing the start of the range to be flushed
>    * @end: IOVA representing the end of the range to be flushed (exclusive)
>    * @pgsize: The interval at which to perform the flush
> + * @granule_ignore: For tlb flushing that could be regardless of granule.
>    *
>    * This structure is intended to be updated by multiple calls to the
>    * ->unmap() function in struct iommu_ops before eventually being passed
> @@ -180,6 +181,7 @@ struct iommu_iotlb_gather {
>   	unsigned long		start;
>   	unsigned long		end;
>   	size_t			pgsize;
> +	bool			granule_ignore;

I can't see that this would ever need to vary on a per-unmap-operation 
basis, so this doesn't seem like the right level of abstraction. AFAICS 
it should simply be hard-coded in the driver logic.

>   };
>   
>   /**
> @@ -544,7 +546,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   	 * a different granularity, then sync the TLB so that the gather
>   	 * structure can be rewritten.
>   	 */
> -	if (gather->pgsize != size ||
> +	if ((!gather->granule_ignore && gather->pgsize != size) ||

I also think this is a slippery slope in the wrong direction anyway - 
there is likely to be a fair bit of hardware-dependent variation around 
how low-level TLB maintenance works (also consider drivers that may want 
to convert a sufficiently large range to an "invalidate all" operation), 
so if a generic helper function doesn't do the right thing for a given 
driver, that driver should simply not use the helper, and directly 
implement the logic it does need.

Robin.

>   	    end < gather->start || start > gather->end) {
>   		if (gather->pgsize)
>   			iommu_iotlb_sync(domain, gather);
> 
