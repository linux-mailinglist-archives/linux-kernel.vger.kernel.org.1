Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED452F400D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbhALXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbhALXQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:16:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B2D23136;
        Tue, 12 Jan 2021 23:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610493327;
        bh=Kfe3ePyRQYamOKH0MzwuBPRzrCfC0mYeRWq/Qn6sTCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UkM2VeEKE2musTkbRa32Kiqvptkt22CmAb2rrV2hF0o1FDuCjGCIdRjg+lXcdICOy
         BccNvB6dO2FRj8/GQ4kijwYF4+aIMbwh07mRKPYoQPYCHZRdP5QwgfVz992dzHgphg
         XD51ZoHRA+2MbdNvhGgbs0lM6IjpIjUhh0NfHxR7Pc8NtyBAOG1Fr7n1593sDaAIow
         syc+8pUtctk4vJoD8yL5hwNhzQi0JduLHJUhbPJ36dlL2Vh7lM8mYN00UYYyefgG/s
         aFJegY8I8EtELxTcqrr8Tj91vQfM22k4esB4SZ+pG3XmcWDn3kUyazQHHwj5SpSoOG
         OXd1aABb38/AA==
Received: by mail-ed1-f52.google.com with SMTP id p22so4235673edu.11;
        Tue, 12 Jan 2021 15:15:26 -0800 (PST)
X-Gm-Message-State: AOAM531pofEif9jsyYCBAO7f4srDuGkt3wsyeOC/tgPTrGtfufd0xXzW
        kMUMUPb/t9AffEzIUTSmJLGRIgm9EYpUIlduMg==
X-Google-Smtp-Source: ABdhPJwq7DBstHCJUv2h0+aFMkDmOTI3eUQpCe+FkwRdLSq7fjfQ4ONJfp6Rm8Bh3qzmgWwisnL0ToyyrV1FyWoDaKk=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr1170614edw.303.1610493325025;
 Tue, 12 Jan 2021 15:15:25 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-13-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-13-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 13 Jan 2021 07:15:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9rKn-peTWg0mL+0guv=5EQj2tLWdpWMdVMRaAJ4sDdMw@mail.gmail.com>
