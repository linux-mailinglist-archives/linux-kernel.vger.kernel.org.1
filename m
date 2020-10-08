Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF0287AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgJHRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:15:00 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36725 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731799AbgJHRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:14:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6A273B4C;
        Thu,  8 Oct 2020 13:14:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Oct 2020 13:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FUvHxf5u9Y1Zg6BGA5ag/iMYoYT
        rV69WKHkeNHoU7UI=; b=t2r0hTIzajpJ73M8n6VK1IHffLejjkwAPU/FdYcRDMV
        MoJxwxeOOioOiDGdSU1LUT/CMYlN/2ZhYJFE3KhytAb7nKHl2vcLzNAnuIuodELE
        uqNAYOMSV77YZaGkKYPvAHcO+YdKGZluKHqTnQPawy1xLeXAEpYF1MrwwizJeS6t
        RhXScn4T1gvjTb03GAJoo4CJEHFSVXtMA6TJtkPSyK5jTcjZlMpthcKEzaOp32Ta
        kGQsofdjuTZ5a/2Bz5qtOWMteTN99dHZlX/T/Pzi18Cfs68smRaUNLdkHVj2puPh
        mIyB/bisLxQNz+AypjrSPO8zXUvNbcsXrtb6AhIynpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FUvHxf
        5u9Y1Zg6BGA5ag/iMYoYTrV69WKHkeNHoU7UI=; b=XY6io0ksYdOzxk3m1a5kSP
        jUZrgcdsDgFDdzSNnrWRLP7O8JfTppDgfSPBjArTrzFy8QtKj9zVmpr4XcIwqkvq
        tzHf7czjgYKJsnVhy8a1387ITeGjydnRgWynqdCZKkWmvI6jr8ZGFBzhdm/oFT8r
        6yiDrcaqGOuVW35fhVORdbI7wOLPotv3NXw1asdEo7Q8f2w44NagCMzu8Ka6fDCV
        Mp2m4KXUGrzOxSOoyV/0KxF635DJOW453J/uc+MPEenN6OvbpbBtCaHAC8/k2lP/
        p7rYKjX2SolbxH9TLn23eGAmomfx3db0f6kje9CTrDwpOfz2iKcmmZtpJENrnl6Q
        ==
X-ME-Sender: <xms:EUl_X7W2onwTmXJwjCiaOGYXUC41GJUjayncDaQ4U9SuXYQkbewAeg>
    <xme:EUl_XzmFQO7FTNZb0-tH0h4IGDWXqXOJedqp12Zqi4B5Ytb3xKU7TVQzw9YnCDxLv
    eT9fFsUIZd91cf_NSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:EUl_X3ZHFp_HYR53DMYBzGP7LFJZC3Qv8exECXQQasFLxuzjMujY2w>
    <xmx:EUl_X2XdWzp1GIngNzB7iCJa_5W-FMhWlQeAOkPHpE1R18KYyojPLQ>
    <xmx:EUl_X1nGZU3yKylfZnSMYdP3G-ZL6TpTQNkqKYZ_ja6bHFsWfs1d5w>
    <xmx:Ekl_X7hbdJkd85BM9nx6UZKGCqRkDirf1XvZKmvpuOF57wSdDjnydQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C04B63280063;
        Thu,  8 Oct 2020 13:14:56 -0400 (EDT)
Date:   Thu, 8 Oct 2020 19:14:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on
 Orange Pi Zero board
Message-ID: <20201008171454.qixrcjmhzko766su@gilmour.lan>
References: <20200929083025.2089-1-msuchanek@suse.de>
 <20201008151315.v3geykbs6musl4wq@gilmour.lan>
 <20201008160219.GM29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3gpiop36hze6ih2e"
Content-Disposition: inline
In-Reply-To: <20201008160219.GM29778@kitsune.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3gpiop36hze6ih2e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 06:02:19PM +0200, Michal Such=E1nek wrote:
> On Thu, Oct 08, 2020 at 05:13:15PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Sep 29, 2020 at 10:30:25AM +0200, Michal Suchanek wrote:
> > > The flash is present on all new boards and users went out of their way
> > > to add it on the old ones.
> > >=20
> > > Enabling it makes a more reasonable default.
> > >=20
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch=
/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > index f19ed981da9d..061d295bbba7 100644
> > > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > > @@ -163,8 +163,8 @@ &ohci1 {
> > >  };
> > > =20
> > >  &spi0 {
> > > -	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards=
 */
> > > -	status =3D "disabled";
> > > +	/* Enable optional SPI NOR by default */
> > > +	status =3D "okay";
> > > =20
> > >  	flash@0 {
> > >  		#address-cells =3D <1>;
> >=20
> > Unfortunately, it's optional, so there's really no reason to enable it
> > all the time. If it's troublesome to users, then the distros or vendors
> > should make the changes necessary to the hardware, bootloader or their
> > documentation to make it easier for those users.
>=20
> I don't understand the reasoning. Why must it be disabled when optional?

Think about it the other way around. If we enable everything that is
optional, we're going to have a multitude of conflicts everywhere, and
without a clear decision as to who is "best" and thus how we should
resolve it.

On a separate platform, recently I've been using a VGA bridge for the
RaspberryPi that takes the UART pins as well. It's definitely optional,
should I enable it by default? At the same time, enabling by default the
UART is just as arbitrary and will result in people using the VGA bridge
to complain about their regression (rightfully so).

So, really, if it's optional, it means that it not always there. If it's
not always there, it's meant to be supported by an overlay.

> By the same reasoning there is no reason to disable it all the time.

I'm not sure I follow you here. The least common denominator is that
it's not there, so it's not enabled.

> Also the boards that do not have the flsh are either broken or
> obsolete.

Making general statements without arguments doesn't really make it true
though. Plenty of boards to have flash and are neither broken nor
obsolete.

> So most of the time enabling the flash chip is the right thing.
>=20
> Or do we need two DTBs like sun8i-h2-plus-orangepi-zero.dts and
> sun8i-h2-plus-orangepi-zero-no-spi-nor.dts

No, you need sun8i-h2-plus-orangepi-zero plus an overlay for the
SPI-NOR.

> There is no way to change the setting on a runnig system, the pins are
> routed to the flash pads anyway so are not usable for anything else. The
> only thing that happens on boards that do not have the flash is kernel
> probing it and complaining that the ID 00 00 00 is not valid SPI NOR
> flash memory ID.

We have people reporting bugs about completely innocuous error messages
without any side effects already. An error about a missing or broken
storage device will surely raise some eyebrows.

Maxime

--3gpiop36hze6ih2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX39JDgAKCRDj7w1vZxhR
xWYCAP4hhSm4f5GM2iD7i6x++2ALyXsf7QhxO15ZYgu0Qh0ReQD/T0zvFuqJDMF2
5spX2m34fPYJM/5ibaOLl103p2EnVAQ=
=Dtct
-----END PGP SIGNATURE-----

--3gpiop36hze6ih2e--
