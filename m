Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CDB1B1637
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgDTTvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:51:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864BC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:51:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so4331190plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cXndO/9atMRBj3ki1OBgBAxeMbivxmBoqy5um/+TbH8=;
        b=aKHshmB81P4jVzDuwe3k2sHJgUvtTm1Mcpd9HHn/+ZTXeDzs7LPgFHPinxZV33OTkh
         pLup8x0WaJi7Rrvq6bARbjU8MnPvOUz5zJ3g9oxEkLBsKDGJqaVZWwXxnYq1LL6H1qil
         tr81s68QkcTewzitq+PCd8ExjXkLEROJBeVCzKrIcaoq2OdEGEhcFOUG7KR85Pc97QDH
         84FqeclwwQj8vxNGHVZBKGCtRCMAcAaDadYuUhNJrNdDxQ1EZqIJU2RtbsCz9PD6tmd1
         qJWWGZ7TrLLUAGVfObzkBCWMqvO4NuJBKPEQiRHjO0zwiEkLg5DxUBkdmMsLmlKs479o
         C9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXndO/9atMRBj3ki1OBgBAxeMbivxmBoqy5um/+TbH8=;
        b=Pg3K7Kar6mM+0RXvFkZEGNQeCp+dFR98tNWN+ZXxsucAY4L6WsTjDPDdqQrpS0H7Gi
         xkqm/JRJOepfC3MoS1zV4qt5v7F03vTmklPcikOIeUad099g254P2h1XvnKlPC00+cqT
         +23k/FQEWcu8tkmXsOZN2h9EKAuZ3GSJ6AXeIK1/tZkcd/tGxC4XVKktwG8b1gpLAMGZ
         m8okWhy9hf2gBWL0/BXpIHfuPkZ6kMGjHVw0/sqdO2fjki5fZ2hgr04pMvopHXjTkDCG
         aMhRCyzvkDCiHb7qaG3Iq/hI3NZ8LrAITNcLWTyE8AYeLUTViOB6e9K/wxjksjnt3qgp
         qkAQ==
X-Gm-Message-State: AGi0PuY7lT/Cz/U+3aCkqBSdihFO00DoYPk9Pmlebk7eZhTA4CLB6zkK
        gNOS56tWWEIa0EG2WC+1EluxrA==
X-Google-Smtp-Source: APiQypKiYnTS3YZu4PQkYRxyoy2DcBPSp/lxOL17ZNtEaP8IVuejdUpKA+GupS/4BaQVy3zMZNf0Xg==
X-Received: by 2002:a17:902:7618:: with SMTP id k24mr8746327pll.71.1587412267357;
        Mon, 20 Apr 2020 12:51:07 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d8sm289923pfd.159.2020.04.20.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:51:06 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:51:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] Revert "drm/msm/a6xx: Use the DMA API for GMU memory
 objects"
Message-ID: <20200420195130.GQ576963@builder.lan>
References: <20200420140313.7263-1-jonathan@marek.ca>
 <20200420140313.7263-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420140313.7263-3-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Apr 07:03 PDT 2020, Jonathan Marek wrote:

> This reverts commit a5fb8b918920c6f7706a8b5b8ea535a7f077a7f6.

