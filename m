Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE62FA01A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404172AbhARMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390844AbhARMgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:36:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CC522286;
        Mon, 18 Jan 2021 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610973356;
        bh=zyiVT4P7E60Eo9KHOBaHS2pbNeuf9t+bbd1HG0CCSqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mv0V0Egf16ygNO/YL+b6SqsCi4MTGY3Xn8aCTzJ+7VogtboS4b4QdI+kAv9sXbMBg
         HEOeBkCH7D0WVJqtNB/scWX73i5wURdjS9VIIkwxgCW9C8WGo+DKVbGU6dX4ZRHtPP
         TXBR9cdKOdAJ4AouDBD9nItiVkPrJ5aPvcwg3fEEwfr6eR73zpmhShNvL/dvngPU+n
         p2lDXjaeb1y76IJmJI0cvWUTsOLAfys1T7RQPDLxSPewlF4R1JmkBJHFy7QMZ77WJ1
         wGk48g7GpQOtsam3tOCBIabNueWNEPNS4dUweFekJomWLJvuxeE62tPrNNFxEwZz9p
         9GAxh19VCbNnw==
Date:   Mon, 18 Jan 2021 12:35:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH 3/6] devicetree/bindings: Initial commit of
 silergy,sy7636a-regulator.yaml
Message-ID: <20210118123519.GF4455@sirena.org.uk>
References: <20210117042539.1609-1-alistair@alistair23.me>
 <20210117042539.1609-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20210117042539.1609-3-alistair@alistair23.me>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 16, 2021 at 08:25:36PM -0800, Alistair Francis wrote:
> Initial support for the Silergy SY7636A-regulator Power Management chip
> driver.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +properties:
> +  compatible:
> +    enum:
> +      - sy7636a-regulator

Compatible strings should be in the form vendor,device. =20

> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        regulator@60 {
> +          compatible =3D "sy7636a-regulator";
> +          reg_epdpmic: vcom {
> +            regulator-name =3D "vcom";
> +            regulator-boot-on;
> +          };
> +        };
> +    };

There's no documentation of VCOM as a valid regulator in the binding.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFgIYACgkQJNaLcl1U
h9Cm3Af8DSa6B05Wbp5ktuy3F+5rF0PIrxE8TRtVen/czTvYnWGjb/v+EkHZWtSx
FVWtD/JKNZVvGMNx59MdAQYTzpAmPFoysqyLvRdmvMXwXKREqioh4qHcQb7J+nO4
qcp8frhkKqExFFeYc/LCx/nDosEuCcAUgOFXoz1nHTPJoh4PtTJM2hd3Vi6R7mrf
lyvDMuJ+McU0KTFIBonc7YGCv4W/z24sG6digErTJwBv8+ss+1Z/0wElK+VvFiSr
nL0UcErPi39oElZ/CQTPJJKywJ12uaYZi9PVvlCSLOXyZNkroOD5rTwDAYUKCjCC
RsMw+mdK2pRBVsAazrok75ZA2XHozQ==
=qfar
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
