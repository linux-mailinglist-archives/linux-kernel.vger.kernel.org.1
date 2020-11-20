Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5442BAF55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgKTPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:52:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42833 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbgKTPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:52:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 38A045C0073;
        Fri, 20 Nov 2020 10:52:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Nov 2020 10:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=243zuxKtb9Id8Wghr25UlB2KG++
        k7labUCOuppsTHUM=; b=UhEKbxr/G9zEmm4mGuI+MdHuJL1mDaXGKgjLWPSltlx
        Ae0XP3P1jT/9itgiZQQY7eAoae0GF8nk+mXGMRqMzW5ErNQ8/EkVwF5jeMN7PfdJ
        b9PClGJSxKC4TJEVCgoVlRd3w/3ioFVyJBERMtZYXP4JRCj790i1F3kmkeIJhmSd
        I6/0NI9fcqM3LF52/qTDmfQ417pTAV5qE82N72BVPq8bqyu+Rnb9z2xzCJDA8RfZ
        Fyv++8vjWB70FV0MgDDZqs1qUSuzhnnobhJb21kJFppjyOTrUttelcBpy3zcQdxb
        6Jvq2etogfGVqG918dtF0/sgdYPl/gvYWhKSR5TxfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=243zux
        Ktb9Id8Wghr25UlB2KG++k7labUCOuppsTHUM=; b=WqRaRHLcvJ8IczAzkV76Q1
        G2Upf/YA65CitbxAD+VM01BfNQCWR/lMP80I4CtI1bI35LKlsavtDH1ePaHEzVfb
        w3cU/LtDPyM70SY59JtqEkqHXMFdwDf0yny9fbP2Tl3RR26AO35eUVLVJf3KcZRH
        FalIX1GkjTFyLKJ/oFnoY+Bk52BSKM7oJh1w0Q90R9xJIWRyGweccE4wOjUfIhOo
        y+QPy5SyKrpYIURMZ7IF7rTzN7EW+Kyoh3D16TJcsQlDGlCktI7A2CvtKbXvr4Ze
        3MvWYxdR4iE2LS8wbSk3Up6JHnJ30bZcckjZrQb+MHpcsz958UH24y4bYdw+2GEA
        ==
X-ME-Sender: <xms:Vua3X-If6XXSIocIbrK0KdyrSbdDhKvf7KsfE350hurX9J2n6zMOBg>
    <xme:Vua3X2K7NU9am4Nn1YX4uQ6TNbHa0hK3Rra5wTAQDqFAKOZTbh6IN-4bZX1e203op
    v0sOkzK1is9NAr-ZVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimh
    gvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepgfffieeiudduveefjeel
    geelhefgtdelgffhkeefjeefvdeviefhheekgeeivddunecuffhomhgrihhnpegsrghnrg
    hnrgdqphhirdhorhhgpdhgohhoghhlvgdrtghomhenucfkphepledtrdekledrieekrdej
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Vua3X-ss87GSqIUDVEh63ZTQ3_4qIjXPTAnUVnZew65lWcB1d5XW4g>
    <xmx:Vua3XzaubLYcjVWnwq2r3RiyRIrJOLxzzTA4IMD8ihvOTgNESm7_nA>
    <xmx:Vua3X1Z11vr-NrgDMCKR2mXlxnlmU19cenUQ4Ypd-DKzg6B1pnVguw>
    <xmx:V-a3X5EJXTWUhW18Fi_CV3_A4ZZOC9nvxoksvfTGaNWLe0XrjQsguw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E61953064AB3;
        Fri, 20 Nov 2020 10:52:53 -0500 (EST)
Date:   Fri, 20 Nov 2020 16:52:52 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-line-names
Message-ID: <20201120155252.kfkavrn4wpqzmbyc@gilmour>
References: <20201115222425.2885427-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nl5t3kiqe4j3hvdu"
Content-Disposition: inline
In-Reply-To: <20201115222425.2885427-1-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nl5t3kiqe4j3hvdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Nov 15, 2020 at 11:24:25PM +0100, Michael Klein wrote:
> Add gpio-line-names as documented in the Banana Pi wiki [1] and in the
> schematics [2].
>=20
> [1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#GPIO_PIN_define
> [2]: https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 4c6704e4c57e..b4ddfaf01b45 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -136,6 +136,70 @@ bluetooth {
> =20
>  };
> =20
> +&pio {
> +	gpio-line-names =3D
> +		/* PA */
> +		"UART2-TX", "UART2-RX", "UART2-RTS", "UART2-CTS",
> +			"UART0-TXD", "UART0-RXD", "PWM1", "PA7-EINT7",
> +		"PA8-EINT8", "PA9-EINT9", "PA10-EINT10", "TWI0-SCK",
> +			"TWI0-SDA", "UART3-TX", "UART3-RX", "UART3-RTS",
> +		"UART3-CTS", "PA17-EINT17", "TWI1-SCK", "TWI1-SDA",
> +			"PA20-EINT20", "PA21-EINT21", "", "",
> +		"", "", "", "", "", "", "", "",

IIRC, the point is to have the pin names that the vendor publishes.

Looking at Documentation/devicetree/bindings/gpio/gpio.txt, it says:

"""
Optionally, a GPIO controller may have a "gpio-line-names" property. This is
an array of strings defining the names of the GPIO lines going out of the
GPIO controller. This name should be the most meaningful producer name
for the system, such as a rail name indicating the usage. Package names
such as pin name are discouraged: such lines have opaque names (since they
are by definition generic purpose) and such names are usually not very
helpful.
"""

In this case, from the link you gave above, I think having the CON*-P*
names make more sense.

Maxime

--nl5t3kiqe4j3hvdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7fmVAAKCRDj7w1vZxhR
xXU4AP4rHtsdpzFcD4BLjn5wb0mrt9+1t23Fg6bPt8E4FDyhPgD/bjrssgUM+XQI
V2oEzJyjtAMwQ08hqEm0tQuzaZzt+gI=
=2t/3
-----END PGP SIGNATURE-----

--nl5t3kiqe4j3hvdu--
