Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2626882B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgINJTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgINJTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:19:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E206BC06174A;
        Mon, 14 Sep 2020 02:19:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so17888006wrr.4;
        Mon, 14 Sep 2020 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wcF550GwyqliSCSyHw0Z/IDzm3K/ogaNto0zdoWfp60=;
        b=tiMPrN36G6dUn/kEUQVays/uU94aZcWuAZpt/Nvk7qqLpik+PvXRFUsv/Eiw4v+VXi
         nUPyrmVyWgm2X5NAZTkS2bjtga25N+GcOlP/8rgU3wlJRPFvOt6CD0D3XpoZb4zO7MJR
         RTb5xROBppfNI3+h3yXQO02cMDQH+vUyMhy7m2/bsQuWqO43t/T652wnp3ccQACIrruE
         w2NSQCEmAac+MPdWfdJqp47I7AkqnuRFn2K3zg5av1CmCkKi4fbhquKHLsLpy7oWEmTq
         1gCex1T5rtmEO45QL7sRyL/mFyhdzteRX3EgBCk5kCAKR8O3mBNDIkkYoFl359gSPulx
         sMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcF550GwyqliSCSyHw0Z/IDzm3K/ogaNto0zdoWfp60=;
        b=BHVN6Dlw3KHHh6rgV+5YF3L93wfE1h4tmFEhoIp0gBY70K1DuS+utKj59SYe7Y9eN6
         sdAn8CCh/UHKVwtcIY9FF2QwwqHoGmdgWQWmPQio0vf6XxECNa1D8QRLnCgr6JDZEzCE
         k5hnl59Bna9/3ETWmTLIz6AoIqvIBoLiitGPOcfNc8+59bUi2Ati7bKxPLWx5txCEIeA
         maDSa1ynurYjZoSZTKdxNnabP2YUNzXWA2D+oKJIrDZb9Wi3rznuA/zmaVoPVJEfKZIv
         cnU8YgKBQiXWAp/MfAxkm52zo3dcUGbbWh8qRtRtDKZ/+PKp8QUjH96iUzn9rE+l5osg
         +uRg==
X-Gm-Message-State: AOAM531LXZu7qvaAm4vNPAdVY1s4Uwrb++5Ra7cFNyjOUeEjhfiKssUN
        7GMd0dkJsG5NcqitqpGClQA=
X-Google-Smtp-Source: ABdhPJyiYN1HRm7fTUbCjsDnDAsfhonS+0cIoWKodJ2jQ+pGXmfjQNFD7P4TdRoi2iJM10fiR86oOA==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr14605256wrt.267.1600075168623;
        Mon, 14 Sep 2020 02:19:28 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id j7sm19884886wrs.11.2020.09.14.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 02:19:27 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/mediatek: add flag for legacy ivrp paddr
To:     Fabien Parent <fparent@baylibre.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, yong.wu@mediatek.com,
        miles.chen@mediatek.com
References: <20200907101649.1573134-1-fparent@baylibre.com>
 <20200907101649.1573134-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cac92e0d-0789-64a4-729c-80ff5f34b6bb@gmail.com>
Date:   Mon, 14 Sep 2020 11:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907101649.1573134-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2020 12:16, Fabien Parent wrote:
> Add a new flag in order to select which IVRP_PADDR format is used
> by an SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
> v4: no change
> v3: set LEGACY_IVRP_PADDR as a flag instead of platform data
> v2: new patch
> 
> ---
>   drivers/iommu/mtk_iommu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 785b228d39a6..b1f85a7e9346 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -116,6 +116,7 @@
>   #define OUT_ORDER_WR_EN			BIT(4)
>   #define HAS_SUB_COMM			BIT(5)
>   #define WR_THROT_EN			BIT(6)
> +#define HAS_LEGACY_IVRP_PADDR		BIT(7)
>   
>   #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>   		((((pdata)->flags) & (_x)) == (_x))
> @@ -582,7 +583,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>   		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
>   	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
>   
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
>   		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
>   	else
>   		regval = lower_32_bits(data->protect_base) |
> @@ -818,7 +819,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>   
>   static const struct mtk_iommu_plat_data mt8173_data = {
>   	.m4u_plat     = M4U_MT8173,
> -	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI,
> +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> +			HAS_LEGACY_IVRP_PADDR,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
>   };
> 
