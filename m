Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846B5286BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgJHAB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgJHAB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:01:26 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE8C20872
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602115285;
        bh=DQSQgnf7iZN9oYiYCpxCoUi+P0CeJf5tjxkIeK1NTSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2pt31eEE2afgzpWpq2IhHZO3N1ID2FEFu00XbkVtKKFAOjq1Tfwn/lcd6Z8VHVFyE
         TUBxWztRZpZSGsBDEGV9x+96DtTas0+0jP7c8c/t7y8hbW++rpWpWQKOkDYM2cSTu6
         47DKS+qi/se9zuQpb23EtolCoT6TkxDCZTRFbwno=
Received: by mail-ed1-f46.google.com with SMTP id g4so4039270edk.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 17:01:25 -0700 (PDT)
X-Gm-Message-State: AOAM5336SOfXEn4MN49nre4GAZw2Wg6Q3+m1MqYKcjenqIww4FbqtjFR
        snPr2biBtLUTOj0YsfAcKVS3f3zEZhru67rGCw==
X-Google-Smtp-Source: ABdhPJwAznF2oZv2XNaUDfOTBX5/13+HntqtKHAHMCYO1QVKA8/FxWkmX5F2efLji9U+4yq9OgRkvGIS89wIpEMwPKE=
X-Received: by 2002:aa7:c3ca:: with SMTP id l10mr6393321edr.72.1602115284045;
 Wed, 07 Oct 2020 17:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201006193320.405529-1-enric.balletbo@collabora.com> <20201006193320.405529-5-enric.balletbo@collabora.com>
In-Reply-To: <20201006193320.405529-5-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 8 Oct 2020 08:01:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY__X8L2sK0s3rkq2LDaMNoQrZKfzn=aJ791fK=UwnJMAyQ@mail.gmail.com>
Message-ID: <CAAOTY__X8L2sK0s3rkq2LDaMNoQrZKfzn=aJ791fK=UwnJMAyQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] soc: mediatek: mmsys: Use an array for setting the
 routing registers
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B410=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:33=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> From: CK Hu <ck.hu@mediatek.com>
>
> Actually, setting the registers for routing, use multiple 'if-else' for d=
ifferent
> routes, but this code would be more and more complicated while we
> support more and more SoCs. Change that and use a table per SoC so the
> code will be more portable and clear.
>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/mtk-mmsys.c | 393 +++++++++++++++++--------------
>  1 file changed, 210 insertions(+), 183 deletions(-)
>

[snip]

>
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
> @@ -93,10 +115,6 @@ static const struct mtk_mmsys_driver_data mt6797_mmsy=
s_driver_data =3D {
>         .clk_driver =3D "clk-mt6797-mm",
>  };
>
> -static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data =3D {
> -       .clk_driver =3D "clk-mt8173-mm",
> -};
> -
>  static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data =3D {
>         .clk_driver =3D "clk-mt8183-mm",
>  };
> @@ -106,180 +124,192 @@ struct mtk_mmsys {
>         const struct mtk_mmsys_driver_data *data;
>  };
>

[snip]

> +static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data =3D {
> +       .clk_driver =3D "clk-mt8173-mm",
> +       .routes =3D mt8173_mmsys_routing_table,
> +       .num_routes =3D ARRAY_SIZE(mt8173_mmsys_routing_table),
> +};
>

I remove my Reviewed-by tag. You does not set routes for mt2701 and
mt2712, but these two SoC need that. Maybe now they use the same table
as mt8173.

Regards,
Chun-Kuang.
