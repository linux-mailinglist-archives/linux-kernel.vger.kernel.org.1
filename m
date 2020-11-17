Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EABE2B5E29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgKQLTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:19:51 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54598 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQLTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:19:51 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHBHdIH013698;
        Tue, 17 Nov 2020 12:19:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=RjgGdVvBAqG4pUc+emH48DVA7ViLFerpkVk7vIIeH4s=;
 b=RTfkfHL9k98Nt494o7k7V+RvYCbQ/cig6R2k9SHyWtGqSubOaiiRogtZ0fsbuyb9Ig23
 t8F9eEF5Gv4JHC0ItWFQFBHRagD0LJXsiQr/y25iOD+kP7DkFsUmtuZeJPNr9WY5sXBT
 2GsvbDlNdcw/4C80TaJYdOA7bu1+tKZ9s/auHVurtfW1ie0OtE24+1UqMFrQznbe1o/1
 HGps3SxeelSxMYHAGwmmsDASI+W2S9lFjPEvjgj6y/kcfw45Wo61FQuBFVrg+mASlNOu
 HJZ0WkNYPcDlso42VGuLJ4JPjzWeWa17PZlHFMPdp5VuVO4Kf4CKFoDB5MHfx1N1nvG9 ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w1rqun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 12:19:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E497810002A;
        Tue, 17 Nov 2020 12:19:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CDE5E241A55;
        Tue, 17 Nov 2020 12:19:40 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 12:19:39 +0100
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: support child mfd cells for the
 stm32mp1 TAMP syscon
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201021102855.18026-1-a.fatoum@pengutronix.de>
 <20201021102855.18026-2-a.fatoum@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <352478be-cd69-2089-baaf-6f796cfc6cfd@st.com>
Date:   Tue, 17 Nov 2020 12:18:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021102855.18026-2-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_03:2020-11-17,2020-11-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 10/21/20 12:28 PM, Ahmad Fatoum wrote:
> The stm32mp1 TAMP peripheral has 32 backup registers that survive
> a warm reset. This makes them suitable for storing a reboot
> mode, which the vendor's kernel tree is already doing[0].
> 
> The actual syscon-reboot-mode child node can be added by a board.dts or
> fixed up by the bootloader. For the child node to be probed, the
> compatible needs to include simple-mfd. The binding now specifies this,
> so have the SoC dtsi adhere to it.
> 
> [0]: https://github.com/STMicroelectronics/linux/commit/2e9bfc29dd
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>    - Dropped simple-bus. simple-mfd is all that's needed
>    - reworded commit message
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 842ecffae73a..662c2408d41b 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1542,7 +1542,7 @@ i2c6: i2c@5c009000 {
>   		};
>   
>   		tamp: tamp@5c00a000 {
> -			compatible = "st,stm32-tamp", "syscon";
> +			compatible = "st,stm32-tamp", "syscon", "simple-mfd";
>   			reg = <0x5c00a000 0x400>;
>   		};
>   
> 

Series applied on stm32-next.

Regards
Alex
