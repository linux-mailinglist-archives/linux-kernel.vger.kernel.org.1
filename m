Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFED52FECF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbhAUOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:35:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:21461 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbhAUOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611239616; x=1642775616;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JIYh/BA9/2B0v9jjsKocRc0WgxdVQOXbQUX/QBfk/Wc=;
  b=odKUQHcnF8ijUtlQ9RYBOQ9dAbcJK7zZr1pNgMa+az9Fb1b35huzZMK5
   3ImiP8jQnRKOzX2Qo+ARTymT30YaoAn7AGQtWbXfARr+2ypOhx/sqCRUd
   qidWm+WYiMmWVWe00nE2URDBQwPuj9ASkqulRfDataBafHfWenuGdMsxm
   ayPfjwWWy9UgRuLCZocifkZ8voXaD5xKGD9RqhQXR3JmzPFVH/cN7JcqK
   Fc1Z1eeJG6eI3GfNyMXWuFDogg3DOv3zJs55cLZ9xaMfWTWbIE/nGuh/F
   8cHzfw2IfCcDZpyIxQGJChFsGUuujRJc4cIW7S8E9ca2QTilJRs4SRTwQ
   A==;
IronPort-SDR: t/azd1fb8nrXIg7+MBeHuLuPxECYMD3WABZrAbFpSToA3wxKwnsWqjsKzzFfH4GLIIzCJJDRUY
 vQYwbEh7sJb9iKcmnfxlONVBqVhgODA3aEZWtE6shyXhRRm9bx4UikhYBx6VayqCbP20n+o5Dx
 8jGfJWBpl8gwPmNmYT9IL3GMFy7oYTfILZTN8yXm4H/JHm+asDDbVqItfvLDYY6jRk7utVZ8kU
 1ibd+Y/GBINcpSQpL5mBqlYx1CGp+hve6LwBQxOivNLEB9Vf1q1+9w/QRL7P6n311o7ChCg+Hd
 4GA=
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="103698934"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 07:27:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 07:27:18 -0700
Received: from [10.205.29.84] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 21 Jan 2021 07:27:15 -0700
Subject: Re: [PATCH] ARM: dts: at91-sama5d27_wlsom1: add i2c recovery
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
References: <20210117183558.5369-1-nicolas.ferre@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <6b8db824-bd2a-ebfa-4af6-261aa6d985bc@microchip.com>
Date:   Thu, 21 Jan 2021 15:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210117183558.5369-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2021 at 19:35, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add the i2c gpio pinctrls to support the i2c bus recovery on this board.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

added to at91-dt.

Regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 22 +++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> index a06700e53e4c..025a78310e3a 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> @@ -43,14 +43,20 @@ uart6: serial@200 {
>   
>   &i2c0 {
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
> -	pinctrl-names = "default";
> +	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +	pinctrl-names = "default", "gpio";
> +	sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   	status = "okay";
>   };
>   
>   &i2c1 {
>   	dmas = <0>, <0>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	sda-gpios = <&pioA PIN_PD19 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   	status = "okay";
>   
>   	mcp16502@5b {
> @@ -258,12 +264,24 @@ pinctrl_i2c0_default: i2c0_default {
>   		bias-disable;
>   	};
>   
> +	pinctrl_i2c0_gpio: i2c0_gpio {
> +		pinmux = <PIN_PD21__GPIO>,
> +			 <PIN_PD22__GPIO>;
> +		bias-disable;
> +	};
> +
>   	pinctrl_i2c1_default: i2c1_default {
>   		pinmux = <PIN_PD19__TWD1>,
>   			 <PIN_PD20__TWCK1>;
>   		bias-disable;
>   	};
>   
> +	pinctrl_i2c1_gpio: i2c1_gpio {
> +		pinmux = <PIN_PD19__GPIO>,
> +			 <PIN_PD20__GPIO>;
> +		bias-disable;
> +	};
> +
>   	pinctrl_macb0_default: macb0_default {
>   		pinmux = <PIN_PB14__GTXCK>,
>   			 <PIN_PB15__GTXEN>,
> 


-- 
Nicolas Ferre
