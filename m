Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4728BC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbgJLPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:35:11 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43871 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389542AbgJLPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:35:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D18CD5C00E5;
        Mon, 12 Oct 2020 11:35:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Oct 2020 11:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8WPDmq8Px9NeRB/EwuqE6fGKo9C
        uXza8q8je5LxZUZo=; b=cAd6pQLdZsgxczAQC4nWoNULj1m1GVZIuLNA96Ci1SB
        PuJouhnWAfcO8gYRiN1gmVO/EYjyXoygfUKLmzfk57vgAs5+BPixlmAM3kZJ4P/h
        g7X+GsbpRmVx55uiYtsSd5+PrxMVAjinUb9nF+sAV6uYWUG3uWGgswW4IKfUHePJ
        k8SW6WCCjygz5wSE/U+1XscNRZ27WUXIJbOSSQolqtlBXG6olu5RmnNfW5kq8K0g
        TA25tXQ6bCJcAUNazhmKgrmj/G+qwX96vK6l6umoBgviFcW/BHtfT2psVFGZjOF0
        CBoeLxA5Sru20JhkXm8yBjYU3GNfBU8Y77h8Z/6cRqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8WPDmq
        8Px9NeRB/EwuqE6fGKo9CuXza8q8je5LxZUZo=; b=GLaydWszHP+Fz/T6nBQAmh
        VLztBebFxiXdKlBTAtFUS1n9FBKklCp3P65pFuCpC2bVLmfTuntfbN7dzJZKcXLQ
        74ZZny6wSSAFtNhXicoKkuR2FbtyifgGtEnY1YrF4LEYMJb9aRAlGVgAyRYXBoHv
        GvVAYIfrhinDX1y69pT2N7NIpCH6NrGwLDZX3QDv2E2PzPBThkewGXuve3y82j+r
        M8he7fsugx9ZeokcYansAPEHpfIipH6a09U3jZttcggZyXSRMnumScetyEjgFDIb
        fNWu7lW2Ar1J/pWzQXS71t+nSffLzMYtp6poh9qEurIM82IGCg6w+lYc4iur1rKA
        ==
X-ME-Sender: <xms:rHeEX7k05qDJSSzMdQPwW6Lf4a30YU1p3fU5nlxGXYy4GScRAtLiHQ>
    <xme:rHeEX-3E5KVwDGnbJ3XzXskZBn23vOUd3Mc9whkcW4sFGzRTPPc9KOI0_EiR87L81
    QW1hw2eTue1Bhgj3G0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rHeEXxofMTPCTCZHWcQkYnKAb1hNf3ID29UIRiIgaXJl2Fu5oVPqKw>
    <xmx:rHeEXzkGt2qO6O0B1diF90k8DrbtUkRhYR_xGaKx6Q1m7Z3Y7d_kDA>
    <xmx:rHeEX52gVEYo_HGFrzsrrUxeOnYTafAUQ1oK4TxWD8WskjBuFDT0PA>
    <xmx:rXeEXyzNBoOZfkItGsKXGAFpVYzD4zFBXVtNCFFo8yy-EB58UoTQLg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 853C0328005D;
        Mon, 12 Oct 2020 11:35:08 -0400 (EDT)
Date:   Mon, 12 Oct 2020 17:35:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201012153507.ft77jgaprpendpne@gilmour.lan>
References: <20200929083025.2089-1-msuchanek@suse.de>
 <20201008151315.v3geykbs6musl4wq@gilmour.lan>
 <20201008160219.GM29778@kitsune.suse.cz>
 <20201008171454.qixrcjmhzko766su@gilmour.lan>
 <20201008174044.GN29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrqed7t2ppdm64mi"
