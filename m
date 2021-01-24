Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E3301D01
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbhAXPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:11:16 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:57201 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAXPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:09:58 -0500
Received: from [192.168.1.101] (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6A56D3EBD9;
        Sun, 24 Jan 2021 16:09:13 +0100 (CET)
Subject: Re: [PATCH 2/3] arm64: dts: qcom: msm8916: Add blsp_i2c3
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20210124135409.5473-1-jonathan.albrieux@gmail.com>
 <20210124135409.5473-3-jonathan.albrieux@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <b35ff524-bf5a-4a22-cd5a-14ac7ab3a900@somainline.org>
Date:   Sun, 24 Jan 2021 16:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210124135409.5473-3-jonathan.albrieux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.01.2021 14:54, Jonathan Albrieux wrote:
> MSM8916 has another I2C QUP controller that can be enabled on
> GPIO 10 and 11.
>
> Add blsp_i2c3 to msm8916.dtsi and disable it by default.
>
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 16 ++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi      | 15 +++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> index 4dc437f13fa5..7dedb91b9930 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> @@ -220,6 +220,22 @@
>  		bias-disable;
>  	};
>  
> +	i2c3_default: i2c3-default {
> +		pins = "gpio10", "gpio11";
> +		function = "blsp_i2c3";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	i2c3_sleep: i2c3-sleep {
> +		pins = "gpio10", "gpio11";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>  	i2c4_default: i2c4-default {
>  		pins = "gpio14", "gpio15";
>  		function = "blsp_i2c4";
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 402e891a84ab..1045d7e518f3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1528,6 +1528,21 @@
>  			status = "disabled";
>  		};
>  
> +		blsp_i2c3: i2c@78b7000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b7000 0x500>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> +				 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
> +			clock-names = "iface", "core";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&i2c3_default>;
> +			pinctrl-1 = <&i2c3_sleep>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		blsp_spi3: spi@78b7000 {
>  			compatible = "qcom,spi-qup-v2.2.1";
>  			reg = <0x078b7000 0x500>;
>

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Things to consider for the future:


* DMA on I2C

* Merging in the -pins.dtsi to 8916.dtsi?


Konrad


