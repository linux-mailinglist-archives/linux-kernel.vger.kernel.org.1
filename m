Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28329F344
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgJ2Ray (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:30:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33973 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgJ2Ray (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:30:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 58F975C0211;
        Thu, 29 Oct 2020 13:30:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Oct 2020 13:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=aDTzGcRq8uj0IehmuOHDWTZbitX
        s2g0zbVaX5jsC3xk=; b=UocIG3C8obC7TWkO0u7PRm7i8cF77YOrGsS7qIEXSVV
        rYnTJmqy4C+kAWC5fq2S/e9Iq4JYkuVB6shWqdnbijzcKIuRxQcj0VaDXmwjS214
        ht9nzvPCKxLECbCHAb79DlVSpjbqdNMXye1GZ9wvUQ/Pa69QDtqVhh/PHsrold/m
        gAQBLo/9XV737d5TaXN7bxqtSnaZRih389zZj8POPyebNUfPXZw76fIF5o01S3MY
        OpG83QFSNOrg2HHDr+ubjri/VVtPneTC9ltjJ6IS275oAXNiK71gXhI7h6VPy/kB
        ofzIulhkjhZG2FJb92fkFUgMjvFCzTgajU8XtbFGPSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aDTzGc
        Rq8uj0IehmuOHDWTZbitXs2g0zbVaX5jsC3xk=; b=bReMaTujLd7cnCIO7vW/X+
        AAlGCAF/XDXGi6r3bCu00x2HCP+yif++g+KsyU25SsBoPUs3lz4HlJAiOUCYyfnx
        chlYXwyt/J0cF2WeESLWu6UwSe0C9qezokjbQZVGucS+NrBJujeQW4AzYIrcIT4X
        TycGJ6DFvCVwgQF+C6c/gMfaM9rw+R3CS+ksnbvJvqDb10PVtrqAPDHusVAPxuTz
        4m+qkvZaIWC5/5Nlg9GqJpF5E6BImEGSZAbrz3dJGk3OjP3vfwrwi5Nk8t0i4Hkh
        5eiWMr0HCd/LavMUkMjHshQJRXvdquRctK5GR8lEGoKIWr4bWa1+87fSxPEdFr5g
        ==
X-ME-Sender: <xms:SfyaX4dI0-GU0DoDqD6blsQ8ptOVbwlLmUazbcMTHmkfKDV9_OZq2A>
    <xme:SfyaX6NHiTCf8N9wzfgtH1kBN7F_j9fxwO3jifZljZ42CLwka1HB9eEvLuDBABfiy
    i1YZUnDfesmvplLhsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SvyaX5hKdFyx50xzqrTXHrE8-7_uabf5TNV1BrdLsmqczCC0w7F2eA>
    <xmx:SvyaX9--i7G53Ql-efhH1yni_eGVYUf_ffaGww4aLMr-TPCa6jomNg>
    <xmx:SvyaX0tj1LmxzqDe4r1oNFnYEx_KcfhEnx0Rnn3ggMyBAV3_rVgoCw>
    <xmx:TPyaXwKyhx4zyAQSDg8_4Zvh-XND1YWXGfgbrI4nonWC712Dmwt9pQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A0B80328005A;
        Thu, 29 Oct 2020 13:30:49 -0400 (EDT)
Date:   Thu, 29 Oct 2020 18:30:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Message-ID: <20201029173047.7zrato523q6bgq33@gilmour.lan>
References: <20201027084803.17368-1-mtwget@gmail.com>
 <20201027084803.17368-2-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="irwkiecmuwf2s2v2"
Content-Disposition: inline
In-Reply-To: <20201027084803.17368-2-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--irwkiecmuwf2s2v2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2020 at 04:48:03PM +0800, Yu-Tung Chang wrote:
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
>  arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 199 ++++++++++++++++++
>  3 files changed, 205 insertions(+)
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
> index 000000000000..d4b90892a4d8
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (C) 2019 Igor Pecovnik <igor@armbian.com>
> + * Copyright (C) 2020 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
> + * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

You should use an SPDX header instead of the license text here

> +#include "sun8i-h3-nanopi.dtsi"
> +
> +/ {
> +	model =3D "FriendlyARM NanoPi R1";
> +	compatible =3D "friendlyarm,nanopi-r1", "allwinner,sun8i-h3";
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
> +

There's an extra line here

> +		wan {

Those aren't valid node names, you should use led-[0-9] here

> +			label =3D "nanopi:green:wan";

label is deprecated in favor of the "function" and "color" properties=20

> +			gpios =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
> +		};
> +
> +		lan {
> +			label =3D "nanopi:green:lan";
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
> +	sdio_wifi: sdio_wifi@1 {
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

This should be the default already?

> +	status =3D "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart3_pins>, <&uart3_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "brcm,bcm43438-bt";
> +		clocks =3D <&rtc 1>;
> +		clock-names =3D "lpo";
> +		vbat-supply =3D <&reg_vcc3v3>;
> +		vddio-supply =3D <&reg_vcc3v3>;
> +		device-wakeup-gpios =3D <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
> +		host-wakeup-gpios =3D <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
> +		shutdown-gpios =3D <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
> +	};
> +};
> +
> +&usb_otg {
> +	status =3D "okay";
> +	dr_mode =3D "peripheral";

If there's an ID pin and a controllable VBUS, you should be able to use
otg here?

Thanks!
Maxime

--irwkiecmuwf2s2v2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5r8RwAKCRDj7w1vZxhR
xRvGAP9vQldrPPVTHRtHP3GydBNmilDcYfan2nU4p0o65BnJ3QD/Q45gfhrQJ/1T
VIO82okA9jPADYoNLFbRQrEVaSNF4QA=
=iCX4
-----END PGP SIGNATURE-----

--irwkiecmuwf2s2v2--
