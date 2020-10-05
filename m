Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3630228325D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgJEInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:43:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:43:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0958hkYP109357;
        Mon, 5 Oct 2020 03:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601887426;
        bh=jh2QqHXOSUrPqqdK3EFgzaPuY0jrTqqLV5rHJjNjmRY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B6BDyc8vJjyb8GNjzr31mCJA1+vccXTdL7nqH2NwDJHCjttOJj5F+nPscTbTMx1pJ
         lQ6yRkRqEZrt6DxKGBxDk0YM94tdzWws+V0NENL45vp6FpUg5ivSKS6RJDExrD6FTo
         l+PLG2AWXCjPsz7O156Jw6fVCXsnjxhs+ZuOFc8k=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0958hkxH100441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 03:43:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 03:43:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 03:43:46 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0958hh6p067311;
        Mon, 5 Oct 2020 03:43:44 -0500
Subject: Re: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
To:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.org" <peter.chen@nxp.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
References: <20200930065758.23740-1-pawell@cadence.com>
 <722fa58e-604b-bc34-d404-caf7939bb176@ti.com>
 <DM6PR07MB5529095F1B656C5065CBA8B4DD310@DM6PR07MB5529.namprd07.prod.outlook.com>
 <b73f6bb7-8e5e-d5f9-5adf-f6b10bdb5fb6@ti.com>
 <DM6PR07MB55297B8671A649E8AED7231FDD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5ca1fdf6-fd91-a223-92cc-a771ffa3c068@ti.com>
Date:   Mon, 5 Oct 2020 11:43:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB55297B8671A649E8AED7231FDD0C0@DM6PR07MB5529.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 05/10/2020 08:54, Pawel Laszczak wrote:
> Roger,
>>
>> Pawel,
>>
>> On 02/10/2020 12:08, Pawel Laszczak wrote:
>>> Roger,
>>>
>>>>
>>>> On 30/09/2020 09:57, Pawel Laszczak wrote:
>>>>> To avoid duplicate error information patch replaces platform_get_irq_byname
>>>>> into platform_get_irq_byname_optional.
>>>>
>>>> What is duplicate error information?
>>>
>>> The function platform_get_irq_byname print:
>>> " dev_err(&dev->dev, "IRQ %s not found\n", name);" if error occurred.
>>>
>>> In core.c we have the another error message below invoking this function.
>>> e.g
>>> 	if (cdns->dev_irq < 0)
>>> 		dev_err(dev, "couldn't get peripheral irq\n");
>>>
>>> So, it's looks like one dev_err is  redundant.
>>
>> If we want all 3 IRQs to be valid irrespective of dr_mode then we should
>> use platform_get_irq_byname() and error out in probe if (ret < 0 && ret != -EPROBE_DEFER).
>>
>> We can get rid of the irq check and duplicate error message in other places.
> 
> To be sure we understand each other correctly.
> 
> Are You suggesting  to leave the  platform_get_irq_byname()
> and rid of from core.c the following lines :
> 
> if (cdns->dev_irq < 0)
> 	dev_err(dev, "couldn't get peripheral irq\n");
> 	
> and
> 
> dev_err(dev, "couldn't get otg irq\n");
> ?

Yes.

> 
> A word of explanation why this patch has been sent.
> During reviewing the cdnsp driver Chunfeng Yun add such comment:
> 
> "
>> +	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
>> +	if (cdns->dev_irq == -EPROBE_DEFER)
>> +		return cdns->dev_irq;
>> +
>> +	if (cdns->dev_irq < 0)
>> +		dev_err(dev, "couldn't get peripheral irq\n");
> Use platform_get_irq_byname_optional? otherwise no need print this log,
> platform_get_irq_byname() will print it.
> "
> 
> In this patch I've chosen the platform_get_irq_byname_optional because both
> function do the same but the error message from core.c tell us little more then
> generic message from platform_get_irq_byname.

Using platform_get_irq_byname_optional() says driver expects it is optional but
only to fail later. It will be confusing to new reader that's all. I leave it to
you to decide what approach to take.

cheers,
-roger

>>
>>>
>>>>
>>>>>
>>>>> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
>>>>>
>>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>>> ---
>>>>>     drivers/usb/cdns3/core.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>>> index a0f73d4711ae..a3f6dc44cf3a 100644
>>>>> --- a/drivers/usb/cdns3/core.c
>>>>> +++ b/drivers/usb/cdns3/core.c
>>>>> @@ -465,7 +465,7 @@ static int cdns3_probe(struct platform_device *pdev)
>>>>>
>>>>>     	cdns->xhci_res[1] = *res;
>>>>>
>>>>> -	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
>>>>> +	cdns->dev_irq = platform_get_irq_byname_optional(pdev, "peripheral");
>>>>
>>>> As per DT binding document, these are mandatory properties
>>>
>>> I think that name platform_get_irq_byname_optional is little confusing.
>>> Function descriptions show that both are almost identical:
>>> /**
>>>    * platform_get_irq_byname_optional - get an optional IRQ for a device by name
>>>    * @dev: platform device
>>>    * @name: IRQ name
>>>    *
>>>    * Get an optional IRQ by name like platform_get_irq_byname(). Except that it
>>>    * does not print an error message if an IRQ can not be obtained.
>>>    *
>>>    * Return: non-zero IRQ number on success, negative error number on failure.
>>>    */
>>>
>>>>
>>>>    - interrupts: Interrupts used by cdns3 controller:
>>>>           "host" - interrupt used by XHCI driver.
>>>>           "peripheral" - interrupt used by device driver
>>>>           "otg" - interrupt used by DRD/OTG  part of driver
>>>>
>>>> for dr_mode == "otg" -> all 3 are mandatory.
>>>> for dr_mode == "host" -> "otg" and "peripheral" IRQs are not required.
>>>> for dr_mode == "periphearal" -> "otg" and "host" IRQs are not required.
>>>>
>>>>>     	if (cdns->dev_irq == -EPROBE_DEFER)
>>>>>     		return cdns->dev_irq;
>>>>>
>>>>> @@ -477,7 +477,7 @@ static int cdns3_probe(struct platform_device *pdev)
>>>>>     		return PTR_ERR(regs);
>>>>>     	cdns->dev_regs	= regs;
>>>>>
>>>>> -	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
>>>>> +	cdns->otg_irq = platform_get_irq_byname_optional(pdev, "otg");
>>>>>     	if (cdns->otg_irq == -EPROBE_DEFER)
>>>>>     		return cdns->otg_irq;
>>>>>
>>>>>
>>>>
>>>
>>> Regards,
>>> Pawel
>>>
>>
>> --
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
