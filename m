Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B82C6DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 00:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgK0XtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 18:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbgK0XfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 18:35:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E1C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 15:35:22 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 1so7808102wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4F/42hYjyqyL+aZY2Lepn5obAALGh+LegP2VS6nWf7s=;
        b=G1UcnmWnAQHFsBAZskAa4olwjSkYMi/D4LHXjWPn9C1QhmCdRTzoJfLpPuEaHQ4r+F
         11mNqiw/uzcKu19G+VyXyS9xqAu52XloAZy+fcx9MZCmV5f2Fmkvvqc5TWQnVQGjzXNt
         6q0sl2SBqvqUjZBE8xod9R9AeRfYV7/cThIoBt9bh0N7vrP6xDHJIX98FXYywmnPKHwa
         YmulnIsv0S9bRy1utyPSV1bri8Tdtn/irRYMw5ZePwk/GfzKYirg0zsrmfcIVqVNNc5U
         /D2Cz2cM9zULqQxJpbd6ZtSkIjs7Pn+CBspTC03nBwBLRfKQy/Y6052bq+r5JpCiuARi
         wjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4F/42hYjyqyL+aZY2Lepn5obAALGh+LegP2VS6nWf7s=;
        b=Rpm6BhXB6r05GzkXPoeZdx0te+Vv2yeDseWaDQ4yQZhkwVZC3Ww7Gnab2STPIbwnkZ
         9NmP/PancQNQuxqLuyYLVE0GRuwMzIE/HbzaR7H7y+gGEmkSPiWxdKPDRu2AxI7fz75b
         Hm7a8Np3nVXt2debIH8g6EuA6L38BnEOP6GzehIDJbKXrZoaHlQqlin22WdMAar2IPQJ
         W/ER2aJCnUNYKCYck1k0DyP7OUQPwrcBZKky4K1QS2YBLLz0/aEdIoUfvhStsaXojcZQ
         zkZ+cOlKcfzF4YNUEr+Ca0JIxFrjPZDOWaiEw7Va7+9H7APWGRHo5QIizK3JtHziEaKE
         nJbA==
X-Gm-Message-State: AOAM532vg9nDYHwYHsTOACfGw68ZXbtKHmeb+pbEt4y+AmtVu0DcqTKH
        cIK+fUgvxJhsrraj/yfxlGs=
X-Google-Smtp-Source: ABdhPJwft7Sf+k6f33QQ7aIuDGIaAlTA/RUoe+AlXUi5qgEUy4DOTmyQnKKGhy+g6qHsh7ZeOJz9ow==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr11782565wmc.144.1606520121447;
        Fri, 27 Nov 2020 15:35:21 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id w21sm15028929wmi.29.2020.11.27.15.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 15:35:19 -0800 (PST)
Subject: Re: [PATCH 1/4] soc / drm: mediatek: Move DDP component defines into
 mtk-mmsys.h
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        yongqiang.niu@mediatek.com, drinkcat@chromium.org,
        hsinyi@chromium.org, chunkuang.hu@kernel.org,
        CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
 <20201006193320.405529-2-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5b6816ca-f3c9-3048-57ca-f6af128fbb0b@gmail.com>
Date:   Sat, 28 Nov 2020 00:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201006193320.405529-2-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2020 21:33, Enric Balletbo i Serra wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> MMSYS is the driver which controls the routing of these DDP components,
> so the definition of the mtk_ddp_comp_id enum should be placed in mtk-mmsys.h
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> This patch was previously part of another series, but has no
> dependencies and can be applied independently. As the latest version
> sent is from two months ago, I resent this patch because the next patches
> of this series depends on it to apply cleanly.
> 

Applied to v5.10-next/soc

Thanks

