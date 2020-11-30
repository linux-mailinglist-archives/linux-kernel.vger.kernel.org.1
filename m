Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6192C892A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgK3QR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgK3QRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:17:55 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:17:15 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id z23so8143774oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tV/C7GeezOobqCaRKG/f30JW1l6AaMA2lgKxUiykxZY=;
        b=cRUuqUINRqDLby+DkEGzH9DkxtixvgdMhiU6I5S4MVhkz7TSn+sEMJmKxLHLPfosf3
         kbTN1lF1ewoZT7P3qK+qAlBlzqsXqC9j20V8xjZvvqvb9sdE0MJWx1862Z4bXJuBgROt
         5ZjgwHSojQ1Wsxh5Kvz3DGhPueoLFEmBQ6VtBWfN9ecz8/w/EE1dSbW1IIvKK7q44EqH
         Gyr9AB8HTnwNNcot9SBtMosvU/7J4/lZ00ISfVSzIkg+ySZLBin6fkDezT1tV5ktc0R3
         Zt2jCI1p/MG+ZvPMT9LRvRcu0JePJ+zT+ov5FCvoWYP+vJ3Fn8awqc2SrD3khQgvOPRu
         r6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tV/C7GeezOobqCaRKG/f30JW1l6AaMA2lgKxUiykxZY=;
        b=BVBs9IQSBKdaPkMd4vqba7azGfI/f7NE7OuHL5wml9CJOJHqpFHxpYIoWaH1Rvne+v
         iKp5Wyx2FDgAWCdo9vszgCMFUFxX6RNwbeftqNOj+Tuhzs2tEvmqOAj2wxOCqUVH374Q
         8B6gHqKkrbkpoCcWy0s/Jbvodri4JbMKH0WfbfhAjNMG+yaRLWATG5mBzxf5HsHtA2YC
         yEp3rxYn2d4QAYXCK7uNR1Osx+XIENTMuU/eNoL1pvod6lFQ6W2gMe1kE9QtY1P4avdF
         Kzb1j20oD6dcqoswnR3A96XxK9ygi9oVQOYgk2a0U9Enihyf6aoipKxe8imp9402d1Ma
         h8Yw==
X-Gm-Message-State: AOAM531MeDgXU7+JebU87C/CXKf0WVLLYfO+qoGXdhBgGLSB8fj34B+A
        AvIK6xX9+O8ps1xsECjp8dp14Ls42Jl58ojEOD4=
X-Google-Smtp-Source: ABdhPJyBxG19Tnems8zCREa9c3oltliYRZCXQhD81OdFTirYnlobrArIQnXA6I3B9cfXSrcpk4XLNg==
X-Received: by 2002:a9d:3e1d:: with SMTP id a29mr7660559otd.249.1606753033311;
        Mon, 30 Nov 2020 08:17:13 -0800 (PST)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id g3sm9852058oif.26.2020.11.30.08.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:17:12 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: qcom: c630: Define eDP bridge and panel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201128034231.89750-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <36fcd40c-efd8-5aea-a9ab-80f49c2b01ae@kali.org>
Date:   Mon, 30 Nov 2020 10:17:11 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201128034231.89750-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/20 9:42 PM, Bjorn Andersson wrote:
> The Lenovo Yoga C630 drives the Boe NV133FHM-N61 eDP display from DSI
> using a TI SN65DSI86 bridge chip on I2C 10. Define the bridge and eDP
> panel and enable the display blocks.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index f956dbf664c1..bdd5d92ee6c3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -44,6 +44,26 @@ mode {
>  			linux,code = <SW_TABLET_MODE>;
>  		};
>  	};
> +
> +	panel {
> +		compatible = "boe,nv133fhm-n61";
> +		no-hpd;
> +
> +		ports {
> +			port {
> +				panel_in_edp: endpoint {
> +					remote-endpoint = <&sn65dsi86_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	sn65dsi86_refclk: sn65dsi86-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +
> +		clock-frequency = <19200000>;
> +	};
>  };
>  
>  &adsp_pas {
> @@ -260,6 +280,25 @@ &cdsp_pas {
>  	status = "okay";
>  };
>  
> +&dsi0 {
> +	status = "okay";
> +	vdda-supply = <&vreg_l26a_1p2>;
> +
> +	ports {
> +		port@1 {
> +			endpoint {
> +				remote-endpoint = <&sn65dsi86_in_a>;
> +				data-lanes = <0 1 2 3>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_phy {
> +	status = "okay";
> +	vdds-supply = <&vreg_l1a_0p875>;
> +};
> +
>  &gcc {
>  	protected-clocks = <GCC_QSPI_CORE_CLK>,
>  			   <GCC_QSPI_CORE_CLK_SRC>,
> @@ -328,6 +367,45 @@ tsc1: hid@10 {
>  	};
>  };
>  
> +&i2c10 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	sn65dsi86: bridge@2c {
> +		compatible = "ti,sn65dsi86";
> +		reg = <0x2c>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sn65dsi86_pin_active>;
> +
> +		enable-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +
> +		vpll-supply = <&vreg_l14a_1p88>;
> +		vccio-supply = <&vreg_l14a_1p88>;
> +
> +		clocks = <&sn65dsi86_refclk>;
> +		clock-names = "refclk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				sn65dsi86_in_a: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				sn65dsi86_out: endpoint {
> +					remote-endpoint = <&panel_in_edp>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &i2c11 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> @@ -344,10 +422,26 @@ ecsh: hid@5c {
>  	};
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>  &mss_pil {
>  	firmware-name = "qcom/LENOVO/81JL/qcdsp1v2850.mbn", "qcom/LENOVO/81JL/qcdsp2850.mbn";
>  };
>  
> +&qup_i2c10_default {
> +	pinconf {
> +		pins = "gpio55", "gpio56";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
>  &qup_i2c12_default {
>  	drive-strength = <2>;
>  	bias-disable;
> @@ -454,6 +548,12 @@ codec {
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>, <81 4>;
>  
> +	sn65dsi86_pin_active: sn65dsi86-enable {
> +		pins = "gpio96";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>  	i2c3_hid_active: i2c2-hid-active {
>  		pins = "gpio37";
>  		function = "gpio";

Tested-by: Steev Klimaszewski <steev@kali.org>


