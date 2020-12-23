Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5682E1A13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgLWIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgLWIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:36:49 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48680C061793
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:36:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i5so2108579pgo.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OfrCLZAsvCa9E+UEDy5cUIBPR5zJvNqTrXdr4SCdt8c=;
        b=UMtBz2ORbpVVyCNyCiHvLukqnZRr+r1kBszkzGgaFwSRTKhnXtkTKFOQ3j4EW8oH6w
         GFbFzzbhOy/70vwgvVKxApt7Q2zMX4OxTTGx9xgMIoDQkcRAdA14b3rhrMW+6EhQoTOJ
         TqJ6Iy2alC5vUZDfgy4IAEav+SfuPKmg9Nkxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OfrCLZAsvCa9E+UEDy5cUIBPR5zJvNqTrXdr4SCdt8c=;
        b=PnE0Ndc0qXVkM2VotJVwJRFYaFCQ9p14KklLGSX7ZVbzr62Z1Xg9HL8yLNq8q9RYrZ
         P0lXddwZ8ezjLVsrKvS5Dn7SAtJ0/WBxyuL3c8GaituqYSI9vR5MIDK5xhsLsjVCy9I3
         Wupoj8DEZbHYrziOugSGUG2VIMOpmkdXUFVXcVAO7IgUHNMjS43WU+MHTkwNsZ+cTziZ
         ddHej9WVceoFGoHIg7TLZ7YnNWEIyBuNhBLGqLONarIXsh5j5Mv1B/b7SbQ8jb/UqKtq
         2qi9zmgHk0iJTsN3rmTdLEMqO+sJpoyLYmpy3R+J5LUda5W5DThfrfgMsHMQ9gElXv2P
         WpgQ==
X-Gm-Message-State: AOAM530slNLZlPvXOIZS2GO40mCNEn5CWRfPifKm4jpMbzXWPHDrtUqa
        Z8M283lnlF+F4nh7AkhAx1fkTQ==
X-Google-Smtp-Source: ABdhPJy/ufv05/kcnbxdEivoZ5wcPsxjZGhiKhgHTe44wYRRjbq3ykCToz7VfuynLjBYvDDkre6gdA==
X-Received: by 2002:a63:504e:: with SMTP id q14mr5162728pgl.21.1608712568834;
        Wed, 23 Dec 2020 00:36:08 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
        by smtp.gmail.com with ESMTPSA id l197sm23336277pfd.97.2020.12.23.00.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 00:36:08 -0800 (PST)
Date:   Wed, 23 Dec 2020 17:36:02 +0900
From:   Tomasz Figa <tfiga@chromium.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 18/27] iommu/mediatek: Add power-domain operation
Message-ID: <X+MBcmzQn9iQWlVZ@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-19-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-19-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:53PM +0800, Yong Wu wrote:
> In the previous SoC, the M4U HW is in the EMI power domain which is
> always on. the latest M4U is in the display power domain which may be
> turned on/off, thus we have to add pm_runtime interface for it.
> 
> When the engine work, the engine always enable the power and clocks for
> smi-larb/smi-common, then the M4U's power will always be powered on
> automatically via the device link with smi-common.
> 
> Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> If its power already is on, of course it is ok. if the power is off,
> the main tlb will be reset while M4U power on, thus the tlb flush while
> m4u power off is unnecessary, just skip it.
> 
> There will be one case that pm runctime status is not expected when tlb
> flush. After boot, the display may call dma_alloc_attrs before it call
> pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
> the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
> at that time, I also think this is ok.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 41 +++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fe3ee2b2bf5..0e9c03cbab32 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -184,6 +184,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>  	struct mtk_iommu_data *data = cookie;
>  
>  	for_each_m4u(data) {
> +		if (!pm_runtime_active(data->dev))
> +			continue;

Is it guaranteed that the status is active in the check above, but then
the process is preempted and it goes down here?

Shouldn't we do something like below?

        ret = pm_runtime_get_if_active();
        if (!ret)
                continue;
        if (ret < 0)
                // handle error
        
        // Flush
        
        pm_runtime_put();

Similar comment to the other places being changed by this patch.

>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>  			       data->base + data->plat_data->inv_sel_reg);
>  		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> @@ -200,6 +202,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  	u32 tmp;
>  
>  	for_each_m4u(data) {
> +		/* skip tlb flush when pm is not active. */
> +		if (!pm_runtime_active(data->dev))
> +			continue;
> +
>  		spin_lock_irqsave(&data->tlb_lock, flags);
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>  			       data->base + data->plat_data->inv_sel_reg);
> @@ -384,6 +390,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  {
>  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	struct device *m4udev = data->dev;
> +	bool pm_enabled = pm_runtime_enabled(m4udev);
>  	int ret;
>  
>  	if (!data)
> @@ -391,12 +399,25 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  
>  	/* Update the pgtable base address register of the M4U HW */
>  	if (!data->m4u_dom) {
> +		if (pm_enabled) {
> +			ret = pm_runtime_get_sync(m4udev);
> +			if (ret < 0) {
> +				pm_runtime_put_noidle(m4udev);
> +				return ret;
> +			}
> +		}
>  		ret = mtk_iommu_hw_init(data);
> -		if (ret)
> +		if (ret) {
> +			if (pm_enabled)
> +				pm_runtime_put(m4udev);
>  			return ret;
> +		}
>  		data->m4u_dom = dom;
>  		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
>  		       data->base + REG_MMU_PT_BASE_ADDR);
> +
> +		if (pm_enabled)
> +			pm_runtime_put(m4udev);
>  	}
>  
>  	mtk_iommu_config(data, dev, true);
> @@ -747,10 +768,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	if (dev->pm_domain) {
>  		struct device_link *link;
>  
> +		pm_runtime_enable(dev);
> +
>  		link = device_link_add(data->smicomm_dev, dev,
>  				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>  		if (!link) {
>  			dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> +			pm_runtime_disable(dev);
>  			return -EINVAL;
>  		}
>  	}
> @@ -785,8 +809,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  out_sysfs_remove:
>  	iommu_device_sysfs_remove(&data->iommu);
>  out_link_remove:
> -	if (dev->pm_domain)
> +	if (dev->pm_domain) {
>  		device_link_remove(data->smicomm_dev, dev);
> +		pm_runtime_disable(dev);
> +	}
>  	return ret;
>  }
>  
> @@ -801,8 +827,10 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>  		bus_set_iommu(&platform_bus_type, NULL);
>  
>  	clk_disable_unprepare(data->bclk);
> -	if (pdev->dev.pm_domain)
> +	if (pdev->dev.pm_domain) {
>  		device_link_remove(data->smicomm_dev, &pdev->dev);
> +		pm_runtime_disable(&pdev->dev);
> +	}
>  	devm_free_irq(&pdev->dev, data->irq, data);
>  	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
>  	return 0;
> @@ -834,6 +862,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>  	void __iomem *base = data->base;
>  	int ret;
>  
> +	/* Avoid first resume to affect the default value of registers below. */
> +	if (!m4u_dom)
> +		return 0;
>  	ret = clk_prepare_enable(data->bclk);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
> @@ -847,9 +878,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>  	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
>  	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
> -	if (m4u_dom)
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
>  	return 0;
>  }
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
