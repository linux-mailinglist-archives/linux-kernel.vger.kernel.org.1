Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6542A2846
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgKBKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgKBKay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:30:54 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B14C0617A6;
        Mon,  2 Nov 2020 02:30:54 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 71256C013D;
        Mon,  2 Nov 2020 11:30:52 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id E0284C1D7A; Mon,  2 Nov 2020 11:30:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from aptenodytes (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 9F407C1D32;
        Mon,  2 Nov 2020 11:30:43 +0100 (CET)
Date:   Mon, 2 Nov 2020 11:30:42 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 9/9] ARM: dts: sun8i-v3: Add support for the SL631 Action
 Camera with IMX179
Message-ID: <20201102103042.GC11809@aptenodytes>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-10-contact@paulk.fr>
 <20201102101626.t4ox3rwbwp335i2m@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102101626.t4ox3rwbwp335i2m@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 02 Nov 20, 11:16, Maxime Ripard wrote:
> On Sat, Oct 31, 2020 at 07:21:37PM +0100, Paul Kocialkowski wrote:
> > The SL631 is a family of Allwinner V3 action cameras sold under
> > various names, such as SJCAM SJ4000 Air or F60 Action Camera.
> > 
> > Devices in this family share a common board design but can be found
> > with different image sensors, including the IMX179 and the OV4689.
> > 
> > This adds support for a common dtsi for the SL631 family as well as
> > a specific dts for the IMX179 fashion, which will later be populated
> > with an IMX179 node when a driver is available.
> > 
> > Features that were tested on the device include:
> > - UART debug
> > - MMC
> > - USB peripheral (e.g. g_ether)
> > - Buttons
> > - SPI NOR flash
> > 
> > Note that the exact designer/vendor of these boards is unknown.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  arch/arm/boot/dts/Makefile                  |   1 +
> >  arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts |  12 ++
> >  arch/arm/boot/dts/sun8i-v3-sl631.dtsi       | 145 ++++++++++++++++++++
> >  3 files changed, 158 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
> >  create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4363ba564bb4..b76bcda9a9df 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1196,6 +1196,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
> >  	sun8i-s3-lichee-zero-plus.dtb \
> >  	sun8i-s3-pinecube.dtb \
> >  	sun8i-t3-cqa3t-bv3.dtb \
> > +	sun8i-v3-sl631-imx179.dtb \
> >  	sun8i-v3s-licheepi-zero.dtb \
> >  	sun8i-v3s-licheepi-zero-dock.dtb \
> >  	sun8i-v40-bananapi-m2-berry.dtb
> > diff --git a/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts b/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
> > new file mode 100644
> > index 000000000000..9e3b78000bdb
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> > +/*
> > + * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
> > + */
> > +
> > +#include "sun8i-v3-sl631.dtsi"
> > +
> > +/ {
> > +	model = "SL631 Action Camera with IMX179";
> > +	compatible = "unknown,sl631-imx179", "unknown,sl631",
> > +		     "allwinner,sun8i-v3";
> > +};
> > diff --git a/arch/arm/boot/dts/sun8i-v3-sl631.dtsi b/arch/arm/boot/dts/sun8i-v3-sl631.dtsi
> > new file mode 100644
> > index 000000000000..9bc84d2812a6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-v3-sl631.dtsi
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> > +/*
> > + * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun8i-v3.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +
> > +/ {
> > +	model = "SL631 Action Camera";
> > +	compatible = "unknown,sl631", "allwinner,sun8i-v3";
> > +
> > +	aliases {
> > +		serial0 = &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +};
> > +
> > +&i2c0 {
> > +	status = "okay";
> > +
> > +	axp209: pmic@34 {
> > +		reg = <0x34>;
> > +		interrupt-parent = <&nmi_intc>;
> > +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pb_pins>;
> > +	status = "okay";
> > +};
> > +
> > +&lradc {
> > +	vref-supply = <&reg_ldo2>;
> > +	status = "okay";
> > +
> > +	button@174 {
> > +		label = "Volume Down";
> > +		linux,code = <KEY_VOLUMEDOWN>;
> > +		channel = <0>;
> > +		voltage = <174603>;
> > +	};
> > +
> > +	button@384 {
> > +		label = "Volume Up";
> > +		linux,code = <KEY_VOLUMEUP>;
> > +		channel = <0>;
> > +		voltage = <384126>;
> > +	};
> > +
> > +	button@593 {
> > +		label = "Home";
> > +		linux,code = <KEY_HOME>;
> > +		channel = <0>;
> > +		voltage = <593650>;
> > +	};
> > +};
> 
> The buttons are not valid node names, since you can't use a unit-address
> without reg.

Ah sorry, I see that nowadays the form is e.g. button-174.
This was probably a copy-paste from older dts. And indeed there's no reg around
to justify it (and a voltage is not an address anyway).

> > +&mmc0 {
> > +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> > +	bus-width = <4>;
> > +	vmmc-supply = <&reg_dcdc3>;
> > +	status = "okay";
> > +};
> > +
> > +&pio {
> > +	vcc-pd-supply = <&reg_dcdc3>;
> > +	vcc-pe-supply = <&reg_dcdc3>;
> > +};
> > +
> > +#include "axp209.dtsi"
> > +
> > +&ac_power_supply {
> > +	status = "okay";
> > +};
> > +
> > +&battery_power_supply {
> > +	status = "okay";
> > +};
> > +
> > +&reg_dcdc2 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <1250000>;
> > +	regulator-max-microvolt = <1250000>;
> > +	regulator-name = "vdd-sys-cpu";
> > +};
> > +
> > +&reg_dcdc3 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <3300000>;
> > +	regulator-max-microvolt = <3300000>;
> > +	regulator-name = "vdd-3v3";
> > +};
> > +
> > +&reg_ldo1 {
> > +	regulator-name = "vdd-rtc";
> > +};
> > +
> > +&reg_ldo2 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <3000000>;
> > +	regulator-max-microvolt = <3000000>;
> > +	regulator-name = "avcc";
> > +};
> > +
> > +&reg_ldo4 {
> > +	regulator-always-on;
> > +	regulator-min-microvolt = <3300000>;
> > +	regulator-max-microvolt = <3300000>;
> > +	regulator-name = "vcc-ep952";
> > +};
> 
> AFAIK we don't have a driver for the ep952, why would we need to leave
> that regulator on?

Right, I don't think it needs to be. I'll test without it and remove if it is
indeed not needed.

Keep in mind that all of this comes from the fex and I don't have schematics
so this is trial and error.

> > +&spi0 {
> > +	status = "okay";
> > +
> > +	spi-flash@0 {
> > +		reg = <0>;
> > +		compatible = "macronix,mx25l6436f", "jedec,spi-nor";
> > +		spi-max-frequency = <50000000>;
> > +	};
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-0 = <&uart1_pg_pins>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +	dr_mode = "peripheral";
> > +	status = "okay";
> > +};
> 
> Is it a peripheral because you didn't test the host mode, or because the
> hardware doesn't have it?

According to the fex and trial and error, there's no way to drive VBUS on the
hardware design so it's only peripheral.

Cheers and thanks for the review,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
