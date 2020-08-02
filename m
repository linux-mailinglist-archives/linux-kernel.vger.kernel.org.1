Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028D92354EF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 05:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHBDH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 23:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBDH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 23:07:56 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8BE2067D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 03:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596337675;
        bh=BDe3yrs2v8VZq1a11x+flngPwziIhT6reSqN/ADz+Do=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K+ksXFY7u11n48uVBOuFNHQQ9C51A4Cx58+FxIOWeKiJEnIL5aj1+hUZK1aggDn1z
         myxPzZKhwAtNJMXb4+HnJmr6aMIR00n7EUNU0o1eHBY3QdqzCwEtTAvlh4i3oNpMo0
         jhBDyaCR35CyK0BXxAATuMXx20uru00c1cnKX3RE=
Received: by mail-ed1-f47.google.com with SMTP id n2so24925514edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 20:07:54 -0700 (PDT)
X-Gm-Message-State: AOAM533G/PGVP4RVb7Wa+v2EbYYLNlj6H40IuVaFsRhrorOSYaCZTHlV
        Q16abCjyc8Fh4FQp857dViU9+PUCGtGmm1R6/g==
X-Google-Smtp-Source: ABdhPJyuI+jxJ9FjQ8z4X4OB88xraUiJO81XEDCBTWmaeVREdXxTr4LuiheHcUQRI8EXwQMSWtSMj+P+/FhYw6yGYmE=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr10069970edb.48.1596337673694;
 Sat, 01 Aug 2020 20:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-5-frank-w@public-files.de>
In-Reply-To: <20200728111800.77641-5-frank-w@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Aug 2020 11:07:41 +0800
X-Gmail-Original-Message-ID: <CAAOTY_99VEs2aNAoWBJhcCMsem5ewmV18B=GMLc_n-Wico_+Hg@mail.gmail.com>
Message-ID: <CAAOTY_99VEs2aNAoWBJhcCMsem5ewmV18B=GMLc_n-Wico_+Hg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/mediatek: dpi/dsi: change the getting
 possible_crtc way
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:18=E5=AF=AB=E9=81=93=
=EF=BC=9A

>
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> [Detail]
> dpi/dsi get the possible_crtc by
> mtk_drm_find_possible_crtc_by_comp(*drm_dev, ddp_comp)
>

I would like more information of why do this patch. For example:

For current mediatek dsi encoder, its possible crtc is fixed in crtc
0, and mediatek dpi encoder's possible crtc is fixed in crtc 1. In
some SoC the possible crtc is not fixed in this case, so call
mtk_drm_find_possible_crtc_by_comp() to find out the correct possible
crtc.

Regards,
Chun-Kuang.

> Test: build pass and boot to logo
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index d4f0fb7ad312..e43977015843 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -608,7 +608,8 @@ static int mtk_dpi_bind(struct device *dev, struct de=
vice *master, void *data)
>         drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_fun=
cs);
>
>         /* Currently DPI0 is fixed to be driven by OVL1 */
> -       dpi->encoder.possible_crtcs =3D BIT(1);
> +       dpi->encoder.possible_crtcs =3D
> +               mtk_drm_find_possible_crtc_by_comp(drm_dev, dpi->ddp_comp=
);
>
>         ret =3D drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
>         if (ret) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 270bf22c98fe..c31d9c12d4a9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -892,7 +892,8 @@ static int mtk_dsi_create_conn_enc(struct drm_device =
*drm, struct mtk_dsi *dsi)
>          * Currently display data paths are statically assigned to a crtc=
 each.
>          * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
>          */
> -       dsi->encoder.possible_crtcs =3D 1;
> +       dsi->encoder.possible_crtcs =3D
> +               mtk_drm_find_possible_crtc_by_comp(drm, dsi->ddp_comp);
>
>         /* If there's a bridge, attach to it and let it create the connec=
tor */
>         if (dsi->bridge) {
> --
> 2.25.1
>
