Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA52E19E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgLWIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgLWIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:21:46 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22592C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:21:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so10156344pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCs+PY9Jy4cJoFYJpIvFxqIHuHMCQdFNyYUz6uJ1sAQ=;
        b=d/9+nZaV1qO/0LfciBy5aYtvWgjbBI/NXmbljXsW42Yuo0HoyAAN+f7JEXSaxp/DYD
         JgGpEkBJYVZVLRYpbowwg3x0k9d+eowvXvHIkRU7X6kNcKJF1t2aoaPAlvcKEDoG1nYw
         RNgJnKSuqF8euK21HV5k+yUKAeNycY7f61my8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yCs+PY9Jy4cJoFYJpIvFxqIHuHMCQdFNyYUz6uJ1sAQ=;
        b=eMYFfhf3P/MtMgpc71oVekGJN1DT1cF9ArIVmGWPtf4TWYqQ05nlPYOdT+lFvXhPCg
         zIux1BJt8j3h272a+/iHk41fsVkMw/VYMXJfXBZeeIUnOa67KpcqcTQEOZDX5giejNZ1
         VPzdhTLpBkZZu4kIKSgqrDhdTAg4u3cC3qsa2Ipq7hX4cutXdlm6hfM6Areyi6KWfM7s
         Pdq9/Az/Tt1LtH9yBSdPp1kS65+AYSrRaoRYkUOmiDr4MqGI4d5h/GVTbkvUfl+JPJ1K
         zLLJNRrMAZwXdqrL34Hiri7DT2XIbqPK80kkoh84edXljVzXu0Nh92I5JFvTZNxLGD2Q
         Yq0A==
X-Gm-Message-State: AOAM533eCPwTUW+/X+X2HyMbstyiWwaOIdEn/s4eDKy3tuRh8B4syBlm
        hW7U91NUOn9i+jYr4n/FlkVObQ==
X-Google-Smtp-Source: ABdhPJxiFDxtXVQfHOA/peW0Rqkubb2VRH7OvGhUiOyyazKhYhYGQY/mwvl4Aox+RLd0Y+RD2ZEmHA==
X-Received: by 2002:a62:fc4f:0:b029:19d:d060:27ca with SMTP id e76-20020a62fc4f0000b029019dd06027camr22818371pfh.66.1608711665713;
        Wed, 23 Dec 2020 00:21:05 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
        by smtp.gmail.com with ESMTPSA id gb9sm7480288pjb.40.2020.12.23.00.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 00:21:05 -0800 (PST)
Date:   Wed, 23 Dec 2020 17:20:58 +0900
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
Subject: Re: [PATCH v5 09/27] iommu/io-pgtable-arm-v7s: Extend PA34 for
 MediaTek
Message-ID: <X+L96uZU2aZWfjSP@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-10-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-10-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:44PM +0800, Yong Wu wrote:
> MediaTek extend the bit5 in lvl1 and lvl2 descriptor as PA34.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 9 +++++++--
>  drivers/iommu/mtk_iommu.c          | 2 +-
>  include/linux/io-pgtable.h         | 4 ++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index e880745ab1e8..4d0aa079470f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -112,9 +112,10 @@
>  #define ARM_V7S_TEX_MASK		0x7
>  #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>  
> -/* MediaTek extend the two bits for PA 32bit/33bit */
> +/* MediaTek extend the bits below for PA 32bit/33bit/34bit */
>  #define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
>  #define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
> +#define ARM_V7S_ATTR_MTK_PA_BIT34	BIT(5)
>  
>  /* *well, except for TEX on level 2 large pages, of course :( */
>  #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> @@ -194,6 +195,8 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>  		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
>  	if (paddr & BIT_ULL(33))
>  		pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> +	if (paddr & BIT_ULL(34))
> +		pte |= ARM_V7S_ATTR_MTK_PA_BIT34;
>  	return pte;
>  }
>  
> @@ -218,6 +221,8 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>  		paddr |= BIT_ULL(32);
>  	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
>  		paddr |= BIT_ULL(33);
> +	if (pte & ARM_V7S_ATTR_MTK_PA_BIT34)
> +		paddr |= BIT_ULL(34);
>  	return paddr;
>  }
>  
> @@ -754,7 +759,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  	if (cfg->ias > ARM_V7S_ADDR_BITS)
>  		return NULL;
>  
> -	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
> +	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
>  		return NULL;
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6451d83753e1..ec3c87d4b172 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -320,7 +320,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>  			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
>  		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
>  		.ias = 32,
> -		.oas = 34,
> +		.oas = 35,

Shouldn't this be set according to the real hardware capabilities,
instead of always setting it to 35?

Best regards,
Tomasz

>  		.tlb = &mtk_iommu_flush_ops,
>  		.iommu_dev = data->dev,
>  	};
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 4cde111e425b..1ae0757f4f94 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -77,8 +77,8 @@ struct io_pgtable_cfg {
>  	 *	TLB maintenance when mapping as well as when unmapping.
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_MTK_EXT: (ARM v7s format) MediaTek IOMMUs extend
> -	 *	to support up to 34 bits PA where the bit32 and bit33 are
> -	 *	encoded in the bit9 and bit4 of the PTE respectively.
> +	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
> +	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
>  	 *
>  	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>  	 *	on unmap, for DMA domains using the flush queue mechanism for
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
