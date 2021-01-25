Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217B43031F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 03:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbhAYQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:01:28 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48086 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730382AbhAYP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:57:09 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10PF1YUQ029834;
        Mon, 25 Jan 2021 16:05:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=iCz92iVqfHGteRU+hU/TvcxooA89t1WUlYOEoi877eE=;
 b=e2ixu6nDXMeNFxQMc8yCSH7pB0ubJ5Cqo8V0EukSC1NytFpSTZI3hjyv8j1UCOk1H8X8
 Wu8L/OMSjafFJ0H1yJnCKc63EdBpE2cFCWxajGuIu4Sqhvs5MfEkeGhHHzu5TrNghdvR
 wtOvmrBHKJMA0WmtuvxHyoVp4Rch+i5R5rK7ajYoAUCc3fg++m48Bd1doQbtYhfBlfRY
 wdV5PE3bnP47WXKLlR7nHV8tG+r8sdKt7g7ppfFxh8taxsJgC7Vx3UOaScRjHgWizuWw
 FTgtBrP4mh4DUOQebvmx0Vc3FN0x2UKdqYXoILtxgwov+OqUvg/y6Jq9zN+C7y7g/9rF +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368c15k9wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 16:05:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82DBE10002A;
        Mon, 25 Jan 2021 16:05:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AA1522B283;
        Mon, 25 Jan 2021 16:05:31 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Jan
 2021 16:05:30 +0100
Subject: Re: [PATCH 2/5] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 SoM
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amarula@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Francesco Utel <francesco.utel@engicam.com>,
        Mirko Ardinghi <mirko.ardinghi@engicam.com>
References: <20201223191402.378560-1-jagan@amarulasolutions.com>
 <20201223191402.378560-3-jagan@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <21398844-c334-f753-0fac-144a0cdc29dc@foss.st.com>
Date:   Mon, 25 Jan 2021 16:05:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201223191402.378560-3-jagan@amarulasolutions.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_05:2021-01-25,2021-01-25 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/23/20 8:13 PM, Jagan Teki wrote:
> MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.
> 
> General features:
> - STM32MP157AAC
> - Up to 1GB DDR3L-800
> - 512MB Nand flash
> - I2S
> 
> MicroGEA STM32MP1 needs to mount on top of Engicam MicroDev carrier
> boards for creating complete platform solutions.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
> Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>   .../dts/stm32mp157a-microgea-stm32mp1.dtsi    | 147 ++++++++++++++++++
>   1 file changed, 147 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> 
> diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> new file mode 100644
> index 000000000000..97d569107bfe
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutons(India)
> + */
> +

If STM32MP157AAC is soldered onto this board, you should include SoC 
dtsi here and no into MicroDev 2.0 board. No ?

+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxaa-pinctrl.dtsi"


Regards
Alex

> +/ {
> +	compatible = "engicam,microgea-stm32mp1", "st,stm32mp157";
> +
> +	memory@c0000000 {
> +		reg = <0xc0000000 0x10000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mcuram2: mcuram2@10000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10000000 0x40000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@10040000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10040000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@10041000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10041000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0buffer: vdev0buffer@10042000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10042000 0x4000>;
> +			no-map;
> +		};
> +
> +		mcuram: mcuram@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x30000000 0x40000>;
> +			no-map;
> +		};
> +
> +		retram: retram@38000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x38000000 0x10000>;
> +			no-map;
> +		};
> +	};
> +
> +	vin: regulator-vin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vin";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddcore: regulator-vddcore {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vddcore";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};
> +
> +	vdd: regulator-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};
> +
> +	vddq_ddr: regulator-vddq-ddr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vddq_ddr";
> +		regulator-min-microvolt = <1350000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};
> +};
> +
> +&dts {
> +	status = "okay";
> +};
> +
> +&fmc {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&fmc_pins_a>;
> +	pinctrl-1 = <&fmc_sleep_pins_a>;
> +	status = "okay";
> +
> +	nand-controller@4,0 {
> +		status = "okay";
> +
> +		nand@0 {
> +			reg = <0>;
> +			nand-on-flash-bbt;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +	};
> +};
> +
> +&ipcc {
> +	status = "okay";
> +};
> +
> +&iwdg2{
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&m4_rproc{
> +	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
> +			<&vdev0vring1>, <&vdev0buffer>;
> +	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> +	mbox-names = "vq0", "vq1", "shutdown";
> +	interrupt-parent = <&exti>;
> +	interrupts = <68 1>;
> +	status = "okay";
> +};
> +
> +&rng1 {
> +	status = "okay";
> +};
> +
> +&rtc{
> +	status = "okay";
> +};
> +
> +&vrefbuf {
> +	regulator-min-microvolt = <2500000>;
> +	regulator-max-microvolt = <2500000>;
> +	vdda-supply = <&vdd>;
> +	status = "okay";
> +};
> 
