Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C35295548
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442289AbgJUXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404943AbgJUXm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:42:28 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE08724197;
        Wed, 21 Oct 2020 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603323748;
        bh=BESI+542e7zfS3UEqo6HAOXoKEmppsFmRI/GraPxDPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1unrDcjabHeLDDqS/apsiljcFHGIO18AqDTOVKbU+vvALlFaGbNzUssIB6t1VFqK7
         EGSjXx5bDIFwmnNpkGTQxnF1O7La4nHIbZXzKKHB6W+idmBfQytHpuwMZmrYXuRjy+
         Z2GVPU9PeH5FzPjjkFzFe6tAI9Y2170ZsxaPz7zk=
Received: by mail-ej1-f49.google.com with SMTP id k3so44101ejj.10;
        Wed, 21 Oct 2020 16:42:27 -0700 (PDT)
X-Gm-Message-State: AOAM530Ne4UZvd+Q0VlHEcOP/O4VSpn7T4sjI6Q/Lrx5p9mxt82duxBF
        7QHNIavoqUVW4mjKyvG3yYrCcGVWCuRpLPbsvA==
X-Google-Smtp-Source: ABdhPJwgMVbl3VYJeXaSvXiI9nwXO3E9FGk9CZ7wEou8onpN28BE+CNBywsvzb2a+LmZGUfNobLk6I2nGy6MQrV80nI=
X-Received: by 2002:a17:906:3b8e:: with SMTP id u14mr5725503ejf.127.1603323746144;
 Wed, 21 Oct 2020 16:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201020174253.3757771-1-fparent@baylibre.com> <20201020174253.3757771-4-fparent@baylibre.com>
In-Reply-To: <20201020174253.3757771-4-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 22 Oct 2020 07:42:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8vDopCaJ+=kZwhTPgM0ioTL=PdCdQLjgWMdyJHkyD=Pw@mail.gmail.com>
Message-ID: <CAAOTY_8vDopCaJ+=kZwhTPgM0ioTL=PdCdQLjgWMdyJHkyD=Pw@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/mediatek: add disp-color MT8167 support
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

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add support for disp-color on MT8167 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
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
