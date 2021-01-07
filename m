Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D192ECDBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAGK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbhAGK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:26:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B893B2333E;
        Thu,  7 Jan 2021 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610015128;
        bh=lrVNmjK/AZCpYBgu0dgdNTPyw20HiS8UxKhqGUFg0Zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FFECKUGzMPj8u6PIm2izCz3Ka74m3qfvpdUi56g+TItkwlg+892Uz1lpBB1KMK0yw
         Pj9LqrNUu6YtPJUVBZg2d/IhhT85KHtdDRLRA7BHYmOanFmaogYIwFxsPfGn9qqHUv
         70BTgddr7bUHpxmoDU7qiSpgnsA7U66mroLgxLeotsoezpKCKFuYlyQQWe7H/jVp+O
         GH5oBFX4VOkwwLn2cE0OllTiLrGlRZInVDECfOPYpHR3XqAjCb1HqpH1oEFHN5uW+o
         +TYLk6qJRG/SLULr0PS477VxZB7lHs09a8KA1e33XmqizSxTOKAuxaDsy3z4RP1eqQ
         Tga/UhPjc/ebA==
Received: by mail-ej1-f42.google.com with SMTP id t16so8870194ejf.13;
        Thu, 07 Jan 2021 02:25:27 -0800 (PST)
X-Gm-Message-State: AOAM532LlEcvpaMy82QoDRvZMfn84ARFx7KotxZop2fb/ADFHDSh39Yn
        /MZ/XFGXHxAjKaQup6ZhDHCZL6HiFE8rdwaqSA==
X-Google-Smtp-Source: ABdhPJwL9jsIf4Ymk01C8MtZet4m2qZAn1gdbr/wPxCWbP4RsApk74NMiO4zHAq/rtky13ceLXZNKxezz9A/o7fXGHE=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr5842777ejy.63.1610015126143;
 Thu, 07 Jan 2021 02:25:26 -0800 (PST)
MIME-Version: 1.0
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com> <1609989081-29353-8-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609989081-29353-8-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 7 Jan 2021 18:25:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Gt1Pd-qm0gwdMqmiWSn6v46J8cBirU7rR+6R-LH3KGQ@mail.gmail.com>
Message-ID: <CAAOTY_9Gt1Pd-qm0gwdMqmiWSn6v46J8cBirU7rR+6R-LH3KGQ@mail.gmail.com>
Subject: Re: [PATCH v9, 07/11] drm/mediatek: separate gamma module
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
=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> mt8183 gamma module will different with mt8173
> separate gamma for add private data

