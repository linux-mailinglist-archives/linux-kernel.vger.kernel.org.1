Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C122FD707
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbhATR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:29:41 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:57018 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbhATOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:48:33 -0500
Received: from fiber.protonic.nl (edge2.prtnl [192.168.1.170])
        by sparta.prtnl (Postfix) with ESMTP id 86D9144A022A;
        Wed, 20 Jan 2021 15:47:23 +0100 (CET)
MIME-Version: 1.0
Date:   Wed, 20 Jan 2021 15:47:23 +0100
From:   robin <robin@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 4/7] ARM: dts: imx6dl-prtvt7: add TSC2046 touchscreen
 node
Reply-To: robin@protonic.nl
In-Reply-To: <20210120142217.29652-5-o.rempel@pengutronix.de>
References: <20210120142217.29652-1-o.rempel@pengutronix.de>
 <20210120142217.29652-5-o.rempel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <f531bec0c48efdeafccd1b251b97ec11@protonic.nl>
X-Sender: robin@protonic.nl
Organization: Protonic Holland
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 15:22, Oleksij Rempel wrote:
> Add touchscreen support to the Protonic VT7 board.
> 
> Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6dl-prtvt7.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts
> b/arch/arm/boot/dts/imx6dl-prtvt7.dts
> index d9cb1e41cc10..63ae2065834c 100644
> --- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
> +++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
> @@ -266,6 +266,26 @@ &ecspi2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi2>;
>  	status = "okay";
> +
> +	touchscreen@0 {
> +		compatible = "ti,tsc2046";
> +		reg = <0>;
> +		pinctrl-0 = <&pinctrl_tsc>;
> +		pinctrl-names ="default";
> +		spi-max-frequency = <100000>;
> +		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
> +		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
> +
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;

Please remove both inverted properties since it's not inverted.

> +		touchscreen-max-pressure = <4095>;
> +
> +		ti,vref-delay-usecs = /bits/ 16 <100>;
> +		ti,x-plate-ohms = /bits/ 16 <800>;
> +		ti,y-plate-ohms = /bits/ 16 <300>;
> +
> +		wakeup-source;
> +	};
>  };
> 
>  &i2c1 {

Robin
