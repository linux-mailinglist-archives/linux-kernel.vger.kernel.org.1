Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061BD2AB63A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgKILLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:11:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22876 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727303AbgKILLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:11:09 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9B7u8n009311;
        Mon, 9 Nov 2020 12:11:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=9bs5t6Bcs74pMRrZFN4Yti7b4GoxPP7Dgl4wugNGlh0=;
 b=ZL+uSg4JZZJSn0ynN2frvn64ELbA0PyPKRms/JkiSOL2zHu7X5wsgNr2CoeGBZA1oMjZ
 6SZ2cfYZo2oaBf7VNEM9iBPcQsEd2qk7aXkD5MQO1GkIqc/OWXHlhGbj1aNfEA15b+Gi
 /Lna5l8SHpj5ZfrvauYda7sEnFsy9/uqn8gWQK6fUAzeNetTB2CaWe/yjW2lTczd5MpQ
 rzkXPkLHgpJJAfZhPcaBamTXdkTpPEY5sMAx6Zm8OnNbED0jHwWW8wZOlVSbqE4H5Sr9
 EJc2bkVbaqqh7s4ocM1rlFi8FLdSB3EfLsQH+pcAlVUJETH+hnR4LDJ66ORDVEA5BiqB uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhkcj4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 12:11:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6004210002A;
        Mon,  9 Nov 2020 12:11:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 541D824D14B;
        Mon,  9 Nov 2020 12:11:02 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 12:11:01 +0100
Subject: Re: [PATCH 1/1] ARM: multi_v7_defconfig: add STM32 crypto support
To:     Lionel Debieve <lionel.debieve@st.com>,
        Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20201105094730.8320-1-lionel.debieve@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <ed3d0ce8-b3f2-f941-afaa-24147da282e4@st.com>
Date:   Mon, 9 Nov 2020 12:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105094730.8320-1-lionel.debieve@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lionel

On 11/5/20 10:47 AM, Lionel Debieve wrote:
> Enable crypto controllers enabling following flags as module:
> CONFIG_CRYPTO_DEV_STM32_CRC
> CONFIG_CRYPTO_DEV_STM32_HASH
> CONFIG_CRYPTO_DEV_STM32_CRYP
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index a611b0c1e540..57eafa2d7775 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1133,6 +1133,9 @@ CONFIG_CRYPTO_DEV_ATMEL_AES=m
>   CONFIG_CRYPTO_DEV_ATMEL_TDES=m
>   CONFIG_CRYPTO_DEV_ATMEL_SHA=m
>   CONFIG_CRYPTO_DEV_ROCKCHIP=m
> +CONFIG_CRYPTO_DEV_STM32_CRC=m
> +CONFIG_CRYPTO_DEV_STM32_HASH=m
> +CONFIG_CRYPTO_DEV_STM32_CRYP=m
>   CONFIG_CMA_SIZE_MBYTES=64
>   CONFIG_PRINTK_TIME=y
>   CONFIG_MAGIC_SYSRQ=y
> 

Applied on stm32-next.

Thanks.
Alex
