Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4401295287
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504537AbgJUS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395239AbgJUS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:56:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:56:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b8so4265447ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cc/K/PIuG41/PR7b04TzfA68X44vY0DhA0nNvxK+odE=;
        b=GrBOpz3B04eglI4Ou/H+aoMQQg7CO3n/sx11CnC2KFyl751f5YKbxaSJfAieTMWw+3
         kUWQ215pQELE9Py74xWRSY0RUbNNU8vjRkpRQdw7F2GGU/dlVP7gC2Eu6WVVw+Hv6gmq
         fT3Ik/FKSDcRA8IdinKj2EfiCJZ8PsY1Wpev4G37iKVKPC3gKiVcL75dRi5pCmlhLOnb
         xw6VL88vbHWo41Wgo35mqxEQH5kQUEKl7XojseMCtNHeMNA9jtXbEr72jh9Sdcuc9GaW
         bW/GP+M9fsP2tI1TpMf5ZvWbfEtZl4I+lpZjbzIxPbFgx9c8joumjuG2a2iPHZxVfnnB
         pD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cc/K/PIuG41/PR7b04TzfA68X44vY0DhA0nNvxK+odE=;
        b=dfea3sBSmHdzLrk0D7JAeJsQOl3OZt16Oxj6osr7no+3ALO4ehOgtxY8TiFE0d3qqK
         EdhNCCQt7/KK9bCbwck2DBjboGBy7yLyqp8gkRGu0Dg21zh4hn+JlVD2zoNL73MFxW5K
         JigBoFcBIxdHVhUZ18QzfRvUFLDIB9Y01aQuqfzfWrS1AcCx+R7p3b4Du4xzOsauo2sh
         G0yQ7SsmTXG+Zv6Yh/tU2ctiHRR6IuNqFwkcBFfmIHS86g+GGrcyZo8Lms1Ls7cIK110
         EV+44AYUol+Fk6jgy0wus4e96J22WaHFw7BJUeyt5vvgaYPeeg17IkXO1G+T+JQTLi0I
         L7hg==
X-Gm-Message-State: AOAM533WzobhuZhNHzwSY4HPG7Ed6e0wOZgI1WylTlobnTSS8l83Y317
        6Ku6tmHbSzM5g+aynZZ/xWuqMFFSbj0th/2rrKQDHg==
X-Google-Smtp-Source: ABdhPJyLG0RAlvFN8Zp7U5m+RnWUUNGK8TOymUgePPUKY/An2N5DmxSuoTuNWfKoZwAH4W8THjAuI9EyHl7jMFAlVZ4=
X-Received: by 2002:a05:6638:1243:: with SMTP id o3mr3993558jas.82.1603306603222;
 Wed, 21 Oct 2020 11:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201020174253.3757771-1-fparent@baylibre.com>
 <20201020174253.3757771-3-fparent@baylibre.com> <CAAOTY_9m-nqCe1HanPv5xa3mVLpyG6mC1pF1FRAFJdU1jqza_A@mail.gmail.com>
In-Reply-To: <CAAOTY_9m-nqCe1HanPv5xa3mVLpyG6mC1pF1FRAFJdU1jqza_A@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 21 Oct 2020 20:56:32 +0200
Message-ID: <CAOwMV_wvf6v1acXjtuB3Sm83YNyf=A7ULJkEDz7RY7T7mijqHg@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: display: mediatek: dsi: add
 documentation for MT8167 SoC
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

On Wed, Oct 21, 2020 at 7:01 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Fabien:
>
> Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Add binding documentation for the MT8167 SoC. The SoC needs
> > an additional clock compared to the already supported SoC: mipi26m.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt  | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi=
.txt
> > index f06f24d405a5..10ae6be7225e 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> > @@ -7,12 +7,13 @@ channel output.
> >
> >  Required properties:
> >  - compatible: "mediatek,<chip>-dsi"
> > -- the supported chips are mt2701, mt7623, mt8173 and mt8183.
> > +- the supported chips are mt2701, mt7623, mt8167, mt8173 and mt8183.
> >  - reg: Physical base address and length of the controller's registers
> >  - interrupts: The interrupt signal from the function block.
> >  - clocks: device clocks
> >    See Documentation/devicetree/bindings/clock/clock-bindings.txt for d=
etails.
> > -- clock-names: must contain "engine", "digital", and "hs"
> > +- clock-names: must contain "engine", "digital", "hs"
> > +  Can optionnally also contain "mipi26m"
>
> It seems that mipi26m is the clock of mipi-tx. In mt8173.dtsi [1],
> mipi-tx's clock is 26m.
>
> mipi_tx0: mipi-dphy@10215000 {
> compatible =3D "mediatek,mt8173-mipi-tx";
> reg =3D <0 0x10215000 0 0x1000>;
> clocks =3D <&clk26m>;
> clock-output-names =3D "mipi_tx0_pll";
> #clock-cells =3D <0>;
> #phy-cells =3D <0>;
> status =3D "disabled";
> };
>
> If this is the clock of mipi-tx, it should be controlled by mipi-tx drive=
r.

Thanks, I will fix that in v2.

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=3Dv5.9
>
> Regards,
> Chun-Kuang.
>
> >  - phys: phandle link to the MIPI D-PHY controller.
> >  - phy-names: must contain "dphy"
> >  - port: Output port node with endpoint definitions as described in
> > @@ -26,7 +27,7 @@ The MIPI TX configuration module controls the MIPI D-=
PHY.
> >
> >  Required properties:
> >  - compatible: "mediatek,<chip>-mipi-tx"
> > -- the supported chips are mt2701, 7623, mt8173 and mt8183.
> > +- the supported chips are mt2701, 7623, mt8167, mt8173 and mt8183.
> >  - reg: Physical base address and length of the controller's registers
> >  - clocks: PLL reference clock
> >  - clock-output-names: name of the output clock line to the DSI encoder
> > --
> > 2.28.0
> >
