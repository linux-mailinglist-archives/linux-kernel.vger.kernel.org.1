Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19E303CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392171AbhAZLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbhAZHmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:42:40 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 23:41:55 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z22so31821123ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 23:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTEzEls579DZ3BH7hVcyPhp2fOCUcEmP44D/dLy0dWM=;
        b=lhkvH0huBJvc9H+HHJT5oD2JJfLRkNYrzMGtQpHmHbrcyuVVO75mflEeMeVGM5SLeV
         Nvz2LpNpnG4NLXQS3PzviLTmcoJ28ZzcjvSuunpWVNA8XdJ5QA/GD6hAbJMtxdnbxWmo
         TblN5TW94Rysnh9stZJyH71Ylpu5BK5dkAgLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTEzEls579DZ3BH7hVcyPhp2fOCUcEmP44D/dLy0dWM=;
        b=G+odOz6QDo6OgC6O/8j9kM4KjIZyUUmuCTaSTq6nvPHM6G/NuA2Q3fohvbevas+jRF
         4BciZ5kxJz0gTV9fxypaXhiiS49dlPP5M2i9ZP/HAJWpbITyt4VOw/iOFI3J3KbpnkoY
         XMSfCzCgMbhSUI8h5JQOJbD4BGuMBlynuPlopfoNosefxoB2ShLjJVKaMQ9Hs3YWjLNx
         2TnlX1/otuR0mtLPYpqPeP/cM0FKfdRikCdA3oKPmYSVwFlpPWQcz0MkVXrxn+4nE2Kz
         MSVES8apx82ZBL6kD/cvdRPltBOUWQNwmBkgdDSoC1aRccwUxEYVdsXDKPd9X97REXWb
         4b6A==
X-Gm-Message-State: AOAM532AlDT67f7TngYvwlJZxO6v/MGeCi4GaizswCyEo/Z/4NCktyev
        1SZnvIqU0ZTmP/MBwrm7U2VktbsOct0WHf0TGlKzqw==
X-Google-Smtp-Source: ABdhPJwlpBCKAL7fXLH9DDApVCKASF37ZecJUvGno+yw0iUERuo8IehQdIP5bitm9orrlTzk/WX0NRpPQ8lzpIqZxIQ=
X-Received: by 2002:a05:6638:b12:: with SMTP id a18mr3834357jab.114.1611646915306;
 Mon, 25 Jan 2021 23:41:55 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-6-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-6-git-send-email-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 26 Jan 2021 15:41:29 +0800
