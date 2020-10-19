Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDD2925E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgJSKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:35:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49725 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbgJSKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:35:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EBDA5C00DA;
        Mon, 19 Oct 2020 06:35:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Oct 2020 06:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=x1zUlvl7MAJX2jsFZNJsQT88znY
        tzZshjbMQGDPEvW8=; b=mk0b2dBL8tYplOKJUHt68NAkVis775nX7RJ9/H7EYhh
        f2ppDVmL+niXUZ38Qb4Mv2bwBtwzff+tREVaiWuSskNvdlJFLydsN+wntAHr2uMx
        CEBiCaOMpLskkzvD2YTkZSLYvgfbxyeWJ3o27d6W1sshAIz8Idsffyz4BWsQ8/2C
        lUMOgzzuARcpQIiuuAEqBxJO9brT57RpMAB8Vq9kifo9bCDyAuHuYgwpIBT/eqVo
        r1jLRiUkPiJFt/0BsFYWfvDVslc7Jtga2lTwNH0tXT0Yb1FdM8yTWCZLorTzJcr8
        ktRdaijrYlJ2PGkYHPJIqd/BPYVf//1vBevyGWgN0NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=x1zUlv
        l7MAJX2jsFZNJsQT88znYtzZshjbMQGDPEvW8=; b=GerGs17G201BPLHWm6MOeT
        4GcP2/BC5us9tS2mSuKr3cdU8B8kgRsnsbaB1cMeHq8SSzr1zytK4q0XnJYpAhTQ
        mudhsCSJOo4vRcRZtQ7Y9XPxjw8OgYxRrDOPWSl8P6JcJkNpDoUNh3VYBJLmfODJ
        RKbVIOXP1GkGhmPl+XQevieb4/OQu8irjb7a99FrbAf/PVPiaTLWRFbiiHZMHVQ9
        QCwYPMUVHEUDqGbK2bu7xZOaqXm1+7L2KuJxWTG3MA0nj+ZF8fH7on00VPP9W4p2
        TPg7EdfWGHgxbQgICfGwmGcxnQ7IWhhExVkhaohvopEyKVdilXGhD2Fi7bFGADwg
        ==
X-ME-Sender: <xms:02uNX_nH-QK53_ut5SwuLSJ8uyxQQRWsa58TWdP2DezddK7mnDkH-A>
    <xme:02uNXy33hT2IZsFEjMWDG7rtwhwRd9SMG-f4F3ylWxbeB_CVTqedEd1z420YlVoB2
    CW8slPVSg0bZGVfqmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:02uNX1oE-WjvRlTI8-npkSXZIT4Y-6yfnf6DE3jtTP3E8wUwH_hJMA>
    <xmx:02uNX3kiy78UMigI5tTTug8JnhVJ5dDSQdDrX7wNwheRD07Fdmg7kA>
    <xmx:02uNX90nRhxQd0Vqyij2Hez9fgZmf95wBx7FtBvPveuiHx-UN4MkyA>
    <xmx:1GuNX2xrtX_QRvRhEdNjrLoymOnF0ZR3LDlWjsBjpSIutIfh3X-ixQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8787A328005A;
        Mon, 19 Oct 2020 06:34:59 -0400 (EDT)
Date:   Mon, 19 Oct 2020 12:34:57 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: allwinner: beelink-gs1: Update LED power
 node
Message-ID: <20201019103457.imvvjktozc2jybze@gilmour.lan>
References: <20201011212238.174792-1-peron.clem@gmail.com>
 <20201012112218.juke4ll4dnwrmwzw@gilmour.lan>
 <CAJiuCceNOgZVNquFx7Fytxi-e0hvA_==V2Oudq+fYWSRKWD5sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a7gtrmvmv7q5j7sp"
Content-Disposition: inline
In-Reply-To: <CAJiuCceNOgZVNquFx7Fytxi-e0hvA_==V2Oudq+fYWSRKWD5sA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a7gtrmvmv7q5j7sp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2020 at 07:25:10PM +0200, Cl=E9ment P=E9ron wrote:
> HI Maxime,
>=20
> On Mon, 12 Oct 2020 at 13:22, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi!
> >
> > On Sun, Oct 11, 2020 at 11:22:37PM +0200, Cl=E9ment P=E9ron wrote:
> > > Beelink GS1 LED trigger a warning when running dtbs_check.
> > >
> > > Update the node with a valid pattern property.
> > >
> > > Also add the function and the color of the LED and drop the
> > > label which is deprecated.
> > >
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > index 3f7ceeb1a767..a364cb4e5b3f 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > @@ -7,6 +7,7 @@
> > >  #include "sun50i-h6-cpu-opp.dtsi"
> > >
> > >  #include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/leds/common.h>
> > >
> > >  / {
> > >       model =3D "Beelink GS1";
> > > @@ -43,8 +44,9 @@ ext_osc32k: ext_osc32k_clk {
> > >       leds {
> > >               compatible =3D "gpio-leds";
> > >
> > > -             power {
> > > -                     label =3D "beelink:white:power";
> > > +             led-0 {
> > > +                     function =3D LED_FUNCTION_POWER;
> > > +                     color =3D <LED_COLOR_ID_WHITE>;
> > >                       gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4=
 */
> > >                       default-state =3D "on";
> > >               };
> >
> > Doesn't that also change the sysfs file that LED is exposed to the user=
space with?
>=20
> Indeed the previous led sysfs:
> /sys/class/leds/beelink:white:power/
> is now
> /sys/class/leds/white:power/
>=20
> Do you want me to keep the label property to avoid this sysfs change ?

I don't know, the documentation seems to indicate that we should use one
or the other, but I'm not sure if both makes sense or not. I guess we
should ask Pavel or Rob?

Maxime

--a7gtrmvmv7q5j7sp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX41r0QAKCRDj7w1vZxhR
xQvlAP9f09QWfBLwHoAIwRXyOLDPy/b3vrppYyDpbh1S7WF6MgD+Nsbfx8GF+Wpm
YmUg6uWKKMDJkUzuXaB3SBt0NwRvBAY=
=yTde
-----END PGP SIGNATURE-----

--a7gtrmvmv7q5j7sp--
