Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1A2FB780
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404998AbhASLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:01:35 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1235 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391041AbhASKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:52:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JAlo8w024026;
        Tue, 19 Jan 2021 11:51:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=9YMOD6MmU6S+E9nQgamOnACAlveEyKVrfmoJphPUeHU=;
 b=TBRRBHg6sjVJRAb6kZJ2/Ebv4/CRq3EEuXNvCtjLq4JKisvSqNqd4ZTMRMvD7r22BdQd
 cMhQfLO98aTKU/6pn/U5C3k8COoorD8AZX3DXauwY91Z0qioIIxl10BUtWdYAI3Xd+Jq
 gmkALxqJ2wzxjlDx5o2aAt6ctAgZ4OqmOvhRoLLTzezpBt/EDFMJh/99IMWDo+ndVRQ0
 b7HfXs+cdX/YCIv6sbnPcZ3sOzJo6S2qOBpYnbIO+B29fVEa93xre4KEirOlYYNjiOk4
 YtWvFUjCcqKc1KZ5hc6a7tkfT8ZN6H8CFdm3ehguGzHSJryXVsROBbtNFYHnTtvry3Ty Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 363p5dfdet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 11:51:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C43F6100034;
        Tue, 19 Jan 2021 11:51:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B341A2296E0;
        Tue, 19 Jan 2021 11:51:20 +0100 (CET)
Received: from lmecxl0602.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 11:51:19 +0100
Subject: Re: [Linux-stm32] [PATCH] ARM: dts: stm32: enable STM32MP1 crypto/CRC
 accelerators unconditionally
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210119095241.17888-1-a.fatoum@pengutronix.de>
From:   Lionel DEBIEVE <lionel.debieve@foss.st.com>
Message-ID: <d14933ea-2c77-7cca-8e2b-3972ea47d733@foss.st.com>
Date:   Tue, 19 Jan 2021 11:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119095241.17888-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_02:2021-01-18,2021-01-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

These IPs could be enabled in the secure side. To avoid any concurrency 
access, I prefer to keep all that crypto IPs status disable.
For examples, RNG can be managed in OP-TEE, so it will remain disable in 
Linux.
BR,

Lionel

