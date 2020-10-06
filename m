Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29B62854EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgJFXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 19:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFXYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:24:35 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D63D20E65
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602026674;
        bh=7fCFux5T52NDX9X2wa4ONXbiYQX8LD2c8RnqfpaOVKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OFHm1jcxiWUYB9G6jvRQPqXKAcgVUdnPMO7wHxKd6A38ZjnGabDGDK9hJz9yrOfjW
         5pEMVNUkuTmGzSnXt5tQwLzXk4ieJRk55CoMGxqv3T0hCkmo04WQVggC3aYgayVB6C
         SbncSCiGnjZcOhJZop/FzRoFV8XoVbO20QxHWt/Q=
Received: by mail-ed1-f42.google.com with SMTP id cq12so243064edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 16:24:34 -0700 (PDT)
X-Gm-Message-State: AOAM5325uuht8WKHTKdv62CFetE7/qJwn6Il/9Dzggw0rjY1qgDVAo+V
        0OlKQfdqZRS2CTjOub5ELXMJV28H2vIdsc6uBQ==
X-Google-Smtp-Source: ABdhPJwkiVZMgIhg+FDOs00EiyOPpGCdsQi8SVV4lVL6LqIgdTHCy0njE2cQDMAxUJQR6YQtRXDDbdTlrnOVRoProjw=
X-Received: by 2002:aa7:cd5a:: with SMTP id v26mr541730edw.38.1602026672473;
 Tue, 06 Oct 2020 16:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201006193320.405529-1-enric.balletbo@collabora.com> <20201006193320.405529-4-enric.balletbo@collabora.com>
In-Reply-To: <20201006193320.405529-4-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 7 Oct 2020 07:24:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yoptcLCg1YC-wZv+jsOKsKsYFY1xCCwqWVv7M8nNd_w@mail.gmail.com>
Message-ID: <CAAOTY_-yoptcLCg1YC-wZv+jsOKsKsYFY1xCCwqWVv7M8nNd_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] soc: mediatek: mmsys: Create struct mtk_mmsys to
 store context data
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

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B410=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:33=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> From: CK Hu <ck.hu@mediatek.com>
>
> Apart from the driver data, in order to extend the driver to support more
> and more SoCs, we will need to store other configuration data. So, create
> a mtk_mmsys struct to encapsulate all that information.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>

>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/mtk-mmsys.c | 47 ++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 18f93979e14a..da2de8f6969e 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -101,6 +101,11 @@ static const struct mtk_mmsys_driver_data mt8183_mms=
ys_driver_data =3D {
>         .clk_driver =3D "clk-mt8183-mm",
>  };
>
> +struct mtk_mmsys {
> +       void __iomem *regs;
> +       const struct mtk_mmsys_driver_data *data;
> +};
> +
>  static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
>                                           enum mtk_ddp_comp_id next,
>                                           unsigned int *addr)
> @@ -259,21 +264,21 @@ void mtk_mmsys_ddp_connect(struct device *dev,
>                            enum mtk_ddp_comp_id cur,
>                            enum mtk_ddp_comp_id next)
>  {
> -       void __iomem *config_regs =3D dev_get_drvdata(dev);
> +       struct mtk_mmsys *mmsys =3D dev_get_drvdata(dev);
>         unsigned int addr, value, reg;
>
>         value =3D mtk_mmsys_ddp_mout_en(cur, next, &addr);
>         if (value) {
> -               reg =3D readl_relaxed(config_regs + addr) | value;
> -               writel_relaxed(reg, config_regs + addr);
> +               reg =3D readl_relaxed(mmsys->regs + addr) | value;
> +               writel_relaxed(reg, mmsys->regs + addr);
>         }
>
> -       mtk_mmsys_ddp_sout_sel(config_regs, cur, next);
> +       mtk_mmsys_ddp_sout_sel(mmsys->regs, cur, next);
>
>         value =3D mtk_mmsys_ddp_sel_in(cur, next, &addr);
>         if (value) {
> -               reg =3D readl_relaxed(config_regs + addr) | value;
> -               writel_relaxed(reg, config_regs + addr);
> +               reg =3D readl_relaxed(mmsys->regs + addr) | value;
> +               writel_relaxed(reg, mmsys->regs + addr);
>         }
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
> @@ -282,44 +287,46 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>                               enum mtk_ddp_comp_id cur,
>                               enum mtk_ddp_comp_id next)
>  {
> -       void __iomem *config_regs =3D dev_get_drvdata(dev);
> +       struct mtk_mmsys *mmsys =3D dev_get_drvdata(dev);
>         unsigned int addr, value, reg;
>
>         value =3D mtk_mmsys_ddp_mout_en(cur, next, &addr);
>         if (value) {
> -               reg =3D readl_relaxed(config_regs + addr) & ~value;
> -               writel_relaxed(reg, config_regs + addr);
> +               reg =3D readl_relaxed(mmsys->regs + addr) & ~value;
> +               writel_relaxed(reg, mmsys->regs + addr);
>         }
>
>         value =3D mtk_mmsys_ddp_sel_in(cur, next, &addr);
>         if (value) {
> -               reg =3D readl_relaxed(config_regs + addr) & ~value;
> -               writel_relaxed(reg, config_regs + addr);
> +               reg =3D readl_relaxed(mmsys->regs + addr) & ~value;
> +               writel_relaxed(reg, mmsys->regs + addr);
>         }
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>
>  static int mtk_mmsys_probe(struct platform_device *pdev)
>  {
> -       const struct mtk_mmsys_driver_data *data;
>         struct device *dev =3D &pdev->dev;
>         struct platform_device *clks;
>         struct platform_device *drm;
> -       void __iomem *config_regs;
> +       struct mtk_mmsys *mmsys;
>         int ret;
>
> -       config_regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(config_regs)) {
> -               ret =3D PTR_ERR(config_regs);
> +       mmsys =3D devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
> +       if (!mmsys)
> +               return -ENOMEM;
> +
> +       mmsys->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(mmsys->regs)) {
> +               ret =3D PTR_ERR(mmsys->regs);
>                 dev_err(dev, "Failed to ioremap mmsys registers: %d\n", r=
et);
>                 return ret;
>         }
>
> -       platform_set_drvdata(pdev, config_regs);
> -
> -       data =3D of_device_get_match_data(&pdev->dev);
> +       mmsys->data =3D of_device_get_match_data(&pdev->dev);
> +       platform_set_drvdata(pdev, mmsys);
>
> -       clks =3D platform_device_register_data(&pdev->dev, data->clk_driv=
er,
> +       clks =3D platform_device_register_data(&pdev->dev, mmsys->data->c=
lk_driver,
>                                              PLATFORM_DEVID_AUTO, NULL, 0=
);
>         if (IS_ERR(clks))
>                 return PTR_ERR(clks);
> --
> 2.28.0
>
