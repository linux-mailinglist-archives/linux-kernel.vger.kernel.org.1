Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CFB2B5C24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgKQJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:47:23 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:30810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgKQJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:47:21 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH9bTlx005869;
        Tue, 17 Nov 2020 10:47:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=kLGZQ9kpLWhNXSWjbr7GvxK3zYqJJaKPYV5Y/uduEoo=;
 b=vq3T8nafabzNUmOoQhlyd3dCg1VP/QoifrPH+LHv8R4km4n+2tI2Sl4A/fOhXxF69gDR
 apgDod/hozCuK/OE+PX/dWhUfDkJpXeUBNiXtWeITHW6S7QNygfBM64vfkD29kZCUQJQ
 SKcRtK4kcTB4TUXR9jXCOmeilgiT/Y68jB1WRr1clo/8xY57oCax3zvV7qDCGcQE0Lna
 wWv1GcanfD+fXaHE5RZT9T0mWVGMf7F7w+UI/Dg9DKCIWUeHAj6j8VhG3gxu8ajUuZ6V
 E3LIXOGtsJdlrRl2kv6wUpcsZktFJfEurU44lIoFVJhimUMjaVwlOiORdMjd2iz9y74V rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5k5095j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 10:47:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A84610002A;
        Tue, 17 Nov 2020 10:47:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7AC19235AA8;
        Tue, 17 Nov 2020 10:47:09 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 10:47:08 +0100
Subject: Re: [PATCH 1/1] ARM: dts: stm32: fix mdma1 clients channel priority
 level on stm32mp151
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201110143641.13879-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <3be2f6c9-609a-3ecc-ebae-31ae24859493@st.com>
Date:   Tue, 17 Nov 2020 10:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110143641.13879-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_03:2020-11-13,2020-11-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/10/20 3:36 PM, Amelie Delaunay wrote:
> Update mdma1 clients channel priority level following stm32-mdma bindings.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 719a4276a348..b95c46c82223 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1294,7 +1294,7 @@
>   			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&rcc HASH1>;
>   			resets = <&rcc HASH1_R>;
> -			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0>;
> +			dmas = <&mdma1 31 0x2 0x1000A02 0x0 0x0>;
>   			dma-names = "in";
>   			dma-maxburst = <2>;
>   			status = "disabled";
> @@ -1358,8 +1358,8 @@
>   			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
>   			reg-names = "qspi", "qspi_mm";
>   			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -			dmas = <&mdma1 22 0x10 0x100002 0x0 0x0>,
> -			       <&mdma1 22 0x10 0x100008 0x0 0x0>;
> +			dmas = <&mdma1 22 0x2 0x100002 0x0 0x0>,
> +			       <&mdma1 22 0x2 0x100008 0x0 0x0>;
>   			dma-names = "tx", "rx";
>   			clocks = <&rcc QSPI_K>;
>   			resets = <&rcc QSPI_R>;
> 

Applied on stm32-next.

Thanks.
Alex
