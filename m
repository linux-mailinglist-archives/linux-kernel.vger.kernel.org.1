Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12F2CC1B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgLBQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:07:53 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36383 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388964AbgLBQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:07:52 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8B196580324;
        Wed,  2 Dec 2020 11:07:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 02 Dec 2020 11:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SzXxlSkSGRoREDq69ZxNmxNcJlR
        p/+f9IrMRRTQgKgA=; b=GvlPW0keYnkFohqdzp9M1e/lDFnqqj5wFXv5QRaydKM
        e9TuNVzwrdOhMlG6q06BmjxQdgoNv1uGW7JjzRvXioungZf16H38NYjBgPJXLA1J
        Xlk6GDiSXOny3HxDxxhnZFTkxDW0rdfa6inncO98IMa7aNpGSUt+4SxEZQRegm5B
        zNYr2mhoCHqR6csPObeh9ZOlIMbo/Q+Rm4mh8qqAJ5D+a3kA09Cc5JxNu2VU66sR
        1409NWFbTIsHL+nGDvH/EiOuZa3mRh6jprfdWa+he5UN7UZ/kHSZ2DcQLjG+6rxz
        a0Oa09AIRHFYze3KCeOfxDF1C++xH2xL12DESMXXSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SzXxlS
        kSGRoREDq69ZxNmxNcJlRp/+f9IrMRRTQgKgA=; b=f8L6x6tJ6iQR8n4IQ5BAyh
        eDkUCLXpowxyYCLRl0kjkhsX8iUb1NwozafjnkTnqBHwY3ETuQuolN3/gHMKil/O
        NUnGJWErM3ZCeiTj7Uf2+bOKcKpjcOER0GY93xihedJ5unGHpN0Ep6OnH4WwiFBO
        v+SHeohBLCNRpVfn3BmEk9C0CXGbDtmZmGVnbhiR8PGn8aNhr3hwkpufvjtFRcnd
        YMkGbdHC15Cepx6Nd5BkIHJa4+cV01nDTAuot2x+G24rydqYyzgAz++q+SZ7q/gy
        N95aQiRvVjnAsycaAWtWc5pL5+nphXO8EijHsbCVK+vQlNZuJeQq+NbZSzhTobUw
        ==
X-ME-Sender: <xms:p7vHXy_kbA5O_z--wfUc45MGQGCsTvxt3Ftlz7fp5vv39GDSjjTZXQ>
    <xme:p7vHX8KX9MMiMxkZRVrRBCCV4vbTShHlua3QsdfRp_hRWJg5YngqnQFaIFGEEq3EQ
    vIGBKbBon1z3XnX3D4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeigedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdfggfelgeehieeuieegfefgueduudefheffhfejleekheefjeevveegueel
    ueefnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:p7vHX3k366BXrnsoB7HCqLal4z1to8ZdXMNoOvAG8fEC4Fa6S5sxLw>
    <xmx:p7vHXwNodHFQnpDUknp-HlNFfNKSPg2An9ZV0CDLgiPLkoHj3905rg>
    <xmx:p7vHX93h83tHPrl993pqVR4-L2fTUDHv9jA29MG2klFOUe4jhblUSA>
    <xmx:qbvHX7HkufcEH5Vk79cYS6EaDDpm1vuGf1JdCyj9vRPEDPAv0Xo2Aw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63B57240061;
        Wed,  2 Dec 2020 11:07:03 -0500 (EST)
Date:   Wed, 2 Dec 2020 17:07:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: allwinner: Add OrangePi Zero 2 .dts
Message-ID: <20201202160702.rdigwtcv3avil4n3@gilmour>
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ojkz43yurbxnyb2s"
Content-Disposition: inline
In-Reply-To: <20201202135409.13683-9-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ojkz43yurbxnyb2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 01:54:09PM +0000, Andre Przywara wrote:
> The OrangePi Zero 2 is a development board with the new H616 SoC.
>=20
> It features the usual connectors used on those small boards, and comes
> with the AXP305, which seems to be compatible with the AXP805.
>=20
> For more details see: http://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 228 ++++++++++++++++++
>  2 files changed, 229 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-ze=
ro2.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index 211d1e9d4701..0cf8299b1ce7 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-pl=
us.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> new file mode 100644
> index 000000000000..814f5b4fec7c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model =3D "OrangePi Zero2";
> +	compatible =3D "xunlong,orangepi-zero2", "allwinner,sun50i-h616";

This needs to be documented too

> +	aliases {
> +		ethernet0 =3D &emac0;
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		power {
> +			label =3D "orangepi:red:power";
> +			gpios =3D <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
> +			default-state =3D "on";
> +		};
> +
> +		status {
> +			label =3D "orangepi:green:status";
> +			gpios =3D <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
> +		};

Those node names don't follow the led binding convention

> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-5v";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "usb1-vbus";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		enable-active-high;
> +		gpio =3D <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +		status =3D "okay";
> +	};
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&emac0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&ext_rgmii_pins>;
> +	phy-mode =3D "rgmii";
> +	phy-handle =3D <&ext_rgmii_phy>;
> +	phy-supply =3D <&reg_dcdce>;
> +	allwinner,rx-delay-ps =3D <3100>;
> +	allwinner,tx-delay-ps =3D <700>;
> +	status =3D "okay";
> +};
> +
> +&mdio {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply =3D <&reg_dcdce>;
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&r_i2c {
> +	status =3D "okay";
> +
> +	axp305: pmic@36 {
> +		compatible =3D "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		reg =3D <0x36>;
> +
> +		/* dummy interrupt to appease the driver for now */
> +		interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply =3D <&reg_vcc5v>;
> +		vinb-supply =3D <&reg_vcc5v>;
> +		vinc-supply =3D <&reg_vcc5v>;
> +		vind-supply =3D <&reg_vcc5v>;
> +		vine-supply =3D <&reg_vcc5v>;
> +		aldoin-supply =3D <&reg_vcc5v>;
> +		bldoin-supply =3D <&reg_vcc5v>;
> +		cldoin-supply =3D <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-sys";
> +			};
> +
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc3v3-ext";
> +			};
> +
> +			reg_aldo3: aldo3 {
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc3v3-ext2";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-name =3D "vcc1v8";
> +			};
> +
> +			bldo2 {
> +				/* unused */
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				/* reserved */
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <1080000>;
> +				regulator-name =3D "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <810000>;
> +				regulator-max-microvolt =3D <1080000>;
> +				regulator-name =3D "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <1500000>;
> +				regulator-max-microvolt =3D <1500000>;
> +				regulator-name =3D "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_ph_pins>;
> +	status =3D "okay";
> +};
> +
> +&usbotg {
> +	dr_mode =3D "otg";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	usb0_vbus-supply =3D <&reg_vcc5v>;
> +	usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +	status =3D "okay";
> +};

Did you really test it as OTG without an ID pin?

Maxime

--ojkz43yurbxnyb2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8e7pgAKCRDj7w1vZxhR
xQXUAPsFzoqoyDf7aiuBs1ku7UiwOihJhTCOFtwIHEViZJyFdAEAsULp7pKIrnQI
AQGGRy0l/xXJ2dxl1GU057sjUoA1DwM=
=Sg00
-----END PGP SIGNATURE-----

--ojkz43yurbxnyb2s--
