Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A53303E79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403884AbhAZNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:21:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404326AbhAZNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:17:17 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QDBudM001701;
        Tue, 26 Jan 2021 14:16:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xa70l9azV9gym1p2Ripu8D6jOM/EugA2+SDeRh0kXyk=;
 b=bi8dvUsDIojjZW9RBUV6RKY2HotQGbjq2Cbe6j/LhP3ck3z9ezQMoRCW3cHcDyT6EMGb
 q7jike30y135mSloXCFi9EwFiVmPweh9Gn9rWhvybj/YuUdum9gIrLMD2lSQv/DAmI2q
 GcImUFHmNAZ+nND5uCFsZ4CmCNGCvKgrT1o+YGiPkvKESqc01NVidoVB+DCk/phfZctp
 2rYgN9ERsO+zhwJIYADOqbs+6VERt8WGkTHfB/dKgw1bAM5JXiBVYuev7jVWqGF4iLQz
 ltvPA4MO1h1sSKzDlyBq0mVSBrlyOUyGaCwX5yXSIIwRPfEXaBg9/Y2vpiu6g4FAdDfm WA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368bjn94de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 14:16:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF6FB10002A;
        Tue, 26 Jan 2021 14:16:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BEA7243718;
        Tue, 26 Jan 2021 14:16:20 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan
 2021 14:16:20 +0100
Subject: Re: [PATCH v2 0/3] ARM: stm32: USBPHYC updates on stm32mp15
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210114131524.3298-1-amelie.delaunay@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <9e6fe1ab-bbd7-e313-b491-570070be3e6e@foss.st.com>
Date:   Tue, 26 Jan 2021 14:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114131524.3298-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_07:2021-01-26,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie,

On 1/14/21 2:15 PM, Amelie Delaunay wrote:
> This series updates usbphyc parent and child nodes to follow latest DT
> bindings.
> 
> ---
> Changes in v2:
> - squash all DT board patches in one patch
> - update also non-ST DT
> 
> Amelie Delaunay (3):
>    ARM: dts: stm32: add usbphyc vdda1v1 and vdda1v8 supplies on
>      stm32mp151
>    ARM: dts: stm32: remove usbphyc ports vdda1v1 & vdda1v8 on stm32mp15
>      boards
>    ARM: dts: stm32: add #clock-cells property to usbphyc node on
>      stm32mp151
> 
>   arch/arm/boot/dts/stm32mp151.dtsi                  | 3 +++
>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi       | 4 ----
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              | 4 ----
>   arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi     | 2 --
>   arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      | 4 ----
>   arch/arm/boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   | 4 ----
>   arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 4 ----
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             | 4 ----
>   8 files changed, 3 insertions(+), 26 deletions(-)
> 

DT patches applied on stm32-next.

Thanks
Alex
