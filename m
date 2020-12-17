Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05A2DCE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgLQJFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbgLQJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:04:58 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83471C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:04:18 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id w18so12933245iot.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wO5PdkW1h0hMqSfogzOe9zRiOHCL2Q7rrfsrpK94HwI=;
        b=FP7CYpsQuy86qnPV+sDFWgK6sj5ReWWecWwDT/HFoT4buDPtxUIIJ+AbFmoWJHCgS0
         EwTURlJrqD0uWvV1zZlmC9XYU1xL8CVCcckNfT4wNCLRhInh8sG1lhYOohkOIZDdwvwR
         TE1HbGWKgWoPxEdTf0UMwQ3wjj7NNUhsTw3CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wO5PdkW1h0hMqSfogzOe9zRiOHCL2Q7rrfsrpK94HwI=;
        b=O+4fY7hnpu7w45VRmuubyuboN217acUvjPqZFlOe7hN0ReKNXOMOYqf/eMKD+zt9Va
         Dlxle0pilu6WypEgtNZnpT/4XX84hE52Gk/qYsGxY8BNqDidi1zpnJdqAbtXm2aLwXli
         GfHyNMyb14DPn8g5+21mFlJ1rtnEYNVcGtNyBg8vYS5aT8uEvLW3SghUG0IbrlTwDEZd
         5TgQ1i6F5PRsVBD7rLgtHPdxQwduVP/OX8GeqSzz9/tAvZ8ZseE17svbNqVfNjr8rgf0
         ed8tJ86wndYO4JNqkCDYYCK7vtlqaBdcCS8F4fnUsOmvmrGmVZ8h1LhZj+OyUiDPvYxd
         Nk1w==
X-Gm-Message-State: AOAM530wh9sSGmMULqmPRRLzL77Vx285mnvzuBaB77LORN+w8/ZpZGk/
        wwNyEqBZnGcuVurzbVxJjqtrF8rh5HYFEXK0CJLi7Q==
X-Google-Smtp-Source: ABdhPJywqMThmvuS3pOWYs8OtKoGze+h43JEKfuJyX/5uakupcLxkSc1wlxjo5J3V0umBbt4crX06jSGenmYXkkzBMw=
X-Received: by 2002:a02:b011:: with SMTP id p17mr47557156jah.114.1608195857543;
 Thu, 17 Dec 2020 01:04:17 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com> <1607591262-21736-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607591262-21736-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 17 Dec 2020 17:03:51 +0800
