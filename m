Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE02AB58E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgKIKzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:55:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28904 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgKIKzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:55:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Apk1B010517;
        Mon, 9 Nov 2020 11:54:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=7YBJZg79to76zaOOPRXbZj81XDRsRMNu+P3U5gDITj0=;
 b=KlWmOGZfo3Qs/G6DxzIxaOgMjLmRXx7IA7ZlxWGacdds511BJn9Fl75Gd7SEuiDQu+OM
 0lPl8U7bDtEsJf5aMDR5k/9rcnlOcQD69+2So7Njql4JNMEvfav+Fwyum+4Cgk+47Ex1
 aZnfMp/kMj46OROJbzhyFCVa62BbtXaWuZKqW4T0W4QlbaibEq8DySIKm9yyK6XCwz8M
 aw/LuqqYw5tiA8P++TH65bMfD03J+qe8yiqub5LCMxVqcG1SYaXnRbfpW246b0ioqzlI
 KjhF6mmBO/KtTQzH3PTgIiwxnOBtJkS6304mx0FV1litVkWIpReC+SNaql5NhtMeGAaX aQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhkcj1ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 11:54:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 845C110002A;
        Mon,  9 Nov 2020 11:54:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72D2A24C784;
        Mon,  9 Nov 2020 11:54:43 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 11:54:42 +0100
Subject: Re: [PATCH 0/3] Add STM32 LP timer EXTI interrupts
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <maz@kernel.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c77e3222-85cf-a22f-3b9f-f081565a9243@st.com>
Date:   Mon, 9 Nov 2020 11:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 10/16/20 4:40 PM, Fabrice Gasnier wrote:
> STM32 LP timer that's available on STM32MP15x can wakeup the platform
> using EXTI interrupts.
> 
> This series add:
> - LP timer EXTI - GIC interrupt events to EXTI driver and device-tree
> - LP timer wakeup-source to device-tree
> 
> Fabrice Gasnier (3):
>    irqchip/stm32-exti: Add all LP timer exti direct events support
>    ARM: dts: stm32: Add LP timer irqs on stm32mp151
>    ARM: dts: stm32: Add LP timer wakeup-source on stm32mp151
> 
>   arch/arm/boot/dts/stm32mp151.dtsi | 10 ++++++++++
>   drivers/irqchip/irq-stm32-exti.c  |  4 ++++
>   2 files changed, 14 insertions(+)
> 

DT patches applied on stm32-next.

thanks
alex
