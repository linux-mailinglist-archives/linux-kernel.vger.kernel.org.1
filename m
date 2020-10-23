Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9F2972BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbgJWPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463313AbgJWPpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:45:25 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED08024673;
        Fri, 23 Oct 2020 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603467923;
        bh=G6M/BTlJg0FbYXp3CDG9TBtlEGlMSzVeKa7vY6mNHfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WyvjvOvROY+IG+DfKhwK9L8oCSrnKk8bKt9/1GzuHrmsiYW+IiqOIMkw+qft9jms4
         rqUjOjdQu0Cbn9n/AHrl1OxN4dnOwY1ssJb51bdJJ0upNNWeBvDZL4ZUzD0AB7nnQ0
         XgRSBdI4tBdHgVU+jxaLBory2RAlvJ16a/tw6mIw=
Received: by mail-ed1-f51.google.com with SMTP id dn5so1970897edb.10;
        Fri, 23 Oct 2020 08:45:22 -0700 (PDT)
X-Gm-Message-State: AOAM530BoG3bfTXcTDYWJZ+nOSLWNqEyh0Pz/k3CeKnIjCYrU5V3SADg
        +xL1yGyaB972NCZIgu4OgMuKmTMOBSfvs6qDng==
X-Google-Smtp-Source: ABdhPJx0SUdWMn6Vo3xfJkuFhv02uNkzsQmCZ8hthB7UjShnrm6FmW8b0KoxznzvfpoL1Xhz7/ifyV9SXc3gShTo5t8=
X-Received: by 2002:aa7:c3ca:: with SMTP id l10mr2814992edr.72.1603467921215;
 Fri, 23 Oct 2020 08:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-5-fparent@baylibre.com>