Why?

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 115 +++++++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |   6 +-
>  2 files changed, 107 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index c4e71abbdd53..748cd379065f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2,7 +2,6 @@
>  /* Copyright (c) 2017-2019 The Linux Foundation. All rights reserved. */
>  
>  #include <linux/clk.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/interconnect.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> @@ -921,10 +920,21 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  
>  static void a6xx_gmu_memory_free(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo)
>  {
> +	int count, i;
> +	u64 iova;
> +
>  	if (IS_ERR_OR_NULL(bo))
>  		return;
>  
> -	dma_free_wc(gmu->dev, bo->size, bo->virt, bo->iova);
> +	count = bo->size >> PAGE_SHIFT;
> +	iova = bo->iova;
> +
> +	for (i = 0; i < count; i++, iova += PAGE_SIZE) {
> +		iommu_unmap(gmu->domain, iova, PAGE_SIZE);
> +		__free_pages(bo->pages[i], 0);
> +	}
> +
> +	kfree(bo->pages);
>  	kfree(bo);
>  }
>  
> @@ -932,6 +942,7 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
>  		size_t size)
>  {
>  	struct a6xx_gmu_bo *bo;
> +	int ret, count, i;
>  
>  	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
>  	if (!bo)
> @@ -939,14 +950,86 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
>  
>  	bo->size = PAGE_ALIGN(size);
>  
> -	bo->virt = dma_alloc_wc(gmu->dev, bo->size, &bo->iova, GFP_KERNEL);
> +	count = bo->size >> PAGE_SHIFT;
>  
> -	if (!bo->virt) {
> +	bo->pages = kcalloc(count, sizeof(struct page *), GFP_KERNEL);
> +	if (!bo->pages) {
>  		kfree(bo);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	for (i = 0; i < count; i++) {
> +		bo->pages[i] = alloc_page(GFP_KERNEL);
> +		if (!bo->pages[i])
> +			goto err;
> +	}
> +
> +	bo->iova = gmu->uncached_iova_base;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = iommu_map(gmu->domain,
> +			bo->iova + (PAGE_SIZE * i),
> +			page_to_phys(bo->pages[i]), PAGE_SIZE,
> +			IOMMU_READ | IOMMU_WRITE);
> +
> +		if (ret) {
> +			DRM_DEV_ERROR(gmu->dev, "Unable to map GMU buffer object\n");
> +
> +			for (i = i - 1 ; i >= 0; i--)
> +				iommu_unmap(gmu->domain,
> +					bo->iova + (PAGE_SIZE * i),
> +					PAGE_SIZE);
> +
> +			goto err;
> +		}
> +	}
> +
> +	bo->virt = vmap(bo->pages, count, VM_IOREMAP,
> +		pgprot_writecombine(PAGE_KERNEL));
> +	if (!bo->virt)
> +		goto err;
> +
> +	/* Align future IOVA addresses on 1MB boundaries */
> +	gmu->uncached_iova_base += ALIGN(size, SZ_1M);
> +
>  	return bo;
> +
> +err:
> +	for (i = 0; i < count; i++) {
> +		if (bo->pages[i])
> +			__free_pages(bo->pages[i], 0);
> +	}
> +
> +	kfree(bo->pages);
> +	kfree(bo);
> +
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
> +{
> +	int ret;
> +
> +	/*
> +	 * The GMU address space is hardcoded to treat the range
> +	 * 0x60000000 - 0x80000000 as un-cached memory. All buffers shared
> +	 * between the GMU and the CPU will live in this space
> +	 */
> +	gmu->uncached_iova_base = 0x60000000;
> +
> +
> +	gmu->domain = iommu_domain_alloc(&platform_bus_type);
> +	if (!gmu->domain)
> +		return -ENODEV;
> +
> +	ret = iommu_attach_device(gmu->domain, gmu->dev);
> +
> +	if (ret) {
> +		iommu_domain_free(gmu->domain);
> +		gmu->domain = NULL;
> +	}
> +
> +	return ret;
>  }
>  
>  /* Return the 'arc-level' for the given frequency */
> @@ -1206,6 +1289,10 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
>  
>  	a6xx_gmu_memory_free(gmu, gmu->hfi);
>  
> +	iommu_detach_device(gmu->domain, gmu->dev);
> +
> +	iommu_domain_free(gmu->domain);
> +
>  	free_irq(gmu->gmu_irq, gmu);
>  	free_irq(gmu->hfi_irq, gmu);
>  
> @@ -1226,15 +1313,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  
>  	gmu->dev = &pdev->dev;
>  
> -	/* Pass force_dma false to require the DT to set the dma region */
> -	ret = of_dma_configure(gmu->dev, node, false);
> -	if (ret)
> -		return ret;
> -
> -	/* Set the mask after the of_dma_configure() */
> -	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(31));
> -	if (ret)
> -		return ret;
> +	of_dma_configure(gmu->dev, node, true);
>  
>  	/* Fow now, don't do anything fancy until we get our feet under us */
>  	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
> @@ -1246,6 +1325,11 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	if (ret)
>  		goto err_put_device;
>  
> +	/* Set up the IOMMU context bank */
> +	ret = a6xx_gmu_memory_probe(gmu);
> +	if (ret)
> +		goto err_put_device;
> +
>  	/* Allocate memory for for the HFI queues */
>  	gmu->hfi = a6xx_gmu_memory_alloc(gmu, SZ_16K);
>  	if (IS_ERR(gmu->hfi))
> @@ -1291,6 +1375,11 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  err_memory:
>  	a6xx_gmu_memory_free(gmu, gmu->hfi);
>  
> +	if (gmu->domain) {
> +		iommu_detach_device(gmu->domain, gmu->dev);
> +
> +		iommu_domain_free(gmu->domain);
> +	}
>  	ret = -ENODEV;
>  
>  err_put_device:
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 4af65a36d5ca..2af91ed7ed0c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -12,7 +12,8 @@
>  struct a6xx_gmu_bo {
>  	void *virt;
>  	size_t size;
> -	dma_addr_t iova;
> +	u64 iova;
> +	struct page **pages;
>  };
>  
>  /*
> @@ -48,6 +49,9 @@ struct a6xx_gmu {
>  	int hfi_irq;
>  	int gmu_irq;
>  
> +	struct iommu_domain *domain;
> +	u64 uncached_iova_base;
> +
>  	struct device *gxpd;
>  
>  	int idle_level;
> -- 
> 2.26.1
> 
