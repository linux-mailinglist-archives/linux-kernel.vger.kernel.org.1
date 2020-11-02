Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BEC2A2804
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgKBKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:16:30 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55285 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728256AbgKBKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:16:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 533ADF40;
        Mon,  2 Nov 2020 05:16:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qg+IBDr4XlMr/uCqKeMaRSomA6I
        /aeqM6HF4bPsS+Z8=; b=VbCWBKo/3EekOTVOQv9W9UGuStt54qsdvlvr/F01kEf
        K1PVegrpfhdqKJfuhbEXeP7O0drw5/qz7gXe9OObUeJOUOmYzwFZ5u7k3oBf0Rez
        b0ltNICOJGZGc079xREchOj3LTXHKgKZzzqeRJiEeNppLnupyNCUgeQJan0tyfng
        Q6uWPXJe0qqA7A+p3fNdhN4uKpPk+X7j13U0fJkTcctIhPq+wcle4lZCvQpYvig2
        BhgkWsa9PCyU2ndafayF68DeJZ/YRQyHZWfPNTK3FKRMWysDt9T7Cl/ztmW+4vN+
        U0N9Ayfb2gCO/y0EgS2ru/NOLT7r4OTN8ouSaZcfg4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qg+IBD
        r4XlMr/uCqKeMaRSomA6I/aeqM6HF4bPsS+Z8=; b=ZiAICfgGzu/QBLJfQWDGmX
        9uN62n1VilZjvurmmBN7JGr1INuC2O8r6FFimRK+LOUK8ZdfEVadEUvdsod3b2s1
        gsW0Oq7frqGZ+wHssQbAf8ukmwDjCHVU9nEAyYZ2FeF+hIr3ZuOJbz6yEZTqXkkx
        en/SRPngosvsO/u+xhqFu6rxcQ5RSw40wEszAHf7b2oD7pOiXV3grSEastxbFrGQ
        l/WNz/8QHnsCvy4+LC+9ldmBki2cE0zQryxaOYe2vfvrctBQ9RV4Y45DSe7TV2Y5
        v9Boo6jF7ucOgYjawEpnOL4e9FX/F4G+mHn64fl3Vt5/BRHI7F0cwmy1inLPP6SQ
        ==
X-ME-Sender: <xms:e9yfX2zCpgnOTfyGr9MRhaN5EnsSKUFWYZrCbpfYlLNH00d12To70A>
    <xme:e9yfXyTsMxqhmPtNSHZfO0jrGiZ7yni3QSHlLEpUOCemPJBsVGlUwwDUYfDLqROnQ
    hv9e2K6RlW1A34iIfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:e9yfX4U71K5PPcbLtNUkS7pfVCN38Bh-dRzXzQzKb4fYZkRFDTDdRQ>
    <xmx:e9yfX8hBVpeKc-l1-ItuUjcTXLkq03xYKsBbySmnmh7ycYY254-Wjw>
    <xmx:e9yfX4B2dz_-hK70f_qLikZSushu8H3aE5VUYtg5ozcTlIsz_p2Mhw>
    <xmx:e9yfX36ITCrptCdQHiX3_rcRMgdSE1ObdyI3__tlcf5jRGOUM653nQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18A743064674;
        Mon,  2 Nov 2020 05:16:27 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:16:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 9/9] ARM: dts: sun8i-v3: Add support for the SL631 Action
 Camera with IMX179
