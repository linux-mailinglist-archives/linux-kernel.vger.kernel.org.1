Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01D2AB472
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgKIKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:08:15 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32488 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKIKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:08:14 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9A2V9d010554;
        Mon, 9 Nov 2020 11:07:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=FPLSmiDPRdoUr1m+ss77hjLUotPubH/KZ4b2fNX41no=;
 b=s7Njn+pOnZ+fmI7U3NXuMOGV3C/YzAFpMhD64WLkRLXR/ZlsyngO816SBJm/IkCpJCQ+
 zd+QEnS1YJk8WFVWjaUbmH9+7AeBS2kbYqqLdJ7CMsHWz+KKNsAh0qyDIF3humKc70u+
 0bQmz8pS9K5JjXasTJgoZQaPUZBhxPj57QpEMGszigIFkD68DJL/Xbz55dFGZsqIZYHJ
 I8EjTG/WlbedmsdDWI2OoZAvtxnkUWL8d3QDp3ufIF30bI0TiydTM4RaFQq9dj5vvBOD
 nm1vZuIlNflEFfG4m0RQ5ZBHDDP1U+OB/ZKVP3LzqFuQtp09b0GflyS+A1YAKPg2RGJ5 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nj80h98e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 11:07:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7091710002A;
        Mon,  9 Nov 2020 11:07:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 53B3B233C35;
        Mon,  9 Nov 2020 11:07:59 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 11:07:58 +0100
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable counter subsystem and
 stm32 counter drivers
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <vilhelm.gray@gmail.com>, <arnd@arndb.de>, <linux@armlinux.org.uk>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1602835229-10903-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <fdc3f436-3d06-4e3d-fc51-f484fc58f0e5@st.com>
Date:   Mon, 9 Nov 2020 11:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1602835229-10903-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi fabrice

On 10/16/20 10:00 AM, Fabrice Gasnier wrote:
> This enables the counter subsystem and drivers for the stm32 timer and LP
> timer.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index e9e76e3..f052db3 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1092,6 +1092,9 @@ CONFIG_FSI_MASTER_ASPEED=m
>   CONFIG_FSI_SCOM=m
>   CONFIG_FSI_SBEFIFO=m
>   CONFIG_FSI_OCC=m
> +CONFIG_COUNTER=m
> +CONFIG_STM32_TIMER_CNT=m
> +CONFIG_STM32_LPTIMER_CNT=m
>   CONFIG_EXT4_FS=y
>   CONFIG_AUTOFS4_FS=y
>   CONFIG_MSDOS_FS=y
> 

Applied on stm32-next.

Thanks.
Alex
