Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846522F48BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbhAMKeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbhAMKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:34:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77749C061786;
        Wed, 13 Jan 2021 02:33:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9547A1F4102A
Subject: Re: [PATCH v3 1/2] arm64: dts: mt8183: config dsi node
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210113062834.4043956-1-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6f4c11c7-ee1e-0308-2328-d71906a8c0c8@collabora.com>
Date:   Wed, 13 Jan 2021 11:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113062834.4043956-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

On 13/1/21 7:28, Hsin-Yi Wang wrote:
> Config dsi node for mt8183 kukui. Set panel and ports.
> 
> Several kukui boards share the same panel property and only compatible
> is different. So compatible will be set in board dts for comparison
> convenience.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  .../mediatek/mt8183-kukui-krane-sku176.dts    |  5 +++
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 37 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
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
> index bf2ad1294dd30..c5f41b94f154e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -249,6 +249,35 @@ &cpu7 {
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

It'd make sense to add also the backlight here?

+               backlight = <&backlight_lcd0>;

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

I think you should enable the MIPI TX to have DSI and panel working?

+&mipi_tx0 {
+       status = "okay";
+};


>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
> @@ -547,6 +576,14 @@ pins_clk {
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
