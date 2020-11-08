Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB792AA8DC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 02:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgKHBy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 20:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgKHBy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 20:54:27 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23683221FC;
        Sun,  8 Nov 2020 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604800466;
        bh=5N/oNzrmeu3aOtDAHcU54Nt3NGOMRnUUf8OnNnCXcWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YQRexxsWat85DKj1qNwAszWih5nB4XBXAT4Q8jHuBplQNSlCR7sedt8rn8EdmR2XX
         8JUBFzJnb6WTa+ChRgM1m7sXKKq4zcFtaRjASABA0klqF6iWY09q6gt45UeC0zIL2c
         IzKLPIHYiLedvAtL6T0f4tppdwTf9CqIz0Q5bPHI=
Received: by mail-ed1-f44.google.com with SMTP id cq7so4895669edb.4;
        Sat, 07 Nov 2020 17:54:26 -0800 (PST)
X-Gm-Message-State: AOAM530Q7URi8BLE+le27P1cC+GFYd8bUyUE/3TbVKsD7+j7NqeuQ8iw
        TqPyxc56ILxL+d2CqgTewmp3p4eJnRhKCXkwTA==
X-Google-Smtp-Source: ABdhPJz9PLvOVHmdu2y0FOkaVh+eRhblRF0PoRpr3EGHovwbntqZAc8CKlK37k+KXdox0EpoWbXJydOn5iVXuc0kGs0=
X-Received: by 2002:a50:8745:: with SMTP id 5mr8862319edv.49.1604800464719;
 Sat, 07 Nov 2020 17:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-4-fparent@baylibre.com>
In-Reply-To: <20201023133130.194140-4-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 8 Nov 2020 09:54:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY__EhnZaLT8hXqQ-ndS_3A391kSDZWKgVEd5tziPfiNs-g@mail.gmail.com>
Message-ID: <CAAOTY__EhnZaLT8hXqQ-ndS_3A391kSDZWKgVEd5tziPfiNs-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/mediatek: add disp-color MT8167 support
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
> Add support for disp-color on MT8167 SoC.

For this patch, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>
> Changelog:
>
> V2: No change
>
>  drivers/gpu/drm/mediatek/mtk_disp_color.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/=
mediatek/mtk_disp_color.c
> index 3ae9c810845b..a1227cefbf31 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> @@ -16,6 +16,7 @@
>
>  #define DISP_COLOR_CFG_MAIN                    0x0400
>  #define DISP_COLOR_START_MT2701                        0x0f00
> +#define DISP_COLOR_START_MT8167                        0x0400
>  #define DISP_COLOR_START_MT8173                        0x0c00
>  #define DISP_COLOR_START(comp)                 ((comp)->data->color_offs=
et)
>  #define DISP_COLOR_WIDTH(comp)                 (DISP_COLOR_START(comp) +=
 0x50)
> @@ -148,6 +149,10 @@ static const struct mtk_disp_color_data mt2701_color=
_driver_data =3D {
>         .color_offset =3D DISP_COLOR_START_MT2701,
>  };
>
> +static const struct mtk_disp_color_data mt8167_color_driver_data =3D {
> +       .color_offset =3D DISP_COLOR_START_MT8167,
> +};
> +
>  static const struct mtk_disp_color_data mt8173_color_driver_data =3D {
>         .color_offset =3D DISP_COLOR_START_MT8173,
>  };
> @@ -155,6 +160,8 @@ static const struct mtk_disp_color_data mt8173_color_=
driver_data =3D {
>  static const struct of_device_id mtk_disp_color_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-color",
>           .data =3D &mt2701_color_driver_data},
> +       { .compatible =3D "mediatek,mt8167-disp-color",
> +         .data =3D &mt8167_color_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-color",
>           .data =3D &mt8173_color_driver_data},
>         {},
> --
> 2.28.0
>
