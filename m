Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202A02972E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464109AbgJWPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372857AbgJWPwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:52:35 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2082622254;
        Fri, 23 Oct 2020 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603468354;
        bh=UqiBU0IVvWwjw9aBiH3MdRxRMS7aPSW9F28A6auwWrw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Z9HFPN5Sdtl8JKgP0G+XrSnC/XWCPYRk4Io18Rushg4Xmc+W0iehTMl+pKbrVPHA
         k0NjI9+KxNUs4zfaDHtf/1lzU/F40I2N0WifVGvfPr8e8U1UUQPW/8IDOqyu2H6Tpd
         nilIplOCJEIFLg5h5B5lOgQxrd5FRRxshtw9lLgE=
Received: by mail-ed1-f46.google.com with SMTP id w23so2024739edl.0;
        Fri, 23 Oct 2020 08:52:34 -0700 (PDT)
X-Gm-Message-State: AOAM532Ay6Aod0syBpnU/U08yBQw7OHLZWqk4UhZ8RkE8rqKNqWjRCRg
        OmlfXN8yHhRkzssFvaZQvdrKi01RT3YNbiKFwg==
X-Google-Smtp-Source: ABdhPJzdmjU4HyJf9LFyBtcFyE62bogi7FwJWjjwCC3gI5A4C6dnpOf0hsr+qjEfhYN883OsWlCNT6Z2X0GSz/vFEt8=
X-Received: by 2002:a05:6402:c12:: with SMTP id co18mr2757331edb.162.1603468352366;
 Fri, 23 Oct 2020 08:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-6-fparent@baylibre.com>
In-Reply-To: <20201023133130.194140-6-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 23 Oct 2020 23:52:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8ZgoQJFnEDDZ=JCy-3zLwn7yjk1EHVYgeSG2ufLxK04g@mail.gmail.com>
Message-ID: <CAAOTY_8ZgoQJFnEDDZ=JCy-3zLwn7yjk1EHVYgeSG2ufLxK04g@mail.gmail.com>
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

This patch looks good to me, but it depend on another patch which
define the compatible "mediatek,mt8167-mmsys". Where is that patch?

Regards,
Chun-Kuang.

> +         .data =3D &mt8167_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8173-mmsys",
>           .data =3D &mt8173_mmsys_driver_data},
>         { }
> --
> 2.28.0
>
