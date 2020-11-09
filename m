Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB352AB568
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgKIKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:50:42 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgKIKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:50:42 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9AmTU8002133;
        Mon, 9 Nov 2020 11:50:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Yqdwz9aL/2Si5yHqMENpFmQ48fWUzw1GXx6IQxVxh3A=;
 b=AMthtwAoAv0lQKQLEKheykj77OtSLVeTbtYwBc7OTOPDTiEFrkkJ2NA0OrrLZQs1qEo5
 vTcWJ/HkfKM0q7mVAPIVE+Db37m/6hbPbno4VcVNgjR9s8PQfqsEUElmW01143nFWKEx
 OwX+36qwk0GQ1Wt6fe7iUEYsrArzNsHZ4igt52cL5kKTS/zBhyhOLz3JIBuDlzYyHpR+
 18ORV/Ea3CINI44vj27inNDSRQLzzKaWHz1XdHThK89AYbDwaVSehcEc5A1gIfQ/iDC9
 laTFyqnc/JYu3wsEtQo+jh3IDeGxmEbD76YE4qT06vdr50tV+LbWrSHxNSiAr2W6xDnS FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhx4sk7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 11:50:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0735010003A;
        Mon,  9 Nov 2020 11:50:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF17523C375;
        Mon,  9 Nov 2020 11:50:29 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 11:50:29 +0100
Subject: Re: [PATCH] ARM: dts: stm32: update sdmmc IP version for STM32MP157
 SOC
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, Yann Gautier <yann.gautier@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201020140450.29158-1-a.fatoum@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <505ef7e6-ef6d-07d6-9d98-d6694b5fa388@st.com>
Date:   Mon, 9 Nov 2020 11:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020140450.29158-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 10/20/20 4:04 PM, Ahmad Fatoum wrote:
> From: Yann Gautier <yann.gautier@st.com>
> 
> Update the IP version to v2.0, which supports linked lists in internal DMA,
> and is present in STM32MP1 SoCs.
> 
> The mmci driver supports the v2.0 periph id since 7a2a98be672b ("mmc: mmci:
> Add support for sdmmc variant revision 2.0"), so it's now Ok to add it into
> the SoC device tree to benefit from the improved DMA support.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Yann Gautier <yann.gautier@st.com>
> [afa: cherry-picked from https://github.com/STMicroelectronics/linux/commit/31e2a6bc8]
> [afa: extended commit message with reference to driver patch]
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Applied on stm32-next.

Thanks.
Alex


> ---
> Cc: Ludovic Barre <ludovic.barre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index bfe29023fbd5..b8d996d32dc0 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1040,7 +1040,7 @@ adc2: adc@100 {
>   
>   		sdmmc3: sdmmc@48004000 {
>   			compatible = "arm,pl18x", "arm,primecell";
> -			arm,primecell-periphid = <0x10153180>;
> +			arm,primecell-periphid = <0x00253180>;
>   			reg = <0x48004000 0x400>;
>   			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "cmd_irq";
> @@ -1338,7 +1338,7 @@ qspi: spi@58003000 {
>   
>   		sdmmc1: sdmmc@58005000 {
>   			compatible = "arm,pl18x", "arm,primecell";
> -			arm,primecell-periphid = <0x10153180>;
> +			arm,primecell-periphid = <0x00253180>;
>   			reg = <0x58005000 0x1000>;
>   			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "cmd_irq";
> @@ -1353,7 +1353,7 @@ sdmmc1: sdmmc@58005000 {
>   
>   		sdmmc2: sdmmc@58007000 {
>   			compatible = "arm,pl18x", "arm,primecell";
> -			arm,primecell-periphid = <0x10153180>;
> +			arm,primecell-periphid = <0x00253180>;
>   			reg = <0x58007000 0x1000>;
>   			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "cmd_irq";
> 
