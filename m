Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B972AA8E1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgKHBz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 20:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgKHBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 20:55:59 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B2020704;
        Sun,  8 Nov 2020 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604800558;
        bh=T67Iufr0uPKu+Md6jDu5kMdpCLS8mxT7AldzdaCHeB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ERvnSqzOzvAsT1/vwyFBNFosjYr4/0pzuvB0gPmJnXKD+WHnK6gKfhPIvxk6q1Hts
         WuC7L0SdTPwAVjOonRosQcawMT6hY/P+LYkYt0dnPFIj2SkULvPpeJOvE7zhHgMDgt
         JhKo3+vJYPwLIfGUjzeTdvqLsFktnNZphNf4Ar38=
Received: by mail-ed1-f47.google.com with SMTP id t11so5066101edj.13;
        Sat, 07 Nov 2020 17:55:57 -0800 (PST)
X-Gm-Message-State: AOAM531NWC+k/mCemUw7o05Xy4SVfMKXH+4Xfjq3wYBe+hyaZdbl06rM
        AbpkikACUlzhs4KF5GnaXd1PicWlaeKXbjyXmg==
X-Google-Smtp-Source: ABdhPJyCiEXaygWJ+gT0prVAlkWmDoA7xyXwqbJnDIZD3XSYHBiBe7IHfOG4ddXSUnQD8AMLb3LmmuYv6NAUU6mB03g=
X-Received: by 2002:a50:d587:: with SMTP id v7mr8709048edi.38.1604800556313;
 Sat, 07 Nov 2020 17:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-5-fparent@baylibre.com>
 <CAAOTY_9QWfrExsjSaeGtA6KGZYLyscuc76jdDjHwawd8y964hA@mail.gmail.com>
In-Reply-To: <CAAOTY_9QWfrExsjSaeGtA6KGZYLyscuc76jdDjHwawd8y964hA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 8 Nov 2020 09:55:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY__FPenM6-vKiW4mjMo1m+5K7bGAc++dSJ3gdra4LiC4jg@mail.gmail.com>
Message-ID: <CAAOTY__FPenM6-vKiW4mjMo1m+5K7bGAc++dSJ3gdra4LiC4jg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/mediatek: add DDP support for MT8167
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=882=
3=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Fabien:
>
> Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Add DDP support for MT8167 SoC.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

