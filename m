Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE92F24BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbhALAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404205AbhAKXuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:50:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCE122D08;
        Mon, 11 Jan 2021 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408970;
        bh=M48oHPVrImjbClGq/kBGcUs8mcRWgcc9yzXqOv3qUSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TDpfo4nDfIS12PGyRMoxcX6B04vedLQtaX6jsHfM82HL7ee+RrOSEDobrfqPHa79T
         VwjVcUOH2t1uPAes+DbrCuTCIw9SrZuVB3EvzNX67kF5Tau7cxMbO5q2hJnqhk3mzG
         j4C+mvbjvJenxrw4uoyZewOg7lmGlDQmai9g1AUKkQ4BLucQr+9kyOlMPR/lb+8iRc
         8oovwUCREaf6SPjuKTOCEm3TlZTLTfphReciPJSBCdQkez/FPMn21SxrbNNzRVme0H
         PtTkQ/WS4aOcB/8AuLW/YvHjfmFNljZ6pKNjNWwSNi0gjNK1F//qW/OjpYQCMfhQod
         z8W3LlJ2tJhpw==
Received: by mail-ej1-f49.google.com with SMTP id jx16so855573ejb.10;
        Mon, 11 Jan 2021 15:49:29 -0800 (PST)
X-Gm-Message-State: AOAM530AWlYx/AzCrItDWfqGbgHQOtXqIg6Uu2y2PWnEAU501Tf2JyhK
        2VzqN2RFYB4ML5IkwLfMN8DtV/jxrovoT9z1kw==
X-Google-Smtp-Source: ABdhPJwwM8xox+w60hakWH13ybiux71Umt2MG754yPYOvbh3PK6rnA1St9ldnd84tVRFY8QR64UGGfgx6zwqh7qhoCs=
X-Received: by 2002:a17:906:ae4e:: with SMTP id lf14mr1314212ejb.310.1610408968126;
 Mon, 11 Jan 2021 15:49:28 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-6-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-6-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 12 Jan 2021 07:49:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8rf86RxuJxY6s-Vpx=M+_44eku2Dgm12A67samRLaeVQ@mail.gmail.com>
Message-ID: <CAAOTY_8rf86RxuJxY6s-Vpx=M+_44eku2Dgm12A67samRLaeVQ@mail.gmail.com>
Subject: Re: [PATCH v3, 05/15] drm/mediatek: add component POSTMASK
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add component POSTMASK,

