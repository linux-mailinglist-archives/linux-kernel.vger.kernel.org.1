Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1628B3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbgJLLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:22:24 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45229 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387894AbgJLLWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:22:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 365F4CCF;
        Mon, 12 Oct 2020 07:22:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Oct 2020 07:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=yS0yu0Mwmxidom7vwvRKXLjBjju
        i+KTNl0FEVvCEt68=; b=RPdXnhJtau+I6PZFwjbeq311x8j4jml1zOUpi3YRYEb
        JAExy5z20Ydkc7WyUkAu+jluji6y8QclipDCJ6kntieLeOAbumu+lD8G8DufGd9h
        E6rSQuqC1hzE6I2y4qSWa1RCa7eGY1fg554ULenVNnZSgu6TP4Gh8Zz3MdLQe1px
        CFfKibwW8P1d2shbCzo8cSKqQO1YIFXI3r9LNWypCMvH9Ewc/SaFFyjnnAS+opJ6
        qZbfXmbWSElum00qAm/4qK9bD/3JGOv20+kjz65/9OP6n3qyNKekUM+8cxtR5PPS
        yUJbiVWC0j/BFj8iAPsmII5E7ETJywtZgHGL+7kj9XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yS0yu0
        Mwmxidom7vwvRKXLjBjjui+KTNl0FEVvCEt68=; b=IqfMgJiTGhxAUUtXkYAOfQ
        hIpwIgnwwm7+cDAEw9LQmlWMOnO5gA7x2HjYwW7yVlF/AZ5gs0+b22WNlAaDV64m
        VEOmILcDpFw6rOrbsI0WXwTbUQ3YLl6N5gh4kYZfXz9TohHWiemAy6/1WGLO+QrX
        7lS93xkJprv1pe0Cj3XldLRAW38ZzT2remVFS4jwXUKASn7yT/Hzmci9RSmmchgK
        wPj6UISygpuNNfUpTo3/MWh2e/rFZ9ILz1Mg7EwOKGb+86KjYaN+SznDCxHClLR7
        XYAHJYpKCBhC9ldg9LhWm+PWEz3QfvCKtIml/18GNAsKdqo5n/LR1qOPgYzZvIug
        ==
X-ME-Sender: <xms:bDyEXzsUeaAxUPgeDPfAU-MOOK1t88DbJj3wIWnIy-gqhTFGV9pjuA>
    <xme:bDyEX0e7FDRIhG7UwDfd3Q6opuBj1ufOMyIsM917fepg91bj3qyXH3f1lx9OnMiHc
    5Fn2rfTTDMtdtzxPqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bDyEX2zf6fuaPixSO7UWy3G_Zc6odR8j6CymcXomg8rPJ4M9LWk8Kw>
    <xmx:bDyEXyOVwkViL68l857LxArASA-vsiq0SakaILrY8WJwmE55f9FHaw>
    <xmx:bDyEXz-2XpjB4UFZ5gp-oqk0Gpi1mlMdKDtCGu7qTwR_Rt3i8whibg>
    <xmx:bTyEX2YUDkZB6lNFBK58c9Njqo84OZK8o8mLuy104oKObTbBGkyoNQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A1E903064682;
        Mon, 12 Oct 2020 07:22:20 -0400 (EDT)
Date:   Mon, 12 Oct 2020 13:22:18 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: beelink-gs1: Update LED power
 node
Message-ID: <20201012112218.juke4ll4dnwrmwzw@gilmour.lan>
References: <20201011212238.174792-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vrfdqaecy3uo5lg"
Content-Disposition: inline
In-Reply-To: <20201011212238.174792-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4vrfdqaecy3uo5lg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Oct 11, 2020 at 11:22:37PM +0200, Cl=E9ment P=E9ron wrote:
> Beelink GS1 LED trigger a warning when running dtbs_check.
>=20
> Update the node with a valid pattern property.
>=20
> Also add the function and the color of the LED and drop the
> label which is deprecated.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 3f7ceeb1a767..a364cb4e5b3f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -7,6 +7,7 @@
>  #include "sun50i-h6-cpu-opp.dtsi"
> =20
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> =20
>  / {
>  	model =3D "Beelink GS1";
> @@ -43,8 +44,9 @@ ext_osc32k: ext_osc32k_clk {
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
> -		power {
> -			label =3D "beelink:white:power";
> +		led-0 {
> +			function =3D LED_FUNCTION_POWER;
> +			color =3D <LED_COLOR_ID_WHITE>;
>  			gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
>  			default-state =3D "on";
>  		};

Doesn't that also change the sysfs file that LED is exposed to the userspac=
e with?

Maxime

--4vrfdqaecy3uo5lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4Q8agAKCRDj7w1vZxhR
xX7hAQC4oXWwgfacQSYBnPdjSjU2IAbgQDQSk9UPIxYpcwxv2QEAyhlxZbLdMBsT
26GqO5r09yx5qyIBCXe4HLluLHhijwk=
=+xcE
-----END PGP SIGNATURE-----

--4vrfdqaecy3uo5lg--
