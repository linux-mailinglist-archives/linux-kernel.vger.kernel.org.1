Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9A2F9AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbhARHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732279AbhARHg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:36:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85C82221E5;
        Mon, 18 Jan 2021 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610955377;
        bh=xi58CTyzlY67wE6IItOA/S+q41Zj5ap/7KLB+4wJXqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXhyS6cj1FYCj7S9CyM2J71l9fJ7lhLIsWWxiw8mOuViK1Vv/GNKWbjaXus9ppqqo
         EMWfrM3xvj0ERd+MpiTRd/scPlkB8lk1hETXtE6LzI1xGoMzemGpDS57k22Qe7M2OE
         WeilHNoQWvBEH/+8Gx9rTkk1tJylB1JOC9FqPGUKHaIdd7tRM4pQWpfRHfLIHaMI9k
         BnkUwYTdMJiTL0QPkVqy984NbjMCndST6YHdVrCDtWlNBN6p9y2xuy/YOuhRIhqR1F
         Tcj77+zhYboggnetMfl+pib9cJDJ+kv86d4YiICl1sDGtHl6ySMuo4oUhJNY0BCsq4
         UBhnT5ddoK4IA==
Date:   Mon, 18 Jan 2021 15:36:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Yangbo Lu <yangbo.lu@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: fsl-ls1012a-rdb: add i2c devices
Message-ID: <20210118073609.GQ28365@dragon>
References: <20210115101613.1490837-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115101613.1490837-1-paweldembicki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:16:12AM +0100, Pawel Dembicki wrote:
> LS1012A-RDB equipped in some i2c devices:
>   - 3x GPIO Expander: PCAL9555A (NXP)
>   - Gyro: FXAS21002 (NXP)
>   - Accelerometer: FXOS8700 (NXP)
>   - Current & Power Monitor: INA220 (TI)
> 
> This patch add listed devices to dts.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  .../boot/dts/freescale/fsl-ls1012a-rdb.dts    | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> index d45c17620b98..12117a973eb6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> @@ -7,6 +7,7 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include "fsl-ls1012a.dtsi"
>  
>  / {
> @@ -33,6 +34,50 @@ &esdhc1 {
>  
>  &i2c0 {
>  	status = "okay";
> +
> +	accelerometer@1e {
> +		compatible = "nxp,fxos8700";
> +		reg = <0x1e>;
> +		interrupt-parent = <&gpio26>;
> +		interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "INT1";
> +	};
> +
> +	gyroscope@20 {

Please sort these device node in unit-address.

Shawn

> +		compatible = "nxp,fxas21002c";
> +		reg = <0x20>;
> +	};
> +
> +	gpio@24 {
> +		compatible = "nxp,pcal9555a";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	gpio@25 {
> +		compatible = "nxp,pcal9555a";
> +		reg = <0x25>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	gpio26: gpio@26 {
> +		compatible = "nxp,pcal9555a";
> +		reg = <0x26>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	current-sensor@40 {
> +		compatible = "ti,ina220";
> +		reg = <0x40>;
> +		shunt-resistor = <2000>;
> +	};
>  };
>  
>  &qspi {
> -- 
> 2.25.1
> 
