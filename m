Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4150A2A01B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgJ3JrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:47:09 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:24438 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgJ3JrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:47:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09U8REbs022363;
        Fri, 30 Oct 2020 09:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ZgE/qCYfCapy4vRT52/Xdi9SuwmMVbC8pMtk6Z4UaLA=;
 b=gC2oe8fHnpczUU1vHr99ANa4HnBgRZP39L9jSe3h14yw9JgZi6mQ+uFXitt0UFK4Afle
 E33CDuanPYFWOxbwQ4cogBVqfyKFY1BYLpCe5vXDamHPI+zQE7ABy882kXHe5QRuH4Lj
 gFwiCGcJMDS0MlGr6Sqbv2enf6jtaOnL2quHzel6NQQCm5XtIvfFB+hUKXGIpmssvOZL
 hSlTNNiAIjVP5pZ2ylAK7I+takF6cyc9y8W6Q3QKfBUspbONslAeHLdttHCmIjsHblmQ
 CgrsIoUbs9ik1hDC+OAtRXCh0KJkb6TGCf3FqEKTG4hYQWe10rMGUAbzakbAMWsoIca5 uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccj2deqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 09:31:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F077100034;
        Fri, 30 Oct 2020 09:31:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 335AD25BD99;
        Fri, 30 Oct 2020 09:31:26 +0100 (CET)
Received: from [10.48.0.224] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 09:31:25 +0100
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: fix broken ECC
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1603989492-6670-1-git-send-email-christophe.kerello@st.com>
 <20201030091905.111aa7a4@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <d3073938-e714-6b5d-1dc9-36887b11de46@st.com>
Date:   Fri, 30 Oct 2020 09:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201030091905.111aa7a4@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 10/30/20 9:19 AM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Thu, 29 Oct
> 2020 17:38:12 +0100:
> 
>> Since commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user
>> input parsing bits"), ECC are broken in FMC2 driver in case of
>> nand-ecc-step-size and nand-ecc-strength are not set in the device tree.
>> The default user configuration set in FMC2 driver is lost when
>> rawnand_dt_init function is called. To avoid to lose the default user
>> configuration, it is needed to move it in the new user_conf structure.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> Fixes: d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input parsing bits")
>> ---
>>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> index b31a581..dc86ac9 100644
>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> @@ -1846,6 +1846,7 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>>   	struct resource *res;
>>   	struct mtd_info *mtd;
>>   	struct nand_chip *chip;
>> +	struct nand_device *nanddev;
>>   	struct resource cres;
>>   	int chip_cs, mem_region, ret, irq;
>>   	int start_region = 0;
>> @@ -1952,10 +1953,11 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>>   	chip->options |= NAND_BUSWIDTH_AUTO | NAND_NO_SUBPAGE_WRITE |
>>   			 NAND_USES_DMA;
>>   
>> -	/* Default ECC settings */
>> +	/* Default ECC user settings */
>>   	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
>> -	chip->ecc.size = FMC2_ECC_STEP_SIZE;
>> -	chip->ecc.strength = FMC2_ECC_BCH8;
>> +	nanddev = mtd_to_nanddev(mtd);
>> +	nanddev->ecc.user_conf.step_size = FMC2_ECC_STEP_SIZE;
>> +	nanddev->ecc.user_conf.strength = FMC2_ECC_BCH8;
>>   
>>   	/* Scan to find existence of the device */
>>   	ret = nand_scan(chip, nand->ncs);
> 
> Sorry for breaking the driver with this change, but now I think we
> should have all ECC related bits in ->attach() instead of ->probe().
> The ->attach() hook is called during the nand_scan() operation and at
> this point the chip's requirements/layout are known (not before). I
> know that certain controllers don't really care about that, here your
> simply hardcode these two fields and you don't need to know anything
> about the chip's properties. But as a bid to harmonize all drivers with
> the target of a generic ECC engine in mind, I think it's now time to
> move these three lines (chip->ecc.* = ...) at the top of ->attach().
> Also, these fields should have been populated by the core so perhaps
> the best approach is to check if the user requirements are synced with
> the controller's capabilities and error out otherwise?
> 
> We plan to send a fixes PR for -rc2, if the v2 arrives today I'll
> integrate it.

Ok. Issue is that the controller is initialized when 
stm32_fmc2_nfc_select_chip is called. This function will be called 
before the ->attach() hook, when the first command will be sent to the 
NAND device (reset command). So, moving the default ECC initialization
needs probably more modifications in the driver.
I will try to send a v2 today.

Regards,
Christophe Kerello.

> 
> Thanks,
> Miquèl
> 
