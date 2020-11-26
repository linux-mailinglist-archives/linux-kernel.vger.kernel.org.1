Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9D2C5A47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404391AbgKZRMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:12:07 -0500
Received: from foss.arm.com ([217.140.110.172]:40684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404379AbgKZRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:12:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E7DB31B;
        Thu, 26 Nov 2020 09:12:06 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472113F23F;
        Thu, 26 Nov 2020 09:12:02 -0800 (PST)
Subject: Re: [PATCH v4 17/24] iommu/mediatek: Add single domain
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-18-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <22e49f08-6d23-86cf-bb9c-79d54ce55beb@arm.com>
Date:   Thu, 26 Nov 2020 17:11:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111123838.15682-18-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-11 12:38, Yong Wu wrote:
> Defaultly the iova range is 0-4G. here we add a single-domain(0-4G)
> for the previous SoC. this also is a preparing patch for supporting
> multi-domains.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bf3f4e0f4748..a7727a3899d1 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -161,6 +161,10 @@ struct mtk_iommu_iova_region {
>   	unsigned long long	size;
>   };
>   
> +static const struct mtk_iommu_iova_region single_domain[] = {
> +	{.iova_base = 0,		.size = SZ_4G},
> +};

Hang on, given how the previous patch works, surely this means you're 
now going to *reserve* the entire address space? That doesn't seem 
right... :/

Robin.

> +
>   /*
>    * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
>    * for the performance.
> @@ -922,6 +926,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   	.m4u_plat     = M4U_MT2712,
>   	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
>   };
>   
> @@ -929,6 +935,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>   	.m4u_plat      = M4U_MT6779,
>   	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
> +	.iova_region   = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>   };
>   
> @@ -944,6 +952,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
>   	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
>   			HAS_LEGACY_IVRP_PADDR,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
>   };
>   
> @@ -951,6 +961,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   	.m4u_plat     = M4U_MT8183,
>   	.flags        = RESET_AXI,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
>   };
>   
> 
