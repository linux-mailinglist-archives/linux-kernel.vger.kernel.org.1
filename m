Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315462C3D96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgKYKYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:24:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:24:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 199431F44D98
Subject: Re: [PATCH] arm64: dts: mt8183: Add pwm and backlight node
To:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201124041253.4181273-1-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8484ec3b-14aa-f0de-28d6-f360c491515b@collabora.com>
Date:   Wed, 25 Nov 2020 11:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201124041253.4181273-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

On 24/11/20 5:12, Hsin-Yi Wang wrote:
> Add pwm to mt8183 and backlight to mt8183-kukui.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Picked the patch and checked that pwm for the backlight is working as expected
on my Lenovo Ideapad Duet.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 28 +++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 10 +++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 85f7c33ba4461..bf2ad1294dd30 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -19,6 +19,17 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	backlight_lcd0: backlight_lcd0 {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 500000>;
> +		power-supply = <&bl_pp5000>;
> +		enable-gpios = <&pio 176 0>;
> +		brightness-levels = <0 1023>;
> +		num-interpolated-steps = <1023>;
> +		default-brightness-level = <576>;
> +		status = "okay";
> +	};
> +
>  	memory@40000000 {
>  		device_type = "memory";
>  		reg = <0 0x40000000 0 0x80000000>;
> @@ -536,6 +547,17 @@ pins_clk {
>  		};
>  	};
>  
> +	pwm0_pin_default: pwm0_pin_default {
> +		pins1 {
> +			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
> +			output-high;
> +			bias-pull-up;
> +		};
> +		pins2 {
> +			pinmux = <PINMUX_GPIO43__FUNC_DISP_PWM>;
> +		};
> +	};
> +
>  	scp_pins: scp {
>  		pins_scp_uart {
>  			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
> @@ -670,6 +692,12 @@ pins_wifi_wakeup {
>  	};
>  };
>  
> +&pwm0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_pin_default>;
> +};
> +
>  &scp {
>  	status = "okay";
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 08a914d3a6435..a974bad899365 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -479,6 +479,16 @@ spi0: spi@1100a000 {
>  			status = "disabled";
>  		};
>  
> +		pwm0: pwm@1100e000 {
> +			compatible = "mediatek,mt8183-disp-pwm";
> +			reg = <0 0x1100e000 0 0x1000>;
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
> +			#pwm-cells = <2>;
> +			clocks = <&topckgen CLK_TOP_MUX_DISP_PWM>,
> +					<&infracfg CLK_INFRA_DISP_PWM>;
> +			clock-names = "main", "mm";
> +		};
> +
>  		i2c3: i2c@1100f000 {
>  			compatible = "mediatek,mt8183-i2c";
>  			reg = <0 0x1100f000 0 0x1000>,
> 