Message-ID: <CAJMQK-gVkYqZqnKOVNwoPzV9mmomWKfKAh_mwu4BkMHDAxTw6w@mail.gmail.com>
Subject: Re: [PATCH v8, 6/6] drm/mediatek: add support for mediatek SOC MT8183
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 9:07 AM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch add support for mediatek SOC MT8183
> 1. add ovl private data
> 2. add rdma private data
> 3. add mutes private data
> 4. add main and external path module for crtc create
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 18 ++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  6 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c   | 47 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 43 +++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 28651bc..8cf9f3b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -430,11 +430,29 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>         .fmt_rgb565_is_0 = true,
>  };
>
> +static const struct mtk_disp_ovl_data mt8183_ovl_driver_data = {
> +       .addr = DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits = 10,
> +       .layer_nr = 4,
> +       .fmt_rgb565_is_0 = true,
> +};
> +
> +static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
> +       .addr = DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits = 10,
> +       .layer_nr = 2,
> +       .fmt_rgb565_is_0 = true,
> +};
> +
>  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
>         { .compatible = "mediatek,mt2701-disp-ovl",
>           .data = &mt2701_ovl_driver_data},
>         { .compatible = "mediatek,mt8173-disp-ovl",
>           .data = &mt8173_ovl_driver_data},
> +       { .compatible = "mediatek,mt8183-disp-ovl",
> +         .data = &mt8183_ovl_driver_data},
> +       { .compatible = "mediatek,mt8183-disp-ovl-2l",
> +         .data = &mt8183_ovl_2l_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 0508392..86e77c2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -359,11 +359,17 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
>         .fifo_size = SZ_8K,
>  };
>
> +static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
> +       .fifo_size = 5 * SZ_1K,
> +};
> +
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
>         { .compatible = "mediatek,mt2701-disp-rdma",
>           .data = &mt2701_rdma_driver_data},
>         { .compatible = "mediatek,mt8173-disp-rdma",
>           .data = &mt8173_rdma_driver_data},
> +       { .compatible = "mediatek,mt8183-disp-rdma",
> +         .data = &mt8183_rdma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 014c1bb..60788c1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -15,6 +15,8 @@
>
>  #define MT2701_DISP_MUTEX0_MOD0                        0x2c
>  #define MT2701_DISP_MUTEX0_SOF0                        0x30
> +#define MT8183_DISP_MUTEX0_MOD0                        0x30
> +#define MT8183_DISP_MUTEX0_SOF0                        0x2c
>
>  #define DISP_REG_MUTEX_EN(n)                   (0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)                      (0x24 + 0x20 * (n))
> @@ -25,6 +27,18 @@
>
>  #define INT_MUTEX                              BIT(1)
>
> +#define MT8183_MUTEX_MOD_DISP_RDMA0            0
> +#define MT8183_MUTEX_MOD_DISP_RDMA1            1
> +#define MT8183_MUTEX_MOD_DISP_OVL0             9
> +#define MT8183_MUTEX_MOD_DISP_OVL0_2L          10
> +#define MT8183_MUTEX_MOD_DISP_OVL1_2L          11
> +#define MT8183_MUTEX_MOD_DISP_WDMA0            12
> +#define MT8183_MUTEX_MOD_DISP_COLOR0           13
> +#define MT8183_MUTEX_MOD_DISP_CCORR0           14
> +#define MT8183_MUTEX_MOD_DISP_AAL0             15
> +#define MT8183_MUTEX_MOD_DISP_GAMMA0           16
> +#define MT8183_MUTEX_MOD_DISP_DITHER0          17
> +
>  #define MT8173_MUTEX_MOD_DISP_OVL0             11
>  #define MT8173_MUTEX_MOD_DISP_OVL1             12
>  #define MT8173_MUTEX_MOD_DISP_RDMA0            13
> @@ -74,6 +88,10 @@
>  #define MUTEX_SOF_DSI2                 5
>  #define MUTEX_SOF_DSI3                 6
>
> +#define MT8183_MUTEX_SOF_DPI0                  2
> +#define MT8183_MUTEX_EOF_DSI0                  (MUTEX_SOF_DSI0 << 6)
> +#define MT8183_MUTEX_EOF_DPI0                  (MT8183_MUTEX_SOF_DPI0 << 6)
> +
>
>  struct mtk_disp_mutex {
>         int id;
> @@ -153,6 +171,20 @@ struct mtk_ddp {
>         [DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>
> +static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> +       [DDP_COMPONENT_AAL0] = MT8183_MUTEX_MOD_DISP_AAL0,
> +       [DDP_COMPONENT_CCORR] = MT8183_MUTEX_MOD_DISP_CCORR0,
> +       [DDP_COMPONENT_COLOR0] = MT8183_MUTEX_MOD_DISP_COLOR0,
> +       [DDP_COMPONENT_DITHER] = MT8183_MUTEX_MOD_DISP_DITHER0,
> +       [DDP_COMPONENT_GAMMA] = MT8183_MUTEX_MOD_DISP_GAMMA0,
> +       [DDP_COMPONENT_OVL0] = MT8183_MUTEX_MOD_DISP_OVL0,
> +       [DDP_COMPONENT_OVL_2L0] = MT8183_MUTEX_MOD_DISP_OVL0_2L,
> +       [DDP_COMPONENT_OVL_2L1] = MT8183_MUTEX_MOD_DISP_OVL1_2L,
> +       [DDP_COMPONENT_RDMA0] = MT8183_MUTEX_MOD_DISP_RDMA0,
> +       [DDP_COMPONENT_RDMA1] = MT8183_MUTEX_MOD_DISP_RDMA1,
> +       [DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
> +};
> +
>  static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
>         [DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
>         [DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
> @@ -163,6 +195,12 @@ struct mtk_ddp {
>         [DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
>  };
>
> +static const unsigned int mt8183_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
> +       [DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
> +       [DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,
> +       [DDP_MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
> +};
> +
>  static const struct mtk_ddp_data mt2701_ddp_driver_data = {
>         .mutex_mod = mt2701_mutex_mod,
>         .mutex_sof = mt2712_mutex_sof,
> @@ -184,6 +222,13 @@ struct mtk_ddp {
>         .mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
>  };
>
> +static const struct mtk_ddp_data mt8183_ddp_driver_data = {
> +       .mutex_mod = mt8183_mutex_mod,
> +       .mutex_sof = mt8183_mutex_sof,
> +       .mutex_mod_reg = MT8183_DISP_MUTEX0_MOD0,
> +       .mutex_sof_reg = MT8183_DISP_MUTEX0_SOF0,

Tested on an mt8183 device, and get:

[   10.014978] mediatek-ddp 14016000.mutex: Failed to get clock
[   10.026441] mediatek-ddp: probe of 14016000.mutex failed with error -2

Since mt8183 mutex doesn't need clock, I think this should add
.no_clk = true,


> +};
> +
>  struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned int id)
>  {
>         struct mtk_ddp *ddp = dev_get_drvdata(dev);
> @@ -402,6 +447,8 @@ static int mtk_ddp_remove(struct platform_device *pdev)
>           .data = &mt2712_ddp_driver_data},
>         { .compatible = "mediatek,mt8173-disp-mutex",
>           .data = &mt8173_ddp_driver_data},
> +       { .compatible = "mediatek,mt8183-disp-mutex",
> +         .data = &mt8183_ddp_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 59c85c6..a7e9f88 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -131,6 +131,24 @@
>         DDP_COMPONENT_DPI0,
>  };
>
> +static const enum mtk_ddp_comp_id mt8183_mtk_ddp_main[] = {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_OVL_2L0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DSI0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext[] = {
> +       DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_RDMA1,
> +       DDP_COMPONENT_DPI0,
> +};
> +
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>         .main_path = mt2701_mtk_ddp_main,
>         .main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
> @@ -163,6 +181,13 @@
>         .ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
>  };
>
> +static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
> +       .main_path = mt8183_mtk_ddp_main,
> +       .main_len = ARRAY_SIZE(mt8183_mtk_ddp_main),
> +       .ext_path = mt8183_mtk_ddp_ext,
> +       .ext_len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
> +};
> +
>  static int mtk_drm_kms_init(struct drm_device *drm)
>  {
>         struct mtk_drm_private *private = drm->dev_private;
> @@ -403,12 +428,20 @@ static void mtk_drm_unbind(struct device *dev)
>           .data = (void *)MTK_DISP_OVL },
>         { .compatible = "mediatek,mt8173-disp-ovl",
>           .data = (void *)MTK_DISP_OVL },
> +       { .compatible = "mediatek,mt8183-disp-ovl",
> +         .data = (void *)MTK_DISP_OVL },
> +       { .compatible = "mediatek,mt8183-disp-ovl-2l",
> +         .data = (void *)MTK_DISP_OVL_2L },
>         { .compatible = "mediatek,mt2701-disp-rdma",
>           .data = (void *)MTK_DISP_RDMA },
>         { .compatible = "mediatek,mt8173-disp-rdma",
>           .data = (void *)MTK_DISP_RDMA },
> +       { .compatible = "mediatek,mt8183-disp-rdma",
> +         .data = (void *)MTK_DISP_RDMA },
>         { .compatible = "mediatek,mt8173-disp-wdma",
>           .data = (void *)MTK_DISP_WDMA },
> +       { .compatible = "mediatek,mt8183-disp-ccorr",
> +         .data = (void *)MTK_DISP_CCORR },
>         { .compatible = "mediatek,mt2701-disp-color",
>           .data = (void *)MTK_DISP_COLOR },
>         { .compatible = "mediatek,mt8173-disp-color",
> @@ -417,22 +450,30 @@ static void mtk_drm_unbind(struct device *dev)
>           .data = (void *)MTK_DISP_AAL},
>         { .compatible = "mediatek,mt8173-disp-gamma",
>           .data = (void *)MTK_DISP_GAMMA, },
> +       { .compatible = "mediatek,mt8183-disp-dither",
> +         .data = (void *)MTK_DISP_DITHER },
>         { .compatible = "mediatek,mt8173-disp-ufoe",
>           .data = (void *)MTK_DISP_UFOE },
>         { .compatible = "mediatek,mt2701-dsi",
>           .data = (void *)MTK_DSI },
>         { .compatible = "mediatek,mt8173-dsi",
>           .data = (void *)MTK_DSI },
> +       { .compatible = "mediatek,mt8183-dsi",
> +         .data = (void *)MTK_DSI },
>         { .compatible = "mediatek,mt2701-dpi",
>           .data = (void *)MTK_DPI },
>         { .compatible = "mediatek,mt8173-dpi",
>           .data = (void *)MTK_DPI },
> +       { .compatible = "mediatek,mt8183-dpi",
> +         .data = (void *)MTK_DPI },
>         { .compatible = "mediatek,mt2701-disp-mutex",
>           .data = (void *)MTK_DISP_MUTEX },
>         { .compatible = "mediatek,mt2712-disp-mutex",
>           .data = (void *)MTK_DISP_MUTEX },
>         { .compatible = "mediatek,mt8173-disp-mutex",
>           .data = (void *)MTK_DISP_MUTEX },
> +       { .compatible = "mediatek,mt8183-disp-mutex",
> +         .data = (void *)MTK_DISP_MUTEX },
>         { .compatible = "mediatek,mt2701-disp-pwm",
>           .data = (void *)MTK_DISP_BLS },
>         { .compatible = "mediatek,mt8173-disp-pwm",
> @@ -451,6 +492,8 @@ static void mtk_drm_unbind(struct device *dev)
>           .data = &mt2712_mmsys_driver_data},
>         { .compatible = "mediatek,mt8173-mmsys",
>           .data = &mt8173_mmsys_driver_data},
> +       { .compatible = "mediatek,mt8183-mmsys",
> +         .data = &mt8183_mmsys_driver_data},
>         { }
>  };
>