In-Reply-To: <20201023133130.194140-5-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 23 Oct 2020 23:45:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9QWfrExsjSaeGtA6KGZYLyscuc76jdDjHwawd8y964hA@mail.gmail.com>
Message-ID: <CAAOTY_9QWfrExsjSaeGtA6KGZYLyscuc76jdDjHwawd8y964hA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/mediatek: add DDP support for MT8167
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
> Add DDP support for MT8167 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> Changelog:
>
> V2: don't set DDP_MUTEX_SOF_DSI{1,2,3} since they are not available on MT=
8167
>
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/med=
iatek/mtk_drm_ddp.c
> index 014c1bbe1df2..1f99db6b1a42 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -25,6 +25,19 @@
>
>  #define INT_MUTEX                              BIT(1)
>
> +#define MT8167_MUTEX_MOD_DISP_PWM              1
> +#define MT8167_MUTEX_MOD_DISP_OVL0             6
> +#define MT8167_MUTEX_MOD_DISP_OVL1             7
> +#define MT8167_MUTEX_MOD_DISP_RDMA0            8
> +#define MT8167_MUTEX_MOD_DISP_RDMA1            9
> +#define MT8167_MUTEX_MOD_DISP_WDMA0            10
> +#define MT8167_MUTEX_MOD_DISP_CCORR            11
> +#define MT8167_MUTEX_MOD_DISP_COLOR            12
> +#define MT8167_MUTEX_MOD_DISP_AAL              13
> +#define MT8167_MUTEX_MOD_DISP_GAMMA            14
> +#define MT8167_MUTEX_MOD_DISP_DITHER           15
> +#define MT8167_MUTEX_MOD_DISP_UFOE             16
> +
>  #define MT8173_MUTEX_MOD_DISP_OVL0             11
>  #define MT8173_MUTEX_MOD_DISP_OVL1             12
>  #define MT8173_MUTEX_MOD_DISP_RDMA0            13
> @@ -73,6 +86,8 @@
>  #define MUTEX_SOF_DPI1                 4
>  #define MUTEX_SOF_DSI2                 5
>  #define MUTEX_SOF_DSI3                 6
> +#define MT8167_MUTEX_SOF_DPI0          2
> +#define MT8167_MUTEX_SOF_DPI1          3
>
>
>  struct mtk_disp_mutex {
> @@ -135,6 +150,21 @@ static const unsigned int mt2712_mutex_mod[DDP_COMPO=
NENT_ID_MAX] =3D {
>         [DDP_COMPONENT_WDMA1] =3D MT2712_MUTEX_MOD_DISP_WDMA1,
>  };
>
> +static const unsigned int mt8167_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
> +       [DDP_COMPONENT_AAL0] =3D MT8167_MUTEX_MOD_DISP_AAL,
> +       [DDP_COMPONENT_CCORR] =3D MT8167_MUTEX_MOD_DISP_CCORR,
> +       [DDP_COMPONENT_COLOR0] =3D MT8167_MUTEX_MOD_DISP_COLOR,
> +       [DDP_COMPONENT_DITHER] =3D MT8167_MUTEX_MOD_DISP_DITHER,
> +       [DDP_COMPONENT_GAMMA] =3D MT8167_MUTEX_MOD_DISP_GAMMA,
> +       [DDP_COMPONENT_OVL0] =3D MT8167_MUTEX_MOD_DISP_OVL0,
> +       [DDP_COMPONENT_OVL1] =3D MT8167_MUTEX_MOD_DISP_OVL1,
> +       [DDP_COMPONENT_PWM0] =3D MT8167_MUTEX_MOD_DISP_PWM,
> +       [DDP_COMPONENT_RDMA0] =3D MT8167_MUTEX_MOD_DISP_RDMA0,
> +       [DDP_COMPONENT_RDMA1] =3D MT8167_MUTEX_MOD_DISP_RDMA1,
> +       [DDP_COMPONENT_UFOE] =3D MT8167_MUTEX_MOD_DISP_UFOE,
> +       [DDP_COMPONENT_WDMA0] =3D MT8167_MUTEX_MOD_DISP_WDMA0,
> +};
> +
>  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_AAL0] =3D MT8173_MUTEX_MOD_DISP_AAL,
>         [DDP_COMPONENT_COLOR0] =3D MT8173_MUTEX_MOD_DISP_COLOR0,
> @@ -163,6 +193,13 @@ static const unsigned int mt2712_mutex_sof[DDP_MUTEX=
_SOF_DSI3 + 1] =3D {
>         [DDP_MUTEX_SOF_DSI3] =3D MUTEX_SOF_DSI3,
>  };
>
> +static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =3D {
> +       [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
> +       [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0,
> +       [DDP_MUTEX_SOF_DPI0] =3D MT8167_MUTEX_SOF_DPI0,
> +       [DDP_MUTEX_SOF_DPI1] =3D MT8167_MUTEX_SOF_DPI1,
> +};
> +
>  static const struct mtk_ddp_data mt2701_ddp_driver_data =3D {
>         .mutex_mod =3D mt2701_mutex_mod,
>         .mutex_sof =3D mt2712_mutex_sof,
> @@ -177,6 +214,14 @@ static const struct mtk_ddp_data mt2712_ddp_driver_d=
ata =3D {
>         .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
>  };
>
> +static const struct mtk_ddp_data mt8167_ddp_driver_data =3D {
> +       .mutex_mod =3D mt8167_mutex_mod,
> +       .mutex_sof =3D mt8167_mutex_sof,
> +       .mutex_mod_reg =3D MT2701_DISP_MUTEX0_MOD0,
> +       .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
> +       .no_clk =3D true,
> +};
> +
>  static const struct mtk_ddp_data mt8173_ddp_driver_data =3D {
>         .mutex_mod =3D mt8173_mutex_mod,
>         .mutex_sof =3D mt2712_mutex_sof,
> @@ -400,6 +445,8 @@ static const struct of_device_id ddp_driver_dt_match[=
] =3D {
>           .data =3D &mt2701_ddp_driver_data},
>         { .compatible =3D "mediatek,mt2712-disp-mutex",
>           .data =3D &mt2712_ddp_driver_data},
> +       { .compatible =3D "mediatek,mt8167-disp-mutex",
> +         .data =3D &mt8167_ddp_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-mutex",
>           .data =3D &mt8173_ddp_driver_data},
>         {},
> --
> 2.28.0
>
