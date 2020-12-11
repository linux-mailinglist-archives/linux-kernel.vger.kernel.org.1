Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B72D78C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406562AbgLKPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406548AbgLKPFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:05:14 -0500
X-Gm-Message-State: AOAM5321Q88Ga4kOvROtWKwptfs7tu6P56B86qs8Hfjd0W4d8xc7o4vA
        xMFM1yfYf1lC0Pc7TDMgniLCKmFGENaJgbHhyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607698012;
        bh=kMGlC86uydZtd+hqrVgic6SM+HBSXPFoclUBLRZV+W0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oIyQEnHRnQVqjF3lPXkM2jdJZPuJrBRV4mjDmkyC7D2YkMytrKxvnLYtY/MuZ8U/Z
         W2OUDIdIl5P5nA+Grcj7irhjVn0ALUSpEaB9xq3sTtFco4Ioc5EaORLgi+/Fx1x1B1
         xuTzcH5vpNBd8jobFSsDlhuU/N6m6vTAlNmwOCa52uoTl+L+OKQeUIZBQMMDrnbCbl
         aWGhg7987Lki9Xe3xfn+ju4MxOO01qIDqA7zvZYo8oun/gimaAkwCOmj43NF6l0pID
         NrBJeFA4dAUjrbCc1WRzn31ZiyySttmX0+rmnlXaoevbPEZszXOPWO4MHLzSftdiW2
         VV7HliYYfHt3g==
X-Google-Smtp-Source: ABdhPJwAF2z+4ptZLYQgJaLTwt2m+q4kzvOhtU1ax7sWHg9DZiTR/rIDy9PKQk1Nfa6Qmwufx6w8ViJve1ZjDZ/qZUQ=
X-Received: by 2002:a5d:6443:: with SMTP id d3mr14035794wrw.422.1607698005242;
 Fri, 11 Dec 2020 06:46:45 -0800 (PST)
MIME-Version: 1.0
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607591262-21736-2-git-send-email-yongqiang.niu@mediatek.com>
 <CAAOTY_-oL+NyzDKssCjyP=E8Py3oyEK6a6s=XoYvTFymZE9-zQ@mail.gmail.com> <1607647416.12750.3.camel@mhfsdcap03>
In-Reply-To: <1607647416.12750.3.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 11 Dec 2020 22:46:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY__y70tF2ORQDgZfk7RfeQm4fKraPnOQWMDnWsBb7HmZnQ@mail.gmail.com>
Message-ID: <CAAOTY__y70tF2ORQDgZfk7RfeQm4fKraPnOQWMDnWsBb7HmZnQ@mail.gmail.com>
Subject: Re: [PATCH v8, 1/6] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
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
=8811=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=888:43=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, 2020-12-10 at 23:40 +0800, Chun-Kuang Hu wrote:
> > Hi, Yongqiang:
> >
> > Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=
=9C=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:22=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > rdma fifo size may be different even in same SOC, add this
> > > property to the corresponding rdma
> > >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  .../bindings/display/mediatek/mediatek,disp.txt          | 16 ++++++=
++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/mediatek/media=
tek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt
> > > index 1212207..64c64ee 100644
> > > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dis=
p.txt
> > > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dis=
p.txt
> > > @@ -66,6 +66,13 @@ Required properties (DMA function blocks):
> > >    argument, see Documentation/devicetree/bindings/iommu/mediatek,iom=
mu.txt
> > >    for details.
> > >
> > > +Optional properties (RDMA function blocks):
> > > +- mediatek,rdma_fifo_size: rdma fifo size may be different even in s=
ame SOC, add this
> > > +  property to the corresponding rdma
> > > +  the value is the Max value which defined in hardware data sheet.
> > > +  rdma_fifo_size of rdma0 in mt8183 is 5120
> > > +  rdma_fifo_size of rdma1 in mt8183 is 2048
> > > +
> > >  Examples:
> > >
> > >  mmsys: clock-controller@14000000 {
> > > @@ -207,3 +214,12 @@ od@14023000 {
> > >         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
> > >         clocks =3D <&mmsys CLK_MM_DISP_OD>;
> > >  };
> > > +
> > > +rdma1: rdma@1400c000 {
> > > +       compatible =3D "mediatek,mt8183-disp-rdma";
> > > +       reg =3D <0 0x1400c000 0 0x1000>;
> > > +       interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> > > +       power-domains =3D <&scpsys MT8183_POWER_DOMAIN_DISP>;
> > > +       clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
> > > +       mediatek,rdma_fifo_size =3D <2048>;
> > > +};
> >
> > In [1], Rob has suggest that not add example of rdma1, it's better to
> > add mediatek,rdma_fifo_size in rdma0 for example.
> >
> > [1] https://patchwork.kernel.org/project/linux-mediatek/patch/159685523=
1-5782-2-git-send-email-yongqiang.niu@mediatek.com/
> >
> > Regards,
> > Chun-Kuang.
>
> the description of rdma0 is mt8173, and mt8173 rdma driver set the
> correspond fifo size already ok like this:
> static const struct mtk_disp_rdma_data mt8173_rdma_driver_data =3D {
>         .fifo_size =3D SZ_8K,
> };
>
> please double confirm shall we add this information into rdma0
> description.
>

Device tree is used to describe hardware. That means device tree
description should not consider your driver's implementation.
mediatek,rdma-fifo-size of mt8173-rdma0 is 8K, so I could write this
information in device node because this hardware is.

Regards,
Chun-Kuang.

>
> >
> > > --
> > > 1.8.1.1.dirty
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
