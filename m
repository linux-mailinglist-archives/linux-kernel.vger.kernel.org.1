Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2572D776A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbgLKOGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391755AbgLKOFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:05:32 -0500
X-Gm-Message-State: AOAM533Nq+G+LoQgWpd280agdzhOWB2FpDIUgk68rXPa4rhmSfydoB7g
        RLa4dhzFSRnDoWEP306IAYBBdflF+7Wc3zKpsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607695491;
        bh=es6fVWW1Xi0bIgwukRYW6eN8WCU8aY4WzaCmTH11tlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cmj8IDjnQExrgq6HqlljhAClfXwNIVIPq+rP2vQkvDiIsh3n0Ao/f79F3NUs3qjJv
         LQt7oPodOq18l0z7InPUWFBEe2dY3oAoF877KDkncLXExOC7ZzgfnPkhJNziHWDcbf
         d+g7AcJeaGVrjogmfWvOT6VQ99OYX52wvmFtlNi7Ui/9MNzlv8FE21f6i8CmH84OIt
         CG9GpTIpsYnxiUtp1ZIekfq0K8PfmgJKrO9lAyxr56DwYu4EjUiIXre3d5VZXxK+Q5
         h8fRXzk7i5W5D4C4EuFuIRhQIvz/dW5EyUfj9udChv9EJkPh4QmJAlPggMxamx7ARN
         9QGeOAPTwp+EQ==
X-Google-Smtp-Source: ABdhPJw5D3l7fxlDhHH3ICdRLnDzMkC5Nxb+eP5iE8M2onyZxtW9cChVThBS7p1VgDwSG8vMR0IP/s6Yg7dy61rQB1Y=
X-Received: by 2002:a05:6402:845:: with SMTP id b5mr12134678edz.38.1607695489475;
 Fri, 11 Dec 2020 06:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20201203082445.1342763-1-hsinyi@chromium.org>
In-Reply-To: <20201203082445.1342763-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 11 Dec 2020 22:04:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY__+FHHd6Coa9HDvS_e7Q7dD3gZm7FBbhymOR2w2-i8i4w@mail.gmail.com>
Message-ID: <CAAOTY__+FHHd6Coa9HDvS_e7Q7dD3gZm7FBbhymOR2w2-i8i4w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_dpi: Create connector for bridges
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=883=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Similar to a9d9fea74be2 ("drm/mediatek: mtk_dsi: Create connector for bri=
dges"):
>
> Use the drm_bridge_connector helper to create a connector for pipelines
> that use drm_bridge. This allows splitting connector operations across
> multiple bridges when necessary, instead of having the last bridge in
> the chain creating the connector and handling all connector operations
> internally.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 52f11a63a330..189377e342fa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -20,6 +20,7 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_simple_kms_helper.h>
> @@ -66,6 +67,7 @@ struct mtk_dpi {
>         struct drm_encoder encoder;
>         struct drm_bridge bridge;
>         struct drm_bridge *next_bridge;
> +       struct drm_connector *connector;
>         void __iomem *regs;
>         struct device *dev;
>         struct clk *engine_clk;
> @@ -603,12 +605,21 @@ static int mtk_dpi_bind(struct device *dev, struct =
device *master, void *data)
>
>         dpi->encoder.possible_crtcs =3D mtk_drm_find_possible_crtc_by_com=
p(drm_dev, dpi->ddp_comp);
>
> -       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, 0);
> +       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL,
> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>         if (ret) {
>                 dev_err(dev, "Failed to attach bridge: %d\n", ret);
>                 goto err_cleanup;
>         }
>
> +       dpi->connector =3D drm_bridge_connector_init(drm_dev, &dpi->encod=
er);
> +       if (IS_ERR(dpi->connector)) {
> +               dev_err(dev, "Unable to create bridge connector\n");
> +               ret =3D PTR_ERR(dpi->connector);
> +               goto err_cleanup;
> +       }
> +       drm_connector_attach_encoder(dpi->connector, &dpi->encoder);
> +
>         dpi->bit_num =3D MTK_DPI_OUT_BIT_NUM_8BITS;
>         dpi->channel_swap =3D MTK_DPI_OUT_CHANNEL_SWAP_RGB;
>         dpi->yc_map =3D MTK_DPI_OUT_YC_MAP_RGB;
> --
> 2.29.2.576.ga3fc446d84-goog
>
