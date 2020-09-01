Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8C259F12
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgIATRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 15:17:24 -0400
Received: from foss.arm.com ([217.140.110.172]:48720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIATRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:17:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A3B1FB;
        Tue,  1 Sep 2020 12:17:21 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC9D3F71F;
        Tue,  1 Sep 2020 12:17:20 -0700 (PDT)
Subject: Re: [PATCH v9 13/32] drm: omapdrm: use common helper for extracting
 pages array
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f@eucas1p1.samsung.com>
 <20200826063316.23486-14-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f1474b67-eca5-d115-82a6-e7e74cccaf9f@arm.com>
Date:   Tue, 1 Sep 2020 20:17:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-14-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:32, Marek Szyprowski wrote:
> Use common helper for converting a sg_table object into struct
> page pointer array.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
> index d0d12d5dd76c..ff0c4b0c3fd0 100644
> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
> @@ -1297,10 +1297,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
>   		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
>   	} else {
>   		/* Create pages list from sgt */
> -		struct sg_page_iter iter;
>   		struct page **pages;
>   		unsigned int npages;
> -		unsigned int i = 0;
> +		unsigned int ret;
>   
>   		npages = DIV_ROUND_UP(size, PAGE_SIZE);
>   		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
> @@ -1311,14 +1310,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
>   		}
>   
>   		omap_obj->pages = pages;
> -
> -		for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
> -			pages[i++] = sg_page_iter_page(&iter);
> -			if (i > npages)
> -				break;
> -		}
> -
> -		if (WARN_ON(i != npages)) {
> +		ret = drm_prime_sg_to_page_addr_arrays(sgt, pages, NULL,
> +						       npages);
> +		if (WARN_ON(ret)) {

Again, I'm inclined to think the WARN_ON should remain in 
drm_prime_sg_to_page_addr_arrays() itself such that it could be removed 
here, but either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   			omap_gem_free_object(obj);
>   			obj = ERR_PTR(-ENOMEM);
>   			goto done;
> 
