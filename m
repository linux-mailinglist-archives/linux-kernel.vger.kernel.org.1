Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63202AB733
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgKILgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:04 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50570 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729599AbgKILgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:36:01 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BWVSo017770;
        Mon, 9 Nov 2020 12:35:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=nCNWMSseoOrn7wzGNsCWWTckovRM9wFGc2kDdfQ+cUs=;
 b=f90NrHL2mnjrDStKpnkfXF4Zaojh5QRoxku70I9abypNPmGqsHUpzAbzr+i1LgRuEug1
 Gwr8aDSWAkKZQ3KaacHtVmmXc1W1xwrOgCmgNzZZ08ZvswzaGHRcYO7yXsnt7o6OQXMP
 gz2N7PY+qPKbDILLeilh1cCj0METSb+XlUI/zT99UXuLwyFaJAkDcCkuyIE0VjvStyCa
 Nb6bqAzBmlsOyYz/znJgXPaa3ieygjl6GoebBSNoOsED0oLBr9pkuYlBilrgv5/YXlhX
 gDoSvqLpAokpg/BZxWY1XPuyKbTKHROI+oKPDGkhwKFCABm0GWW2c1csfjKzNSYT7g+D 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nj80hpjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 12:35:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 198F610002A;
        Mon,  9 Nov 2020 12:35:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07FEE233859;
        Mon,  9 Nov 2020 12:35:52 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 12:35:51 +0100
Subject: Re: [PATCH] ARM: dts: stm32: reorder spi4 within stm32mp15-pinctrl
To:     Patrick Delaunay <patrick.delaunay@st.com>,
        <linux-kernel@vger.kernel.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20201022173851.20114-1-patrick.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d60c5bbe-0a13-ef3f-da08-7a9eff0fab50@st.com>
Date:   Mon, 9 Nov 2020 12:35:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022173851.20114-1-patrick.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 10/22/20 7:38 PM, Patrick Delaunay wrote:
> Move spi4 at the right alphabetical place within stm32mp15-pinctrl
> 
> Fixes: 4fe663890ac5 ("ARM: dts: stm32: Fix spi4 pins in stm32mp15-pinctrl")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
> ---
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 28 ++++++++++++------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index d84686e00370..c9e514165672 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1591,6 +1591,20 @@
>   		};
>   	};
>   

Applied on stm32-next.

Thanks.
Alex

> +	spi4_pins_a: spi4-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> +				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
> +			bias-disable;
> +		};
> +	};
> +
>   	uart4_pins_a: uart4-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
> @@ -1726,20 +1740,6 @@
>   		};
>   	};
>   
> -	spi4_pins_a: spi4-0 {
> -		pins {
> -			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> -				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> -			bias-disable;
> -			drive-push-pull;
> -			slew-rate = <1>;
> -		};
> -		pins2 {
> -			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
> -			bias-disable;
> -		};
> -	};
> -
>   	usart2_pins_a: usart2-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
> 
