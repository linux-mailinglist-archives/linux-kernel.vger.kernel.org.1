Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3DB1B5F67
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 17:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgDWPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 11:34:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34735 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729160AbgDWPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:34:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587656079; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=7n4azMkARD+NaN566ZcrsilozS2Vb4we+5eDk5Np3Ew=; b=BF1v6eWiPUW2FjXC8T4DJ5yyd9heNx98u7bD/WNmESEAzBr6X88u53P/QRaCzql/gO4BeMQM
 pDOlrY6Ns788i64rpxK1/8DKMSvRqO41R9w+llHU1/uLws57FNlxT5+FF8VeTlwp2zq43xsH
 2KqG8TBS76nYsZPuOleOqa4iJwc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea1b58e.7f5aaed24228-smtp-out-n05;
 Thu, 23 Apr 2020 15:34:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 711F6C43636; Thu, 23 Apr 2020 15:34:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D6DEC4478F;
        Thu, 23 Apr 2020 15:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D6DEC4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 23 Apr 2020 09:34:31 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] drm/msm/a6xx: use msm_gem for GMU memory objects
Message-ID: <20200423153431.GA15079@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200421234127.27965-1-jonathan@marek.ca>
 <20200421234127.27965-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421234127.27965-4-jonathan@marek.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:41:21PM -0400, Jonathan Marek wrote:
