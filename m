Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847F32E1EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgLWPtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgLWPtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:49:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B576623355;
        Wed, 23 Dec 2020 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608738512;
        bh=gFOktdnZlZmvTlgAN2h803xCQHcUKcooY0lSAj9WxE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o2T+kP9Zf8ewOB+fTNCWBn4of8xAvAv/wo3t9SulGgGTIL9cbgA/kqr9/DtwuPk6X
         VV8CxKCYitOHii4Nc9/XAUa7Yh0lKzg4gCYVVCkSCDMFFzJKE5Z+qZrPfQyUT073aN
         SL1o0C4ALeTb7VuoarrkZyr2nAz0UIgE8bZVeW3DmWEefKTO4JXlL8tdn2QbTY7Gm4
         6+kmIR0ZGg7KSAI9WMMzMWLU+0F3uMluYny9LWunarEkfg8aIOGO79NUdslsSFnK3D
         VyNypJ55YsXkL7OmxjgNkbs6RXx4RDvx/dw+upmiDnbiqfSs6jussFiqh7X8Q2eZHC
         QoQSM9bNUd3ow==
Received: by mail-ed1-f41.google.com with SMTP id c7so16597914edv.6;
        Wed, 23 Dec 2020 07:48:31 -0800 (PST)
X-Gm-Message-State: AOAM531PP6Qm7GHgUWvrQACq8FA1xxq55YCGqxK+PcxR73ZfyLJEu+0E
        8XyAy67zQFN3sIE8m6sl9AR4A0Xt0Yil2TBuVQ==
X-Google-Smtp-Source: ABdhPJwb5w2chHm2EqxPnyCoI9LEydqAoLEm1aIKXtYZ+vl4PEgEEDKf4mkp5MzyZv81GXD9gbxVNqMMg+4+cPbvMq4=
X-Received: by 2002:a50:fc83:: with SMTP id f3mr25508730edq.219.1608738510218;
 Wed, 23 Dec 2020 07:48:30 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607746317-4696-13-git-send-email-yongqiang.niu@mediatek.com>
 <CAAOTY_9gzncFEFe8uyhNSO0Mr9SnQ0b5oCC31_4QSdMtwOx0Mw@mail.gmail.com> <1608687471.18252.10.camel@mhfsdcap03>
In-Reply-To: <1608687471.18252.10.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 23 Dec 2020 23:48:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=QuVvyrFiUP=8-EMNPmgTK9TZr_ZmuJ=SbHZEjNnxyw@mail.gmail.com>
Message-ID: <CAAOTY_9=QuVvyrFiUP=8-EMNPmgTK9TZr_ZmuJ=SbHZEjNnxyw@mail.gmail.com>
Subject: Re: [PATCH v2, 12/17] drm/mediatek: fix gamma size config
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:37=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, 2020-12-15 at 07:40 +0800, Chun-Kuang Hu wrote:
> > Hi, Yongqiang:
> >
> > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=
=9C=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:13=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > fix gamma size config
> >
> > I would like you to provide more information. The original code works
> > in mt8173, why do you modify this? The description may be something
> > like this:
> >
> > According to data sheet, the width is in bits [31, 16] and height is
> > in bits [15, 0]. Even though wrong setting may works in some SoC such
> > as mt8173, but it does not work in mt8192.
> >
> > Regards,
> > Chun-Kuang.
>
> it still works in mt8192.
> just modify this follow data sheet

This patch is not strongly related to MT8192, so move this patch out
of this series.

Regards,
Chun-Kuang.

>
> >
> > >
> > > Fixes: e0a5d3370245 (drm/mediatek: Add GAMMA engine basic function)
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gp=
u/drm/mediatek/mtk_drm_ddp_comp.c
> > > index 00d5687..52b6fc7 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > > @@ -297,7 +297,7 @@ static void mtk_gamma_config(struct mtk_ddp_comp =
*comp, unsigned int w,
> > >                              unsigned int h, unsigned int vrefresh,
> > >                              unsigned int bpc, struct cmdq_pkt *cmdq_=
pkt)
> > >  {
> > > -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_GAMMA_SIZE);
> > > +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_GAMMA_SIZE);
> > >         mtk_dither_set(comp, bpc, DISP_GAMMA_CFG, cmdq_pkt);
> > >  }
> > >
> > > --
> > > 1.8.1.1.dirty
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