Content-Disposition: inline
In-Reply-To: <20201008174044.GN29778@kitsune.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrqed7t2ppdm64mi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 07:40:44PM +0200, Michal Such=E1nek wrote:
> On Thu, Oct 08, 2020 at 07:14:54PM +0200, Maxime Ripard wrote:
> > On Thu, Oct 08, 2020 at 06:02:19PM +0200, Michal Such=E1nek wrote:
> > > On Thu, Oct 08, 2020 at 05:13:15PM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, Sep 29, 2020 at 10:30:25AM +0200, Michal Suchanek wrote:
> > > > > The flash is present on all new boards and users went out of thei=
r way
> > > > > to add it on the old ones.
> > > > >=20
> > > > > Enabling it makes a more reasonable default.
> > > > >=20
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/=
arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > > index f19ed981da9d..061d295bbba7 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > > > @@ -163,8 +163,8 @@ &ohci1 {
> > > > >  };
> > > > > =20
> > > > >  &spi0 {
> > > > > -	/* Disable SPI NOR by default: it optional on Orange Pi Zero bo=
ards */
> > > > > -	status =3D "disabled";
> > > > > +	/* Enable optional SPI NOR by default */
> > > > > +	status =3D "okay";
> > > > > =20
> > > > >  	flash@0 {
> > > > >  		#address-cells =3D <1>;
> > > >=20
> > > > Unfortunately, it's optional, so there's really no reason to enable=
 it
> > > > all the time. If it's troublesome to users, then the distros or ven=
dors
> > > > should make the changes necessary to the hardware, bootloader or th=
eir
> > > > documentation to make it easier for those users.
> > >=20
> > > I don't understand the reasoning. Why must it be disabled when option=
al?
> >=20
> > Think about it the other way around. If we enable everything that is
> > optional, we're going to have a multitude of conflicts everywhere, and
> > without a clear decision as to who is "best" and thus how we should
> > resolve it.
> Conflicts with what?
>=20
> The SPI0 bus is routed the the flash memory pads. Either there is the
> flash mounted or there are free pads. Nothing else on the board uses
> these pins. You could possily solder something else there but that's
> definitely not part of the board.
> >=20
> > On a separate platform, recently I've been using a VGA bridge for the
> > RaspberryPi that takes the UART pins as well. It's definitely optional,
> > should I enable it by default? At the same time, enabling by default the
> > UART is just as arbitrary and will result in people using the VGA bridge
> > to complain about their regression (rightfully so).
>=20
> That's completely different situation. That bridge is probably not even
> part of the board.
>=20
> >=20
> > So, really, if it's optional, it means that it not always there. If it's
> > not always there, it's meant to be supported by an overlay.
> >=20
> > > By the same reasoning there is no reason to disable it all the time.
> >=20
> > I'm not sure I follow you here. The least common denominator is that
> > it's not there, so it's not enabled.
>=20
> You have two options - have a flash mounted or not. You ask why enable
> flash when it is not always present. By the same logic I can ask why
> disable it when it is not always absent. Enabling is the more useful
> option because it degrades gracefully in the case it is not present. It
> does not work the other way around.
>=20
> >=20
> > > Also the boards that do not have the flsh are either broken or
> > > obsolete.
> >=20
> > Making general statements without arguments doesn't really make it true
> > though. Plenty of boards to have flash and are neither broken nor
> > obsolete.
>
> Cannot parse this.

"Plenty of boards do not have flash and are neither broken nor obsolete"

> >=20
> > > So most of the time enabling the flash chip is the right thing.
> > >=20
> > > Or do we need two DTBs like sun8i-h2-plus-orangepi-zero.dts and
> > > sun8i-h2-plus-orangepi-zero-no-spi-nor.dts
> >=20
> > No, you need sun8i-h2-plus-orangepi-zero plus an overlay for the
> > SPI-NOR.
>
> The flash is part of the board.

Not always though.

> There is no need for an overlay.

Overlays are here to deal with the "not always though" situation...

> And overlays don't exist.

If you want to believe that, please go ahead.

But there's support for it in libfdt, and you can either apply them
directly through the U-Boot command line, or bundle them in a FIT image.

Plenty of support for something that doesn't exist.

> >=20
> > > There is no way to change the setting on a runnig system, the pins are
> > > routed to the flash pads anyway so are not usable for anything else. =
The
> > > only thing that happens on boards that do not have the flash is kernel
> > > probing it and complaining that the ID 00 00 00 is not valid SPI NOR
> > > flash memory ID.
> >=20
> > We have people reporting bugs about completely innocuous error messages
> > without any side effects already. An error about a missing or broken
> > storage device will surely raise some eyebrows.
>=20
> I am sure poeple who have an old Orange Pi Zero know that it is missing
> the flash memory.

Do you really expect every single user on an Orange Pi Zero to know
exactly the revision it has and whether or not it's been bundled with a
SPI flash if it's the older ones (with the proper definition of older
ones)?

Maxime

--nrqed7t2ppdm64mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4R3qgAKCRDj7w1vZxhR
xeX0AQDOq25wgE6SgKrWo6nR36hyvIb0rG4gIfamywC5zkvgMwEAwnA2eW7+qkFc
uLOWy7X5C85tgyGrsXXMfm/nv308rwI=
=L5X7
-----END PGP SIGNATURE-----

--nrqed7t2ppdm64mi--