> This gives more fine-grained control over how memory is allocated over the
> DMA api. In particular, it allows using an address range or pinning to
> a fixed address.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 115 ++++++++++++++++++--------
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |   9 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c |   6 +-
>  3 files changed, 88 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index c4e71abbdd53..c9fd0470a321 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2,14 +2,16 @@
>  /* Copyright (c) 2017-2019 The Linux Foundation. All rights reserved. */
>  
>  #include <linux/clk.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/interconnect.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <soc/qcom/cmd-db.h>
> +#include <drm/drm_gem.h>
>  
>  #include "a6xx_gpu.h"
>  #include "a6xx_gmu.xml.h"
> +#include "msm_gem.h"
> +#include "msm_mmu.h"
>  
>  static void a6xx_gmu_fault(struct a6xx_gmu *gmu)
>  {
> @@ -620,7 +622,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
>  	gmu_write(gmu, REG_A6XX_GMU_CM3_BOOT_CONFIG, 0x02);
>  
>  	/* Write the iova of the HFI table */
> -	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_ADDR, gmu->hfi->iova);
> +	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_ADDR, gmu->hfi.iova);
>  	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_INFO, 1);
>  
>  	gmu_write(gmu, REG_A6XX_GMU_AHB_FENCE_RANGE_0,
> @@ -919,34 +921,77 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  	return 0;
>  }
>  
> -static void a6xx_gmu_memory_free(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo)
> +static void a6xx_gmu_memory_free(struct a6xx_gmu *gmu)
>  {
> -	if (IS_ERR_OR_NULL(bo))
> -		return;
> +	msm_gem_kernel_put(gmu->hfi.obj, gmu->aspace, false);
> +	msm_gem_kernel_put(gmu->debug.obj, gmu->aspace, false);
> +
> +	gmu->aspace->mmu->funcs->detach(gmu->aspace->mmu);
> +	msm_gem_address_space_put(gmu->aspace);
> +}
> +
> +static int a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo,
> +		size_t size, u64 iova)
> +{
> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +	struct drm_device *dev = a6xx_gpu->base.base.dev;
> +	uint32_t flags = MSM_BO_WC;
> +	u64 range_start, range_end;
> +	int ret;
> +
> +	size = PAGE_ALIGN(size);
> +	if (!iova) {
> +		/* no fixed address - use GMU's uncached range */
> +		range_start = 0x60000000;
> +		range_end = 0x80000000;
> +	} else {
> +		/* range for fixed address */
> +		range_start = iova;
> +		range_end = iova + size;
> +	}
> +
> +	bo->obj = msm_gem_new(dev, size, flags);
> +	if (IS_ERR(bo->obj))
> +		return PTR_ERR(bo->obj);
>  
> -	dma_free_wc(gmu->dev, bo->size, bo->virt, bo->iova);
> -	kfree(bo);
> +	ret = msm_gem_get_and_pin_iova_range(bo->obj, gmu->aspace, &bo->iova,
> +		range_start >> PAGE_SHIFT, range_end >> PAGE_SHIFT);
> +	if (ret) {
> +		drm_gem_object_put(bo->obj);
> +		return ret;
> +	}
> +
> +	bo->virt = msm_gem_get_vaddr(bo->obj);
> +	bo->size = size;
> +
> +	return 0;
>  }
>  
> -static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
> -		size_t size)
> +static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
>  {
> -	struct a6xx_gmu_bo *bo;
> +	struct iommu_domain *domain;
> +	int ret;
>  
> -	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
> -	if (!bo)
> -		return ERR_PTR(-ENOMEM);
> +	domain = iommu_domain_alloc(&platform_bus_type);
> +	if (!domain)
> +		return -ENODEV;
>  
> -	bo->size = PAGE_ALIGN(size);
> +	domain->geometry.aperture_start = 0x00000000;
> +	domain->geometry.aperture_end = 0x7fffffff;
>  
> -	bo->virt = dma_alloc_wc(gmu->dev, bo->size, &bo->iova, GFP_KERNEL);
> +	gmu->aspace = msm_gem_address_space_create(gmu->dev, domain, "gmu");
> +	if (IS_ERR(gmu->aspace)) {
> +		iommu_domain_free(domain);
> +		return PTR_ERR(gmu->aspace);
> +	}
>  
> -	if (!bo->virt) {
> -		kfree(bo);
> -		return ERR_PTR(-ENOMEM);
> +	ret = gmu->aspace->mmu->funcs->attach(gmu->aspace->mmu);
> +	if (ret) {
> +		msm_gem_address_space_put(gmu->aspace);
> +		return ret;
>  	}
>  
> -	return bo;
> +	return 0;
>  }
>  
>  /* Return the 'arc-level' for the given frequency */
> @@ -1204,7 +1249,7 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
>  	iounmap(gmu->mmio);
>  	gmu->mmio = NULL;
>  
> -	a6xx_gmu_memory_free(gmu, gmu->hfi);
> +	a6xx_gmu_memory_free(gmu);
>  
>  	free_irq(gmu->gmu_irq, gmu);
>  	free_irq(gmu->hfi_irq, gmu);
> @@ -1226,15 +1271,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
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
> @@ -1246,20 +1283,26 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	if (ret)
>  		goto err_put_device;
>  
> +	ret = a6xx_gmu_memory_probe(gmu);
> +	if (ret)
> +		goto err_put_device;
> +
>  	/* Allocate memory for for the HFI queues */
> -	gmu->hfi = a6xx_gmu_memory_alloc(gmu, SZ_16K);
> -	if (IS_ERR(gmu->hfi))
> +	ret = a6xx_gmu_memory_alloc(gmu, &gmu->hfi, SZ_16K, 0);
> +	if (ret)
>  		goto err_memory;
>  
>  	/* Allocate memory for the GMU debug region */
> -	gmu->debug = a6xx_gmu_memory_alloc(gmu, SZ_16K);
> -	if (IS_ERR(gmu->debug))
> +	ret = a6xx_gmu_memory_alloc(gmu, &gmu->debug, SZ_16K, 0);
> +	if (ret)
>  		goto err_memory;
>  
>  	/* Map the GMU registers */
>  	gmu->mmio = a6xx_gmu_get_mmio(pdev, "gmu");
> -	if (IS_ERR(gmu->mmio))
> +	if (IS_ERR(gmu->mmio)) {
> +		ret = PTR_ERR(gmu->mmio);
>  		goto err_memory;
> +	}
>  
>  	/* Get the HFI and GMU interrupts */
>  	gmu->hfi_irq = a6xx_gmu_get_irq(gmu, pdev, "hfi", a6xx_hfi_irq);
> @@ -1288,11 +1331,11 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	iounmap(gmu->mmio);
>  	free_irq(gmu->gmu_irq, gmu);
>  	free_irq(gmu->hfi_irq, gmu);
> -err_memory:
> -	a6xx_gmu_memory_free(gmu, gmu->hfi);
>  
>  	ret = -ENODEV;
>  
> +err_memory:
> +	a6xx_gmu_memory_free(gmu);
>  err_put_device:
>  	/* Drop reference taken in of_find_device_by_node */
>  	put_device(gmu->dev);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 4af65a36d5ca..cd66a5e1d7e9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -10,9 +10,10 @@
>  #include "a6xx_hfi.h"
>  
>  struct a6xx_gmu_bo {
> +	struct drm_gem_object *obj;
>  	void *virt;
>  	size_t size;
> -	dma_addr_t iova;
> +	u64 iova;
>  };
>  
>  /*
> @@ -43,6 +44,8 @@ struct a6xx_gmu_bo {
>  struct a6xx_gmu {
>  	struct device *dev;
>  
> +	struct msm_gem_address_space *aspace;
> +
>  	void * __iomem mmio;
>  
>  	int hfi_irq;
> @@ -52,8 +55,8 @@ struct a6xx_gmu {
>  
>  	int idle_level;
>  
> -	struct a6xx_gmu_bo *hfi;
> -	struct a6xx_gmu_bo *debug;
> +	struct a6xx_gmu_bo hfi;
> +	struct a6xx_gmu_bo debug;
>  
>  	int nr_clocks;
>  	struct clk_bulk_data *clocks;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index e450e0b97211..b90343d4caf0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -176,8 +176,8 @@ static int a6xx_hfi_send_gmu_init(struct a6xx_gmu *gmu, int boot_state)
>  {
>  	struct a6xx_hfi_msg_gmu_init_cmd msg = { 0 };
>  
> -	msg.dbg_buffer_addr = (u32) gmu->debug->iova;
> -	msg.dbg_buffer_size = (u32) gmu->debug->size;
> +	msg.dbg_buffer_addr = (u32) gmu->debug.iova;
> +	msg.dbg_buffer_size = (u32) gmu->debug.size;
>  	msg.boot_state = boot_state;
>  
>  	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_INIT, &msg, sizeof(msg),
> @@ -385,7 +385,7 @@ static void a6xx_hfi_queue_init(struct a6xx_hfi_queue *queue,
>  
>  void a6xx_hfi_init(struct a6xx_gmu *gmu)
>  {
> -	struct a6xx_gmu_bo *hfi = gmu->hfi;
> +	struct a6xx_gmu_bo *hfi = &gmu->hfi;
>  	struct a6xx_hfi_queue_table_header *table = hfi->virt;
>  	struct a6xx_hfi_queue_header *headers = hfi->virt + sizeof(*table);
>  	u64 offset;
> -- 
> 2.26.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