> [1] https://patchwork.kernel.org/patch/11706243
> 
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 34 +--------------------
>   drivers/soc/mediatek/mtk-mmsys.c            |  4 +--
>   include/linux/soc/mediatek/mtk-mmsys.h      | 33 ++++++++++++++++++++
>   3 files changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index debe36395fe7..161201fe5179 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -7,6 +7,7 @@
>   #define MTK_DRM_DDP_COMP_H
>   
>   #include <linux/io.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
>   
>   struct device;
>   struct device_node;
> @@ -35,39 +36,6 @@ enum mtk_ddp_comp_type {
>   	MTK_DDP_COMP_TYPE_MAX,
>   };
>   
> -enum mtk_ddp_comp_id {
> -	DDP_COMPONENT_AAL0,
> -	DDP_COMPONENT_AAL1,
> -	DDP_COMPONENT_BLS,
> -	DDP_COMPONENT_CCORR,
> -	DDP_COMPONENT_COLOR0,
> -	DDP_COMPONENT_COLOR1,
> -	DDP_COMPONENT_DITHER,
> -	DDP_COMPONENT_DPI0,
> -	DDP_COMPONENT_DPI1,
> -	DDP_COMPONENT_DSI0,
> -	DDP_COMPONENT_DSI1,
> -	DDP_COMPONENT_DSI2,
> -	DDP_COMPONENT_DSI3,
> -	DDP_COMPONENT_GAMMA,
> -	DDP_COMPONENT_OD0,
> -	DDP_COMPONENT_OD1,
> -	DDP_COMPONENT_OVL0,
> -	DDP_COMPONENT_OVL_2L0,
> -	DDP_COMPONENT_OVL_2L1,
> -	DDP_COMPONENT_OVL1,
> -	DDP_COMPONENT_PWM0,
> -	DDP_COMPONENT_PWM1,
> -	DDP_COMPONENT_PWM2,
> -	DDP_COMPONENT_RDMA0,
> -	DDP_COMPONENT_RDMA1,
> -	DDP_COMPONENT_RDMA2,
> -	DDP_COMPONENT_UFOE,
> -	DDP_COMPONENT_WDMA0,
> -	DDP_COMPONENT_WDMA1,
> -	DDP_COMPONENT_ID_MAX,
> -};
> -
>   struct mtk_ddp_comp;
>   struct cmdq_pkt;
>   struct mtk_ddp_comp_funcs {
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index a55f25511173..36ad66bb221b 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -5,13 +5,11 @@
>    */
>   
>   #include <linux/device.h>
> +#include <linux/io.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/soc/mediatek/mtk-mmsys.h>
>   
> -#include "../../gpu/drm/mediatek/mtk_drm_ddp.h"
> -#include "../../gpu/drm/mediatek/mtk_drm_ddp_comp.h"
> -
>   #define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x040
>   #define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN	0x044
>   #define DISP_REG_CONFIG_DISP_OD_MOUT_EN		0x048
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index 7bab5d9a3d31..2228bf6133da 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -9,6 +9,39 @@
>   enum mtk_ddp_comp_id;
>   struct device;
>   
> +enum mtk_ddp_comp_id {
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_AAL1,
> +	DDP_COMPONENT_BLS,
> +	DDP_COMPONENT_CCORR,
> +	DDP_COMPONENT_COLOR0,
> +	DDP_COMPONENT_COLOR1,
> +	DDP_COMPONENT_DITHER,
> +	DDP_COMPONENT_DPI0,
> +	DDP_COMPONENT_DPI1,
> +	DDP_COMPONENT_DSI0,
> +	DDP_COMPONENT_DSI1,
> +	DDP_COMPONENT_DSI2,
> +	DDP_COMPONENT_DSI3,
> +	DDP_COMPONENT_GAMMA,
> +	DDP_COMPONENT_OD0,
> +	DDP_COMPONENT_OD1,
> +	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_OVL_2L0,
> +	DDP_COMPONENT_OVL_2L1,
> +	DDP_COMPONENT_OVL1,
> +	DDP_COMPONENT_PWM0,
> +	DDP_COMPONENT_PWM1,
> +	DDP_COMPONENT_PWM2,
> +	DDP_COMPONENT_RDMA0,
> +	DDP_COMPONENT_RDMA1,
> +	DDP_COMPONENT_RDMA2,
> +	DDP_COMPONENT_UFOE,
> +	DDP_COMPONENT_WDMA0,
> +	DDP_COMPONENT_WDMA1,
> +	DDP_COMPONENT_ID_MAX,
> +};
> +
>   void mtk_mmsys_ddp_connect(struct device *dev,
>   			   enum mtk_ddp_comp_id cur,
>   			   enum mtk_ddp_comp_id next);
> 
