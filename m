Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44826F8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIRIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:55:05 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:55:04 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 496CB396; Fri, 18 Sep 2020 10:55:03 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:55:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Handle init_iova_flush_queue failure in dma-iommu path
Message-ID: <20200918085501.GJ31590@8bytes.org>
References: <20200910122539.3662-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910122539.3662-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:25:38PM +0100, Tom Murphy wrote:
> init_iova_flush_queue can fail if we run out of memory. Fall back to noflush
>  queue if it fails.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>  drivers/iommu/dma-iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4959f5df21bd..5f69126f3e91 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -343,8 +343,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  
>  	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
>  			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
> -		cookie->fq_domain = domain;
> -		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
> +		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> +					NULL))
> +			pr_warn("iova flush queue initialization failed\n");
> +		else
> +			cookie->fq_domain = domain;
>  	}
>  
>  	if (!dev)

Looks good to me, but Robin should also have a look.