Message-ID: <20201102101626.t4ox3rwbwp335i2m@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-10-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i74lwqhb42esp3s4"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-10-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i74lwqhb42esp3s4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2020 at 07:21:37PM +0100, Paul Kocialkowski wrote:
> The SL631 is a family of Allwinner V3 action cameras sold under
> various names, such as SJCAM SJ4000 Air or F60 Action Camera.
>=20
> Devices in this family share a common board design but can be found
> with different image sensors, including the IMX179 and the OV4689.
>=20
> This adds support for a common dtsi for the SL631 family as well as
> a specific dts for the IMX179 fashion, which will later be populated
> with an IMX179 node when a driver is available.
>=20
> Features that were tested on the device include:
> - UART debug
> - MMC
> - USB peripheral (e.g. g_ether)
> - Buttons
> - SPI NOR flash
>=20
> Note that the exact designer/vendor of these boards is unknown.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts |  12 ++
>  arch/arm/boot/dts/sun8i-v3-sl631.dtsi       | 145 ++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
>  create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631.dtsi
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4363ba564bb4..b76bcda9a9df 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1196,6 +1196,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-s3-lichee-zero-plus.dtb \
>  	sun8i-s3-pinecube.dtb \
>  	sun8i-t3-cqa3t-bv3.dtb \
> +	sun8i-v3-sl631-imx179.dtb \
>  	sun8i-v3s-licheepi-zero.dtb \
>  	sun8i-v3s-licheepi-zero-dock.dtb \
>  	sun8i-v40-bananapi-m2-berry.dtb
> diff --git a/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts b/arch/arm/boot/=
dts/sun8i-v3-sl631-imx179.dts
> new file mode 100644
> index 000000000000..9e3b78000bdb
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +/*
> + * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
> + */
> +
> +#include "sun8i-v3-sl631.dtsi"
> +
> +/ {
> +	model =3D "SL631 Action Camera with IMX179";
> +	compatible =3D "unknown,sl631-imx179", "unknown,sl631",
> +		     "allwinner,sun8i-v3";
> +};
> diff --git a/arch/arm/boot/dts/sun8i-v3-sl631.dtsi b/arch/arm/boot/dts/su=
n8i-v3-sl631.dtsi
> new file mode 100644
> index 000000000000..9bc84d2812a6
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-v3-sl631.dtsi
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +/*
> + * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun8i-v3.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model =3D "SL631 Action Camera";
> +	compatible =3D "unknown,sl631", "allwinner,sun8i-v3";
> +
> +	aliases {
> +		serial0 =3D &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&nmi_intc>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c1_pb_pins>;
> +	status =3D "okay";
> +};
> +
> +&lradc {
> +	vref-supply =3D <&reg_ldo2>;
> +	status =3D "okay";
> +
> +	button@174 {
> +		label =3D "Volume Down";
> +		linux,code =3D <KEY_VOLUMEDOWN>;
> +		channel =3D <0>;
> +		voltage =3D <174603>;
> +	};
> +
> +	button@384 {
> +		label =3D "Volume Up";
> +		linux,code =3D <KEY_VOLUMEUP>;
> +		channel =3D <0>;
> +		voltage =3D <384126>;
> +	};
> +
> +	button@593 {
> +		label =3D "Home";
> +		linux,code =3D <KEY_HOME>;
> +		channel =3D <0>;
> +		voltage =3D <593650>;
> +	};
> +};

The buttons are not valid node names, since you can't use a unit-address
without reg.

> +&mmc0 {
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +	bus-width =3D <4>;
> +	vmmc-supply =3D <&reg_dcdc3>;
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	vcc-pd-supply =3D <&reg_dcdc3>;
> +	vcc-pe-supply =3D <&reg_dcdc3>;
> +};
> +
> +#include "axp209.dtsi"
> +
> +&ac_power_supply {
> +	status =3D "okay";
> +};
> +
> +&battery_power_supply {
> +	status =3D "okay";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <1250000>;
> +	regulator-max-microvolt =3D <1250000>;
> +	regulator-name =3D "vdd-sys-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3300000>;
> +	regulator-max-microvolt =3D <3300000>;
> +	regulator-name =3D "vdd-3v3";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name =3D "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3000000>;
> +	regulator-max-microvolt =3D <3000000>;
> +	regulator-name =3D "avcc";
> +};
> +
> +&reg_ldo4 {
> +	regulator-always-on;
> +	regulator-min-microvolt =3D <3300000>;
> +	regulator-max-microvolt =3D <3300000>;
> +	regulator-name =3D "vcc-ep952";
> +};

AFAIK we don't have a driver for the ep952, why would we need to leave
that regulator on?

> +
> +&spi0 {
> +	status =3D "okay";
> +
> +	spi-flash@0 {
> +		reg =3D <0>;
> +		compatible =3D "macronix,mx25l6436f", "jedec,spi-nor";
> +		spi-max-frequency =3D <50000000>;
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-0 =3D <&uart1_pg_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "peripheral";
> +	status =3D "okay";
> +};

Is it a peripheral because you didn't test the host mode, or because the
hardware doesn't have it?

Maxime

--i74lwqhb42esp3s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/ceQAKCRDj7w1vZxhR
xRo/AQC3qL538wZDRER4BfR4LNPpXtG/F1qshqGgRHhAYXw1DAD+JeIG9nRQhuDU
A3vBG7tVyqz9RBO3iCX9a0n3kck5iQI=
=Lax1
-----END PGP SIGNATURE-----

--i74lwqhb42esp3s4--
