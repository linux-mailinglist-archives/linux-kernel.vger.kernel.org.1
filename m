Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99957285510
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgJGABd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 20:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJGABc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 20:01:32 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20E32054F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602028892;
        bh=PIWMjyDxBBSKAjQ4wNtgwzJMwZRsueuvW+uTVHej3+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XtCOKVAp4yXop17hJL2J3mI3nJFRfiXSVOY7vStDF+BGEWpKjG7+RDlb9CvEh4OjB
         /Ylg+7o8bGbd9FAdsNYgQBwst/5299n15U2uP5qX4pF/aZ39Ow1QImGfU5Jc0Bx2Go
         Op5GdYxFS0yh+yFAD6gHRxK0rdxWeSY/UZZejhqk=
Received: by mail-ej1-f45.google.com with SMTP id h24so363505ejg.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 17:01:31 -0700 (PDT)
X-Gm-Message-State: AOAM532YfdEVmCjAR4hEC5X98/pIFbJ0ouspWFdICX7MixKw5G+1nG0L
        PGuSIlHza3SSuKWTgylFhcI+xRfoW3NfJGA1Wg==
X-Google-Smtp-Source: ABdhPJygN2AGMadvZ+V3mIFRzJGcI6JjBWXhECF41h8ERzSX9aHm2qUBFiQQdA6s/6/3bR9g83pZYE96kuyZLTrnuwg=
X-Received: by 2002:a17:906:9511:: with SMTP id u17mr566662ejx.194.1602028890413;
 Tue, 06 Oct 2020 17:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
 <20201006193320.405529-3-enric.balletbo@collabora.com> <CAAOTY__NVjKW-WXekeZSb4RRR4G01LQrPN+m_g0EQJ9hLviN8g@mail.gmail.com>
In-Reply-To: <CAAOTY__NVjKW-WXekeZSb4RRR4G01LQrPN+m_g0EQJ9hLviN8g@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 7 Oct 2020 08:01:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY__0i+WEnd1YYr7phOL+M-gxxjEpg7AcZaxFUtttqnNYYA@mail.gmail.com>
Message-ID: <CAAOTY__0i+WEnd1YYr7phOL+M-gxxjEpg7AcZaxFUtttqnNYYA@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc: mediatek: mmsys: Use devm_platform_ioremap_resource()
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=887:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B410=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:33=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > For the common platform_get_resource()+devm_platform_ioremap() combinat=
ion,
> > there is a helper, so use it and make the code a bit more compact.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>
>

Sorry for typo,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/soc/mediatek/mtk-mmsys.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mt=
k-mmsys.c
> > index 36ad66bb221b..18f93979e14a 100644
> > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > @@ -306,15 +306,12 @@ static int mtk_mmsys_probe(struct platform_device=
 *pdev)
> >         struct platform_device *clks;
> >         struct platform_device *drm;
> >         void __iomem *config_regs;
> > -       struct resource *mem;
> >         int ret;
> >
> > -       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -       config_regs =3D devm_ioremap_resource(dev, mem);
> > +       config_regs =3D devm_platform_ioremap_resource(pdev, 0);
> >         if (IS_ERR(config_regs)) {
> >                 ret =3D PTR_ERR(config_regs);
> > -               dev_err(dev, "Failed to ioremap mmsys-config resource: =
%d\n",
> > -                       ret);
> > +               dev_err(dev, "Failed to ioremap mmsys registers: %d\n",=
 ret);
> >                 return ret;
> >         }
> >
> > --
> > 2.28.0
> >
