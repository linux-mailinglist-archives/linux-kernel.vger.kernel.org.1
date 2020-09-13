Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B485267D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 03:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgIMB1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 21:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgIMB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 21:27:24 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0160221D6C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599960442;
        bh=N+1O+3nePb89QXKC6VoJWYEpD90fYclFPn/1MiIC4u8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vW7WnUWWiAgXJ2vfMzeuQBw3loVnGAYVbBIrISRoUQyGjT9GxMNNl3HlHYC5FHIfX
         ZS7WTTrZlYbRJrC53a8KOe10CwJg2OQu21aaCYhNUySqNf9O2hKqQJMmm2y0zTD79Y
         fzd1sJm4FpjuX9UcqPsREFY2Sa4QMvwaE+bE3fvE=
Received: by mail-ej1-f50.google.com with SMTP id nw23so18456526ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 18:27:21 -0700 (PDT)
X-Gm-Message-State: AOAM531MVD4ODC6PK84ntsJ+1u8aY8+SmI429gbZ6eg2URca3pBU3Eb4
        nk1Ss7qxooSfbbJeK9jJ0tr57aLw3jh0npEw3Q==
X-Google-Smtp-Source: ABdhPJxVU8LiDevXSpqfTDnRp2lRvK+BEjBFcnyTq0y4b+t6nIMDZVCyjRvKQ9jlXscFJGiMS9Sv5I5f362/wuN2NJQ=
X-Received: by 2002:a17:906:b756:: with SMTP id fx22mr8003575ejb.245.1599960440472;
 Sat, 12 Sep 2020 18:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826085317.681385-1-enric.balletbo@collabora.com>
 <20200826085317.681385-3-enric.balletbo@collabora.com> <CAAOTY__UwVCDn_J1RWesrm7eTS=Ti4LS9FutaydomFNLBVsF2g@mail.gmail.com>
 <20200910054828.GC438822@phenom.ffwll.local>
In-Reply-To: <20200910054828.GC438822@phenom.ffwll.local>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 13 Sep 2020 09:27:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-6KGLu+_gNLKMYzB1OdUvgohRgyc9-WQH4QCKQfs0_Mw@mail.gmail.com>
Message-ID: <CAAOTY_-6KGLu+_gNLKMYzB1OdUvgohRgyc9-WQH4QCKQfs0_Mw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] drm/mediatek: mtk_dpi: Convert to bridge driver
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        boris.brezillon@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Vetter <daniel@ffwll.ch> =E6=96=BC 2020=E5=B9=B49=E6=9C=8810=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Sep 10, 2020 at 06:35:21AM +0800, Chun-Kuang Hu wrote:
> > Hi, Andrzej & Neil:
> >
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B48=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:53=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > >
> > > Convert mtk_dpi to a bridge driver with built-in encoder support for
> > > compatibility with existing component drivers.
> > >
> >
> > This is a DRM-bridge related patch, how do you think about it?
>
> bridge stuff is also maintained in drm-misc, so good to go imo.
>
> For the bigger picture I think it'd be really good if bridges drivers
> would use the of bridge lookup, and not hand roll something with
> component. So 2nd step of converting this over to a proper bridge driver
> would be to replace the component code here too.

