Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6611030198D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 05:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAXE5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 23:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbhAXE5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 23:57:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BC0A22C9F;
        Sun, 24 Jan 2021 04:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611464223;
        bh=+Dv2W7xUrIowE8lzvyg7LMXioDkpmKs4Tk/Bc5dD3ac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=prxBeikQt0KHNBec0XCwiIrxyhDRs5m11VZV4O+vUx9PV25en2+tYSzhelYr2OUdB
         1h3PXl5DgRhk7QeQCqoO4/4k4N90VQErSruYiXtZVnp7ltNt8qn9Un+bi9BzNr/G93
         mlM/GrTlw39LKBbsza6Akhjt8kCE20GnK+9rzIWRFR4X7blMBdfmgOdJCNGxhVvfEP
         NbbwJnLPXKa/v+Vb2XcgwdiOs05z9QduAFWc+tvgjY0XApV3g//X2Hwf1rhGgBFEBF
         7v1QOOlghhLaT7xhldqbmG0/3SdTABCx1Jtm9XoAS/l0Wnr1TcXHRyQiLuc3yrjSnv
         6x2UKyZAuaWVA==
Received: by mail-ed1-f48.google.com with SMTP id g24so11270602edw.9;
        Sat, 23 Jan 2021 20:57:03 -0800 (PST)
X-Gm-Message-State: AOAM531E9ozVK1F4cv+Cd6dKjF/auxBlQRuT8OwUuceNA5/t/01vmACu
        9pvnP1ZsREP6MMQNTN/gVr0j2wYIUtevLpMNjw==
X-Google-Smtp-Source: ABdhPJwSMImeoz+A6pH+O3PAla2mGiOTiQQ5C2GVf4VJbqxKYrHrXCj9enw3rYIbJLnELNxQr2L4gK4y4v3aX1He228=
X-Received: by 2002:a50:c3c5:: with SMTP id i5mr67225edf.166.1611464222173;
 Sat, 23 Jan 2021 20:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
 <20210122120323.4337-3-chunfeng.yun@mediatek.com> <CAAOTY__O=z-AOo1RCRGfJYuSsXs1cUZgWFaTQz_3W_Tj=CeFBQ@mail.gmail.com>
In-Reply-To: <CAAOTY__O=z-AOo1RCRGfJYuSsXs1cUZgWFaTQz_3W_Tj=CeFBQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 24 Jan 2021 12:56:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8X35EpvLiSOuNdj4dVu7KBocw9mhaKG4TJy24LizvHNg@mail.gmail.com>
Message-ID: <CAAOTY_8X35EpvLiSOuNdj4dVu7KBocw9mhaKG4TJy24LizvHNg@mail.gmail.com>
Subject: Re: [PATCH next v2 03/17] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8812:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Chunfeng:
>
> Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > The compatilbe "mediatek,mt7623-mipi-tx" is not supported in driver,
> > and in fact uses "mediatek,mt2701-mipi-tx" instead on MT7623, so change=
s
> > the compatible items to make dependence clear.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Sorry, please remove my reviewed-by tag. We should not define the
binding document according to the implementation of driver. We define
the binding document according to the hardware. So the description
should be like "mt7623-mipi-tx is compatible to mt2701-mipi-tx".

Regards,
Chun-Kuang.

>
> >
> > Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2: separate two patches suggested by CK
> > ---
> >  .../devicetree/bindings/phy/mediatek,dsi-phy.yaml   | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yam=
l b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> > index 71d4acea1f66..6e4d795f9b02 100644
> > --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> > @@ -19,11 +19,14 @@ properties:
> >      pattern: "^dsi-phy@[0-9a-f]+$"
> >
> >    compatible:
> > -    enum:
> > -      - mediatek,mt2701-mipi-tx
> > -      - mediatek,mt7623-mipi-tx
> > -      - mediatek,mt8173-mipi-tx
> > -      - mediatek,mt8183-mipi-tx
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt7623-mipi-tx
> > +          - const: mediatek,mt2701-mipi-tx
> > +      - const: mediatek,mt2701-mipi-tx
> > +      - const: mediatek,mt8173-mipi-tx
> > +      - const: mediatek,mt8183-mipi-tx
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.18.0
