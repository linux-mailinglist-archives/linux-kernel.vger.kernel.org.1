Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68F2AD559
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgKJLfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:35:37 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38653 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbgKJLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:35:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3090D5C016C;
        Tue, 10 Nov 2020 06:35:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Nov 2020 06:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8RqXGl78Covxbvr7ww003ID22YO
        ld8Ffrms2/TWjkJk=; b=ROWYVVCcvEOemHgFH6G0pj2ufzlnjATIIPuOVBDUwBZ
        jgpBs/ffUyq6/PYSYZe6dTQSLH4N6fpG8x9dQTBhTHobSg397Y/yPVmcRHSOqVCI
        R6pkvgeTiZoYmsXiXZ+o0CqtLtRil/p4VF5X2dPNvHNU3tbvIJ7v/kXaexOthcKt
        tckauBC1a0wpjVf8vPFYd0dErXVS30o3u9RTrnuxMkpGI0GEjMg6DndZizfCVSTZ
        MCjdu2auvSYZy07jdTKMgAs+Ekj53rmGxprecZN2DBiRmm2km/+SFzQf2AMD4OKA
        2ttHQouHb1rNgRhBm2iXcGcUg9Mh/SDXLuG3VjDIKoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8RqXGl
        78Covxbvr7ww003ID22YOld8Ffrms2/TWjkJk=; b=iYCJRtgXwtOYoTmrfbL/Z7
        wJ2W/xJAA0TmuiKewFlL1Mp2f6NhOTYiriIwFiqH/1Qi0eL7+pK8jFAcbx/Rl2Np
        J88TPPZz9vMaDfSMtPkvyfLhJLKVBdUEjwxwaMZCVnUz3mb47CtknGkytD7u7n2D
        n5xEyddDLW+0mVz9JhZpn95n246PuczzQGqM/o4HLuxXpjiBWFBG5yh6CkSocSTk
        cTCqmv7TXeWgcBGIGbVJfclBfyweYJ29hosWgTnT7s4PnAHMWea/iZOTqRj1BtKa
        C4+ntDkCIwLl5VQMn7rxXkwytzj4YGiVJG3MHorxE3MYEMM2vBlkGApYwyE+vX/g
        ==
X-ME-Sender: <xms:BHuqX3M1h1AXP4uk2mMsjSKmwnKOTf8CrKN4K-Df1uEpxNi0EN7zKA>
    <xme:BHuqXx8wkQu8NRHRL-kYsQO3UPKBxr6u87M6jevD3rDjuRlR3Yp-G2Jz0uHiKlCRd
    sFfwehEqQcYSXvB6fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BHuqX2SvAZRDpUpQyk_bVuWYhoWAfiNJdyu_YYBKEXs3nt1Rq44UiQ>
    <xmx:BHuqX7vxXjXGNiZeFiY0JURqQTrr-TS6g2vA_pOXvs_rL79BY3XwBw>
    <xmx:BHuqX_eyQkUoASzMv2py12Xq762OiPEsvltY3Sv10niTQ_YoD7rdcA>
    <xmx:BnuqXwGmEx4Xnh6iKUJXXbDdr_nvrjdEA3E-gJquQQku8JYR2uuydw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A1DBB3280059;
        Tue, 10 Nov 2020 06:35:32 -0500 (EST)
Date:   Tue, 10 Nov 2020 12:35:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: gpio: =?utf-8?Q?sunxi=EF=BC=9Acreat?=
 =?utf-8?Q?e?= a DT header for Allwinner pin controller
Message-ID: <20201110113530.rtuo7nbez6r4xtjc@gilmour.lan>
References: <20200715115412.2544-1-frank@allwinnertech.com>
 <20200717160727.e6y5htg4sjd7bezi@gilmour.lan>
 <db1908ae-817c-f30d-7b88-f4afa593b258@sholland.org>
 <20200729130637.5md3tr6zg7s4wrmh@gilmour.lan>
 <CAEExFWstKV_uMbh5iQ9ULX7=24aj0_6Ge+4uFe07WmwiyDDRMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p46kcmc5bd2wuogb"
