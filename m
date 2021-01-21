Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B02FF887
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAUXPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbhAUXOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:14:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CED3323A61
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611270801;
        bh=L82o30HXnB+r+O8K3ReoPbDoDul/+56tBIA0cVJ1k7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HTOCdCskXbs2ygNkKPsG2P/cbDyJwdctxQKe61LEcLxV9yAgYlXmUGknc9aMA733k
         lFEVo5RGDpfHMyCrPK8I4zIkWz8gqhp1sKdmpaC0oCoT0dSpVk2cZQ6IWum8IpG2O1
         Nuf8grls9siIib7NylYx48OvFGZjNapsm4txfvJPNmzqwpc0oXR93FmZqr473CHDQT
         xf+WWTZ3xWTpw9RPiTmsUbc8zOvpLw9KqwE+apkX6ydfRTvzJgoE3aSdxHssYc8A6G
         eOEgBtgfD86bUveAE0nqHDzF6kE6UyAcK80EnXsuA1an5FihgZ+557zMS+EOuTVmj3
         WvX5rUauXdLmA==
Received: by mail-ej1-f41.google.com with SMTP id 6so5051992ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:13:20 -0800 (PST)
X-Gm-Message-State: AOAM532e4EYbbfF/9LSY7VAeyYiF0i7/RaNcSldDuURcwdv1ycEXCPUb
        UwwI8wI5RgJs7xE0TV5N5ne0dw6fkyM/Lgixxg==
X-Google-Smtp-Source: ABdhPJzG4Ks7WM5fSRNcwNtoBMUhfREE7+DUgbVC917IPz+USYGjYtUsbnVlrkK0juN38OIES4PmwqHxTUNKY+mA6hY=
X-Received: by 2002:a17:906:ada:: with SMTP id z26mr1169169ejf.127.1611270799319;
 Thu, 21 Jan 2021 15:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
 <20210106231729.17173-4-chunkuang.hu@kernel.org> <YAh2JGUUpMcgyke0@ziggy.stardust>
 <CAAOTY_82Z_DQuJWDD5NMeq35o2Tf-zQzmSxJwRYRRpHQJVHNEA@mail.gmail.com> <YAk4722oCzcegGdx@ziggy.stardust>
In-Reply-To: <YAk4722oCzcegGdx@ziggy.stardust>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 22 Jan 2021 07:13:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY__S2WMO9sUOP4NaObCdvtRNdLNe3VHrE2RbgHBM-gYosw@mail.gmail.com>
Message-ID: <CAAOTY__S2WMO9sUOP4NaObCdvtRNdLNe3VHrE2RbgHBM-gYosw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/mediatek: Change disp/ddp term to mutex in mtk
 mutex driver
To:     Matthias Brugger <matthias.bgg@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Brugger <matthias.bgg@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8821=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Jan 21, 2021 at 07:46:44AM +0800, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > Matthias Brugger <matthias.bgg@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=
=9C=8821=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > On Thu, Jan 07, 2021 at 07:17:27AM +0800, Chun-Kuang Hu wrote:
> > > > From: CK Hu <ck.hu@mediatek.com>
> > > >
> > > > mtk mutex is used by both drm and mdp driver, so change disp/ddp te=
rm to
> > > > mutex to show that it's a common driver for drm and mdp.
> > > >
> > > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  30 +--
> > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   2 +-
> > > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   2 +-
> > > >  drivers/gpu/drm/mediatek/mtk_mutex.c    | 305 ++++++++++++--------=
----
> > > >  drivers/gpu/drm/mediatek/mtk_mutex.h    |  26 +-
> > > >  5 files changed, 182 insertions(+), 183 deletions(-)
> > > >
> > > [...]
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/gpu/drm=
/mediatek/mtk_mutex.c
> > > > index 1c8a253f4788..98a060bf225d 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_mutex.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_mutex.c
> > > [...]
> > > >
> > > > -static const struct of_device_id ddp_driver_dt_match[] =3D {
> > > > +static const struct of_device_id mutex_driver_dt_match[] =3D {
> > > >       { .compatible =3D "mediatek,mt2701-disp-mutex",
> > > > -       .data =3D &mt2701_ddp_driver_data},
> > > > +       .data =3D &mt2701_mutex_driver_data},
> > > >       { .compatible =3D "mediatek,mt2712-disp-mutex",
> > > > -       .data =3D &mt2712_ddp_driver_data},
> > > > +       .data =3D &mt2712_mutex_driver_data},
> > > >       { .compatible =3D "mediatek,mt8167-disp-mutex",
> > > > -       .data =3D &mt8167_ddp_driver_data},
> > > > +       .data =3D &mt8167_mutex_driver_data},
> > > >       { .compatible =3D "mediatek,mt8173-disp-mutex",
> > > > -       .data =3D &mt8173_ddp_driver_data},
> > > > +       .data =3D &mt8173_mutex_driver_data},
> > > >       {},
> > > >  };
> > > > -MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> > > > +MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
> > >
> > > I think it would make sense in a follow-up patch to update the bindin=
g
> > > to use "mediatek,mt2701-mutex" to reflect that mutex is used for drm =
and
> > > mdp driver. Make sense?
> >
> > Yes, it make sense. I would try to update the binding, but I wonder
> > device tree should be backward compatible? Let's discuss in that
> > follow-up patches.
> >
>
> From my understanding, we will need to keep the of_device_id entries for
> the old binding in the driver (so that old DTs still work) while we
> should enforce the new binding. I'm not sure if the yaml has a option
> for out-of-date compatibles.

OK, I would do it so and remove out-f-date compatibles in yaml at
first to see any feedback.

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
