Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21232A4461
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgKCLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:37:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33539 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgKCLhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:37:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6B4E1252;
        Tue,  3 Nov 2020 06:37:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 03 Nov 2020 06:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/FmQxCk+NycNX4SUaT0+hCAEV3H
        Cx4PFmy3e006gaPM=; b=lBGt6NNQw6Wk8zzsp1aUYPpOXGi7uC8MZWEOSFbmFoX
        wf9xFPvA4n+MoRmo5tU2y0YOm61ZXrqULqZIkHq0HKEuXB4fCirvIT6bnjtLJL2P
        l84c47uWZqz2ORsygLjBctrYZIOYCAW/Xrg1Y4sqQ+rzE+apcGLjoSKc/idV7gGQ
        gAjTp7LpzbkMoG3HX7aTDeHtfmQ9UfF5ZaoMM7smdiESRhsPnPjUIDkxAXt85kaF
        HhLs2WYH6KOpG5ei2WyKXvU2so76/gCvhFKhhClPJdajkppzyF/X9T1AHSOzHvn2
        MlzoThd7mhtUlTAP0eIkdIgzMVl1FFQOCd0yydeAVTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/FmQxC
        k+NycNX4SUaT0+hCAEV3HCx4PFmy3e006gaPM=; b=Mb6vjPBm0nyGn99FmSrJGp
        OwKUhrdpDM7bZE5TmyqNmr63VNFCkX2H9NTTo1nIUqQAaNLt6aSYR6BGVB5tpEKw
        Kpf/aIsdEPIEVqnCTqKoEO5B7CXtaermIKR9tR8uPMTzohXhspW46QV19kthz7RS
        hYDbITY5dCi2eQ47FEupIPItfJ+KK8sKbWtrCiP0kI/XQwUISKM3ipN4AEwz0xUO
        77EqbKU8QP9F1mFnQc440+/6OS2je9RaHA/y14afs1s696pDVEKxTXARQ3DJjNNA
        qM5nqs2U1R/whQRASfBgh9RpDWbm0cvw6ptpUwUB1nIBG5RO+7JoT3A1SCAi0peA
        ==
X-ME-Sender: <xms:CUGhX4m6FNiJa9sJPi1PgnYiC1esD81LKOCDzxWGIiJGouJ86mPsGQ>
    <xme:CUGhX32erKxhmq4wh-0WH4D7pXX2LQm_K7DAhaRdYXbM4oiYvX8dKZr8UkbhxZ8id
    xrrxu9AQt3Gfvx2fnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CUGhX2ohgBQ-obLTZvtc8N82QVmiA-27picL_1cTe-3roZ0iN4BM_A>
    <xmx:CUGhX0niLte880ukD1t1HiLdawsbApduJbeFS3nEraJOK7eYFu9Q4A>
    <xmx:CUGhX22z0-PIeV_Sirgpa5H_zXzww90eN5-qee905APOC8zmSfGYOA>
    <xmx:CkGhX7xxjEcbFtcyy5Y5FVRCzVfhYB0XNu2YKQ894_IuidNDQpAuig>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22CB7328005A;
        Tue,  3 Nov 2020 06:37:45 -0500 (EST)
Date:   Tue, 3 Nov 2020 12:37:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Message-ID: <20201103113743.5764tj2ryrht4dfs@gilmour.lan>
References: <20201102100157.85801-1-mtwget@gmail.com>
 <20201102100157.85801-2-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kjczsezvhyt7c3cf"
