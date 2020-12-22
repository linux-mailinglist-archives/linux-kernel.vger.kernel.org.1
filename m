Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C522E0DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgLVRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:42:20 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43497 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLVRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:42:20 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4D0kCX2VQXz1rxwf;
        Tue, 22 Dec 2020 18:41:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4D0kCX1F2sz1tSQV;
        Tue, 22 Dec 2020 18:41:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 72ugdAVwJ_R2; Tue, 22 Dec 2020 18:41:10 +0100 (CET)
X-Auth-Info: 85OJrTyGy1GjlWs8OTVX2YEXxAWPd/RAt92k05x/mMo=
Received: from jawa (89-64-25-12.dynamic.chello.pl [89.64.25.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 22 Dec 2020 18:41:10 +0100 (CET)
Date:   Tue, 22 Dec 2020 18:41:09 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>
Subject: Re: [PATCH v2] ARM: dts: imx28: add pinmux for USB1 overcurrent on
 pwm2
Message-ID: <20201222184109.20706806@jawa>
In-Reply-To: <20201209220903.27058-1-lukma@denx.de>
References: <20201209220903.27058-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/yhu8Rxil7jL.3=Bnzi_r8lt"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yhu8Rxil7jL.3=Bnzi_r8lt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> From: Mans Rullgard <mans@mansr.com>
>=20
> Add pinmux setting for USB1 overcurrent on pwm2 pad.
>=20

Gentle ping on this patch.

> Signed-off-by: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Add S-o-B
> ---
>  arch/arm/boot/dts/imx28.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/imx28.dtsi
> b/arch/arm/boot/dts/imx28.dtsi index bbe52150b165..84d0176d5193 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -948,6 +948,16 @@
>  					fsl,pull-up =3D
> <MXS_PULL_DISABLE>; };
> =20
> +				usb1_pins_b: usb1@1 {
> +					reg =3D <1>;
> +					fsl,pinmux-ids =3D <
> +
> MX28_PAD_PWM2__USB1_OVERCURRENT
> +					>;
> +					fsl,drive-strength =3D
> <MXS_DRIVE_12mA>;
> +					fsl,voltage =3D
> <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up =3D
> <MXS_PULL_DISABLE>;
> +				};
> +
>  				usb0_id_pins_a: usb0id@0 {
>  					reg =3D <0>;
>  					fsl,pinmux-ids =3D <




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/yhu8Rxil7jL.3=Bnzi_r8lt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl/iL7UACgkQAR8vZIA0
zr1wJQgA5J9GLb1+eSFThGphhuOPNgM3b2xHROd7wdWfVXHLt9S4TTcAamlvFeKH
AVmeyAJ/z292hsRasYYbZGdFpej6NhZEJuRF1gwYSXy9wzebNYMj6my/NgnRJW1K
3cZQLdP2mqvWscf0LYuMUx1wuN7j4EkI+NSOv8KmpVqaVb4dRrSxwoSX1UhNanxH
NXm9mKknQk+RZ/VgW3x8B7ImH6ocYnnQ+Z3QAG+EJYahQiQGUSlBD455zHpBPDuO
HySjsgNGf8YQF5jKscseU13/g5XOCYzQKmOrvyCShfmVj7wreFP71q/sqozICBi2
tuPbBJhS739XW0wHIBJJ8CLecJe5KQ==
=OB9q
-----END PGP SIGNATURE-----

--Sig_/yhu8Rxil7jL.3=Bnzi_r8lt--
