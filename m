Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524572854E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 01:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgJFXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 19:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFXVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:21:46 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DBD20BED
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 23:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602026506;
        bh=w3rqYm5bSFfRjGcsvP6qbO0O2mVCq2b8LjMq0OPbP40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xl0uxwUm+NkrIKVP4mecVV2Rs0vfEWkV9waA9yE/pESk2/GZ7DSFJAAd7CuIBn9oQ
         MRyBBeWeGeUnFZodptsOWZQlHLI2WIFiPbaZKQ4U7EgYwxMFIh4sanjDcskWD6S9do
         usmA1KwJ+wokdx33MuZ9qTHbgDLQIt/OkrXm58OY=
Received: by mail-ej1-f41.google.com with SMTP id a3so256097ejy.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 16:21:46 -0700 (PDT)
X-Gm-Message-State: AOAM531vUtj1PgN8VVBpjpib6T/gQOEfIU7CICK62+wHgRpmUMrzA0Gf
        6X3gATgBYJ2H65UQe1lZhRlnXCDHUhGCOAnb/w==
X-Google-Smtp-Source: ABdhPJzI6uOPlHzkLjMWX6Wd8VyldUGyz9WuXn4fUheBeqE1Mroh8mreITWhdb7rTnLjmpJOrZaD3RCflUhpQe4Iqhs=
X-Received: by 2002:a17:906:3b8e:: with SMTP id u14mr402539ejf.127.1602026504590;
 Tue, 06 Oct 2020 16:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201006193320.405529-1-enric.balletbo@collabora.com> <20201006193320.405529-3-enric.balletbo@collabora.com>
In-Reply-To: <20201006193320.405529-3-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 7 Oct 2020 07:21:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY__NVjKW-WXekeZSb4RRR4G01LQrPN+m_g0EQJ9hLviN8g@mail.gmail.com>
Message-ID: <CAAOTY__NVjKW-WXekeZSb4RRR4G01LQrPN+m_g0EQJ9hLviN8g@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc: mediatek: mmsys: Use devm_platform_ioremap_resource()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B410=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:33=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> For the common platform_get_resource()+devm_platform_ioremap() combinatio=
n,
> there is a helper, so use it and make the code a bit more compact.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/mtk-mmsys.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 36ad66bb221b..18f93979e14a 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -306,15 +306,12 @@ static int mtk_mmsys_probe(struct platform_device *=
pdev)
>         struct platform_device *clks;
>         struct platform_device *drm;
>         void __iomem *config_regs;
> -       struct resource *mem;
>         int ret;
>
> -       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       config_regs =3D devm_ioremap_resource(dev, mem);
> +       config_regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(config_regs)) {
>                 ret =3D PTR_ERR(config_regs);
> -               dev_err(dev, "Failed to ioremap mmsys-config resource: %d=
\n",
> -                       ret);
> +               dev_err(dev, "Failed to ioremap mmsys registers: %d\n", r=
et);
>                 return ret;
>         }
>
> --
> 2.28.0
>
