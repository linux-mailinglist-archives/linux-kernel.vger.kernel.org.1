Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389E2F4A26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbhAML26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbhAML26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:28:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E8C061575;
        Wed, 13 Jan 2021 03:28:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1AEB11F456C3
Subject: Re: [PATCH v4 1/3] arm64: dts: mt8183: config dsi node
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210113110400.616319-1-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c8ebbaf6-fe92-0986-3f42-a74a515948bb@collabora.com>
Date:   Wed, 13 Jan 2021 12:28:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113110400.616319-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On 13/1/21 12:03, Hsin-Yi Wang wrote:
> Config dsi node for mt8183 kukui. Set panel and ports.
> 
> Several kukui boards share the same panel property and only compatible
> is different. So compatible will be set in board dts for comparison
> convenience.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Tested on my Lenovo Ideapad Duet. Display is working.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
> change:
> v4: add backlight and enable mipi_tx0
> ---
>  .../mediatek/mt8183-kukui-krane-sku176.dts    |  5 +++
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 42 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> index 47113e275cb52..721d16f9c3b4f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
> @@ -16,3 +16,8 @@ / {
>  	model = "MediaTek krane sku176 board";
>  	compatible = "google,krane-sku176", "google,krane", "mediatek,mt8183";
>  };
> +
> +&panel {
> +        status = "okay";
> +        compatible = "boe,tv101wum-nl6";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index bf2ad1294dd30..da1e947587074 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -249,6 +249,36 @@ &cpu7 {
>  	proc-supply = <&mt6358_vproc11_reg>;
>  };
>  
> +&dsi0 {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	panel: panel@0 {
> +		/* compatible will be set in board dts */
> +		reg = <0>;
> +		enable-gpios = <&pio 45 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&panel_pins_default>;
> +		avdd-supply = <&ppvarn_lcd>;
> +		avee-supply = <&ppvarp_lcd>;
> +		pp1800-supply = <&pp1800_lcd>;
> +		backlight = <&backlight_lcd0>;
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port {
> +			dsi_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
> @@ -290,6 +320,10 @@ &i2c6 {
>  	clock-frequency = <100000>;
>  };
>  
> +&mipi_tx0 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	status = "okay";
>  	pinctrl-names = "default", "state_uhs";
> @@ -547,6 +581,14 @@ pins_clk {
>  		};
>  	};
>  
> +	panel_pins_default: panel_pins_default {
> +		panel_reset {
> +			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
> +			output-low;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	pwm0_pin_default: pwm0_pin_default {
>  		pins1 {
>  			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
> 
