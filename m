Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D52756CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWLCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:02:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46342 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWLCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:02:30 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kL2Xa-0006ap-7G; Wed, 23 Sep 2020 13:02:26 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        art@khadas.com, jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick@khadas.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3399-khadas-edge add missed ir-receiver and ir_rx pinctl nodes
Date:   Wed, 23 Sep 2020 13:02:25 +0200
Message-ID: <7887815.vmt15hixIf@diego>
In-Reply-To: <20200923101225.1513392-3-email2tema@gmail.com>
References: <20200923101225.1513392-1-email2tema@gmail.com> <20200923101225.1513392-3-email2tema@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

Am Mittwoch, 23. September 2020, 12:12:25 CEST schrieb Artem Lapkin:
> From: Artem Lapkin <art@khadas.com>
> 
> add missed ir receivier to Khadas Edge board
> Khadas Edge uses gpio-ir-receiver on RK_PB6 gpio

Missing Signed-off-by

> ---
>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> index 42ebbd6fa46..389ae43d869 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> @@ -109,6 +109,14 @@ vsys_5v0: vsys-5v0 {
>  		vin-supply = <&vsys>;
>  	};
>  
> +	ir-receiver {

please sort alphabetically.

Also more importantly, is this really part of all Khadas Edge board variants?
[just making sure ;-) ]

> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ir_rx>;
> +		linux,rc-map-name = "rc-khadas";
> +	};
> +
>  	adc-keys {
>  		compatible = "adc-keys";
>  		io-channels = <&saradc 1>;
> @@ -682,6 +690,14 @@ &sdmmc {
>  	status = "okay";
>  };
>  
> +&pinctrl {

there is already a "&pinctrl" node in the "rk3399-khadas-edge.dtsi"
please don't add another one, and make sure things are somewhat
sorted alphabetically ;-) .

Thanks
Heiko

> +    ir {
> +	ir_rx: ir-rx {
> +	    rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +	};
> +    };
> +};
> +
>  &sdhci {
>  	bus-width = <8>;
>  	mmc-hs400-1_8v;
> 




