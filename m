Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD30227A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgGUIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:09:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728109AbgGUIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:09:35 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L82pnM003649;
        Tue, 21 Jul 2020 10:09:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=E2Wd2EJdD/kFe0rBJ1Ny0EHEbraKYutMjfWXFZHqZWw=;
 b=IiepC+FgGdz9o3n6xitfN0Fi/9xgBbPDWvmW7ACnzM1xlDsWZQD8M4F6XUbsDEkskOLF
 I22SF1LTUdKZbbUbbh6ffZCKZI//w9jSduqW6OAW1PGwIQJki/JUtMg98dXMFi1moy3J
 AEMZ1b2o0VbHsyn0Jaa0N7niB4adOJ0tyvUqedZ0B7i1xKm627rldeugLMj+yMh91ggb
 a7Yb/lWdAN1VQCI+HLSxaY9jEVBVuqao6L1PsR41tRidCE0MPedJi+IhcWC5AspJFesQ
 6bpyPJt+wDUhq95zCwRIPJapyzkJayRoVWhP2NiyBuirp0FL2DkBQwSPSvHMY6TlRt7Y 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsagvs4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:09:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6FDB10002A;
        Tue, 21 Jul 2020 10:09:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A09902A4D85;
        Tue, 21 Jul 2020 10:09:22 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Jul
 2020 10:09:22 +0200
Subject: Re: [PATCH v2 0/5] STM32 add usart nodes support
To:     Erwan Le Ray <erwan.leray@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200618130651.29836-1-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <ff943604-19a8-3011-62f9-cc74f7fbab11@st.com>
Date:   Tue, 21 Jul 2020 10:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200618130651.29836-1-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan

On 6/18/20 3:06 PM, Erwan Le Ray wrote:
> Add the support of uart instances available on STM32MP157 boards:
> - usart3 on stm32mp157c-ev1, stm32mp157a-dk1, and stm32mp157c-dk2
> - uart7 on stm32mp157a-dk1 and stm32mp157c-dk2
> - usart2 on stm32mp157c-dk2
> 
> Erwan Le Ray (5):
>    ARM: dts: stm32: add usart2, usart3 and uart7 pins in
>      stm32mp15-pinctrl
>    ARM: dts: stm32: add usart3 node to stm32mp15xx-dkx boards
>    ARM: dts: stm32: add usart3 node to stm32mp157c-ev1
>    ARM: dts: stm32: add uart7 support to stm32mp15xx-dkx boards
>    ARM: dts: stm32: add usart2 node to stm32mp157c-dk2
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 138 +++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157a-dk1.dts    |   2 +
>   arch/arm/boot/dts/stm32mp157c-dk2.dts    |  11 ++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts    |  15 +++
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |  17 +++
>   5 files changed, 183 insertions(+)
> 

With minor changes:

Series applied on stm32-next.

Regards
Alex
