Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED06D269899
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgINWJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgINWJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:09:38 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA72921D7D;
        Mon, 14 Sep 2020 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600121377;
        bh=Nz7gGQ+J/ilhJdHLM4BsmqhATykFw0LEpRBTDA8GVOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vcdsExYa08FePhjPFL/B5tV+UlxmRi0Dt3qUnKHypkDv/qhVr8oRIH0/ZDlgoanh+
         29ZTRj2HAFMritc/hyC2IL6dnmTKAdsl6rnasfKf2sCXvjnHAp8zgRsSkPRX/IGO8Q
         dMjY3XH6toV6vEqTpZUk3JOYmtS00w/dbnKAhXVo=
Received: by mail-ej1-f54.google.com with SMTP id nw23so2162006ejb.4;
        Mon, 14 Sep 2020 15:09:36 -0700 (PDT)
X-Gm-Message-State: AOAM531qga1WjgFS41PmkZMxZbA4wNP8Isvvmd3gbVV3Vpke+1Qo6fzV
        di4kY6PuOOib/W3PR8eSdBNte8kw3FH98UH+cQ==
X-Google-Smtp-Source: ABdhPJzJGzLWfXMkzj/uZwj/GppT/VN4DVF+j5uKOZfH5SCyReE4lyC/KudDVVDW7AFmoqKRghaV4EK54CnHc9xzmBw=
X-Received: by 2002:a17:906:7102:: with SMTP id x2mr16660250ejj.260.1600121375444;
 Mon, 14 Sep 2020 15:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200904110002.88966-1-linux@fw-web.de> <20200904110002.88966-2-linux@fw-web.de>
In-Reply-To: <20200904110002.88966-2-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Sep 2020 06:09:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY__TNsteFiTxdXfnKns4jkz62NNG7joUtsu0XVV8MwhhRQ@mail.gmail.com>
Message-ID: <CAAOTY__TNsteFiTxdXfnKns4jkz62NNG7joUtsu0XVV8MwhhRQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] drm/mediatek: disable tmds on mt2701
To:     Frank Wunderlich <linux@fw-web.de>,
        Jitao Shi <jitao.shi@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B49=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: chunhui dai <chunhui.dai@mediatek.com>
>
> Without that patch if you use specific resolutions like 1280x1024,
> I can see distortion in the output. It seems as if the
> frequency for updating the pixel of the image is out of sync.
>
> For initialization tmds needs to be active, but can be disabled after ini=
t
> to fix blurry display

As discussed with Jitao offline, he agree this patch, so I applied
this patch to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 1 +
>  drivers/phy/mediatek/phy-mtk-hdmi.c        | 3 +++
>  drivers/phy/mediatek/phy-mtk-hdmi.h        | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt2701.c
> index a6cb1dea3d0c..b74c65a1762c 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> @@ -238,6 +238,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi=
_phy *hdmi_phy)
>
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf =3D {
>         .flags =3D CLK_SET_RATE_GATE,
> +       .pll_default_off =3D true,
>         .hdmi_phy_clk_ops =3D &mtk_hdmi_phy_pll_ops,
>         .hdmi_phy_enable_tmds =3D mtk_hdmi_phy_enable_tmds,
>         .hdmi_phy_disable_tmds =3D mtk_hdmi_phy_disable_tmds,
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/p=
hy-mtk-hdmi.c
> index 8fc83f01a720..47c029d4b270 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> @@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device =
*pdev)
>                 return PTR_ERR(phy_provider);
>         }
>
> +       if (hdmi_phy->conf->pll_default_off)
> +               hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
> +
>         return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>                                    hdmi_phy->pll);
>  }
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/p=
hy-mtk-hdmi.h
> index b13e1d5f8e78..dcf9bb13699b 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.h
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
> @@ -21,6 +21,7 @@ struct mtk_hdmi_phy;
>
>  struct mtk_hdmi_phy_conf {
>         unsigned long flags;
> +       bool pll_default_off;
>         const struct clk_ops *hdmi_phy_clk_ops;
>         void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>         void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
