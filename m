Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347B429BAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807621AbgJ0QMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:12:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39723 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1806808AbgJ0QIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:08:34 -0400
Received: by mail-il1-f193.google.com with SMTP id q1so1984288ilt.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6rAfY3NSqXlT1WPhNg+wGdttjuTFu01uQvx6roKDSO0=;
        b=oTPIk2RzGWVc0YchN2QbHHL1XteP2IXxgpmMpZquQvHvczuYqGOsZrCgpJ22tf88xB
         1/hxl9IubMODeS95YYwaSxGDtch6FIdKjE/89+a76oWGMYkYbZj1viSeT/VkiIIR/FSI
         jwPP7xGFGjEPGjH2vaNDnlloENr6lse4BmeuXNuyRAFFjRqT0l2CUXWOwhvxy6v/74+4
         nnHamh0JLMz9LiYmYfNQwZgXcFDzb8bRhddwzHlfOSizKFP3WmhjE82VqCb2kaz1MKVc
         2BI19EevEy1hXzNsD4mMmHFqLQkkFdRc3Kpca5C41NJyG51RcOARrRa+rdH7tPLxjNyb
         m0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6rAfY3NSqXlT1WPhNg+wGdttjuTFu01uQvx6roKDSO0=;
        b=qB9UOEFv9+m9oH5fnP2rBEDUyEwCAXIBYqxZNKSRN6MbWWFx7swWK4C4simZSU1/H8
         hyAtjTCt9xJH/NcpyuOquGJ6ar0HNKY4mU8ytckjfepKHEOLwt8tvAceHBo1EwZHcO9B
         8G342ML3SZkP2wDLrfi3aUUbnAughas+Zr4FCKV6ez1UWdkjmkthTzsC1km0jbOUff38
         86dMp3Hw5APziEC5A5c6sbPL5q2ya5UsYIWSNRAhjUOdFlHnp5XNcNv/Lta2V9+So7Pj
         gvjI14jI+badPQAv1DSbP0+DbVJnd36YT+WVPr+IgNZdaTbyOnv2P02jJ2U2B4HTxe4n
         lxEg==
X-Gm-Message-State: AOAM531dwuBiHyxCV8LKeCEKA1tCKAfwHpYeojSvz4eikrMdSDtQ9qoY
        FRctausOZMAqFiv2VJdZo37JTWHLzoIxgjGJz14Piw==
X-Google-Smtp-Source: ABdhPJxxoCNaawsy16iagkTtkcpbO1hw7slzU7A2BngEf7XFnJH07yerrqnn5NlbErjreG6y7YKFIW10fq3gdxZRrzk=
X-Received: by 2002:a92:aa01:: with SMTP id j1mr2679564ili.301.1603814913221;
 Tue, 27 Oct 2020 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-6-fparent@baylibre.com>
 <CAAOTY_8ZgoQJFnEDDZ=JCy-3zLwn7yjk1EHVYgeSG2ufLxK04g@mail.gmail.com>
