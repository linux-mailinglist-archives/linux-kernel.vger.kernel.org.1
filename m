Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74E33036BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbhAZGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:41:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34550 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729674AbhAYOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:41:10 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10PEbl9t026481;
        Mon, 25 Jan 2021 15:38:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=MIuVa7N9W1Fh67WY3zuMzD4+gl2zGit1w7lDqAqbRls=;
 b=b1WJZHMLUdC7ufEVjoNaD2PTQ7Oq27HEbSh2fiOjDzvji4HlrISf2xHfUJJ8DIqBaHwy
 F4Af9dAvwggjoqgNDGKhR4bqiySfhsRSlfR3Ce8AUm3SppsHe+/Go7HxWxc3j5RMOiQC
 koMGaEt67eUgsn9PlUQex5M8sXsAvW6vfjoasTahByc6cV4FPZDlnSS/LWa8sUSSCwbH
 hgq+xGcDTrD6X69408bBYjfJNUf/lz6JHQZvXIXowNdts0SZwwaqCpGejHV/Il+ScUqB
 9IB86VzOuOIvyV3kAtfT10EgxOtZYe4WsTjSooMaYbZsMkOksrEioPxTgY1EOU/8S+uH Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368bjn3ddn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 15:38:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4A4A100034;
        Mon, 25 Jan 2021 15:38:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CD202288B4;
        Mon, 25 Jan 2021 15:38:50 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Jan
 2021 15:38:49 +0100
Subject: Re: [PATCH] ARM: dts: stm32: Add STM32MP1 I2C6 SDA/SCL pinmux
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amarula@amarulasolutions.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201223110757.126937-1-jagan@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <06748341-211c-c956-7ac2-d85ca0b582e2@foss.st.com>
Date:   Mon, 25 Jan 2021 15:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201223110757.126937-1-jagan@amarulasolutions.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_04:2021-01-25,2021-01-25 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/23/20 12:07 PM, Jagan Teki wrote:
> Add SDA/SCL pinmux lines for I2C6 on STM32MP1.
> 
> This support adds both in default and sleep states.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 20a59e8f7a33..2036c1d0d798 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -2018,6 +2018,23 @@ pins {
>   		};
>   	};
>   
> +	i2c6_pins_a: i2c6-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('Z', 6, AF2)>, /* I2C6_SCL */
> +				 <STM32_PINMUX('Z', 7, AF2)>; /* I2C6_SDA */
> +			bias-disable;
> +			drive-open-drain;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	i2c6_sleep_pins_a: i2c6-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('Z', 6, ANALOG)>, /* I2C6_SCL */
> +				 <STM32_PINMUX('Z', 7, ANALOG)>; /* I2C6_SDA */
> +		};
> +	};
> +
>   	spi1_pins_a: spi1-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('Z', 0, AF5)>, /* SPI1_SCK */
> 

Applied on stm32-next.

Thanks.
Alex
