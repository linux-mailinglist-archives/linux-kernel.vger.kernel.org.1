Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541FE2EB5F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbhAEXKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbhAEXKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:10:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDC1023100;
        Tue,  5 Jan 2021 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609888180;
        bh=fed5XlKEYP7XWtaTDihJhGMdXSKuB5tSlmnJYeJp5tA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XTorqmmoQFo45G1nbewWbvP/CAvceHKlyXWurSrvetkZZc/6Kuavisei2FTiVpZ13
         vVx27/Msk/wjDmCKaBFSV0xmyQ1R1rqj2S7HfSDf8rBdcUKh/FQjukqWHttxrImIBq
         i7q5eRq119nsRWEku8jfaeNm38AvuH8WI7exdD4y6oWj3Ej4qsbuUfrm1RUNEA4xuv
         d0qy0RR9uo3rbPxZ46uOG2qGaE9/oRYGdygF/B5cMKUXGNBrO3woliFM7wKvJ5/D4X
         goorMZ2I8ptX/nwdRzzsyYXqV7eAxwoDems14MOxsH0kTfIanPc6Nk6EINA1WNwL93
         YLgNEr/YXSuEw==
Received: by mail-ed1-f46.google.com with SMTP id r5so2552566eda.12;
        Tue, 05 Jan 2021 15:09:39 -0800 (PST)
X-Gm-Message-State: AOAM531y8+kAKzvNrnMc66NbVhJsDfGV55j7vZRwEejY/7cmNCa2VStj
        6NkbSeg11CMmeZwNHdrisKEZ3dXBcx4HIR6x6Q==
X-Google-Smtp-Source: ABdhPJzIhUlEvoUVEDqvgDDYC9VWDoT47pLXuX5VmL//f0UtuCznywGNVW5rGOqFAhZlyQJoJHGegCDvr8Y5OwVO8xU=
X-Received: by 2002:a50:fc96:: with SMTP id f22mr2120443edq.162.1609888178364;
 Tue, 05 Jan 2021 15:09:38 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607591262-21736-6-git-send-email-yongqiang.niu@mediatek.com>
 <CAAOTY_-aYFz1Xg6r2ur+BF_k_35F3qNLLb16_2c0MaMsYre-+w@mail.gmail.com>
 <1607647514.12750.5.camel@mhfsdcap03> <CAAOTY__HA95WLNppOKainvsZCxA6Wv3edLyvOW6FxAjUos=afQ@mail.gmail.com>
 <1609828577.1574.5.camel@mhfsdcap03>
In-Reply-To: <1609828577.1574.5.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 6 Jan 2021 07:09:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-AGNuwwCv-A_GWy7gDO8csXenJGciLsP7mRAUuUKWUKA@mail.gmail.com>
Message-ID: <CAAOTY_-AGNuwwCv-A_GWy7gDO8csXenJGciLsP7mRAUuUKWUKA@mail.gmail.com>
Subject: Re: [PATCH v8, 5/6] drm/mediatek: add RDMA fifo size error handle
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

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, 2020-12-14 at 22:54 +0800, Chun-Kuang Hu wrote:
> > Hi, Yongqiang:
> >
> > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=
=9C=8811=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=888:45=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > On Thu, 2020-12-10 at 23:50 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Yongqiang:
> > > >
> > > > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B41=
2=E6=9C=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:08=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > >
> > > > > This patch add RDMA fifo size error handle
> > > > > rdma fifo size will not always bigger than the calculated thresho=
ld
> > > > > if that case happened, we need set fifo size as the threshold
> > > > >
> > > > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > > > ---
> > > > >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/g=
pu/drm/mediatek/mtk_disp_rdma.c
> > > > > index 794acc5..0508392 100644
> > > > > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > > > > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > > > > @@ -151,6 +151,10 @@ static void mtk_rdma_config(struct mtk_ddp_c=
omp *comp, unsigned int width,
> > > > >          * account for blanking, and with a pixel depth of 4 byte=
s:
> > > > >          */
> > > > >         threshold =3D width * height * vrefresh * 4 * 7 / 1000000=
;
> > > > > +
> > > > > +       if (threshold > rdma_fifo_size)
> > > > > +               threshold =3D rdma_fifo_size;
> > > >
> > > > If the formula is not correct, you should fix the formula not work =
around.
> > > >
> > > > Regards,
> > > > Chun-Kuang.
> > >
> > > how about this:
> > > threshold =3D max(width * height * vrefresh * 4 * 7 / 1000000,
> > > rdma_fifo_size);
> >
> > When I use width =3D 1920, height =3D 1080, vrefresh =3D 60 to calculat=
e, I
> > get threshold =3D 2985.
> > So I think set threshold to half of fifo size is OK for MAX_WIDTH,
> > MAX_HEIGHT, MAX_VREFRESH (these three may be different in each SoC)
> >
> > threshold =3D RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) / 2;
> >
> > But I worry half fifo size is too big for small resolution and let
> > small resolution too easy to trigger burst read DRAM. So let the
> > formula to be this:
> >
> > threshold =3D RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) * width * height *
> > vrefresh / 2 / MAX_WIDTH / MAX_HEIGHT / MAX_VREFRESH;
> >
> > How do you think about this?
> >
> > Regards,
> > Chun-Kuang.
>
> how about remove this formula, and set threshold =3D rdma_fifo_size

This means that RDMA would always trigger burst read. In normal case,
I think no hardware would trigger burst read. Only the emergency
occur, the hardware trigger burst read. RDMA always triggering burst
read is good for RDMA, but it may hurt other hardware to read DRAM. So
I think RDMA should trigger burst read only when fifo data is under a
emergency threshold.

Regards,
Chun-Kuang.

> >
> > > >
> > > > > +
> > > > >         reg =3D RDMA_FIFO_UNDERFLOW_EN |
> > > > >               RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
> > > > >               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> > > > > --
> > > > > 1.8.1.1.dirty
> > > > > _______________________________________________
> > > > > Linux-mediatek mailing list
> > > > > Linux-mediatek@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
>
