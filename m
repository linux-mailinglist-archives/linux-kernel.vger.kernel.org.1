Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC85302C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbhAYUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:30:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:39601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbhAYU2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611606373;
        bh=EFre/a3jxQxs6PpHV4GixbvePX8KFTSbRFMlZ4ilUP0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UWn9olG0oI9NA/RcFbkJaLiYqGfDVsh+50NSnMeT1qA7kjDcHplPK5IJzr0Zb0rED
         v1xWm/O0t1irWT6lHSefCD0laydTVu8OWwyWhtMteaVTIxUhmlBbWcgLodgrPKnQ+t
         2k5id9nzP5phY77G7pntxzy11Ir30zDhoMRO1kdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1m6Otm0KZj-0166Bd; Mon, 25
 Jan 2021 21:26:13 +0100
Date:   Mon, 25 Jan 2021 21:26:10 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, j.neuschaefer@gmx.net
Subject: Re: [PATCH] ARM: dts: imx6sl-tolino-shine2hd: Add Netronix embedded
 controller
Message-ID: <YA8pYv1944Y7uaT0@latitude>
References: <20210124214127.3631530-8-j.neuschaefer@gmx.net>
 <20210125190804.12552-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kTqtERsJ9y+2H155"
Content-Disposition: inline
In-Reply-To: <20210125190804.12552-1-andreas@kemnade.info>
X-Provags-ID: V03:K1:o6uNvkYzVOedAmld+ISO/GuuMIygh/it05hbmQLNE9GlRObmwEc
 T6CfoHJ12oCWRev4lwMiF6lBzGQ4N4UignoFzTtg9ctm5+LhjJ3znqQUa9k6FJE5nInHjLV
 FdfLWpv9Sj70b5BEGPjak5WZEe97P5MeoFSu7C+V4Lir0fbCTd+CIUCyvqPpFK0R5BmUH0Y
 WZfm8WUbcV28LpWKvpl3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iR91ag/I62I=:MovJrX+Kyx+YKy4XnmrS1c
 v+u/wrh7RTEy75SlPcfhk01NRl/rjmkDG/M0rQRgp8wzqH+8L69bMMLiDlfdnI9N+CKYMvRop
 KfZ6huQBBDTvD9Wkd52tfRUt+jyii2qXe4uCkvlPajy6JOOwFh9CrpxV/FlkMC6k7opkkdg5d
 MBhLIB43De7eMeT/zteEdx8dPz+29dEhcDKckQPJYqEYWyMhtAxDKKNqfQ3c4hNy+wVTJ79WH
 lR2ddH9vQpnamlh9FOuyUWLDgYEmTBL0kzoaZkE5qOohz+EpZvPr5BDPOUaiXRiJZDjFhjceN
 jgwY3BFtglj6sgl/W7pWKfPJpMk+LEm3LwW3TXLnU6XVp+iHpxQsfu9OzttJtaJsRyIrnl9gU
 +1pWMfsXN6Qot7BDgwyTER/jvey8K3l/wBq806iZgqn8kS5/tsGic3fvMhTzg8KiWr7Ztvw/1
 O0TExe+c9iNPwDbzB1DMcrx2foUkr/c8BbhTIdVzDS6Qb4nwk5+kkwDvEJm+l8z4lWZaecZIi
 7RQEtspfTJ48pfk5CvMNjnx/3FCEYjxG0XOMhOkODV6NdxRAMjWUe/Bd9FrODNxlYmgYeyat6
 pxYOE07ju5SceL7u8ym4SvG2uJ5X3lHt7Cipy91H9WPJkCp050sZJQKSJ5H22VRilGDvHdbqJ
 hDKLXIhajJOUtiznomfOhkW/AfBKWb+1/8T0eCQ5K1DZZ8F+AdTHkbxHFKhjltbWgoGyXfOro
 tN3JjGHCsuX3YqgRPkJ113lSyWOAZlUHwTClEyD+KJIdKF5PZF2286BMKquS/UPxuIbxWiXVj
 bns5JEolycShzHuu4PhNc8/ei97IqltfwWKf6CQx9yC52iPhEe7t0YYaRcfBK9z5xWO00gH6e
 5OL0fYoHJw4/HInvR7vA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kTqtERsJ9y+2H155
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2021 at 08:08:04PM +0100, Andreas Kemnade wrote:
> For now, the driver detects an incompatible version, but since
> that can be handled by auto-detection, add the controller to the
> devicetree now. Only PWM seems to be available, there is no RTC
> in that controller.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

>  arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot=
/dts/imx6sl-tolino-shine2hd.dts
> index caa279608803..c26bc5e10593 100644
> --- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> @@ -97,8 +97,11 @@ &i2c1 {
>  	pinctrl-1 =3D <&pinctrl_i2c1_sleep>;
>  	status =3D "okay";
> =20
> -	/* TODO: embedded controller at 0x43 (driver missing) */
> -
> +	ec: embedded-controller@43 {
> +		compatible =3D "netronix,ntxec";
> +		reg =3D <0x43>;
> +		#pwm-cells =3D <2>;
> +	};

Looks good.


Thanks,
Jonathan

--kTqtERsJ9y+2H155
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmAPKUoACgkQCDBEmo7z
X9u9ag//S/K5DO3ayaScrll9NlC74fZcgRkDT5nttrbR2oI2+Sek0ed+0S3jCAXJ
JkkPbjLUhIKLc3dzANimLEmmG6BNTdANoz0kHMWNMg3tqgf2MaHeIS2mGFKKs+FT
xtnfezH1ZXNUpONGIk+fp9KvDLibSsflQZyyR32F+OqWH7GpXcmi8Gaz6kk1jxmk
qsPpqRcB3RiFJjkeywnacOoS+zoRw4eOthu2KunHTQodNH/oFhQF47GD+mNUOrlT
NCvapl6RbRWB3NNvHSWmNmpoVSuMkFXwC/dShAtVpaVd0NmuxonXw+4MpP1KoBmi
K+piVAv8jmf3PMSDLZY15ShowDplIgwqmtKiVpMEqkD3uiaKu5xT245v/1yhLcr6
ja9kKuTP853VIs2zjqrC2wIWEFmd979WofnR9Oev5uE4WP/iY5dbIp7Ny3iZSyl7
3oytpKKvIaj9kRbAqvWnpA6ZoHksu3/bXWaDAMe4HbZDukfeczKnfF1Xgb0mbIhQ
PkY8kStCSXmg+91JryzEFkMP5WhgjYCqUV3ibx5vcBnUM4Bg40/lZmS7TGlZUJIM
YSPTiFY0cOyyh5ZXDCUPk2GHl9lLxuDj7/SvI4eDb/rREbcqUGwck4HNYTlh7FSH
/fitjSt+2r2ypFs16yKg3S/+Exm9iCRW+qjyK220WvBxeaiUd4o=
=Jnph
-----END PGP SIGNATURE-----

--kTqtERsJ9y+2H155--
