Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B372B675A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgKQO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:27:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728063AbgKQO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:27:51 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHEQqZ1010083;
        Tue, 17 Nov 2020 15:27:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Vj2Fn4LsQM5ZirBQzqSd0b6wK1xakoRZ2IbWQcg5ueM=;
 b=rbqG/WSH/9tr2HVMjWfNRa+kUFmfjS5xNVpt6zDkF+erzglU/6bW8x5JYTJH0WEv70uP
 CECOTXKis00OqVw0MfL4YU1106RxL6ma7wcJIZQ9YjwaL8E1FSX8NUkzOXHVyH1T0G0Y
 c4Ltlxy/tZLbVbttrXhfkC3eihEZ8KExcsaGKUhpDCvgYHaHWquIiWVOy+9j/TKZ/l5H
 jM67ePa0OVcYw8JhPtEgiuQDzhroumBfE/g0Jd+yy8Jmmp1UbggUiJosptFapMFz7f09
 V6F4ODZmEKR7aTK290PItG1pVA7o98vCP7oyVaQSqaDLnYh96YeSibwG861v0vOClLMd 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t58cj7et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 15:27:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDB8C100038;
        Tue, 17 Nov 2020 15:27:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D99D6231294;
        Tue, 17 Nov 2020 15:27:37 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 15:27:37 +0100
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: lxa-mc1: add OSD32MP15x to list
 of compatibles
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201110102552.7270-1-a.fatoum@pengutronix.de>
 <20201110102552.7270-3-a.fatoum@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f98a412c-d64f-e9b7-cfe4-a92b12806a28@st.com>
Date:   Tue, 17 Nov 2020 15:26:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110102552.7270-3-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_04:2020-11-17,2020-11-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 11/10/20 11:25 AM, Ahmad Fatoum wrote:
> Earlier commit modified the binding, so the SiP is to be specified
> as well. Adjust the device tree accordingly.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>    - split up binding and device tree change
> ---
>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> index 1e5333fd437f..cda8e871f999 100644
> --- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> @@ -15,7 +15,7 @@
>   
>   / {
>   	model = "Linux Automation MC-1 board";
> -	compatible = "lxa,stm32mp157c-mc1", "st,stm32mp157";
> +	compatible = "lxa,stm32mp157c-mc1", "oct,stm32mp15xx-osd32", "st,stm32mp157";
>   
>   	aliases {
>   		ethernet0 = &ethernet0;
> 

Series applied on stm32-next.

Regards
Alex