Content-Disposition: inline
In-Reply-To: <CAEExFWstKV_uMbh5iQ9ULX7=24aj0_6Ge+4uFe07WmwiyDDRMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p46kcmc5bd2wuogb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 08:15:45PM +0800, Frank Lee wrote:
> On Wed, Jul 29, 2020 at 9:06 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Sat, Jul 25, 2020 at 02:18:39PM -0500, Samuel Holland wrote:
> > > On 7/17/20 11:07 AM, Maxime Ripard wrote:
> > > > Hi!
> > > >
> > > > On Wed, Jul 15, 2020 at 07:54:12PM +0800, Frank Lee wrote:
> > > >> From: Yangtao Li <frank@allwinnertech.com>
> > > >>
> > > >> The sunxi gpio binding defines a few custom cells for its gpio spe=
cifier.
> > > >> Provide bank name for those.
> > > >>
> > > >> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > > >
> > > > Thanks for working on this, I wanted to do it at some point but it =
kept
> > > > getting pushed further into my todo list.
> > > >
> > > >> ---
> > > >>  include/dt-bindings/gpio/sunxi-gpio.h | 29 ++++++++++++++++++++++=
+++++
> > > >>  1 file changed, 29 insertions(+)
> > > >>  create mode 100644 include/dt-bindings/gpio/sunxi-gpio.h
> > > >>
> > > >> diff --git a/include/dt-bindings/gpio/sunxi-gpio.h b/include/dt-bi=
ndings/gpio/sunxi-gpio.h
> > > >> new file mode 100644
> > > >> index 000000000000..c692b4360da6
> > > >> --- /dev/null
> > > >> +++ b/include/dt-bindings/gpio/sunxi-gpio.h
> > > >
> > > > So generally we've been using the compatible name as the file name.=
 You
> > > > should follow that convention too, and since it was added with the =
A10,
> > > > using the A10 compatible.
> > > >
> > > >> @@ -0,0 +1,29 @@
> > > >> +/* SPDX-License-Identifier: GPL-2.0 */
> > > >> +/*
> > > >> + * GPIO definitions for Allwinner SoCs
> > > >> + *
> > > >> + * Copyright (C) 2020 Yangtao Li <frank@allwinnertech.com>
> > > >> + */
> > > >> +
> > > >> +#ifndef _DT_BINDINGS_SUNXI_GPIO_H
> > > >> +#define _DT_BINDINGS_SUNXI_GPIO_H
> > > >> +
> > > >> +#include <dt-bindings/gpio/gpio.h>
> > > >> +
> > > >> +/* pio */
> > > >> +#define PA        0
> > > >> +#define PB        1
> > > >> +#define PC        2
> > > >> +#define PD        3
> > > >> +#define PE        4
> > > >> +#define PF        5
> > > >> +#define PG        6
> > > >> +#define PH        7
> > > >> +#define PI        8
> > > >> +
> > > >> +/* r-pio */
> > > >> +#define PL        0
> > > >> +#define PM        1
> > > >> +#define PN        2
> > > >> +
> > > >> +#endif /* _DT_BINDINGS_SUNXI_GPIO_H */
> > > >
> > > > Maybe we can go one step further and use a macro to have something =
like
> > > > PIN(A, 12) ?
> > >
> > > Since we have separate cells for the bank and pin, I don't think it w=
ould be
> > > appropriate to have a single macro generating both.
> >
> > Yeah, but it's "just" an encoding issue though, it's not a major concern
> > if it makes our life easier.
> >
> > > And I'm not sure what the benefit of the macro would be, if all it
> > > does is forward its arguments. Are you concerned that P[A-M] could
> > > conflict with something else in the device tree?
> >
> > There's indeed a bunch of names that are fairly generic and could be
> > conflicting with others (PD for power domain is the first one that comes
> > to my mind). Using a prefix would make the GPIO descriptors pretty long,
> > so it wasn't ideal either. A macro makes it readable without increasing
> > too much the risks of conflicts
>=20
> I tried to use macros, but failed.
>=20
> I have a look at some other GPIO macros, which have a prefix in front of =
them.
> Maybe we can do the same? It's all numbers. It's not intuitive.

This works

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index f3f8e177ab61..3a66d1102a78 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -8,6 +8,9 @@
=20
 #include <dt-bindings/gpio/gpio.h>
=20
+#define SUNXI_PE 4
+#define SUNXI_PIN(bank, pin)    SUNXI_##bank pin
+
 / {
 	model =3D "Olimex A64-Olinuxino";
 	compatible =3D "olimex,a64-olinuxino", "allwinner,sun50i-a64";
@@ -37,7 +40,7 @@ leds {
=20
 		led-0 {
 			label =3D "a64-olinuxino:red:user";
-			gpios =3D <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
+			gpios =3D <&pio SUNXI_PIN(PE, 17) GPIO_ACTIVE_HIGH>;
 		};
 	};
=20

Maxime

--p46kcmc5bd2wuogb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6p7AgAKCRDj7w1vZxhR
xaZIAP4kKe1HN6QbbWLT3zvzIUpn37zaZb0odq3twp5hz5ZaYgEAwEP90OzyZQcZ
9CVs+apvim7KJ4sb+1sK2dwUEtj66Ag=
=ll9u
-----END PGP SIGNATURE-----

--p46kcmc5bd2wuogb--