This patch has conflicts with the series "Decouple Mediatek DRM sub
driver" [1] which has been applied to mediatek-drm-next, so please
rebase this patch onto mediatek-drm-next.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D3999=
15

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile            |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_postmask.c | 160 +++++++++++++++++++++=
++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c  |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h  |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c       |   4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h       |   1 +
>  6 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_postmask.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index 17a08e2..ce5ad59 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -3,6 +3,7 @@
>  mediatek-drm-y :=3D mtk_disp_color.o \
>                   mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
> +                 mtk_disp_postmask.o \
>                   mtk_disp_rdma.o \
>                   mtk_drm_crtc.o \
>                   mtk_drm_ddp.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_postmask.c b/drivers/gpu/d=
rm/mediatek/mtk_disp_postmask.c
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
> +static inline struct mtk_disp_postmask *comp_to_postmask(struct mtk_ddp_=
comp *comp)
> +{
> +       return container_of(comp, struct mtk_disp_postmask, ddp_comp);
> +}
> +
> +static void mtk_postmask_config(struct mtk_ddp_comp *comp, unsigned int =
w,
> +                             unsigned int h, unsigned int vrefresh,
> +                             unsigned int bpc, struct cmdq_pkt *cmdq_pkt=
)
> +{
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_POSTMASK_SIZE);
> +       mtk_ddp_write(cmdq_pkt, POSTMASK_RELAY_MODE, comp, DISP_POSTMASK_=
CFG);
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
> +static const struct mtk_ddp_comp_funcs mtk_disp_postmask_funcs =3D {
> +       .config =3D mtk_postmask_config,
> +       .start =3D mtk_postmask_start,
> +       .stop =3D mtk_postmask_stop,
> +};
> +
> +static int mtk_disp_postmask_bind(struct device *dev, struct device *mas=
ter, void *data)
> +{
> +       struct mtk_disp_postmask *priv =3D dev_get_drvdata(dev);
> +       struct drm_device *drm_dev =3D data;
> +       int ret;
> +
> +       ret =3D mtk_ddp_comp_register(drm_dev, &priv->ddp_comp);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to register component %pOF: %d\n",
> +                       dev->of_node, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void mtk_disp_postmask_unbind(struct device *dev, struct device *=
master,
> +                                 void *data)
> +{
> +       struct mtk_disp_postmask *priv =3D dev_get_drvdata(dev);
> +       struct drm_device *drm_dev =3D data;
> +
> +       mtk_ddp_comp_unregister(drm_dev, &priv->ddp_comp);
> +}
> +
> +static const struct component_ops mtk_disp_postmask_component_ops =3D {
> +       .bind   =3D mtk_disp_postmask_bind,
> +       .unbind =3D mtk_disp_postmask_unbind,
> +};
> +
> +static int mtk_disp_postmask_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mtk_disp_postmask *priv;
> +       int comp_id;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       comp_id =3D mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_POSTMASK);
> +       if (comp_id < 0) {
> +               dev_err(dev, "Failed to identify by alias: %d\n", comp_id=
);
> +               return comp_id;
> +       }
> +
> +       ret =3D mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, com=
p_id,
> +                               &mtk_disp_postmask_funcs);
> +       if (ret) {
> +               if (ret !=3D -EPROBE_DEFER)
> +                       dev_err(dev, "Failed to initialize component: %d\=
n",
> +                               ret);
> +
> +               return ret;
> +       }
> +
> +       priv->data =3D of_device_get_match_data(dev);
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       pm_runtime_enable(dev);
> +
> +       ret =3D component_add(dev, &mtk_disp_postmask_component_ops);
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
> +static const struct of_device_id mtk_disp_postmask_driver_dt_match[] =3D=
 {
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_postmask_driver_dt_match);
> +
> +struct platform_driver mtk_disp_postmask_driver =3D {
> +       .probe          =3D mtk_disp_postmask_probe,
> +       .remove         =3D mtk_disp_postmask_remove,
> +       .driver         =3D {
> +               .name   =3D "mediatek-disp-postmask",
> +               .owner  =3D THIS_MODULE,
> +               .of_match_table =3D mtk_disp_postmask_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index a715127..bc6b10a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -354,6 +354,7 @@ static void mtk_dither_stop(struct mtk_ddp_comp *comp=
)
>         [MTK_DISP_MUTEX] =3D "mutex",
>         [MTK_DISP_OD] =3D "od",
>         [MTK_DISP_BLS] =3D "bls",
> +       [MTK_DISP_POSTMASK] =3D "postmask",
>  };
>
>  struct mtk_ddp_comp_match {
> @@ -384,6 +385,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_OVL_2L0] =3D { MTK_DISP_OVL_2L,    0, NULL },
>         [DDP_COMPONENT_OVL_2L1] =3D { MTK_DISP_OVL_2L,    1, NULL },
>         [DDP_COMPONENT_OVL_2L2] =3D { MTK_DISP_OVL_2L,    2, NULL },
> +       [DDP_COMPONENT_POSTMASK0]       =3D { MTK_DISP_POSTMASK,  0, NULL=
 },
>         [DDP_COMPONENT_PWM0]    =3D { MTK_DISP_PWM,       0, NULL },
>         [DDP_COMPONENT_PWM1]    =3D { MTK_DISP_PWM,       1, NULL },
>         [DDP_COMPONENT_PWM2]    =3D { MTK_DISP_PWM,       2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
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
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index b6e963e..bc205e9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -533,7 +533,7 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>                 private->comp_node[comp_id] =3D of_node_get(node);
>
>                 /*
> -                * Currently only the COLOR, GAMMA, OVL, RDMA, DSI, and D=
PI blocks have
> +                * Currently only the COLOR, GAMMA, OVL, POSTMASK, RDMA, =
DSI, and DPI blocks have
>                  * separate component platform drivers and initialize the=
ir own
>                  * DDP component structure. The others are initialized he=
re.
>                  */
> @@ -541,6 +541,7 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>                     comp_type =3D=3D MTK_DISP_GAMMA ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
> +                   comp_type =3D=3D MTK_DISP_POSTMASK ||
>                     comp_type =3D=3D MTK_DISP_RDMA ||
>                     comp_type =3D=3D MTK_DSI ||
>                     comp_type =3D=3D MTK_DPI) {
> @@ -654,6 +655,7 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_=
suspend,
>         &mtk_disp_color_driver,
>         &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
> +       &mtk_disp_postmask_driver,
>         &mtk_disp_rdma_driver,
>         &mtk_dpi_driver,
>         &mtk_drm_platform_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
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
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
