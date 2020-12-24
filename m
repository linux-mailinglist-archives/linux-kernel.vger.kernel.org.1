Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8432E25A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgLXJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 04:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgLXJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 04:22:27 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE5DC061794;
        Thu, 24 Dec 2020 01:21:46 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 8AF30C013D;
        Thu, 24 Dec 2020 10:21:43 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id F0320C1D1F; Thu, 24 Dec 2020 10:21:42 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 1DD67C19AD;
        Thu, 24 Dec 2020 10:21:35 +0100 (CET)
Date:   Thu, 24 Dec 2020 10:21:33 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ARM: dts: sun8i-v3s: Add CSI0 MCLK pin definition
Message-ID: <X+RdnbRbpAa7M+Zs@collins>
References: <20201218195033.2301127-1-contact@paulk.fr>
 <3035881.9zrMQt1rZd@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QDtH0RqLR267EXo0"
Content-Disposition: inline
In-Reply-To: <3035881.9zrMQt1rZd@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QDtH0RqLR267EXo0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Tue 22 Dec 20, 09:17, Jernej =C5=A0krabec a =C3=A9crit :
> Dne petek, 18. december 2020 ob 20:50:33 CET je Paul Kocialkowski napisal=
(a):
> > This adds a device-tree definition for the CSI0 MCLK pin,
> > which can be used for feeding MIPI CSI-2 sensors.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>=20
> Is this used anywhere? Current policy is to add pin definitions only if a=
ny=20
> user exists.

Ah right, sorry. I'll resend this when adding a board that uses it!

Cheers,

Paul

> Best regards,
> Jernej
>=20
> > ---
> >  arch/arm/boot/dts/sun8i-v3s.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi
> > b/arch/arm/boot/dts/sun8i-v3s.dtsi index a9f5795d4e57..bff822b9fa01 100=
644
> > --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> > @@ -337,6 +337,12 @@ pio: pinctrl@1c20800 {
> >  			interrupt-controller;
> >  			#interrupt-cells =3D <3>;
> >=20
> > +			/omit-if-no-ref/
> > +			csi0_mclk_pin: csi0-mclk-pin {
> > +				pins =3D "PE20";
> > +				function =3D "csi_mipi";
> > +			};
> > +
> >  			/omit-if-no-ref/
> >  			csi1_8bit_pins: csi1-8bit-pins {
> >  				pins =3D "PE0", "PE2", "PE3",=20
> "PE8", "PE9",
>=20
>=20
>=20
>=20

--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--QDtH0RqLR267EXo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAl/kXZ0ACgkQhP3B6o/u
lQzSlw/+PFYGsL8tqDt9bxPswZ/jGXebbWN3JG16pZFi07R8HmxR8f3TaB33Xcij
hIOSBRvJxs/1b3enlTpvlnsOYawTu/4HYgH9eEES2jBOcdCXhUO7l+AuLfeSdxYC
1a4i5NvSmQAIkRbJVAfuvU0VJKsrILll3ugGdIDLXn0MpHIOlC7rmfRgoozPPDeV
DjbwFXKsPZMA7fiM6TsmV/dJcYyZ/KxZ0HSKGiGQWG/VonL1nSEshspTobxBR80Y
bslUEVpzrWwnFbw81o3nGCqc8YsVA7Xrmz7IoF3gOYlfT5e27+DxbtqUCfZCJGLj
1HVKn4BLJ5xQ5mordHco7WNNKwf/3QgtqNDb+08PEt6HDmyyCd05F+mRMOESw1AD
Qc2XfTGoDuaXe0NeJF9zRMd2nnW6f70gXpCDyZETEq0Dx+fpQtw24PzRZjDT0pUy
BgWMUN+Zc81gt6sbu6R0RWhVESX+4c7CMQ/Fq7Px7IeNCD8uo51Fl27JqUa+Sfa7
ABvfBYZ+TPTI40LKQGJ3cvu+OMyuoDpcGN63AfXMpI/amVhXhSI6KvaceCLqoNUq
x+IydiUGXMiuKBDtotB74owfVkLmr9TXRWhQ7IsugsoYWEmBltNi7av7BrlKvvXR
mkdChOq1qSoagnGy8cox7mju6RHzjRyUzHCERAQxNHLbDIZ1AGs=
=XqWO
-----END PGP SIGNATURE-----

--QDtH0RqLR267EXo0--
