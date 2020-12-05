Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166352CFDD8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgLESpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgLEQtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:49:31 -0500
X-Gm-Message-State: AOAM530gkKG+y7EsAalN42kEKi7L4/mwXKCiRh+Pe0R61V5d1tb7HQeP
        M5UVM4M9XShJM5DdqtHxIXK99wkcoqf4l7pBXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607185321;
        bh=HqCL0C0fBHGxybJAYvYG5qc36iWdza1r3+6oQ7q/QYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TtJl9McoDTm4OO627Yqz78MaeEc4lov2ZnYQKkmPATAcFuvhKtxucO2BDITPFuftx
         hVTzsMORaModcamthtXy46dRtD0/1iZ0ZY0RywfehXS/fFmj/pUpNrupP7/vKUxEV7
         EcxMLfUuEEfN4GGPYcfTlCHkjyf9NsEeaGT6EI8TgcOphkCDEl19PltzMSXEsnTM9O
         XkhXjSYZFlYQCOpNJTPKDjTOsTEUIGKPFUiKJYMuv+YRXhGnNNpz7RRdR5qZ+VM4nA
         5Bapll5WHjlNyxm62RiT+sdWeNOpNh++dzGKIGIlTnT+HZYtb3zluT0K6C/MOYLkoE
         XsSNjBsuzhKTQ==
X-Google-Smtp-Source: ABdhPJxwRKEQCMgyly92qJS7B2s5xnqRdBYASutdDp1ipsbSBixu6U9DGAGmsD6yZUvGOAiiKhKjffVVI+kTdkQiO3c=
X-Received: by 2002:a1c:790f:: with SMTP id l15mr10033938wme.188.1607185320277;
 Sat, 05 Dec 2020 08:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20201205091146.3184305-1-vkoul@kernel.org>
In-Reply-To: <20201205091146.3184305-1-vkoul@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 6 Dec 2020 00:21:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-_X98x=DeGLnSRDcZ+9wfpW2-EzpqJLQxDJ-UGoYaONw@mail.gmail.com>
Message-ID: <CAAOTY_-_X98x=DeGLnSRDcZ+9wfpW2-EzpqJLQxDJ-UGoYaONw@mail.gmail.com>
Subject: Re: [PATCH] phy: mediatek: statify mtk_hdmi_phy_driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

Hi, Vinod:

Vinod Koul <vkoul@kernel.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=885=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=885:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> mtk_hdmi_phy_driver is not declared as static, so statify it.
>
> drivers/phy/mediatek/phy-mtk-hdmi.c:204:24: warning: symbol 'mtk_hdmi_phy=
_driver' was not declared. Should it be static?
>

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/mediatek/phy-mtk-hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/p=
hy-mtk-hdmi.c
> index 47c029d4b270..c5c61f5a9ea0 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> @@ -201,7 +201,7 @@ static const struct of_device_id mtk_hdmi_phy_match[]=
 =3D {
>         {},
>  };
>
> -struct platform_driver mtk_hdmi_phy_driver =3D {
> +static struct platform_driver mtk_hdmi_phy_driver =3D {
>         .probe =3D mtk_hdmi_phy_probe,
>         .driver =3D {
>                 .name =3D "mediatek-hdmi-phy",
> --
> 2.26.2
>
