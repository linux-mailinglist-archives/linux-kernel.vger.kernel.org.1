Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97522FDFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393297AbhAUCw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388125AbhATXrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:47:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD46A23715
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611186420;
        bh=0WJekRe162njhz/lN/s1NsUfes3ExpoWd49kVBnEejU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dlb2GafUES632XMG7xdeT6FSzA/aAwE13grNWfpunJA+7lNdexHZA6/QYAs7SFKPO
         L6cbuaCB4dTuFxVBT8hBPP6/2uiOULwpuVH8LKH7KdSVM13adQ78pHDn2xR8t6oaWF
         I5SedOZO7iEhqJ2hQ5nwQjKNsoFfhqEOtwNk5aN/UfPTfO2Kd/UgBcL/xDPZc/wG3T
         xLhWN49VGhxmxtTB4Of+7Yyxny6qEbxw+xwH+JrYoDWlQZcIUwb4EkwcfgpcJy3BpS
         RVzxrWfKXhAZjlLMq+9cd7lZSYKWy9jfgoC5DEmyISRKSXl+d3+RJzbHD4GdwwZ4Lf
         PKbr9yMGlV7CA==
Received: by mail-wr1-f51.google.com with SMTP id 6so50281wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:46:59 -0800 (PST)
X-Gm-Message-State: AOAM530K/a1QrsggfXFGAP46/zwdgI4/4eoSPWp6aEOT5h0i9iRPRJT+
        s7OZypi14yk7Vnk4wXSR0KJLMm9m0ScTxX7lkg==
X-Google-Smtp-Source: ABdhPJyOeJAtpzLliOtYNxoGXZZfEVvmUMa8zd9WYN928+G7DsPAZ514fbLy1jNVz+KdZq3J5WPxeP/R7tiMsnrbC4c=
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr2662537wrd.134.1611186418365;
 Wed, 20 Jan 2021 15:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
 <20210106231729.17173-4-chunkuang.hu@kernel.org> <YAh2JGUUpMcgyke0@ziggy.stardust>
In-Reply-To: <YAh2JGUUpMcgyke0@ziggy.stardust>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 21 Jan 2021 07:46:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY_82Z_DQuJWDD5NMeq35o2Tf-zQzmSxJwRYRRpHQJVHNEA@mail.gmail.com>
Message-ID: <CAAOTY_82Z_DQuJWDD5NMeq35o2Tf-zQzmSxJwRYRRpHQJVHNEA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/mediatek: Change disp/ddp term to mutex in mtk
 mutex driver
To:     Matthias Brugger <matthias.bgg@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8821=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Jan 07, 2021 at 07:17:27AM +0800, Chun-Kuang Hu wrote:
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > mtk mutex is used by both drm and mdp driver, so change disp/ddp term t=
o
> > mutex to show that it's a common driver for drm and mdp.
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  30 +--
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   2 +-
> >  drivers/gpu/drm/mediatek/mtk_mutex.c    | 305 ++++++++++++------------
> >  drivers/gpu/drm/mediatek/mtk_mutex.h    |  26 +-
> >  5 files changed, 182 insertions(+), 183 deletions(-)
> >
> [...]
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/gpu/drm/med=
iatek/mtk_mutex.c
> > index 1c8a253f4788..98a060bf225d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mutex.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mutex.c
> [...]
> >
> > -static const struct of_device_id ddp_driver_dt_match[] =3D {
> > +static const struct of_device_id mutex_driver_dt_match[] =3D {
> >       { .compatible =3D "mediatek,mt2701-disp-mutex",
> > -       .data =3D &mt2701_ddp_driver_data},
> > +       .data =3D &mt2701_mutex_driver_data},
> >       { .compatible =3D "mediatek,mt2712-disp-mutex",
> > -       .data =3D &mt2712_ddp_driver_data},
> > +       .data =3D &mt2712_mutex_driver_data},
> >       { .compatible =3D "mediatek,mt8167-disp-mutex",
> > -       .data =3D &mt8167_ddp_driver_data},
> > +       .data =3D &mt8167_mutex_driver_data},
> >       { .compatible =3D "mediatek,mt8173-disp-mutex",
> > -       .data =3D &mt8173_ddp_driver_data},
> > +       .data =3D &mt8173_mutex_driver_data},
> >       {},
> >  };
> > -MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> > +MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
>
> I think it would make sense in a follow-up patch to update the binding
> to use "mediatek,mt2701-mutex" to reflect that mutex is used for drm and
> mdp driver. Make sense?

Yes, it make sense. I would try to update the binding, but I wonder
device tree should be backward compatible? Let's discuss in that
follow-up patches.

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
