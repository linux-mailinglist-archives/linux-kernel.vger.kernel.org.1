Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC62AB2BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgKIIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:50:32 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:16450 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgKIIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:50:31 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A98mX9Y005110;
        Mon, 9 Nov 2020 09:50:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=kbMEOF7fHi1ILrCU9QmthxuRje1kCpQhTQ54wrm0nmI=;
 b=VoVYQhrTVC0cHUBC+GLuhDgjJBxLKtKm1gcBuYZEN1uMCRT6CdjEayTClrL+3ZR/tQNV
 7g/qvOf/k0gMWW+hET8q6Vlc46bOSBqL2tSBoGyhK6P6iWjuo7hWoTL5200H/wZRegPI
 s2zQBVve7GUMNz12eCJThSFCaP6WPGqeWyGgCm/zfWyMNSY812aByF6q//bPVmBy2u1r
 oEpmfoOFvO2is8pwuQpRU7X9rVfgghJLZBuVXrSF5E70Jt5Mt9gx6yYscarmOq7RPEid
 C52TM+eXaMfKNwXnFPxFfg+HJ8fjDcDseZOvaxx734ARbJ6mg4nT7TqgpNf8PMEyawEQ rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nj80gun3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 09:50:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32AF910002A;
        Mon,  9 Nov 2020 09:50:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15FD42314C1;
        Mon,  9 Nov 2020 09:50:21 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 09:50:20 +0100
Subject: Re: [PATCH] ARM: dts: stm32: fix DCMI DMA features on stm32mp15
 family
To:     Hugues Fruchet <hugues.fruchet@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alain Volmat <alain.volmat@st.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
References: <1602148182-25869-1-git-send-email-hugues.fruchet@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <585bbff2-89a7-0e10-2280-e4236dc36d2c@st.com>
Date:   Mon, 9 Nov 2020 09:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1602148182-25869-1-git-send-email-hugues.fruchet@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues

On 10/8/20 11:09 AM, Hugues Fruchet wrote:
> Enable FIFO mode with half-full threshold.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index bfe2902..cfba9a1 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1091,7 +1091,7 @@
>   			resets = <&rcc CAMITF_R>;
>   			clocks = <&rcc DCMI>;
>   			clock-names = "mclk";
> -			dmas = <&dmamux1 75 0x400 0x0d>;
> +			dmas = <&dmamux1 75 0x400 0x01>;
>   			dma-names = "tx";
>   			status = "disabled";
>   		};
> 

Applied on stm32-next.

Thanks.
Alex
