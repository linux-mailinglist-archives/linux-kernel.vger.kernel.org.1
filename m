Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A12BAF79
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgKTP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:59:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46303 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728919AbgKTP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:59:43 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AFD05C00D0;
        Fri, 20 Nov 2020 10:59:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 20 Nov 2020 10:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=T1SgiXg1TuJbavRTzfVKemq6SSp
        RHfqpbA6KSfHRZ3A=; b=gE5ULDdLWhUA+NzBMolnoMD9lgWF8gh0PfpWMoF9dYa
        BEEK5RJcgGrhXIEGQC/XTNwJyGUtpHa5szUh6RXT9vm9ZWnyhbrOy6m1PA4Sv/nF
        eSeURNX+9PkuDE06XJqTS7I5HRdZCIkN1X213ZZK4yTSdNmnzUhCkiSllbI94xO1
        m2Ng2DUbaqkfD3CoxzWLopvrn22BhPMu/doL2ltf8dnOBOUfj5juMWW2ZXWpBemo
        EtlKMIVKZGo+1e3m6YRYiMKm5HdBCrBWwIc21ZV9pfTvpGBGgqmvKpv4J2+LldWI
        iQmT2yVsUZVYJsStw82KhLeKjrMoiagoiuv22XIdehw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=T1SgiX
        g1TuJbavRTzfVKemq6SSpRHfqpbA6KSfHRZ3A=; b=khT/YBqXeZ4OkkoVG2ymxs
        N8R3KV9iauibyf3Rix7OFTwH1xv8JvlnnvtOqB6PUtNqt3etRvdGVsvEsCZWqpNX
        +T69G1b51OJYtRnnE7gjJEAfj6xBAYEB/Vr50wEKsR1UZQIR+yRYyDs+RErgFw3Y
        7Yl+dom98iHtyXcfzfI3A3wVR3quu2NdX59M0rxi1FZS9bPdfG6cJNMOb9IWn7R8
        6OGo95HzWYIXc/1XAumfKjFO4YqKA1hRgWPzxWi8jt0lwrEf3H39lgGEW1IZVhhJ
        61iDZ5eNJ70lDUuR0O+fWFtyVwgwSK/+7Us49yfYnZgEYBG/Yf1vMIpAVrnbv0sw
        ==
X-ME-Sender: <xms:7Oe3XweQ_jR16EsfgDfeaywcxxuzzBlEMk70l5yacLRHnIf89hVyyw>
    <xme:7Oe3XyO5M2ayKsPc82DmJe-7dbBbzwzTEHICgm2YyOhaBsqhxMll2EK7yohkdsgJv
    qLa3t4hHxoCd0FAfIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:7Oe3Xxie__mkaR4XlWZif5kynFYrbCkJ1jd9a9bBfko7Wp_4sbstZQ>
    <xmx:7Oe3X19M4-ykQqbKbJEN90HAxXlkEtOqy4JIZLt1ncsBZpMX2FMF2w>
    <xmx:7Oe3X8uiPBn6FEZVIrQNawUHRpqwANl0ZUKERjUyI7uedkwpgJmavw>
    <xmx:7ee3X2U_7nuk06y3nedIE0QI9j0MD4jzR4cM67frbQdaLiA3bYZvSQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 719ED3280060;
        Fri, 20 Nov 2020 10:59:40 -0500 (EST)
Date:   Fri, 20 Nov 2020 16:59:39 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
Message-ID: <20201120155939.3ajmbny2pka2vsnf@gilmour>
References: <20201107124958.2222253-1-icenowy@aosc.io>
 <20201107125332.2223197-1-icenowy@aosc.io>
 <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
 <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
 <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kr27hb3hbkksxdbb"
Content-Disposition: inline
In-Reply-To: <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kr27hb3hbkksxdbb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 02:36:48AM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8816=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8811:55:08, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> >On Tue, Nov 10, 2020 at 06:41:37PM +0800, Icenowy Zheng wrote:
> >>=20
> >>=20
> >> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8810=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=886:39:25, Maxime Ripard <maxime@cerno.tech>
> >=E5=86=99=E5=88=B0:
> >> >On Sat, Nov 07, 2020 at 08:53:32PM +0800, Icenowy Zheng wrote:
> >> >> Some developers received PineTab samples that used an old LCD
> >panel.
> >> >>=20
> >> >> Add device tree for these samples.
> >> >>=20
> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >> ---
> >> >>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >> >>  .../dts/allwinner/sun50i-a64-pinetab-dev.dts  | 28
> >> >+++++++++++++++++++
> >> >>  2 files changed, 29 insertions(+)
> >> >>  create mode 100644
> >> >arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >> >>=20
> >> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >> >b/arch/arm64/boot/dts/allwinner/Makefile
> >> >> index 211d1e9d4701..a221dcebfad4 100644
> >> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >> >> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
> >> >sun50i-a64-pinephone-1.0.dtb
> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.1.dtb
> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.2.dtb
> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab.dtb
> >> >> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab-dev.dtb
> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1.dtb
> >> >> diff --git
> >a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >> >> new file mode 100644
> >> >> index 000000000000..3a4153890f3e
> >> >> --- /dev/null
> >> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >> >> @@ -0,0 +1,28 @@
> >> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> >> +/*
> >> >> + * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc.io>
> >> >> + *
> >> >> + */
> >> >> +
> >> >> +/dts-v1/;
> >> >> +
> >> >> +#include "sun50i-a64-pinetab.dts"
> >> >> +
> >> >> +/ {
> >> >> +	model =3D "PineTab Developer Sample";
> >> >> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
> >> >> +};
> >> >
> >> >Changing the DT and the compatible half-way through it isn't ok.
> >Please
> >> >add a new DT with the newer revision like we did for the pinephone
> >>=20
> >> We did this on Pine H64.
> >
> >What are you referring to? I couldn't find a commit where we did what
> >you suggested in that patch to the pine H64.
>=20
> Oh the situation is complex. On Pine H64, we didn't specify anything at
> start (which is the same here), the DT is originally version-neutral
> but then transitioned to model B, then reverted to model A. Here the DT i=
s always
> for the sample.
>=20
> However, for Pine H64 there's model A/B names, but for PineTab there's no
> any samples that are sold, thus except who got the samples, all PineTab
> owners simply owns a "PineTab", not a "PineTab xxx version".

It's fairly simple really, we can't really predict the future, so any DT
submitted is for the current version of whatever board there is. This is
what we (somewhat messily) did for the PineH64, for the pinephone, or
really any other board that has several revisions

Maxime

--kr27hb3hbkksxdbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7fn6gAKCRDj7w1vZxhR
xQDkAQCfC6YLcVIPzWXZLKF5hjULRGNX9s+snk1vmmRwyYTx+AD+ME8Rr9Zwu0/K
hMZs3H3xTpAk0y09kQAE5aboePkK3wY=
=u1dU
-----END PGP SIGNATURE-----

--kr27hb3hbkksxdbb--
