Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0A2B5C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgKQKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:00:32 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbgKQKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:00:31 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH9bavK025748;
        Tue, 17 Nov 2020 11:00:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=y2Io4U8P70EBSSJuLyQPTHs4SXuaogmus/3Tq9b2AiA=;
 b=I9ZlYEsUrv1jfABsS3t0ujS5lzVZFwnES52kL3SRMyQepR/eYYwXeVmHp1R2dqK6v7tw
 O/CUpyqg80K+TpYAIBsYBvAC1vJ8D8G8Rz8m9d2VxRh6Mgn8umFvGBSZ7Y2s9IVcPXQ5
 m1Vj+SbbAn5fLjcejNauhMb7WZS+zU9pr7t0o+Jx43opkzNQ+o1aIe82NC87fH9uDF8l
 kr//nh+sHdULjoAUkFZFB1WedgZAXpNvH6oe0AXCH8+Urlz9l06cJZJ8hlVK29j/mTMv
 d4vS4THOQU1Z6Z6fY/f8/NQX3sw1eRg7LCi7X4TUEveo0jKzs81Lsk5Cjt8kZbcVDKPU og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w1r975-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:00:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDA5510002A;
        Tue, 17 Nov 2020 11:00:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBDA2238C96;
        Tue, 17 Nov 2020 11:00:21 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 11:00:21 +0100
Subject: Re: [PATCH 1/1] ARM: dts: stm32: adjust USB OTG gadget fifo sizes in
 stm32mp151
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201110131059.7826-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f324e117-114b-3f2f-318a-9b57a93438bc@st.com>
Date:   Tue, 17 Nov 2020 10:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110131059.7826-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_03:2020-11-13,2020-11-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 11/10/20 2:10 PM, Amelie Delaunay wrote:
> Defaut use case on stm32mp151 USB OTG is ethernet gadget, using EP1 bulk
> endpoint (MPS=512 bytes) and EP2 interrupt endpoint (MPS=16 bytes).
> This patch optimizes USB OTG FIFO sizes accordingly.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 6ffcf06dc0e8..928e31db1526 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1070,9 +1070,9 @@
>   			resets = <&rcc USBO_R>;
>   			reset-names = "dwc2";
>   			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -			g-rx-fifo-size = <256>;
> +			g-rx-fifo-size = <512>;
>   			g-np-tx-fifo-size = <32>;
> -			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
> +			g-tx-fifo-size = <256 16 16 16 16 16 16 16>;
>   			dr_mode = "otg";
>   			usb33d-supply = <&usb33>;
>   			status = "disabled";
> 

Applied on stm32-next.

Thanks.
Alex
