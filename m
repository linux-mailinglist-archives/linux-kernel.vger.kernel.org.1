Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBA29E843
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJ2KEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:04:48 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50847 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgJ2KEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:04:46 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7CB7EE0003;
        Thu, 29 Oct 2020 10:04:42 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:04:42 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: dts: sun8i: V3/S3: Add UART1 pin definitions to
 the V3/S3 dtsi
Message-ID: <20201029100442.GA460689@aptenodytes>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201029022000.601913-3-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20201029022000.601913-3-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 29 Oct 20, 02:19, Matteo Scordino wrote:
> The Allwinner V3 and S3 can use PG6/7 as RX/TX for UART1. Since no other
> functions are assigned to those pins, they are a convenient choice for
> a debugging or application UART.
> This is specific to V3/S3 as the V3s's non-BGA package did not have
> those pins.

Looks good to me, I've had to make the same change when bringing up both
another S3 and another V3 board.

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-v3.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3=
=2Edtsi
> index ca4672ed2e02..c279e13583ba 100644
> --- a/arch/arm/boot/dts/sun8i-v3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3.dtsi
> @@ -24,4 +24,9 @@
> =20
>  &pio {
>  	compatible =3D "allwinner,sun8i-v3-pinctrl";
> +
> +	uart1_pg_pins: uart1-pg-pins {
> +		pins =3D "PG6", "PG7";
> +		function =3D "uart1";
> +	};
>  };
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl+ak7kACgkQ3cLmz3+f
v9EJmgf/a3UChSVK1qcvdGoWUcjwH6BucjdO9UG6lF3xejjxubCwuSK/4QiuXPQ8
dz1s0NlP/ZqfMkZ7YlQp9fiEzBBWlldZD4aRR0f8/huMLQljbxnAMHxhvXiD2a+4
cM4nLujTGXVIG3dEUSlgiw/pZkj/xf+shfajjebCh+1DPVTweKioHpBSM5ilDqGF
FrxnHdI6B9Gqyn/+VttrgvE07y+FIKmBztoLD7YryCv4vPt7BOHnX2yxcfMzYxSR
rAWzMh7gaWXmPNsmcXC2EpqaGml2kSyrGrvlXwzeH8l/xjlC8aJLe2dlk6/GBGlv
j0lpDI2ZQMr6Oj47D04owZ2Pgwthkw==
=WI93
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
