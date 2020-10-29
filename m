Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441F529E88E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgJ2KJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:09:42 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:56503 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJ2KJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:09:40 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A9F1F40015;
        Thu, 29 Oct 2020 10:09:36 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:09:36 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus
 SoM
Message-ID: <20201029100936.GC460689@aptenodytes>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201029022000.601913-4-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20201029022000.601913-4-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 29 Oct 20, 02:19, Matteo Scordino wrote:
> The Elimo Engineering Impetus is an Open Source Hardware System-on-Module
> based on the SoChip S3 SoC.
>=20
> It is meant for integration into carrier boards or, more generally,
> larger designs, and uses an M2 connector to facilitate that.
>=20
> Interfaces on the M.2/NGFF 42mm connector:
> WiFi IEEE 802. 11abgn (on-module Realtek)
> Bluetooth 4.2/BLE (on-module Realtek)
> RGB LCD Interface (on-module connector)
> MIPI Camera Interface (on-module connector)
> IEEE 802. 3u Ethernet MAC (external connecto)
> USB2.0 (Host, Device, OTG) (external connector)
> Audio Line In/Out (external connector)
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
>=20
> diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/boo=
t/dts/sun8i-s3-elimo-impetus.dtsi
> new file mode 100644
> index 000000000000..3550125cf334
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-v3.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +/ {
> +	model =3D "Elimo Impetus SoM";
> +	compatible =3D "elimo,impetus", "sochip,s3", "allwinner,sun8i-s3";

I'm wondering what to do about the SoC compatibles here:
- Do we really need the "sochip,s3" compatible, as it seems redundant with
  "allwinner,sun8i-s3"?
- Could we add a "allwinner,sun8i-v3" compatible at the end since there is =
no
  functional difference between the two?

Another thing is that we should probably add "allwinner,sun8i-v3" to
mach-sunxi/sunxi.c so that it's matched by the DT_MACHINE_START.

If that seems agreeable, I can craft a patch for the latter.

What do you think?

The rest of the dt looks good to me :)

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
> +&mmc0 {
> +	broken-cd;
> +	bus-width =3D <4>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 =3D <&uart0_pb_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 =3D <&uart1_pg_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpio =3D <&pio 5 6 GPIO_ACTIVE_HIGH>;
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

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl+alOAACgkQ3cLmz3+f
v9EmnQgAn+lmJ4WldMeeZzOVmSP/s7CWdSfpraIUOkaYBb92TvrOAg2XXIb6EGDP
p2G4DRWqzQGGpWAXJHk6CGZkIn5s3Nwo697lFLaXcXLcbapjgidGNYXRhS4dSYn0
kuoCzp0RhM8LcPLGFAqH6Vj2svF+u+oGGEjHG0Wn0mGZJZZ7dJrQAl7PisxWkMJS
00lTX6hrcxfpMhgKkt06h1kaIqRCNw8CQvP81uR5kG7wOkk399fh7aqiFek8M/PV
eDqCAkJ+qaibFVOTsAqGZAa+k5ItxktNok1LWhvyR/YvAndGsaEz7nDfJnsCHDpM
LjxN6Do8HJvmoO6xcWrr6hXdL8STNw==
=wg98
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
