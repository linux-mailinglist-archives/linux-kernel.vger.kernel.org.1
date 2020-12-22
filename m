Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873152E0DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgLVRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgLVRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:43:32 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C8C0613D6;
        Tue, 22 Dec 2020 09:42:52 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4D0kFR0BpQz1s1KJ;
        Tue, 22 Dec 2020 18:42:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4D0kFQ60Qsz1tSQV;
        Tue, 22 Dec 2020 18:42:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5MH4ge1mi0Ri; Tue, 22 Dec 2020 18:42:48 +0100 (CET)
X-Auth-Info: 7DsCkGSKO1Lcwkx1bMVcPZ/VBMyUaUGXcuhKawToJn8=
Received: from jawa (89-64-25-12.dynamic.chello.pl [89.64.25.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 22 Dec 2020 18:42:48 +0100 (CET)
Date:   Tue, 22 Dec 2020 18:42:48 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: imx28: Add DTS description of imx28 based
 XEA board
Message-ID: <20201222184248.1d79c2a3@jawa>
In-Reply-To: <20201209231141.377af967@jawa>
References: <20201125161815.2361-1-lukma@denx.de>
        <20201125161815.2361-3-lukma@denx.de>
        <20201209231141.377af967@jawa>
Organization: denx.de
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/V7FuaNgqB+vX/Npg4EOHPPf"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V7FuaNgqB+vX/Npg4EOHPPf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> Dear Community,
>=20
> > This patch adds DTS definition of the imx278 based XEA board.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/Makefile       |   3 +-
> >  arch/arm/boot/dts/imx28-lwe.dtsi | 185
> > +++++++++++++++++++++++++++++++ arch/arm/boot/dts/imx28-xea.dts  |
> > 99 +++++++++++++++++ 3 files changed, 286 insertions(+), 1
> > deletion(-) create mode 100644 arch/arm/boot/dts/imx28-lwe.dtsi
> >  create mode 100644 arch/arm/boot/dts/imx28-xea.dts
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4572db3fa5ae..c7c95ddc648b 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -702,7 +702,8 @@ dtb-$(CONFIG_ARCH_MXS) +=3D \
> >  	imx28-m28evk.dtb \
> >  	imx28-sps1.dtb \
> >  	imx28-ts4600.dtb \
> > -	imx28-tx28.dtb
> > +	imx28-tx28.dtb \
> > +	imx28-xea.dtb
> >  dtb-$(CONFIG_ARCH_NOMADIK) +=3D \
> >  	ste-nomadik-s8815.dtb \
> >  	ste-nomadik-nhk15.dtb
> > diff --git a/arch/arm/boot/dts/imx28-lwe.dtsi
> > b/arch/arm/boot/dts/imx28-lwe.dtsi new file mode 100644
> > index 000000000000..cb2eb4377d9c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx28-lwe.dtsi
> > @@ -0,0 +1,185 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2020
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28.dtsi"
> > +
> > +/ {
> > +	compatible =3D "fsl,imx28";
> > +
> > +	aliases {
> > +		spi2 =3D &ssp3;
> > +	};
> > +
> > +	chosen {
> > +		bootargs =3D "root=3D/dev/mmcblk0p2 rootfstype=3Dext4 ro
> > rootwait console=3DttyAMA0,115200 panic=3D1";
> > +	};
> > +
> > +	memory {
> > +		reg =3D <0x40000000 0x08000000>;
> > +	};
> > +
> > +	regulators {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		reg_3v3: regulator@0 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <0>;
> > +			regulator-name =3D "3V3";
> > +			regulator-min-microvolt =3D <3300000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		reg_usb_5v: regulator@1 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <1>;
> > +			regulator-name =3D "usb_vbus";
> > +			regulator-min-microvolt =3D <5000000>;
> > +			regulator-max-microvolt =3D <5000000>;
> > +			enable-active-high;
> > +		};
> > +
> > +		reg_fec_3v3: regulator@2 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <2>;
> > +			regulator-name =3D "fec-phy";
> > +			regulator-min-microvolt =3D <3300000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +			enable-active-high;
> > +			regulator-boot-on;
> > +		};
> > +	};
> > +};
> > +
> > +&duart {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&duart_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c0_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&saif0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&saif0_pins_a>;
> > +	#sound-dai-cells =3D <0>;
> > +	assigned-clocks =3D <&clks 53>;
> > +	assigned-clock-rates =3D <12000000>;
> > +	status =3D "okay";
> > +};
> > +
> > +&saif1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&saif1_pins_a>;
> > +	fsl,saif-master =3D <&saif0>;
> > +	#sound-dai-cells =3D <0>;
> > +	status =3D "okay";
> > +};
> > +
> > +&spi3_pins_a {
> > +	fsl,pinmux-ids =3D <
> > +		MX28_PAD_AUART2_RX__SSP3_D4
> > +		MX28_PAD_AUART2_TX__SSP3_D5
> > +		MX28_PAD_SSP3_SCK__SSP3_SCK
> > +		MX28_PAD_SSP3_MOSI__SSP3_CMD
> > +		MX28_PAD_SSP3_MISO__SSP3_D0
> > +		MX28_PAD_SSP3_SS0__SSP3_D3
> > +		MX28_PAD_AUART2_TX__GPIO_3_9
> > +	>;
> > +};
> > +
> > +&ssp3 {
> > +	compatible =3D "fsl,imx28-spi";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi3_pins_a>;
> > +	status =3D "okay";
> > +
> > +	flash0: s25fl256s0@0 {
> > +		compatible =3D "s25fl256s1", "jedec,spi-nor";
> > +		spi-max-frequency =3D <40000000>;
> > +		reg =3D <0>;
> > +
> > +		partitions {
> > +			compatible =3D "fixed-partitions";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +
> > +			partition@0 {
> > +				label =3D "u-boot";
> > +				reg =3D <0 0x80000>;
> > +				read-only;
> > +			};
> > +
> > +			partition@80000 {
> > +				label =3D "env0";
> > +				reg =3D <0x80000 0x10000>;
> > +			};
> > +
> > +			partition@90000 {
> > +				label =3D "env1";
> > +				reg =3D <0x90000 0x10000>;
> > +			};
> > +
> > +			partition@100000 {
> > +				label =3D "kernel";
> > +				reg =3D <0x100000 0x400000>;
> > +			};
> > +
> > +			partition@500000 {
> > +				label =3D "swupdate";
> > +				reg =3D <0x500000 0x800000>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&ssp2 {
> > +	compatible =3D "fsl,imx28-spi";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi2_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&ssp0 {
> > +	compatible =3D "fsl,imx28-mmc";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&mmc0_8bit_pins_a>;
> > +	bus-width =3D <8>;
> > +	vmmc-supply =3D <&reg_3v3>;
> > +	non-removable;
> > +	status =3D "okay";
> > +};
> > +
> > +&usb0 {
> > +	vbus-supply =3D <&reg_usb_5v>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&usb0_pins_b>, <&usb0_id_pins_a>;
> > +	dr_mode =3D "host";
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb1 {
> > +	vbus-supply =3D <&reg_usb_5v>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&usb1_pins_b>;
> > +	dr_mode =3D "host";
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy1 {
> > +	status =3D "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/imx28-xea.dts
> > b/arch/arm/boot/dts/imx28-xea.dts new file mode 100644
> > index 000000000000..672080485b78
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx28-xea.dts
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2020
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28-lwe.dtsi"
> > +
> > +/ {
> > +	model =3D "XEA";
> > +};
> > +
> > +&can0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&can1_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c1_pins_b>;
> > +	status =3D "okay";
> > +};
> > +
> > +&pinctrl {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&hog_pins_a &hog_pins_tiva>;
> > +
> > +	hog_pins_a: hog@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_D00__GPIO_0_0
> > +			MX28_PAD_GPMI_D02__GPIO_0_2
> > +			MX28_PAD_GPMI_D05__GPIO_0_5
> > +			MX28_PAD_GPMI_CE1N__GPIO_0_17
> > +			MX28_PAD_GPMI_RDY0__GPIO_0_20
> > +			MX28_PAD_GPMI_RDY1__GPIO_0_21
> > +			MX28_PAD_GPMI_RDY2__GPIO_0_22
> > +			MX28_PAD_GPMI_RDN__GPIO_0_24
> > +			MX28_PAD_GPMI_CLE__GPIO_0_27
> > +			MX28_PAD_LCD_VSYNC__GPIO_1_28
> > +			MX28_PAD_SSP1_SCK__GPIO_2_12
> > +			MX28_PAD_SSP1_CMD__GPIO_2_13
> > +			MX28_PAD_SSP2_SS1__GPIO_2_20
> > +			MX28_PAD_SSP2_SS2__GPIO_2_21
> > +			MX28_PAD_LCD_D00__GPIO_1_0
> > +			MX28_PAD_LCD_D01__GPIO_1_1
> > +			MX28_PAD_LCD_D02__GPIO_1_2
> > +			MX28_PAD_LCD_D03__GPIO_1_3
> > +			MX28_PAD_LCD_D04__GPIO_1_4
> > +			MX28_PAD_LCD_D05__GPIO_1_5
> > +			MX28_PAD_LCD_D06__GPIO_1_6
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	hog_pins_tiva: hog@1 {
> > +		reg =3D <1>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_RDY3__GPIO_0_23
> > +			MX28_PAD_GPMI_WRN__GPIO_0_25
> > +		>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	hog_pins_coding: hog@2 {
> > +		reg =3D <2>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_D01__GPIO_0_1
> > +			MX28_PAD_GPMI_D03__GPIO_0_3
> > +			MX28_PAD_GPMI_D04__GPIO_0_4
> > +			MX28_PAD_GPMI_D06__GPIO_0_6
> > +			MX28_PAD_GPMI_D07__GPIO_0_7
> > +		>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +};
> > +
> > +&reg_fec_3v3 {
> > +	gpio =3D <&gpio0 0 0>;
> > +};
> > +
> > +&reg_usb_5v {
> > +	gpio =3D <&gpio0 2 0>;
> > +};
> > +
> > +&spi2_pins_a {
> > +	fsl,pinmux-ids =3D <
> > +		MX28_PAD_SSP2_SCK__SSP2_SCK
> > +		MX28_PAD_SSP2_MOSI__SSP2_CMD
> > +		MX28_PAD_SSP2_MISO__SSP2_D0
> > +		MX28_PAD_SSP2_SS0__GPIO_2_19
> > +	>;
> > +}; =20
>=20
> Gentle ping on this patch.

Gentle ping on this patch. Are there any comments regarding it?

>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/V7FuaNgqB+vX/Npg4EOHPPf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl/iMBgACgkQAR8vZIA0
zr0qAgf/VzXnTx95PnMYmCy6X0HBmwKgcR9LcWJ933Et/SsjrW97LIr9a/4WeZHn
r3OvqPCkUIwLq4FIPUw4/yyTFTnaEiJqzl1mm9MLYRHAWwt98159pKE9XFJ4wp1j
vr1UwwfLnR0geAAxAnQy7clWPT0iq42V/rSTrreBPSu4a8V9UU7Vs4/QailJVO+L
NOarmGUsupkys2Rm2vhgm2VEbAs9o2NI/iKzuF6JQEN6GrQ6e8d4egKc8gYbnUbk
TNbJZTb27c1wX8+UpIEHIbqYrfCqzvCFO2mhSqh6vSmjtj/fv0JPJ111VLjPeZ2t
x1WioZYUD6zoY3gf0cMegn/n/ySCJQ==
=z7E+
-----END PGP SIGNATURE-----

--Sig_/V7FuaNgqB+vX/Npg4EOHPPf--