On 1/19/21 10:52 AM, Ahmad Fatoum wrote:
> There is no SoC-external hardware support needed for the hash1, rng1,
> crc1 and cryp1 IP blocks to function. Enable them thus unconditionally
> instead of replicating their enablement in board device trees.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi              |  3 ---
>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi   |  4 ----
>   arch/arm/boot/dts/stm32mp157c-dk2.dts          |  4 ----
>   arch/arm/boot/dts/stm32mp157c-ed1.dts          | 16 ----------------
>   arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi |  4 ----
>   arch/arm/boot/dts/stm32mp15xc.dtsi             |  1 -
>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi   |  8 --------
>   arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi   |  4 ----
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi         | 12 ------------
>   arch/arm/boot/dts/stm32mp15xx-osd32.dtsi       |  4 ----
>   10 files changed, 60 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 3c75abacb374..c2d998343b6a 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1297,7 +1297,6 @@ hash1: hash@54002000 {
>   			dmas = <&mdma1 31 0x2 0x1000A02 0x0 0x0>;
>   			dma-names = "in";
>   			dma-maxburst = <2>;
> -			status = "disabled";
>   		};
>   
>   		rng1: rng@54003000 {
> @@ -1305,7 +1304,6 @@ rng1: rng@54003000 {
>   			reg = <0x54003000 0x400>;
>   			clocks = <&rcc RNG1_K>;
>   			resets = <&rcc RNG1_R>;
> -			status = "disabled";
>   		};
>   
>   		mdma1: dma-controller@58000000 {
> @@ -1402,7 +1400,6 @@ crc1: crc@58009000 {
>   			compatible = "st,stm32f7-crc";
>   			reg = <0x58009000 0x400>;
>   			clocks = <&rcc CRC1>;
> -			status = "disabled";
>   		};
>   
>   		stmmac_axi_config_0: stmmac-axi-config {
> diff --git a/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi b/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
> index 58275bcf9e26..268a99291d79 100644
> --- a/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
> @@ -253,10 +253,6 @@ &pwr_regulators {
>   	vdd_3v3_usbfs-supply = <&vdd_usb>;
>   };
>   
> -&rng1 {
> -	status = "okay";
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> index 2bc92ef3aeb9..045636555ddd 100644
> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> @@ -29,10 +29,6 @@ chosen {
>   	};
>   };
>   
> -&cryp1 {
> -	status = "okay";
> -};
> -
>   &dsi {
>   	status = "okay";
>   	phy-dsi-supply = <&reg18>;
> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> index 81a7d5849db4..f69622097e89 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> @@ -115,14 +115,6 @@ adc1: adc@0 {
>   	};
>   };
>   
> -&crc1 {
> -	status = "okay";
> -};
> -
> -&cryp1 {
> -	status = "okay";
> -};
> -
>   &dac {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&dac_ch1_pins_a &dac_ch2_pins_a>;
> @@ -144,10 +136,6 @@ &gpu {
>   	contiguous-area = <&gpu_reserved>;
>   };
>   
> -&hash1 {
> -	status = "okay";
> -};
> -
>   &i2c4 {
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&i2c4_pins_a>;
> @@ -325,10 +313,6 @@ &pwr_regulators {
>   	vdd_3v3_usbfs-supply = <&vdd_usb>;
>   };
>   
> -&rng1 {
> -	status = "okay";
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> index 6cf49a0a9e69..a2aca1982bf6 100644
> --- a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
> @@ -250,10 +250,6 @@ &m4_rproc {
>   	status = "okay";
>   };
>   
> -&rng1 {
> -	status = "okay";
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/stm32mp15xc.dtsi b/arch/arm/boot/dts/stm32mp15xc.dtsi
> index b06a55a2fa18..86953d7ddde0 100644
> --- a/arch/arm/boot/dts/stm32mp15xc.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xc.dtsi
> @@ -12,7 +12,6 @@ cryp1: cryp@54001000 {
>   			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&rcc CRYP1>;
>   			resets = <&rcc CRYP1_R>;
> -			status = "disabled";
>   		};
>   	};
>   };
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> index ac46ab363e1b..603c14054509 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> @@ -377,14 +377,6 @@ flash0: mx66l51235l@0 {
>   	};
>   };
>   
> -&rng1 {
> -	status = "okay";
> -};
> -
> -&rtc {
> -	status = "okay";
> -};
> -
>   &sdmmc1 {
>   	pinctrl-names = "default", "opendrain", "sleep";
>   	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
> index 803eb8bc9c85..3f4af430aaf4 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
> @@ -204,10 +204,6 @@ flash0: spi-flash@0 {
>   	};
>   };
>   
> -&rng1 {
> -	status = "okay";
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> index 89c0e1ddc387..0cca6c3ff4a0 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> @@ -124,10 +124,6 @@ &cec {
>   	status = "okay";
>   };
>   
> -&crc1 {
> -	status = "okay";
> -};
> -
>   &dts {
>   	status = "okay";
>   };
> @@ -155,10 +151,6 @@ &gpu {
>   	contiguous-area = <&gpu_reserved>;
>   };
>   
> -&hash1 {
> -	status = "okay";
> -};
> -
>   &i2c1 {
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&i2c1_pins_a>;
> @@ -482,10 +474,6 @@ &pwr_regulators {
>   	vdd_3v3_usbfs-supply = <&vdd_usb>;
>   };
>   
> -&rng1 {
> -	status = "okay";
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> index 713485a95795..d03d4d12133c 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> @@ -224,7 +224,3 @@ &m4_rproc {
>   	interrupts = <68 1>;
>   	status = "okay";
>   };
> -
> -&rng1 {
> -	status = "okay";
> -};