OK, so this series is applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Cheers, Daniel
>
> >
> > Regards,
> > Chun-Kuang.
> >
> > > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Maintain error message when attach to bridge fails. (Boris)
> > >
> > >  drivers/gpu/drm/mediatek/mtk_dpi.c | 71 ++++++++++++++++++----------=
--
> > >  1 file changed, 42 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/med=
iatek/mtk_dpi.c
> > > index f7372dbdac0e..589ef33a1780 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > @@ -64,6 +64,7 @@ enum mtk_dpi_out_color_format {
> > >  struct mtk_dpi {
> > >         struct mtk_ddp_comp ddp_comp;
> > >         struct drm_encoder encoder;
> > > +       struct drm_bridge bridge;
> > >         struct drm_bridge *next_bridge;
> > >         void __iomem *regs;
> > >         struct device *dev;
> > > @@ -83,9 +84,9 @@ struct mtk_dpi {
> > >         int refcount;
> > >  };
> > >
> > > -static inline struct mtk_dpi *mtk_dpi_from_encoder(struct drm_encode=
r *e)
> > > +static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
> > >  {
> > > -       return container_of(e, struct mtk_dpi, encoder);
> > > +       return container_of(b, struct mtk_dpi, bridge);
> > >  }
> > >
> > >  enum mtk_dpi_polarity {
> > > @@ -521,50 +522,53 @@ static int mtk_dpi_set_display_mode(struct mtk_=
dpi *dpi,
> > >         return 0;
> > >  }
> > >
> > > -static bool mtk_dpi_encoder_mode_fixup(struct drm_encoder *encoder,
> > > -                                      const struct drm_display_mode =
*mode,
> > > -                                      struct drm_display_mode *adjus=
ted_mode)
> > > +static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
> > >  {
> > > -       return true;
> > > +       drm_encoder_cleanup(encoder);
> > >  }
> > >
> > > -static void mtk_dpi_encoder_mode_set(struct drm_encoder *encoder,
> > > -                                    struct drm_display_mode *mode,
> > > -                                    struct drm_display_mode *adjuste=
d_mode)
> > > +static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> > > +       .destroy =3D mtk_dpi_encoder_destroy,
> > > +};
> > > +
> > > +static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
> > > +                                enum drm_bridge_attach_flags flags)
> > >  {
> > > -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
> > > +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> > > +
> > > +       return drm_bridge_attach(bridge->encoder, dpi->next_bridge,
> > > +                                &dpi->bridge, flags);
> > > +}
> > > +
> > > +static void mtk_dpi_bridge_mode_set(struct drm_bridge *bridge,
> > > +                               const struct drm_display_mode *mode,
> > > +                               const struct drm_display_mode *adjust=
ed_mode)
> > > +{
> > > +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> > >
> > >         drm_mode_copy(&dpi->mode, adjusted_mode);
> > >  }
> > >
> > > -static void mtk_dpi_encoder_disable(struct drm_encoder *encoder)
> > > +static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
> > >  {
> > > -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
> > > +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> > >
> > >         mtk_dpi_power_off(dpi);
> > >  }
> > >
> > > -static void mtk_dpi_encoder_enable(struct drm_encoder *encoder)
> > > +static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
> > >  {
> > > -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
> > > +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> > >
> > >         mtk_dpi_power_on(dpi);
> > >         mtk_dpi_set_display_mode(dpi, &dpi->mode);
> > >  }
> > >
> > > -static int mtk_dpi_atomic_check(struct drm_encoder *encoder,
> > > -                               struct drm_crtc_state *crtc_state,
> > > -                               struct drm_connector_state *conn_stat=
e)
> > > -{
> > > -       return 0;
> > > -}
> > > -
> > > -static const struct drm_encoder_helper_funcs mtk_dpi_encoder_helper_=
funcs =3D {
> > > -       .mode_fixup =3D mtk_dpi_encoder_mode_fixup,
> > > -       .mode_set =3D mtk_dpi_encoder_mode_set,
> > > -       .disable =3D mtk_dpi_encoder_disable,
> > > -       .enable =3D mtk_dpi_encoder_enable,
> > > -       .atomic_check =3D mtk_dpi_atomic_check,
> > > +static const struct drm_bridge_funcs mtk_dpi_bridge_funcs =3D {
> > > +       .attach =3D mtk_dpi_bridge_attach,
> > > +       .mode_set =3D mtk_dpi_bridge_mode_set,
> > > +       .disable =3D mtk_dpi_bridge_disable,
> > > +       .enable =3D mtk_dpi_bridge_enable,
> > >  };
> > >
> > >  static void mtk_dpi_start(struct mtk_ddp_comp *comp)
> > > @@ -605,12 +609,11 @@ static int mtk_dpi_bind(struct device *dev, str=
uct device *master, void *data)
> > >                 dev_err(dev, "Failed to initialize decoder: %d\n", re=
t);
> > >                 goto err_unregister;
> > >         }
> > > -       drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper=
_funcs);
> > >
> > >         /* Currently DPI0 is fixed to be driven by OVL1 */
> > >         dpi->encoder.possible_crtcs =3D BIT(1);
> > >
> > > -       ret =3D drm_bridge_attach(&dpi->encoder, dpi->next_bridge, NU=
LL, 0);
> > > +       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, =
0);
> > >         if (ret) {
> > >                 dev_err(dev, "Failed to attach bridge: %d\n", ret);
> > >                 goto err_cleanup;
> > > @@ -791,8 +794,15 @@ static int mtk_dpi_probe(struct platform_device =
*pdev)
> > >
> > >         platform_set_drvdata(pdev, dpi);
> > >
> > > +       dpi->bridge.funcs =3D &mtk_dpi_bridge_funcs;
> > > +       dpi->bridge.of_node =3D dev->of_node;
> > > +       dpi->bridge.type =3D DRM_MODE_CONNECTOR_DPI;
> > > +
> > > +       drm_bridge_add(&dpi->bridge);
> > > +
> > >         ret =3D component_add(dev, &mtk_dpi_component_ops);
> > >         if (ret) {
> > > +               drm_bridge_remove(&dpi->bridge);
> > >                 dev_err(dev, "Failed to add component: %d\n", ret);
> > >                 return ret;
> > >         }
> > > @@ -802,7 +812,10 @@ static int mtk_dpi_probe(struct platform_device =
*pdev)
> > >
> > >  static int mtk_dpi_remove(struct platform_device *pdev)
> > >  {
> > > +       struct mtk_dpi *dpi =3D platform_get_drvdata(pdev);
> > > +
> > >         component_del(&pdev->dev, &mtk_dpi_component_ops);
> > > +       drm_bridge_remove(&dpi->bridge);
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.28.0
> > >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