Message-ID: <CAAOTY_9rKn-peTWg0mL+0guv=5EQj2tLWdpWMdVMRaAJ4sDdMw@mail.gmail.com>
Subject: Re: [PATCH v3, 12/15] drm/mediatek: separate ccorr module
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
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> ccorr ctm matrix bits will be different in mt8192

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
>  drivers/gpu/drm/mediatek/Makefile           |   3 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c   | 222 ++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  92 +-----------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   8 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  5 files changed, 231 insertions(+), 95 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index ce5ad59..a02f534 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -mediatek-drm-y :=3D mtk_disp_color.o \
> +mediatek-drm-y :=3D mtk_disp_ccorr.o \
> +                 mtk_disp_color.o \
>                   mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
>                   mtk_disp_postmask.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ccorr.c
> new file mode 100644
> index 0000000..63b3ef6
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -0,0 +1,222 @@
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
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#include "mtk_drm_crtc.h"
> +#include "mtk_drm_ddp_comp.h"
> +
> +#define DISP_CCORR_EN                          0x0000
> +#define CCORR_EN                                       BIT(0)
> +#define DISP_CCORR_CFG                         0x0020
> +#define CCORR_RELAY_MODE                               BIT(0)
> +#define CCORR_ENGINE_EN                                        BIT(1)
> +#define CCORR_GAMMA_OFF                                        BIT(2)
> +#define CCORR_WGAMUT_SRC_CLIP                          BIT(3)
> +#define DISP_CCORR_SIZE                                0x0030
> +#define DISP_CCORR_COEF_0                      0x0080
> +#define DISP_CCORR_COEF_1                      0x0084
> +#define DISP_CCORR_COEF_2                      0x0088
> +#define DISP_CCORR_COEF_3                      0x008C
> +#define DISP_CCORR_COEF_4                      0x0090
> +
> +struct mtk_disp_ccorr_data {
> +       u32 reserved;
> +};
> +
> +/**
> + * struct mtk_disp_ccorr - DISP_CCORR driver structure
> + * @ddp_comp - structure containing type enum and hardware resources
> + * @crtc - associated crtc to report irq events to
> + */
> +struct mtk_disp_ccorr {
> +       struct mtk_ddp_comp                     ddp_comp;
> +       const struct mtk_disp_ccorr_data        *data;
> +};
> +
> +static inline struct mtk_disp_ccorr *comp_to_ccorr(struct mtk_ddp_comp *=
comp)
> +{
> +       return container_of(comp, struct mtk_disp_ccorr, ddp_comp);
> +}
> +
> +static void mtk_ccorr_config(struct mtk_ddp_comp *comp, unsigned int w,
> +                            unsigned int h, unsigned int vrefresh,
> +                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_CCORR_SIZE);
> +       mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, comp, DISP_CCORR_CFG);
> +}
> +
> +static void mtk_ccorr_start(struct mtk_ddp_comp *comp)
> +{
> +       writel(CCORR_EN, comp->regs + DISP_CCORR_EN);
> +}
> +
> +static void mtk_ccorr_stop(struct mtk_ddp_comp *comp)
> +{
> +       writel_relaxed(0x0, comp->regs + DISP_CCORR_EN);
> +}
> +
> +/* Converts a DRM S31.32 value to the HW S1.10 format. */
> +static u16 mtk_ctm_s31_32_to_s1_10(u64 in)
> +{
> +       u16 r;
> +
> +       /* Sign bit. */
> +       r =3D in & BIT_ULL(63) ? BIT(11) : 0;
> +
> +       if ((in & GENMASK_ULL(62, 33)) > 0) {
> +               /* identity value 0x100000000 -> 0x400, */
> +               /* if bigger this, set it to max 0x7ff. */
> +               r |=3D GENMASK(10, 0);
> +       } else {
> +               /* take the 11 most important bits. */
> +               r |=3D (in >> 22) & GENMASK(10, 0);
> +       }
> +
> +       return r;
> +}
> +
> +static void mtk_ccorr_ctm_set(struct mtk_ddp_comp *comp,
> +                             struct drm_crtc_state *state)
> +{
> +       struct drm_property_blob *blob =3D state->ctm;
> +       struct drm_color_ctm *ctm;
> +       const u64 *input;
> +       uint16_t coeffs[9] =3D { 0 };
> +       int i;
> +       struct cmdq_pkt *cmdq_pkt =3D NULL;
> +
> +       if (!blob)
> +               return;
> +
> +       ctm =3D (struct drm_color_ctm *)blob->data;
> +       input =3D ctm->matrix;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(coeffs); i++)
> +               coeffs[i] =3D mtk_ctm_s31_32_to_s1_10(input[i]);
> +
> +       mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
> +                     comp, DISP_CCORR_COEF_0);
> +       mtk_ddp_write(cmdq_pkt, coeffs[2] << 16 | coeffs[3],
> +                     comp, DISP_CCORR_COEF_1);
> +       mtk_ddp_write(cmdq_pkt, coeffs[4] << 16 | coeffs[5],
> +                     comp, DISP_CCORR_COEF_2);
> +       mtk_ddp_write(cmdq_pkt, coeffs[6] << 16 | coeffs[7],
> +                     comp, DISP_CCORR_COEF_3);
> +       mtk_ddp_write(cmdq_pkt, coeffs[8] << 16,
> +                     comp, DISP_CCORR_COEF_4);
> +}
> +
> +static const struct mtk_ddp_comp_funcs mtk_disp_ccorr_funcs =3D {
> +       .config =3D mtk_ccorr_config,
> +       .start =3D mtk_ccorr_start,
> +       .stop =3D mtk_ccorr_stop,
> +       .ctm_set =3D mtk_ccorr_ctm_set,
> +};
> +
> +static int mtk_disp_ccorr_bind(struct device *dev, struct device *master=
,
> +                              void *data)
> +{
> +       struct mtk_disp_ccorr *priv =3D dev_get_drvdata(dev);
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
> +static void mtk_disp_ccorr_unbind(struct device *dev, struct device *mas=
ter,
> +                                 void *data)
> +{
> +       struct mtk_disp_ccorr *priv =3D dev_get_drvdata(dev);
> +       struct drm_device *drm_dev =3D data;
> +
> +       mtk_ddp_comp_unregister(drm_dev, &priv->ddp_comp);
> +}
> +
> +static const struct component_ops mtk_disp_ccorr_component_ops =3D {
> +       .bind   =3D mtk_disp_ccorr_bind,
> +       .unbind =3D mtk_disp_ccorr_unbind,
> +};
> +
> +static int mtk_disp_ccorr_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mtk_disp_ccorr *priv;
> +       int comp_id;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       comp_id =3D mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_CCORR);
> +       if (comp_id < 0) {
> +               dev_err(dev, "Failed to identify by alias: %d\n", comp_id=
);
> +               return comp_id;
> +       }
> +
> +       ret =3D mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, com=
p_id,
> +                               &mtk_disp_ccorr_funcs);
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
> +       ret =3D component_add(dev, &mtk_disp_ccorr_component_ops);
> +       if (ret)
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_ccorr_remove(struct platform_device *pdev)
> +{
> +       pm_runtime_disable(&pdev->dev);
> +
> +       component_del(&pdev->dev, &mtk_disp_ccorr_component_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8183-disp-ccorr"},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
> +
> +struct platform_driver mtk_disp_ccorr_driver =3D {
> +       .probe          =3D mtk_disp_ccorr_probe,
> +       .remove         =3D mtk_disp_ccorr_remove,
> +       .driver         =3D {
> +               .name   =3D "mediatek-disp-ccorr",
> +               .owner  =3D THIS_MODULE,
> +               .of_match_table =3D mtk_disp_ccorr_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 6081800..bb7893d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -35,20 +35,6 @@
>  #define DISP_AAL_EN                            0x0000
>  #define DISP_AAL_SIZE                          0x0030
>
> -#define DISP_CCORR_EN                          0x0000
> -#define CCORR_EN                               BIT(0)
> -#define DISP_CCORR_CFG                         0x0020
> -#define CCORR_RELAY_MODE                       BIT(0)
> -#define CCORR_ENGINE_EN                                BIT(1)
> -#define CCORR_GAMMA_OFF                                BIT(2)
> -#define CCORR_WGAMUT_SRC_CLIP                  BIT(3)
> -#define DISP_CCORR_SIZE                                0x0030
> -#define DISP_CCORR_COEF_0                      0x0080
> -#define DISP_CCORR_COEF_1                      0x0084
> -#define DISP_CCORR_COEF_2                      0x0088
> -#define DISP_CCORR_COEF_3                      0x008C
> -#define DISP_CCORR_COEF_4                      0x0090
> -
>  #define DISP_DITHER_EN                         0x0000
>  #define DITHER_EN                              BIT(0)
>  #define DISP_DITHER_CFG                                0x0020
> @@ -187,75 +173,6 @@ static void mtk_aal_stop(struct mtk_ddp_comp *comp)
>         writel_relaxed(0x0, comp->regs + DISP_AAL_EN);
>  }
>
> -static void mtk_ccorr_config(struct mtk_ddp_comp *comp, unsigned int w,
> -                            unsigned int h, unsigned int vrefresh,
> -                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> -{
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_CCORR_SIZE);
> -       mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, comp, DISP_CCORR_CFG);
> -}
> -
> -static void mtk_ccorr_start(struct mtk_ddp_comp *comp)
> -{
> -       writel(CCORR_EN, comp->regs + DISP_CCORR_EN);
> -}
> -
> -static void mtk_ccorr_stop(struct mtk_ddp_comp *comp)
> -{
> -       writel_relaxed(0x0, comp->regs + DISP_CCORR_EN);
> -}
> -
> -/* Converts a DRM S31.32 value to the HW S1.10 format. */
> -static u16 mtk_ctm_s31_32_to_s1_10(u64 in)
> -{
> -       u16 r;
> -
> -       /* Sign bit. */
> -       r =3D in & BIT_ULL(63) ? BIT(11) : 0;
> -
> -       if ((in & GENMASK_ULL(62, 33)) > 0) {
> -               /* identity value 0x100000000 -> 0x400, */
> -               /* if bigger this, set it to max 0x7ff. */
> -               r |=3D GENMASK(10, 0);
> -       } else {
> -               /* take the 11 most important bits. */
> -               r |=3D (in >> 22) & GENMASK(10, 0);
> -       }
> -
> -       return r;
> -}
> -
> -static void mtk_ccorr_ctm_set(struct mtk_ddp_comp *comp,
> -                             struct drm_crtc_state *state)
> -{
> -       struct drm_property_blob *blob =3D state->ctm;
> -       struct drm_color_ctm *ctm;
> -       const u64 *input;
> -       uint16_t coeffs[9] =3D { 0 };
> -       int i;
> -       struct cmdq_pkt *cmdq_pkt =3D NULL;
> -
> -       if (!blob)
> -               return;
> -
> -       ctm =3D (struct drm_color_ctm *)blob->data;
> -       input =3D ctm->matrix;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(coeffs); i++)
> -               coeffs[i] =3D mtk_ctm_s31_32_to_s1_10(input[i]);
> -
> -       mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
> -                     comp, DISP_CCORR_COEF_0);
> -       mtk_ddp_write(cmdq_pkt, coeffs[2] << 16 | coeffs[3],
> -                     comp, DISP_CCORR_COEF_1);
> -       mtk_ddp_write(cmdq_pkt, coeffs[4] << 16 | coeffs[5],
> -                     comp, DISP_CCORR_COEF_2);
> -       mtk_ddp_write(cmdq_pkt, coeffs[6] << 16 | coeffs[7],
> -                     comp, DISP_CCORR_COEF_3);
> -       mtk_ddp_write(cmdq_pkt, coeffs[8] << 16,
> -                     comp, DISP_CCORR_COEF_4);
> -}
> -
>  static void mtk_dither_config(struct mtk_ddp_comp *comp, unsigned int w,
>                               unsigned int h, unsigned int vrefresh,
>                               unsigned int bpc, struct cmdq_pkt *cmdq_pkt=
)
> @@ -315,13 +232,6 @@ static void mtk_dither_stop(struct mtk_ddp_comp *com=
p)
>         .stop =3D mtk_aal_stop,
>  };
>
> -static const struct mtk_ddp_comp_funcs ddp_ccorr =3D {
> -       .config =3D mtk_ccorr_config,
> -       .start =3D mtk_ccorr_start,
> -       .stop =3D mtk_ccorr_stop,
> -       .ctm_set =3D mtk_ccorr_ctm_set,
> -};
> -
>  static const struct mtk_ddp_comp_funcs ddp_dither =3D {
>         .config =3D mtk_dither_config,
>         .start =3D mtk_dither_start,
> @@ -367,7 +277,7 @@ struct mtk_ddp_comp_match {
>         [DDP_COMPONENT_AAL0]    =3D { MTK_DISP_AAL,       0, &ddp_aal },
>         [DDP_COMPONENT_AAL1]    =3D { MTK_DISP_AAL,       1, &ddp_aal },
>         [DDP_COMPONENT_BLS]     =3D { MTK_DISP_BLS,       0, NULL },
> -       [DDP_COMPONENT_CCORR]   =3D { MTK_DISP_CCORR,     0, &ddp_ccorr }=
,
> +       [DDP_COMPONENT_CCORR]   =3D { MTK_DISP_CCORR,     0, NULL },
>         [DDP_COMPONENT_COLOR0]  =3D { MTK_DISP_COLOR,     0, NULL },
>         [DDP_COMPONENT_COLOR1]  =3D { MTK_DISP_COLOR,     1, NULL },
>         [DDP_COMPONENT_DITHER]  =3D { MTK_DISP_DITHER,    0, &ddp_dither =
},
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index bc205e9..79e86f7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -533,11 +533,12 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                 private->comp_node[comp_id] =3D of_node_get(node);
>
>                 /*
> -                * Currently only the COLOR, GAMMA, OVL, POSTMASK, RDMA, =
DSI, and DPI blocks have
> -                * separate component platform drivers and initialize the=
ir own
> +                * Currently only the CCORR, COLOR, GAMMA, OVL, POSTMASK,=
 RDMA, DSI, and DPI
> +                * blocks have separate component platform drivers and in=
itialize their own
>                  * DDP component structure. The others are initialized he=
re.
>                  */
> -               if (comp_type =3D=3D MTK_DISP_COLOR ||
> +               if (comp_type =3D=3D MTK_DISP_CCORR ||
> +                   comp_type =3D=3D MTK_DISP_COLOR ||
>                     comp_type =3D=3D MTK_DISP_GAMMA ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
> @@ -652,6 +653,7 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_=
suspend,
>
>  static struct platform_driver * const mtk_drm_drivers[] =3D {
>         &mtk_ddp_driver,
> +       &mtk_disp_ccorr_driver,
>         &mtk_disp_color_driver,
>         &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index 8a9544b..e20a0e8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -47,6 +47,7 @@ struct mtk_drm_private {
>  };
>
>  extern struct platform_driver mtk_ddp_driver;
> +extern struct platform_driver mtk_disp_ccorr_driver;
>  extern struct platform_driver mtk_disp_color_driver;
>  extern struct platform_driver mtk_disp_gamma_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