For this patch, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >
> > Changelog:
> >
> > V2: don't set DDP_MUTEX_SOF_DSI{1,2,3} since they are not available on =
MT8167
> >
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 47 ++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_ddp.c
> > index 014c1bbe1df2..1f99db6b1a42 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -25,6 +25,19 @@
> >
> >  #define INT_MUTEX                              BIT(1)
> >
> > +#define MT8167_MUTEX_MOD_DISP_PWM              1
> > +#define MT8167_MUTEX_MOD_DISP_OVL0             6
> > +#define MT8167_MUTEX_MOD_DISP_OVL1             7
> > +#define MT8167_MUTEX_MOD_DISP_RDMA0            8
> > +#define MT8167_MUTEX_MOD_DISP_RDMA1            9
> > +#define MT8167_MUTEX_MOD_DISP_WDMA0            10
> > +#define MT8167_MUTEX_MOD_DISP_CCORR            11
> > +#define MT8167_MUTEX_MOD_DISP_COLOR            12
> > +#define MT8167_MUTEX_MOD_DISP_AAL              13
> > +#define MT8167_MUTEX_MOD_DISP_GAMMA            14
> > +#define MT8167_MUTEX_MOD_DISP_DITHER           15
> > +#define MT8167_MUTEX_MOD_DISP_UFOE             16
> > +
> >  #define MT8173_MUTEX_MOD_DISP_OVL0             11
> >  #define MT8173_MUTEX_MOD_DISP_OVL1             12
> >  #define MT8173_MUTEX_MOD_DISP_RDMA0            13
> > @@ -73,6 +86,8 @@
> >  #define MUTEX_SOF_DPI1                 4
> >  #define MUTEX_SOF_DSI2                 5
> >  #define MUTEX_SOF_DSI3                 6
> > +#define MT8167_MUTEX_SOF_DPI0          2
> > +#define MT8167_MUTEX_SOF_DPI1          3
> >
> >
> >  struct mtk_disp_mutex {
> > @@ -135,6 +150,21 @@ static const unsigned int mt2712_mutex_mod[DDP_COM=
PONENT_ID_MAX] =3D {
> >         [DDP_COMPONENT_WDMA1] =3D MT2712_MUTEX_MOD_DISP_WDMA1,
> >  };
> >
> > +static const unsigned int mt8167_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
> > +       [DDP_COMPONENT_AAL0] =3D MT8167_MUTEX_MOD_DISP_AAL,
> > +       [DDP_COMPONENT_CCORR] =3D MT8167_MUTEX_MOD_DISP_CCORR,
> > +       [DDP_COMPONENT_COLOR0] =3D MT8167_MUTEX_MOD_DISP_COLOR,
> > +       [DDP_COMPONENT_DITHER] =3D MT8167_MUTEX_MOD_DISP_DITHER,
> > +       [DDP_COMPONENT_GAMMA] =3D MT8167_MUTEX_MOD_DISP_GAMMA,
> > +       [DDP_COMPONENT_OVL0] =3D MT8167_MUTEX_MOD_DISP_OVL0,
> > +       [DDP_COMPONENT_OVL1] =3D MT8167_MUTEX_MOD_DISP_OVL1,
> > +       [DDP_COMPONENT_PWM0] =3D MT8167_MUTEX_MOD_DISP_PWM,
> > +       [DDP_COMPONENT_RDMA0] =3D MT8167_MUTEX_MOD_DISP_RDMA0,
> > +       [DDP_COMPONENT_RDMA1] =3D MT8167_MUTEX_MOD_DISP_RDMA1,
> > +       [DDP_COMPONENT_UFOE] =3D MT8167_MUTEX_MOD_DISP_UFOE,
> > +       [DDP_COMPONENT_WDMA0] =3D MT8167_MUTEX_MOD_DISP_WDMA0,
> > +};
> > +
> >  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
> >         [DDP_COMPONENT_AAL0] =3D MT8173_MUTEX_MOD_DISP_AAL,
> >         [DDP_COMPONENT_COLOR0] =3D MT8173_MUTEX_MOD_DISP_COLOR0,
> > @@ -163,6 +193,13 @@ static const unsigned int mt2712_mutex_sof[DDP_MUT=
EX_SOF_DSI3 + 1] =3D {
> >         [DDP_MUTEX_SOF_DSI3] =3D MUTEX_SOF_DSI3,
> >  };
> >
> > +static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] =3D=
 {
> > +       [DDP_MUTEX_SOF_SINGLE_MODE] =3D MUTEX_SOF_SINGLE_MODE,
> > +       [DDP_MUTEX_SOF_DSI0] =3D MUTEX_SOF_DSI0,
> > +       [DDP_MUTEX_SOF_DPI0] =3D MT8167_MUTEX_SOF_DPI0,
> > +       [DDP_MUTEX_SOF_DPI1] =3D MT8167_MUTEX_SOF_DPI1,
> > +};
> > +
> >  static const struct mtk_ddp_data mt2701_ddp_driver_data =3D {
> >         .mutex_mod =3D mt2701_mutex_mod,
> >         .mutex_sof =3D mt2712_mutex_sof,
> > @@ -177,6 +214,14 @@ static const struct mtk_ddp_data mt2712_ddp_driver=
_data =3D {
> >         .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
> >  };
> >
> > +static const struct mtk_ddp_data mt8167_ddp_driver_data =3D {
> > +       .mutex_mod =3D mt8167_mutex_mod,
> > +       .mutex_sof =3D mt8167_mutex_sof,
> > +       .mutex_mod_reg =3D MT2701_DISP_MUTEX0_MOD0,
> > +       .mutex_sof_reg =3D MT2701_DISP_MUTEX0_SOF0,
> > +       .no_clk =3D true,
> > +};
> > +
> >  static const struct mtk_ddp_data mt8173_ddp_driver_data =3D {
> >         .mutex_mod =3D mt8173_mutex_mod,
> >         .mutex_sof =3D mt2712_mutex_sof,
> > @@ -400,6 +445,8 @@ static const struct of_device_id ddp_driver_dt_matc=
h[] =3D {
> >           .data =3D &mt2701_ddp_driver_data},
> >         { .compatible =3D "mediatek,mt2712-disp-mutex",
> >           .data =3D &mt2712_ddp_driver_data},
> > +       { .compatible =3D "mediatek,mt8167-disp-mutex",
> > +         .data =3D &mt8167_ddp_driver_data},
> >         { .compatible =3D "mediatek,mt8173-disp-mutex",
> >           .data =3D &mt8173_ddp_driver_data},
> >         {},
> > --
> > 2.28.0
> >
