Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9360C2B956E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKSOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:45:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37814 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgKSOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:45:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJEjMO3067579;
        Thu, 19 Nov 2020 08:45:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605797122;
        bh=KsKbukhmAd8emgYJwItNnBQsIjp8rGjR04mDjYgnDMI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dui0cc5Kpz131YaPMGnkuKFu3FOMwu0/NlOh7f1/GdPdEF39JcWSZFEviC5advmaQ
         xZWRIgSy3DXEdp2UUCCH+aS/GN/WmqRgo3MDvTMcYUgOwpRY7VoIXMlOalxdmhb+Om
         V4zp6N1MCm2OlTmp+XpZyk31b746rlqUYTrA8XwQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJEjML1127732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 08:45:22 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 08:45:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 08:45:21 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJEjJfL117651;
        Thu, 19 Nov 2020 08:45:19 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j7200-som-p0: main_i2c0 have an
 ioexpander on the SOM
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>
References: <20201119132627.8041-1-peter.ujfalusi@ti.com>
 <20201119132627.8041-2-peter.ujfalusi@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3a4cb3c0-2242-cb81-9c38-85e93ddc7dfc@ti.com>
Date:   Thu, 19 Nov 2020 20:15:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119132627.8041-2-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/20 6:56 PM, Peter Ujfalusi wrote:
> It is used to control several SOM level muxes to make sure that the correct
> signals are routed to the correct pin on the SOM <-> CPB connectors.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Yes, there is indeed a I2C GPIO expander on SOM that's missing from DT
today. So this change looks good to me.

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  .../dts/ti/k3-j7200-common-proc-board.dts     | 11 --------
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 26 +++++++++++++++++++
>  2 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6b3863108571..2721137d8943 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -43,13 +43,6 @@ J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
>  };
>  
>  &main_pmx0 {
> -	main_i2c0_pins_default: main-i2c0-pins-default {
> -		pinctrl-single,pins = <
> -			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
> -			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
> -		>;
> -	};
> -
>  	main_i2c1_pins_default: main-i2c1-pins-default {
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
> @@ -146,10 +139,6 @@ &cpsw_port1 {
>  };
>  
>  &main_i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_i2c0_pins_default>;
> -	clock-frequency = <400000>;
> -
>  	exp1: gpio@20 {
>  		compatible = "ti,tca6416";
>  		reg = <0x20>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index fbd17d38f6b6..7b5e9aa0324e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -48,6 +48,15 @@ J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
>  	};
>  };
>  
> +&main_pmx0 {
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
> +			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
> +		>;
> +	};
> +};
> +
>  &hbmc {
>  	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
>  	 * appropriate node based on board detection
> @@ -131,3 +140,20 @@ &mailbox0_cluster10 {
>  &mailbox0_cluster11 {
>  	status = "disabled";
>  };
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp_som: gpio@21 {
> +		compatible = "ti,tca6408";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "USB2.0_MUX_SEL", "CANUART_MUX1_SEL0",
> +				  "CANUART_MUX2_SEL0", "CANUART_MUX_SEL1",
> +				  "UART/LIN_MUX_SEL", "TRC_D17/AUDIO_REFCLK_SEL",
> +				  "GPIO_LIN_EN", "CAN_STB";
> +	};
> +};
> 