Content-Disposition: inline
In-Reply-To: <20201102100157.85801-2-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjczsezvhyt7c3cf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Nov 02, 2020 at 06:01:57PM +0800, Yu-Tung Chang wrote:
> The NanoPi R1 is a complete open source board developed
> by FriendlyElec for makers, hobbyists, fans and etc.
>=20
> NanoPi R1 key features
> - Allwinner H3, Quad-core Cortex-A7@1.2GHz
> - 512MB/1GB DDR3 RAM
> - 8GB eMMC
> - microSD slot
> - 10/100/1000M Ethernet x 1
> - 10/100 Ethernet x 1
> - Wifi 802.11b/g/n
> - Bluetooth 4.0
> - Serial Debug Port
> - 5V 2A DC power-supply
>=20
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 169 ++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 0f23133672a3..54a1aaee7e22 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -251,6 +251,11 @@ properties:
>            - const: friendlyarm,nanopi-neo-plus2
>            - const: allwinner,sun50i-h5
> =20
> +      - description: FriendlyARM NanoPi R1
> +        items:
> +          - const: friendlyarm,nanopi-r1
> +          - const: allwinner,sun8i-h3
> +
>        - description: FriendlyARM ZeroPi
>          items:
>            - const: friendlyarm,zeropi
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4f0adfead547..aabaf67f86ed 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1192,6 +1192,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-h3-nanopi-m1-plus.dtb \
>  	sun8i-h3-nanopi-neo.dtb \
>  	sun8i-h3-nanopi-neo-air.dtb \
> +	sun8i-h3-nanopi-r1.dtb \
>  	sun8i-h3-orangepi-2.dtb \
>  	sun8i-h3-orangepi-lite.dtb \
>  	sun8i-h3-orangepi-one.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/dts=
/sun8i-h3-nanopi-r1.dts
> new file mode 100644
> index 000000000000..204a39f93f4e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2019 Igor Pecovnik <igor@armbian.com>
> + * Copyright (C) 2020 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
> + * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
> +*/
> +
> +#include "sun8i-h3-nanopi.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model =3D "FriendlyARM NanoPi R1";
> +	compatible =3D "friendlyarm,nanopi-r1", "allwinner,sun8i-h3";
> +
> +	aliases {
> +		serial1 =3D &uart1;
> +		ethernet0 =3D &emac;
> +		ethernet1 =3D &wifi;
> +	};
> +
> +	reg_gmac_3v3: gmac-3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "gmac-3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <100000>;
> +		enable-active-high;
> +		gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> +	};
> +
> +	reg_vdd_cpux: gpio-regulator {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "vdd-cpux";
> +		regulator-type =3D "voltage";
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-min-microvolt =3D <1100000>;
> +		regulator-max-microvolt =3D <1300000>;
> +		regulator-ramp-delay =3D <50>;
> +		gpios =3D <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +		gpios-states =3D <0x1>;
> +		states =3D <1100000 0x0
> +			  1300000 0x1>;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> +		clocks =3D <&rtc 1>;
> +		clock-names =3D "ext_clock";
> +	};
> +
> +	leds {
> +		led-2 {
> +			function =3D LED_FUNCTION_WAN;
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			gpios =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> +		};
> +
> +		led-3 {
> +			function =3D LED_FUNCTION_LAN;
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			gpios =3D <&pio 0 9 GPIO_ACTIVE_HIGH>; /* PA9 */
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_vdd_cpux>;
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&ehci2 {
> +	status =3D "okay";
> +};
> +
> +&emac {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&emac_rgmii_pins>;
> +	phy-supply =3D <&reg_gmac_3v3>;
> +	phy-handle =3D <&ext_rgmii_phy>;
> +	phy-mode =3D "rgmii-id";
> +	status =3D "okay";
> +};
> +
> +&external_mdio {
> +	ext_rgmii_phy: ethernet-phy@7 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <7>;
> +	};
> +};
> +
> +&mmc1 {
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	vqmmc-supply =3D <&reg_vcc3v3>;
> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> +	bus-width =3D <4>;
> +	non-removable;
> +	status =3D "okay";
> +
> +	wifi: wifi@1 {
> +		reg =3D <1>;
> +		compatible =3D "brcm,bcm4329-fmac";
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
> +		interrupt-names =3D "host-wake";
> +	};
> +};
> +
> +&mmc2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc2_8bit_pins>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	vqmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&ohci2 {
> +	status =3D "okay";
> +};
> +
> +&reg_usb0_vbus {
> +	gpio =3D <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart1_pins>;

This should be already set in the DTSI

> +	status =3D "okay";
> +};

What is this UART used for?

Thanks!
Maxime

--kjczsezvhyt7c3cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6FBBwAKCRDj7w1vZxhR
xdgTAQDffIckKDSRQ6dRElFETo94xdrKSm1YmADewRVaGI2v0QEAiqL/NllUMMgT
Syqn9guKqtjwCBDQoz9HftQ3JLJeMwY=
=TXSB
-----END PGP SIGNATURE-----

--kjczsezvhyt7c3cf--
