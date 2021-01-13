Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBA2F56EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbhANBzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbhAMXuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:50:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62E07233FC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610581746;
        bh=Smp7CBcsbwTpztK0DhWsbG+PGWv9mq20lRCePwZJocM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UO7fzeItexglalq9gLqMO12U3TTA56lXYBM+GJRkxiBvhlnj8MscCgPfbc87JGjWr
         92I7ndM5YUB+GzlXAljk4nFnQSb+qOJTNMjABim8T/FlvqaPa02DqyHXd+wiYOtwtQ
         PT5YPPpuPJ7JX7gbFnisXUMfP5xs40qhYE5puctsvYGw+URACccJhk0+ACxVtZdg2W
         gMLS9cXtl7hYYZ8t60LYWeOyfxITEVSPhOjH9+lpRkAKQAXJ9paupmxTa/33aKC2Gy
         ZSaHQhJH4oSDVfgNbBZ7FbSD/2D/bV2o5tp4GSPnS3DeB/JWWqVPIZaP61vSYHzPYE
         qiEuwzcFOSGQg==
Received: by mail-wm1-f50.google.com with SMTP id 190so3065421wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:49:06 -0800 (PST)
X-Gm-Message-State: AOAM531I9dkQShgLKhydOVP2ZqPw5+aYNbM5IvQMQE++HDlA1GTWXnMq
        40XXbWpULzc/c21hIkGT+/TdAcOpil2hlXhk7Q==
X-Google-Smtp-Source: ABdhPJy8+DTEWUczkI17EVLxIUAVLLky1a8Ef6nLYa3ITeegi5pMpgXdPknlUvq+XI50gV49SMzrocSmwF4NuNm4Irw=
X-Received: by 2002:a05:600c:25c2:: with SMTP id 2mr1376818wml.170.1610581744920;
 Wed, 13 Jan 2021 15:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20201203082445.1342763-1-hsinyi@chromium.org> <CAAOTY__+FHHd6Coa9HDvS_e7Q7dD3gZm7FBbhymOR2w2-i8i4w@mail.gmail.com>
In-Reply-To: <CAAOTY__+FHHd6Coa9HDvS_e7Q7dD3gZm7FBbhymOR2w2-i8i4w@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 14 Jan 2021 07:48:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8eEgems8T-KJim--t5wCiPV8mEsqW3=HJa7tgEFuoezA@mail.gmail.com>
Message-ID: <CAAOTY_8eEgems8T-KJim--t5wCiPV8mEsqW3=HJa7tgEFuoezA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_dpi: Create connector for bridges
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=881=
1=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Hsin-Yi:
>
> Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=883=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:24=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Similar to a9d9fea74be2 ("drm/mediatek: mtk_dsi: Create connector for b=
ridges"):
> >
> > Use the drm_bridge_connector helper to create a connector for pipelines
> > that use drm_bridge. This allows splitting connector operations across
> > multiple bridges when necessary, instead of having the last bridge in
> > the chain creating the connector and handling all connector operations
> > internally.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 52f11a63a330..189377e342fa 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -20,6 +20,7 @@
> >
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_bridge_connector.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_simple_kms_helper.h>
> > @@ -66,6 +67,7 @@ struct mtk_dpi {
> >         struct drm_encoder encoder;
> >         struct drm_bridge bridge;
> >         struct drm_bridge *next_bridge;
> > +       struct drm_connector *connector;
> >         void __iomem *regs;
> >         struct device *dev;
> >         struct clk *engine_clk;
> > @@ -603,12 +605,21 @@ static int mtk_dpi_bind(struct device *dev, struc=
t device *master, void *data)
> >
> >         dpi->encoder.possible_crtcs =3D mtk_drm_find_possible_crtc_by_c=
omp(drm_dev, dpi->ddp_comp);
> >
> > -       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, 0)=
;
> > +       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL,
> > +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >         if (ret) {
> >                 dev_err(dev, "Failed to attach bridge: %d\n", ret);
> >                 goto err_cleanup;
> >         }
> >
> > +       dpi->connector =3D drm_bridge_connector_init(drm_dev, &dpi->enc=
oder);
> > +       if (IS_ERR(dpi->connector)) {
> > +               dev_err(dev, "Unable to create bridge connector\n");
> > +               ret =3D PTR_ERR(dpi->connector);
> > +               goto err_cleanup;
> > +       }
> > +       drm_connector_attach_encoder(dpi->connector, &dpi->encoder);
> > +
> >         dpi->bit_num =3D MTK_DPI_OUT_BIT_NUM_8BITS;
> >         dpi->channel_swap =3D MTK_DPI_OUT_CHANNEL_SWAP_RGB;
> >         dpi->yc_map =3D MTK_DPI_OUT_YC_MAP_RGB;
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
