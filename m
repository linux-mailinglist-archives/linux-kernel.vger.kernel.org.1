Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29122D9A62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407912AbgLNOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406954AbgLNOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:11 -0500
X-Gm-Message-State: AOAM533uTUwhWZ4kEPSTtNs1NqTvRMe9qkARSrAb0INdqWuYaCRoCVR5
        TFTPFhkLCCaVpR+R9r+xYMwcKrQu5+XbKrKedg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607957668;
        bh=lx5LcB4r8kThhsWgyjSZ+LWhuKJpQwGa8oXjjRjm8yY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RS3eYjNQYmDFQA7FmdEX3nxqALFkO77gC8VpWHirjJClhd+5Dwy0yRNu1+KhTfH4a
         cqLZgg/Kkskv4JPmU7JM+DynYOaMl3h0zivY/hoPC+ErlcrFlPH/ad04c1d+5YQ5Ma
         rZhVtTeWMyp9ZI3yoPEaQYE6IZmJsOf3Diyl2l8fuvOsYYoia+bs9NqJlPn6agoKZ1
         bIfwzohw/9gHciYqVku6BHJ8LazxVQiEexyGXGFREbFUxxkfjWPvOfuwJN5CWS91HD
         0kWGbHqO9DXNIcJL+uV33r6CGR+3Ocj3JgrL05xqwZ8KmJWNCI5trWCt0ktl5sT5yp
         nKd/kmFx/tQVw==
X-Google-Smtp-Source: ABdhPJywDyFHYaIxrWSBcAnDDsvFyzMN1rO/xQl7TxTsoTfGwXme0jp7BjNRTzumje835VaKEkDPyyP8R0QtuCPZpGE=
X-Received: by 2002:a17:906:ae4e:: with SMTP id lf14mr23355440ejb.310.1607957666417;
 Mon, 14 Dec 2020 06:54:26 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607591262-21736-6-git-send-email-yongqiang.niu@mediatek.com>
 <CAAOTY_-aYFz1Xg6r2ur+BF_k_35F3qNLLb16_2c0MaMsYre-+w@mail.gmail.com> <1607647514.12750.5.camel@mhfsdcap03>
In-Reply-To: <1607647514.12750.5.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 14 Dec 2020 22:54:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY__HA95WLNppOKainvsZCxA6Wv3edLyvOW6FxAjUos=afQ@mail.gmail.com>
Message-ID: <CAAOTY__HA95WLNppOKainvsZCxA6Wv3edLyvOW6FxAjUos=afQ@mail.gmail.com>
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

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=888:45=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, 2020-12-10 at 23:50 +0800, Chun-Kuang Hu wrote:
> > Hi, Yongqiang:
> >
> > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=
=9C=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:08=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > This patch add RDMA fifo size error handle
> > > rdma fifo size will not always bigger than the calculated threshold
> > > if that case happened, we need set fifo size as the threshold
> > >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/d=
rm/mediatek/mtk_disp_rdma.c
> > > index 794acc5..0508392 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > > @@ -151,6 +151,10 @@ static void mtk_rdma_config(struct mtk_ddp_comp =
*comp, unsigned int width,
> > >          * account for blanking, and with a pixel depth of 4 bytes:
> > >          */
> > >         threshold =3D width * height * vrefresh * 4 * 7 / 1000000;
> > > +
> > > +       if (threshold > rdma_fifo_size)
> > > +               threshold =3D rdma_fifo_size;
> >
> > If the formula is not correct, you should fix the formula not work arou=
nd.
> >
> > Regards,
> > Chun-Kuang.
>
> how about this:
> threshold =3D max(width * height * vrefresh * 4 * 7 / 1000000,
> rdma_fifo_size);

When I use width =3D 1920, height =3D 1080, vrefresh =3D 60 to calculate, I
get threshold =3D 2985.
So I think set threshold to half of fifo size is OK for MAX_WIDTH,
MAX_HEIGHT, MAX_VREFRESH (these three may be different in each SoC)

threshold =3D RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) / 2;

But I worry half fifo size is too big for small resolution and let
small resolution too easy to trigger burst read DRAM. So let the
formula to be this:

threshold =3D RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) * width * height *
vrefresh / 2 / MAX_WIDTH / MAX_HEIGHT / MAX_VREFRESH;

How do you think about this?

Regards,
Chun-Kuang.

> >
> > > +
> > >         reg =3D RDMA_FIFO_UNDERFLOW_EN |
> > >               RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
> > >               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> > > --
> > > 1.8.1.1.dirty
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