In-Reply-To: <CAAOTY_8ZgoQJFnEDDZ=JCy-3zLwn7yjk1EHVYgeSG2ufLxK04g@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 27 Oct 2020 17:08:22 +0100
Message-ID: <CAOwMV_wzp67zeiSvXP59OLMwd_8srfSTSqV9BwXagq5gFu6B3g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/mediatek: Add support for main DDP path on MT8167
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On Fri, Oct 23, 2020 at 5:52 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Fabien:
>
> Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Add the main (DSI) drm display path for MT8167.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >
> > Changelog:
> >
> > V2: No change
> >
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 ++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.c
> > index 59c85c63b7cc..3952435093fe 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -112,6 +112,17 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_t=
hird[] =3D {
> >         DDP_COMPONENT_PWM2,
> >  };
> >
> > +static enum mtk_ddp_comp_id mt8167_mtk_ddp_main[] =3D {
> > +       DDP_COMPONENT_OVL0,
> > +       DDP_COMPONENT_COLOR0,
> > +       DDP_COMPONENT_CCORR,
> > +       DDP_COMPONENT_AAL0,
> > +       DDP_COMPONENT_GAMMA,
> > +       DDP_COMPONENT_DITHER,
> > +       DDP_COMPONENT_RDMA0,
> > +       DDP_COMPONENT_DSI0,
> > +};
> > +
> >  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] =3D {
> >         DDP_COMPONENT_OVL0,
> >         DDP_COMPONENT_COLOR0,
> > @@ -163,6 +174,11 @@ static const struct mtk_mmsys_driver_data mt8173_m=
msys_driver_data =3D {
> >         .ext_len =3D ARRAY_SIZE(mt8173_mtk_ddp_ext),
> >  };
> >
> > +static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data =3D=
 {
> > +       .main_path =3D mt8167_mtk_ddp_main,
> > +       .main_len =3D ARRAY_SIZE(mt8167_mtk_ddp_main),
> > +};
> > +
> >  static int mtk_drm_kms_init(struct drm_device *drm)
> >  {
> >         struct mtk_drm_private *private =3D drm->dev_private;
> > @@ -401,26 +417,42 @@ static const struct component_master_ops mtk_drm_=
ops =3D {
> >  static const struct of_device_id mtk_ddp_comp_dt_ids[] =3D {
> >         { .compatible =3D "mediatek,mt2701-disp-ovl",
> >           .data =3D (void *)MTK_DISP_OVL },
> > +       { .compatible =3D "mediatek,mt8167-disp-ovl",
> > +         .data =3D (void *)MTK_DISP_OVL },
> >         { .compatible =3D "mediatek,mt8173-disp-ovl",
> >           .data =3D (void *)MTK_DISP_OVL },
> >         { .compatible =3D "mediatek,mt2701-disp-rdma",
> >           .data =3D (void *)MTK_DISP_RDMA },
> > +       { .compatible =3D "mediatek,mt8167-disp-rdma",
> > +         .data =3D (void *)MTK_DISP_RDMA },
> >         { .compatible =3D "mediatek,mt8173-disp-rdma",
> >           .data =3D (void *)MTK_DISP_RDMA },
> >         { .compatible =3D "mediatek,mt8173-disp-wdma",
> >           .data =3D (void *)MTK_DISP_WDMA },
> > +       { .compatible =3D "mediatek,mt8167-disp-ccorr",
> > +         .data =3D (void *)MTK_DISP_CCORR },
> >         { .compatible =3D "mediatek,mt2701-disp-color",
> >           .data =3D (void *)MTK_DISP_COLOR },
> > +       { .compatible =3D "mediatek,mt8167-disp-color",
> > +         .data =3D (void *)MTK_DISP_COLOR },
> >         { .compatible =3D "mediatek,mt8173-disp-color",
> >           .data =3D (void *)MTK_DISP_COLOR },
> > +       { .compatible =3D "mediatek,mt8167-disp-aal",
> > +         .data =3D (void *)MTK_DISP_AAL},
> >         { .compatible =3D "mediatek,mt8173-disp-aal",
> >           .data =3D (void *)MTK_DISP_AAL},
> > +       { .compatible =3D "mediatek,mt8167-disp-gamma",
> > +         .data =3D (void *)MTK_DISP_GAMMA, },
> >         { .compatible =3D "mediatek,mt8173-disp-gamma",
> >           .data =3D (void *)MTK_DISP_GAMMA, },
> > +       { .compatible =3D "mediatek,mt8167-disp-dither",
> > +         .data =3D (void *)MTK_DISP_DITHER },
> >         { .compatible =3D "mediatek,mt8173-disp-ufoe",
> >           .data =3D (void *)MTK_DISP_UFOE },
> >         { .compatible =3D "mediatek,mt2701-dsi",
> >           .data =3D (void *)MTK_DSI },
> > +       { .compatible =3D "mediatek,mt8167-dsi",
> > +         .data =3D (void *)MTK_DSI },
> >         { .compatible =3D "mediatek,mt8173-dsi",
> >           .data =3D (void *)MTK_DSI },
> >         { .compatible =3D "mediatek,mt2701-dpi",
> > @@ -431,10 +463,14 @@ static const struct of_device_id mtk_ddp_comp_dt_=
ids[] =3D {
> >           .data =3D (void *)MTK_DISP_MUTEX },
> >         { .compatible =3D "mediatek,mt2712-disp-mutex",
> >           .data =3D (void *)MTK_DISP_MUTEX },
> > +       { .compatible =3D "mediatek,mt8167-disp-mutex",
> > +         .data =3D (void *)MTK_DISP_MUTEX },
> >         { .compatible =3D "mediatek,mt8173-disp-mutex",
> >           .data =3D (void *)MTK_DISP_MUTEX },
> >         { .compatible =3D "mediatek,mt2701-disp-pwm",
> >           .data =3D (void *)MTK_DISP_BLS },
> > +       { .compatible =3D "mediatek,mt8167-disp-pwm",
> > +         .data =3D (void *)MTK_DISP_PWM },
> >         { .compatible =3D "mediatek,mt8173-disp-pwm",
> >           .data =3D (void *)MTK_DISP_PWM },
> >         { .compatible =3D "mediatek,mt8173-disp-od",
> > @@ -449,6 +485,8 @@ static const struct of_device_id mtk_drm_of_ids[] =
=3D {
> >           .data =3D &mt7623_mmsys_driver_data},
> >         { .compatible =3D "mediatek,mt2712-mmsys",
> >           .data =3D &mt2712_mmsys_driver_data},
> > +       { .compatible =3D "mediatek,mt8167-mmsys",
>
> This patch looks good to me, but it depend on another patch which
> define the compatible "mediatek,mt8167-mmsys". Where is that patch?

You can find the patch there:
https://patchwork.kernel.org/project/linux-mediatek/patch/20201027160631.60=
8503-2-fparent@baylibre.com/

>
> Regards,
> Chun-Kuang.
>
> > +         .data =3D &mt8167_mmsys_driver_data},
> >         { .compatible =3D "mediatek,mt8173-mmsys",
> >           .data =3D &mt8173_mmsys_driver_data},
> >         { }
> > --
> > 2.28.0
> >
