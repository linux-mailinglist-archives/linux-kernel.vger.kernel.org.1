Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0049F301CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAXPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAXPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:08:03 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B83C061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 07:07:22 -0800 (PST)
Received: from [192.168.1.101] (abaf224.neoplus.adsl.tpnet.pl [83.6.169.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AE0EE3EC75;
        Sun, 24 Jan 2021 16:07:20 +0100 (CET)
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-longcheer-l8910: Add
 imu/magnetometer
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20210124135409.5473-1-jonathan.albrieux@gmail.com>
 <20210124135409.5473-4-jonathan.albrieux@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <e5a65871-08bb-7da9-c298-921395ebf1f8@somainline.org>
Date:   Sun, 24 Jan 2021 16:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210124135409.5473-4-jonathan.albrieux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +&blsp_i2c3 {
> +	status = "okay";
> +
> +	imu@68 {
> +		compatible = "bosch,bmi160";
> +		reg = <0x68>;
> +
> +		vdd-supply = <&pm8916_l17>;
> +		vddio-supply = <&pm8916_l6>;
> +
> +		mount-matrix = "0", "1", "0",
> +			      "-1", "0", "0",
> +			       "0", "0", "1";
> +	};
> +
> +	magnetometer@d {
> +		compatible = "asahi-kasei,ak09911";
> +		reg = <0x0d>;
> +
> +		vdd-supply = <&pm8916_l17>;
> +		vid-supply = <&pm8916_l6>;
> +
> +		reset-gpios = <&msmgpio 111 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mag_reset_default>;
> +	};
> +};

Please sort I2C devices by their address.


>  	};
>  
> +	mag_reset_default: mag-reset-default {
> +		pins = "gpio111";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +

Please add this after gpio110 to keep it sorted gpio-number-wise.


Konrad

