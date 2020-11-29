Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED532C78C4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 12:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgK2LMH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Nov 2020 06:12:07 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34165 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgK2LMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 06:12:07 -0500
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9535D240006;
        Sun, 29 Nov 2020 11:11:24 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add support for LED2
In-Reply-To: <20201006124455.16617-1-pali@kernel.org>
References: <20201006124455.16617-1-pali@kernel.org>
Date:   Sun, 29 Nov 2020 12:11:24 +0100
Message-ID: <87v9doju3n.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

> LED2 is connected to MPP1_2 pin. It is working only on V7 boards.
> V5 boards have hw bug which cause that LED2 is non-working.
>
> So enable LED2 only for Espressobin V7 boards.
>
> Note that LED1 is connected to LED_WLAN# pin on miniPCIe card and LED3 to
> power supply. Therefore on Espressobin board only LED2 can be controlled
> directly from the host. LED1 is possible to control via WiFi card inserted
> in miniPCIe slot if driver for particular card supports it.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Gérald Kerma <gerald@gk2.net>


Applied on mvebu/dt64

Thanks,

Gregory


>
> ---
>
> Previous version of this patch was sent by Uwe in March 2018, but it did
> not work on any tested V5 board. Now we know it was due to V5 HW bug.
>
> https://lore.kernel.org/linux-arm-kernel/20180321105005.18426-3-u.kleine-koenig@pengutronix.de/
> ---
>  .../dts/marvell/armada-3720-espressobin-v7-emmc.dts |  4 ++++
>  .../boot/dts/marvell/armada-3720-espressobin-v7.dts |  4 ++++
>  .../boot/dts/marvell/armada-3720-espressobin.dtsi   | 13 +++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 4775a7eda481..75401eab4d42 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -39,3 +39,7 @@
>  &sdhci0 {
>  	status = "okay";
>  };
> +
> +&led2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index c47a93978386..48a7f50fb427 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -34,3 +34,7 @@
>  &switch0port3 {
>  	label = "wan";
>  };
> +
> +&led2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 8a1c678bea5f..daffe136c523 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -41,6 +41,19 @@
>  			  3300000 0x0>;
>  		enable-active-high;
>  	};
> +
> +	led2: gpio-led2 {
> +		/* led2 is working only on v7 board */
> +		status = "disabled";
> +
> +		compatible = "gpio-leds";
> +
> +		led2 {
> +			label = "led2";
> +			gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
>  };
>  
>  /* J9 */
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
