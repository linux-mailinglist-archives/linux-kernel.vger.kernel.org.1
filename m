Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D12B4A11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgKPPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:55:13 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49869 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730328AbgKPPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:55:12 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F14A7C15;
        Mon, 16 Nov 2020 10:55:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Nov 2020 10:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=C6/JxPnhaPgJVlnYlQEA7XOoQjd
        4FRxsTP1ZuZ6/2Ns=; b=JGEdZGdtR6LDHYfPmJib0wxeLfGOHtAkkzYGzqSkTty
        EmOF1rfFOyUn9qIOpSrV2qEHJ4RBt6lLTtCukvokC5gtLNC+RjiSI2Hag2kKB3p3
        WSJ1zqUdmvledZ+i0jhcyLJtgv33DMpOidfgQlfxzAN9BCAxY8TqtZ77/ki0IhF6
        TjzXmrgO+T7/NXFHmvdvaDHScwh0dclINeT9dmq4PfRzCXUeKvFi511hnnVEv3r+
        zds0WVypzfzR4XL0IJleHg/RngWKyifBGiS9bAleaeirtVbBxW5yVAGuD+o0/9L8
        lAkyIVf/67+ZoqBLP49rHfC58+FSLWHe5bDt6JlnzEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=C6/JxP
        nhaPgJVlnYlQEA7XOoQjd4FRxsTP1ZuZ6/2Ns=; b=EMDB83ptxh/RDtndGqGWWi
        HDKlI2IiPMp9BvtllkUNdK+no/3U8MtjqlAYnBcPvtkKESwSp3fYH+qcK5dA2opi
        0hMqFRoCKyTclX8SN/IgrujnOMdGc6IdUl1dP2ZahMj66rHqa7thIG3uo7eZTGNs
        cWZrdN3aNmFDrQJjtXvmpH9yuau+NbJxT0HIt8EFTjyWwFf2lg8FvtapvkfTTzVp
        0Q43Ghe1SylrVB48ut3lT4L2KgW5LWgQS2BGXRHvK2mM5Ig7/Ac01NKTgT8oBlKh
        bcTOCzAkJG3FDY+QkRTM/rlnl/ULGLarEBcJ7GaeJpPwimwJebtPWDMZ6tRfNIlQ
        ==
X-ME-Sender: <xms:3aCyXxFw5W1U1TOwLtFChENNI63sO2_nmuMi0KNvLnUPZZKuVJREBw>
    <xme:3aCyX2UZAkM6zk6CQAhir7eoz5Ni6Rbwvf27q70PepXH3Jouj5ln0uum0jwHuvUdL
    YhWDGvyzp4OeKVdzlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:3aCyXzLmMWGgkBf5SJYFgvrXGSbrVVlKVpXaK0AF2AyYj69OClIR4g>
    <xmx:3aCyX3FbCw6ydF2X8MZSfRNMCYhokSrIAsKYaoK5uOQx9evLkS4e3A>
    <xmx:3aCyX3U5bbUeFQE0GfpvTlUN2hWzie8--0-cWcMe5FXK7v8-q8uo1w>
    <xmx:3qCyX9fBx5w5AkGh15SlrGkjgyiEOnSoAu4TBQFrdKLTOCV3KcxamQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 667803064AB2;
        Mon, 16 Nov 2020 10:55:09 -0500 (EST)
Date:   Mon, 16 Nov 2020 16:55:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab
 developer sample
Message-ID: <20201116155508.364dg6ycklwylswe@gilmour.lan>
References: <20201107124958.2222253-1-icenowy@aosc.io>
 <20201107125332.2223197-1-icenowy@aosc.io>
 <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
 <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b6qqz3i4ghhtvqx5"
Content-Disposition: inline
In-Reply-To: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b6qqz3i4ghhtvqx5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2020 at 06:41:37PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8810=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=886:39:25, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> >On Sat, Nov 07, 2020 at 08:53:32PM +0800, Icenowy Zheng wrote:
> >> Some developers received PineTab samples that used an old LCD panel.
> >>=20
> >> Add device tree for these samples.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >>  .../dts/allwinner/sun50i-a64-pinetab-dev.dts  | 28
> >+++++++++++++++++++
> >>  2 files changed, 29 insertions(+)
> >>  create mode 100644
> >arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >>=20
> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >b/arch/arm64/boot/dts/allwinner/Makefile
> >> index 211d1e9d4701..a221dcebfad4 100644
> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
> >sun50i-a64-pinephone-1.0.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.1.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1.2.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab.dtb
> >> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab-dev.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1.dtb
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >> new file mode 100644
> >> index 000000000000..3a4153890f3e
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
> >> @@ -0,0 +1,28 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc.io>
> >> + *
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sun50i-a64-pinetab.dts"
> >> +
> >> +/ {
> >> +	model =3D "PineTab Developer Sample";
> >> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
> >> +};
> >
> >Changing the DT and the compatible half-way through it isn't ok. Please
> >add a new DT with the newer revision like we did for the pinephone
>=20
> We did this on Pine H64.

What are you referring to? I couldn't find a commit where we did what
you suggested in that patch to the pine H64.

Maxime

--b6qqz3i4ghhtvqx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7Kg3AAKCRDj7w1vZxhR
xT41AP0ckyvVCkfWKhJUdkRz9sp6ud8h4KSCNehnhkUHfSACnwEAh9EJcxe92mYE
GJ5/nMGgn71V61pr2fPv2XPILv1qwQw=
=eyRo
-----END PGP SIGNATURE-----

--b6qqz3i4ghhtvqx5--