I've applied series "Decouple Mediatek DRM sub driver" [1] into
mediatek-drm-next [2] and this patch would conflict with
mediatek-drm-next, so please rebase this series onto
mediatek-drm-next.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D3999=
15
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 185 ++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  58 +--------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  6 files changed, 192 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index a892ede..17a08e2 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  mediatek-drm-y :=3D mtk_disp_color.o \
> +                 mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
>                   mtk_disp_rdma.o \
>                   mtk_drm_crtc.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> new file mode 100644
> index 0000000..8501821
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -0,0 +1,185 @@
> +/*
> + * SPDX-License-Identifier:
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#include "mtk_drm_crtc.h"
> +#include "mtk_drm_ddp_comp.h"
> +
> +#define DISP_GAMMA_EN                          0x0000
> +#define GAMMA_EN                                       BIT(0)
> +#define DISP_GAMMA_CFG                         0x0020
> +#define GAMMA_LUT_EN                                   BIT(1)
> +#define DISP_GAMMA_SIZE                                0x0030
> +#define DISP_GAMMA_LUT                         0x0700
> +
> +#define LUT_10BIT_MASK                         0x03ff
> +
> +struct mtk_disp_gamma_data {
> +       u32 reserved;
> +};
> +
> +/**
> + * struct mtk_disp_gamma - DISP_GAMMA driver structure
> + * @ddp_comp - structure containing type enum and hardware resources
> + * @crtc - associated crtc to report irq events to
> + */
> +struct mtk_disp_gamma {
> +       struct mtk_ddp_comp                     ddp_comp;
> +       const struct mtk_disp_gamma_data        *data;
> +};
> +
> +static inline struct mtk_disp_gamma *comp_to_gamma(struct mtk_ddp_comp *=
comp)
> +{
> +       return container_of(comp, struct mtk_disp_gamma, ddp_comp);
> +}
> +
> +void mtk_gamma_set(struct mtk_ddp_comp *comp, struct drm_crtc_state *sta=
te)
> +{
> +       unsigned int i, reg;
> +       struct drm_color_lut *lut;
> +       void __iomem *lut_base;
> +       u32 word;
> +
> +       if (state->gamma_lut) {
> +               reg =3D readl(comp->regs + DISP_GAMMA_CFG);
> +               reg =3D reg | GAMMA_LUT_EN;
> +               writel(reg, comp->regs + DISP_GAMMA_CFG);
> +               lut_base =3D comp->regs + DISP_GAMMA_LUT;
> +               lut =3D (struct drm_color_lut *)state->gamma_lut->data;
> +               for (i =3D 0; i < MTK_LUT_SIZE; i++) {
> +                       word =3D (((lut[i].red >> 6) & LUT_10BIT_MASK) <<=
 20) +
> +                               (((lut[i].green >> 6) & LUT_10BIT_MASK) <=
< 10) +
> +                               ((lut[i].blue >> 6) & LUT_10BIT_MASK);
> +                       writel(word, (lut_base + i * 4));
> +               }
> +       }
> +}
> +
> +static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
> +                            unsigned int h, unsigned int vrefresh,
> +                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_disp_gamma *gamma =3D comp_to_gamma(comp);
> +
> +       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_GAMMA_SIZE);
> +
> +       mtk_dither_set(comp, bpc, DISP_GAMMA_CFG, cmdq_pkt);
> +}
> +
> +static void mtk_gamma_start(struct mtk_ddp_comp *comp)
> +{
> +       writel(GAMMA_EN, comp->regs  + DISP_GAMMA_EN);
> +}
> +
> +static void mtk_gamma_stop(struct mtk_ddp_comp *comp)
> +{
> +       writel_relaxed(0x0, comp->regs + DISP_GAMMA_EN);
> +}
> +
> +static const struct mtk_ddp_comp_funcs mtk_disp_gamma_funcs =3D {
> +       .gamma_set =3D mtk_gamma_set,
> +       .config =3D mtk_gamma_config,
> +       .start =3D mtk_gamma_start,
> +       .stop =3D mtk_gamma_stop,
> +};
> +
> +static int mtk_disp_gamma_bind(struct device *dev, struct device *master=
,
> +                              void *data)
> +{
> +       struct mtk_disp_gamma *priv =3D dev_get_drvdata(dev);
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
> +static void mtk_disp_gamma_unbind(struct device *dev, struct device *mas=
ter,
> +                                 void *data)
> +{
> +       struct mtk_disp_gamma *priv =3D dev_get_drvdata(dev);
> +       struct drm_device *drm_dev =3D data;
> +
> +       mtk_ddp_comp_unregister(drm_dev, &priv->ddp_comp);
> +}
> +
> +static const struct component_ops mtk_disp_gamma_component_ops =3D {
> +       .bind   =3D mtk_disp_gamma_bind,
> +       .unbind =3D mtk_disp_gamma_unbind,
> +};
> +
> +static int mtk_disp_gamma_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mtk_disp_gamma *priv;
> +       int comp_id;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       comp_id =3D mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_GAMMA);
> +       if (comp_id < 0) {
> +               dev_err(dev, "Failed to identify by alias: %d\n", comp_id=
);
> +               return comp_id;
> +       }
> +
> +       ret =3D mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, com=
p_id,
> +                               &mtk_disp_gamma_funcs);
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
> +       ret =3D component_add(dev, &mtk_disp_gamma_component_ops);
> +       if (ret)
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_gamma_remove(struct platform_device *pdev)
> +{
> +       component_del(&pdev->dev, &mtk_disp_gamma_component_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_disp_gamma_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8173-disp-gamma"},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
> +
> +struct platform_driver mtk_disp_gamma_driver =3D {
> +       .probe          =3D mtk_disp_gamma_probe,
> +       .remove         =3D mtk_disp_gamma_remove,
> +       .driver         =3D {
> +               .name   =3D "mediatek-disp-gamma",
> +               .owner  =3D THIS_MODULE,
> +               .of_match_table =3D mtk_disp_gamma_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 3064eac..03589c9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -55,11 +55,6 @@
>  #define DITHER_RELAY_MODE                      BIT(0)
>  #define DISP_DITHER_SIZE                       0x0030
>
> -#define DISP_GAMMA_EN                          0x0000
> -#define DISP_GAMMA_CFG                         0x0020
> -#define DISP_GAMMA_SIZE                                0x0030
> -#define DISP_GAMMA_LUT                         0x0700
> -
>  #define LUT_10BIT_MASK                         0x03ff
>
>  #define OD_RELAYMODE                           BIT(0)
> @@ -68,9 +63,6 @@
>
>  #define AAL_EN                                 BIT(0)
>
> -#define GAMMA_EN                               BIT(0)
> -#define GAMMA_LUT_EN                           BIT(1)
> -
>  #define DISP_DITHERING                         BIT(2)
>  #define DITHER_LSB_ERR_SHIFT_R(x)              (((x) & 0x7) << 28)
>  #define DITHER_OVFLW_BIT_R(x)                  (((x) & 0x7) << 24)
> @@ -280,47 +272,6 @@ static void mtk_dither_stop(struct mtk_ddp_comp *com=
p)
>         writel_relaxed(0x0, comp->regs + DISP_DITHER_EN);
>  }
>
> -static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
> -                            unsigned int h, unsigned int vrefresh,
> -                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> -{
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_GAMMA_SIZE);
> -       mtk_dither_set(comp, bpc, DISP_GAMMA_CFG, cmdq_pkt);
> -}
> -
> -static void mtk_gamma_start(struct mtk_ddp_comp *comp)
> -{
> -       writel(GAMMA_EN, comp->regs  + DISP_GAMMA_EN);
> -}
> -
> -static void mtk_gamma_stop(struct mtk_ddp_comp *comp)
> -{
> -       writel_relaxed(0x0, comp->regs  + DISP_GAMMA_EN);
> -}
> -
> -static void mtk_gamma_set(struct mtk_ddp_comp *comp,
> -                         struct drm_crtc_state *state)
> -{
> -       unsigned int i, reg;
> -       struct drm_color_lut *lut;
> -       void __iomem *lut_base;
> -       u32 word;
> -
> -       if (state->gamma_lut) {
> -               reg =3D readl(comp->regs + DISP_GAMMA_CFG);
> -               reg =3D reg | GAMMA_LUT_EN;
> -               writel(reg, comp->regs + DISP_GAMMA_CFG);
> -               lut_base =3D comp->regs + DISP_GAMMA_LUT;
> -               lut =3D (struct drm_color_lut *)state->gamma_lut->data;
> -               for (i =3D 0; i < MTK_LUT_SIZE; i++) {
> -                       word =3D (((lut[i].red >> 6) & LUT_10BIT_MASK) <<=
 20) +
> -                               (((lut[i].green >> 6) & LUT_10BIT_MASK) <=
< 10) +
> -                               ((lut[i].blue >> 6) & LUT_10BIT_MASK);
> -                       writel(word, (lut_base + i * 4));
> -               }
> -       }
> -}
> -
>  static const struct mtk_ddp_comp_funcs ddp_aal =3D {
>         .gamma_set =3D mtk_gamma_set,
>         .config =3D mtk_aal_config,
> @@ -341,13 +292,6 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>         .stop =3D mtk_dither_stop,
>  };
>
> -static const struct mtk_ddp_comp_funcs ddp_gamma =3D {
> -       .gamma_set =3D mtk_gamma_set,
> -       .config =3D mtk_gamma_config,
> -       .start =3D mtk_gamma_start,
> -       .stop =3D mtk_gamma_stop,
> -};
> -
>  static const struct mtk_ddp_comp_funcs ddp_od =3D {
>         .config =3D mtk_od_config,
>         .start =3D mtk_od_start,
> @@ -396,7 +340,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_DSI1]    =3D { MTK_DSI,            1, NULL },
>         [DDP_COMPONENT_DSI2]    =3D { MTK_DSI,            2, NULL },
>         [DDP_COMPONENT_DSI3]    =3D { MTK_DSI,            3, NULL },
> -       [DDP_COMPONENT_GAMMA]   =3D { MTK_DISP_GAMMA,     0, &ddp_gamma }=
,
> +       [DDP_COMPONENT_GAMMA]   =3D { MTK_DISP_GAMMA,     0, NULL },
>         [DDP_COMPONENT_OD0]     =3D { MTK_DISP_OD,        0, &ddp_od },
>         [DDP_COMPONENT_OD1]     =3D { MTK_DISP_OD,        1, &ddp_od },
>         [DDP_COMPONENT_OVL0]    =3D { MTK_DISP_OVL,       0, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index 5aa52b7..178fae9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -179,6 +179,7 @@ int mtk_ddp_comp_init(struct device *dev, struct devi=
ce_node *comp_node,
>  void mtk_ddp_comp_unregister(struct drm_device *drm, struct mtk_ddp_comp=
 *comp);
>  void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>                     unsigned int CFG, struct cmdq_pkt *cmdq_pkt);
> +void mtk_gamma_set(struct mtk_ddp_comp *comp, struct drm_crtc_state *sta=
te);
>  enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_i=
d);
>  void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
>                    struct mtk_ddp_comp *comp, unsigned int offset);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 2f717df..37fec25 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -488,11 +488,12 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                 private->comp_node[comp_id] =3D of_node_get(node);
>
>                 /*
> -                * Currently only the COLOR, OVL, RDMA, DSI, and DPI bloc=
ks have
> +                * Currently only the COLOR, GAMMA, OVL, RDMA, DSI, and D=
PI blocks have
>                  * separate component platform drivers and initialize the=
ir own
>                  * DDP component structure. The others are initialized he=
re.
>                  */
>                 if (comp_type =3D=3D MTK_DISP_COLOR ||
> +                   comp_type =3D=3D MTK_DISP_GAMMA ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
>                     comp_type =3D=3D MTK_DISP_RDMA ||
> @@ -606,6 +607,7 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_=
suspend,
>  static struct platform_driver * const mtk_drm_drivers[] =3D {
>         &mtk_ddp_driver,
>         &mtk_disp_color_driver,
> +       &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
>         &mtk_disp_rdma_driver,
>         &mtk_dpi_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index 5d771cf..bbd362b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -48,6 +48,7 @@ struct mtk_drm_private {
>
>  extern struct platform_driver mtk_ddp_driver;
>  extern struct platform_driver mtk_disp_color_driver;
> +extern struct platform_driver mtk_disp_gamma_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
>  extern struct platform_driver mtk_disp_rdma_driver;
>  extern struct platform_driver mtk_dpi_driver;
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
