Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8492C86E6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgK3Ogc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:36:32 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55903 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgK3Ogb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:36:31 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 35A06C0007;
        Mon, 30 Nov 2020 14:35:49 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Alexandra Alth <alexandra@alth.de>
Subject: Re: [PATCH] arm64: dts: mcbin-singleshot: add heartbeat LED
In-Reply-To: <20201110153831.5336-1-tmn505@gmail.com>
References: <20201110153831.5336-1-tmn505@gmail.com>
Date:   Mon, 30 Nov 2020 15:35:48 +0100
Message-ID: <87wny2j4jf.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> With board revision 1.3, SolidRun moved the power LED to the middle of
> the board. In old place of power LED a GPIO controllable heartbeat LED
> was added. This commit only touches Single Shot variant, since only this
> variant is all revision 1.3.
>
> Reported-by: Alexandra Alth <alexandra@alth.de>
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  .../marvell/armada-8040-mcbin-singleshot.dts  | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
> index 2e6832d02a59..411d20064271 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
> @@ -5,6 +5,8 @@
>   * Device Tree file for MACCHIATOBin Armada 8040 community board platform
>   */
>  
> +#include <dt-bindings/leds/common.h>
> +
>  #include "armada-8040-mcbin.dtsi"
>  
>  / {
> @@ -12,6 +14,19 @@ / {
>  	compatible = "marvell,armada8040-mcbin-singleshot",
>  			"marvell,armada8040-mcbin", "marvell,armada8040",
>  			"marvell,armada-ap806-quad", "marvell,armada-ap806";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&cp0_led18_pins>;
> +		pinctrl-names = "default";
> +
> +		led18 {
> +			gpios = <&cp0_gpio2 1 GPIO_ACTIVE_LOW>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_GREEN>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
>  };
>  
>  &cp0_eth0 {
> @@ -27,3 +42,10 @@ &cp1_eth0 {
>  	managed = "in-band-status";
>  	sfp = <&sfp_eth1>;
>  };
> +
> +&cp0_pinctrl {
> +	cp0_led18_pins: led18-pins {
> +		marvell,pins = "mpp33";
> +		marvell,function = "gpio";
> +	};
> +};
> -- 
> 2.29.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