Message-ID: <CAJMQK-g_+7h0vo7758aoY6304pqULJpHgSWE3HhvF8FWjkze_w@mail.gmail.com>
Subject: Re: [PATCH v3, 05/15] drm/mediatek: add component POSTMASK
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 3:44 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch add component POSTMASK,
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile            |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_postmask.c | 160 +++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c  |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h  |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c       |   4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h       |   1 +
>  6 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_postmask.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 17a08e2..ce5ad59 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -3,6 +3,7 @@
>  mediatek-drm-y := mtk_disp_color.o \
>                   mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
> +                 mtk_disp_postmask.o \
>                   mtk_disp_rdma.o \
>                   mtk_drm_crtc.o \
>                   mtk_drm_ddp.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_postmask.c b/drivers/gpu/drm/mediatek/mtk_disp_postmask.c
> new file mode 100644
> index 0000000..736224c
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_postmask.c
> @@ -0,0 +1,160 @@
> +/*
> + * SPDX-License-Identifier:
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#include "mtk_drm_crtc.h"
> +#include "mtk_drm_ddp_comp.h"
> +
> +#define DISP_POSTMASK_EN                       0x0000
> +#define POSTMASK_EN                                    BIT(0)
> +#define DISP_POSTMASK_CFG                      0x0020
> +#define POSTMASK_RELAY_MODE                            BIT(0)
> +#define DISP_POSTMASK_SIZE                     0x0030
> +
> +struct mtk_disp_postmask_data {
> +       u32 reserved;
> +};
> +

Will there be more data and config for different soc in the future? If
not, it can be put in mtk_drm_ddp_comp.c and use struct
mtk_ddp_comp_dev, like ddp_dither or ddp_aal.


> +/**
> + * struct mtk_disp_postmask - DISP_postmask driver structure
> + * @ddp_comp - structure containing type enum and hardware resources
> + * @crtc - associated crtc to report irq events to
> + */
> +struct mtk_disp_postmask {
> +       struct mtk_ddp_comp                     ddp_comp;
> +       const struct mtk_disp_postmask_data     *data;
> +};
> +
> +static inline struct mtk_disp_postmask *comp_to_postmask(struct mtk_ddp_comp *comp)
> +{
> +       return container_of(comp, struct mtk_disp_postmask, ddp_comp);
> +}
> +
> +static void mtk_postmask_config(struct mtk_ddp_comp *comp, unsigned int w,
> +                             unsigned int h, unsigned int vrefresh,
> +                             unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_POSTMASK_SIZE);
> +       mtk_ddp_write(cmdq_pkt, POSTMASK_RELAY_MODE, comp, DISP_POSTMASK_CFG);
> +}
> +
> +static void mtk_postmask_start(struct mtk_ddp_comp *comp)
> +{
> +       writel(POSTMASK_EN, comp->regs + DISP_POSTMASK_EN);
> +}
> +
> +static void mtk_postmask_stop(struct mtk_ddp_comp *comp)
> +{
> +       writel_relaxed(0x0, comp->regs + DISP_POSTMASK_EN);
> +}
> +
> +static const struct mtk_ddp_comp_funcs mtk_disp_postmask_funcs = {
> +       .config = mtk_postmask_config,
> +       .start = mtk_postmask_start,
> +       .stop = mtk_postmask_stop,
> +};
> +
> +static int mtk_disp_postmask_bind(struct device *dev, struct device *master, void *data)
> +{
> +       struct mtk_disp_postmask *priv = dev_get_drvdata(dev);
> +       struct drm_device *drm_dev = data;
> +       int ret;
> +
> +       ret = mtk_ddp_comp_register(drm_dev, &priv->ddp_comp);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to register component %pOF: %d\n",
> +                       dev->of_node, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void mtk_disp_postmask_unbind(struct device *dev, struct device *master,
> +                                 void *data)
> +{
> +       struct mtk_disp_postmask *priv = dev_get_drvdata(dev);
> +       struct drm_device *drm_dev = data;
> +
> +       mtk_ddp_comp_unregister(drm_dev, &priv->ddp_comp);
> +}
> +
> +static const struct component_ops mtk_disp_postmask_component_ops = {
> +       .bind   = mtk_disp_postmask_bind,
> +       .unbind = mtk_disp_postmask_unbind,
> +};
> +
> +static int mtk_disp_postmask_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct mtk_disp_postmask *priv;
> +       int comp_id;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_POSTMASK);
> +       if (comp_id < 0) {
> +               dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> +               return comp_id;
> +       }
> +
> +       ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
> +                               &mtk_disp_postmask_funcs);
> +       if (ret) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "Failed to initialize component: %d\n",
> +                               ret);
> +
> +               return ret;
> +       }
> +
> +       priv->data = of_device_get_match_data(dev);
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       pm_runtime_enable(dev);
> +
> +       ret = component_add(dev, &mtk_disp_postmask_component_ops);
> +       if (ret)
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_postmask_remove(struct platform_device *pdev)
> +{
> +       pm_runtime_disable(&pdev->dev);
> +
> +       component_del(&pdev->dev, &mtk_disp_postmask_component_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_disp_postmask_driver_dt_match[] = {
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_postmask_driver_dt_match);
> +
> +struct platform_driver mtk_disp_postmask_driver = {
> +       .probe          = mtk_disp_postmask_probe,
> +       .remove         = mtk_disp_postmask_remove,
> +       .driver         = {
> +               .name   = "mediatek-disp-postmask",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = mtk_disp_postmask_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index a715127..bc6b10a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -354,6 +354,7 @@ static void mtk_dither_stop(struct mtk_ddp_comp *comp)
>         [MTK_DISP_MUTEX] = "mutex",
>         [MTK_DISP_OD] = "od",
>         [MTK_DISP_BLS] = "bls",
> +       [MTK_DISP_POSTMASK] = "postmask",
>  };
>
>  struct mtk_ddp_comp_match {
> @@ -384,6 +385,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_OVL_2L0] = { MTK_DISP_OVL_2L,    0, NULL },
>         [DDP_COMPONENT_OVL_2L1] = { MTK_DISP_OVL_2L,    1, NULL },
>         [DDP_COMPONENT_OVL_2L2] = { MTK_DISP_OVL_2L,    2, NULL },
> +       [DDP_COMPONENT_POSTMASK0]       = { MTK_DISP_POSTMASK,  0, NULL },
>         [DDP_COMPONENT_PWM0]    = { MTK_DISP_PWM,       0, NULL },
>         [DDP_COMPONENT_PWM1]    = { MTK_DISP_PWM,       1, NULL },
>         [DDP_COMPONENT_PWM2]    = { MTK_DISP_PWM,       2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 178fae9..0b23b5c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -29,6 +29,7 @@ enum mtk_ddp_comp_type {
>         MTK_DISP_UFOE,
>         MTK_DSI,
>         MTK_DPI,
> +       MTK_DISP_POSTMASK,
>         MTK_DISP_PWM,
>         MTK_DISP_MUTEX,
>         MTK_DISP_OD,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index b6e963e..bc205e9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -533,7 +533,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>                 private->comp_node[comp_id] = of_node_get(node);
>
>                 /*
> -                * Currently only the COLOR, GAMMA, OVL, RDMA, DSI, and DPI blocks have
> +                * Currently only the COLOR, GAMMA, OVL, POSTMASK, RDMA, DSI, and DPI blocks have
>                  * separate component platform drivers and initialize their own
>                  * DDP component structure. The others are initialized here.
>                  */
> @@ -541,6 +541,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>                     comp_type == MTK_DISP_GAMMA ||
>                     comp_type == MTK_DISP_OVL ||
>                     comp_type == MTK_DISP_OVL_2L ||
> +                   comp_type == MTK_DISP_POSTMASK ||
>                     comp_type == MTK_DISP_RDMA ||
>                     comp_type == MTK_DSI ||
>                     comp_type == MTK_DPI) {
> @@ -654,6 +655,7 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>         &mtk_disp_color_driver,
>         &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
> +       &mtk_disp_postmask_driver,
>         &mtk_disp_rdma_driver,
>         &mtk_dpi_driver,
>         &mtk_drm_platform_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index bbd362b..8a9544b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -50,6 +50,7 @@ struct mtk_drm_private {
>  extern struct platform_driver mtk_disp_color_driver;
>  extern struct platform_driver mtk_disp_gamma_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
> +extern struct platform_driver mtk_disp_postmask_driver;
>  extern struct platform_driver mtk_disp_rdma_driver;
>  extern struct platform_driver mtk_dpi_driver;
>  extern struct platform_driver mtk_dsi_driver;
> --
> 1.8.1.1.dirty
>
