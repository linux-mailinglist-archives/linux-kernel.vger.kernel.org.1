Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0929E89E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgJ2KKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:10:37 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48587 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgJ2KKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:10:33 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 955B660003;
        Thu, 29 Oct 2020 10:10:30 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:10:30 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: dts: sun8i: s3: Add dts for the Elimo Initium
 SBC
Message-ID: <20201029101030.GD460689@aptenodytes>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201029022000.601913-6-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20201029022000.601913-6-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 29 Oct 20, 02:20, Matteo Scordino wrote:
> The Elimo Engineering Initium is an Open Source Hardware Single Board
> Computer based on the Elimo Impetus SoM.
>=20
> It is meant as the first development platform for the Impetus, providing
> convenient access to the peripherals on the Impetus.
>=20
> It provides:
> USB-C power input
> UART-to-USB bridge on the USB-C connector, connected to UART1
> USB-A connector for USB2.0 (Host, Device, OTG)
> Audio Line In/Out
> Pin header to access all signals on the M2 connector of the SoM
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                   |  1 +
>  arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 27 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4f0adfead547..dcfb8d39c267 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1210,6 +1210,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-r40-bananapi-m2-ultra.dtb \
>  	sun8i-s3-lichee-zero-plus.dtb \
>  	sun8i-s3-pinecube.dtb \
> +	sun8i-s3-elimo-initium.dtb \
>  	sun8i-t3-cqa3t-bv3.dtb \
>  	sun8i-v3s-licheepi-zero.dtb \
>  	sun8i-v3s-licheepi-zero-dock.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot=
/dts/sun8i-s3-elimo-initium.dts
> new file mode 100644
> index 000000000000..5ddd4dbd636c
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-s3-elimo-impetus.dtsi"
> +
> +/ {
> +	model =3D "Elimo Initium";
> +	compatible =3D "elimo,initium", "elimo,impetus", "allwinner,sun8i-s3";

Same comment as before about having an extra "allwinner,sun8i-v3" here.

Cheers,

Paul

> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&emac {
> +	phy-handle =3D <&int_mii_phy>;
> +	phy-mode =3D "mii";
> +	status =3D "okay";
> +};
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

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl+alRYACgkQ3cLmz3+f
v9FdOwf8Dy+4mzzFs4Zj+RmNNjukknJFD3BpNgmBR2RqL5E9yp1f+kRZeNrCPU/u
l6NXaoTE3kl8B7xTn9o2R6ifvM1Pvo4dZciS7EgmRHw6fFJNg1N8AU00SPrto4wS
JOjxhLyZqwgRcffKPk5vVi1MONgtT6EUVRUscZ8c8NOVoVS0ltpR7jNdsCQBF2Ef
nS7QLVy5F90vdJ68v8VHdR5UfbaIkgDeFKqtsBBEVf7tq4prNT3usw4wXViEbuSj
D/L9F/w2k3jBNhoxugHN5o+wKhLnyiJ6qhV0zlRKDOx0xXz6BCvLgzBfVXhUlzsS
yy8G+Duj793D7xTnCDZ6KXMYBt2ENg==
=tAUe
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
