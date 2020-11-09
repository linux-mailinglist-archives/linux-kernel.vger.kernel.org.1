Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8E2AC975
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgKIXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKIXk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:40:27 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275E72074F;
        Mon,  9 Nov 2020 23:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604965226;
        bh=HYbaJHkk7cdSoS3jVTRSnnUaEKctYjZ3NDHcRvYSXRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aDBEuSmf7uXSEoutBPzACdHRqDjPdgmNkS9iWP0WaIaXbcxnPWTElI1E3rSOzFmsf
         9S6VVH+SqIJ/1peSF1gE7aZpi/lYbZVvMpt2fE38MxljZiguKb1ERbBLVMrmDbehCe
         qg0hL3Fd7lNzhFSWPRpcRxqDwgQaPoSIeVHl6bYI=
Received: by mail-ed1-f47.google.com with SMTP id e18so10677487edy.6;
        Mon, 09 Nov 2020 15:40:26 -0800 (PST)
X-Gm-Message-State: AOAM532usca6MrSyEb3yz+JKfKzn2bPE0JOHoGYeaSgR1yEAttmx8RWe
        TEk/5wq3a2kOzkpxVDzsOD3dyP5fWFRmTtoUwQ==
X-Google-Smtp-Source: ABdhPJwMpHWBa17twiFTSrvsjpX1uPRPRaPfL/R7+B+M/B6lGR0vzIgVjxiXR1cJK4PUndcfFb4cV3+QodvnxSpzu1Y=
X-Received: by 2002:a50:f0d4:: with SMTP id a20mr18284639edm.303.1604965224630;
 Mon, 09 Nov 2020 15:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-6-fparent@baylibre.com>
In-Reply-To: <20201023133130.194140-6-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 10 Nov 2020 07:40:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY__w8p2=rVDnNhcn7cKBJ5rm5he+ZP6-crRBRGpiwTgWJA@mail.gmail.com>
Message-ID: <CAAOTY__w8p2=rVDnNhcn7cKBJ5rm5he+ZP6-crRBRGpiwTgWJA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/mediatek: Add support for main DDP path on MT8167
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add the main (DSI) drm display path for MT8167.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> Changelog:
>
> V2: No change
>
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 59c85c63b7cc..3952435093fe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -112,6 +112,17 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_thi=
rd[] =3D {
>         DDP_COMPONENT_PWM2,
>  };
>
> +static enum mtk_ddp_comp_id mt8167_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_DSI0,
> +};
> +
>  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] =3D {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_COLOR0,
> @@ -163,6 +174,11 @@ static const struct mtk_mmsys_driver_data mt8173_mms=
ys_driver_data =3D {
>         .ext_len =3D ARRAY_SIZE(mt8173_mtk_ddp_ext),
>  };
>
> +static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data =3D {
> +       .main_path =3D mt8167_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt8167_mtk_ddp_main),
> +};
> +
>  static int mtk_drm_kms_init(struct drm_device *drm)
>  {
>         struct mtk_drm_private *private =3D drm->dev_private;
> @@ -401,26 +417,42 @@ static const struct component_master_ops mtk_drm_op=
s =3D {
>  static const struct of_device_id mtk_ddp_comp_dt_ids[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
>           .data =3D (void *)MTK_DISP_OVL },
> +       { .compatible =3D "mediatek,mt8167-disp-ovl",
> +         .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt8173-disp-ovl",
>           .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
> +       { .compatible =3D "mediatek,mt8167-disp-rdma",
> +         .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-wdma",
>           .data =3D (void *)MTK_DISP_WDMA },
> +       { .compatible =3D "mediatek,mt8167-disp-ccorr",
> +         .data =3D (void *)MTK_DISP_CCORR },
>         { .compatible =3D "mediatek,mt2701-disp-color",
>           .data =3D (void *)MTK_DISP_COLOR },
> +       { .compatible =3D "mediatek,mt8167-disp-color",
> +         .data =3D (void *)MTK_DISP_COLOR },
>         { .compatible =3D "mediatek,mt8173-disp-color",
>           .data =3D (void *)MTK_DISP_COLOR },
> +       { .compatible =3D "mediatek,mt8167-disp-aal",
> +         .data =3D (void *)MTK_DISP_AAL},
>         { .compatible =3D "mediatek,mt8173-disp-aal",
>           .data =3D (void *)MTK_DISP_AAL},
> +       { .compatible =3D "mediatek,mt8167-disp-gamma",
> +         .data =3D (void *)MTK_DISP_GAMMA, },
>         { .compatible =3D "mediatek,mt8173-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
> +       { .compatible =3D "mediatek,mt8167-disp-dither",
> +         .data =3D (void *)MTK_DISP_DITHER },
>         { .compatible =3D "mediatek,mt8173-disp-ufoe",
>           .data =3D (void *)MTK_DISP_UFOE },
>         { .compatible =3D "mediatek,mt2701-dsi",
>           .data =3D (void *)MTK_DSI },
> +       { .compatible =3D "mediatek,mt8167-dsi",
> +         .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt8173-dsi",
>           .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt2701-dpi",
> @@ -431,10 +463,14 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2712-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8167-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8173-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2701-disp-pwm",
>           .data =3D (void *)MTK_DISP_BLS },
> +       { .compatible =3D "mediatek,mt8167-disp-pwm",
> +         .data =3D (void *)MTK_DISP_PWM },
>         { .compatible =3D "mediatek,mt8173-disp-pwm",
>           .data =3D (void *)MTK_DISP_PWM },
>         { .compatible =3D "mediatek,mt8173-disp-od",
> @@ -449,6 +485,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt7623_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt2712-mmsys",
>           .data =3D &mt2712_mmsys_driver_data},
> +       { .compatible =3D "mediatek,mt8167-mmsys",
> +         .data =3D &mt8167_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8173-mmsys",
>           .data =3D &mt8173_mmsys_driver_data},
>         { }
> --
> 2.28.0
>
