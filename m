Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1567286F5E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJHH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:28:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46216 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgJHH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:28:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0987SeVj054570;
        Thu, 8 Oct 2020 02:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602142120;
        bh=TnlrlKbewMkVZuA382S9y6byleO5jRxK/7J4sbxqipQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tIXBDULiwhffEZxq71QSDpDd20w0CcneZ4O/LHeerz4P2VJ8GNZy1hEKrF5w3AyX6
         7E3HX0O9fDHK4MqFp7NZBfYiGibSG8vjVRO3/SH9j2zGaWYLba1QSrS85xCFVJe/dY
         0nHCc/t9q81EFink7taPtxjOdDNEQqS3d7iZSSzY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0987SeHE072284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 02:28:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 02:28:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 02:28:40 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0987SNh1004528;
        Thu, 8 Oct 2020 02:28:23 -0500
Subject: Re: [PATCH 1/2] usb: cdns3: Rids of duplicate error message
To:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
References: <20201007033531.22526-1-pawell@cadence.com>
 <94ff37e9-8a32-b61b-5ede-1b71b6a3d4ab@ti.com>
 <DM6PR07MB55292BB3A7BC0A46EE2F5124DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6f551b23-befa-29f1-0e42-c2a97633a733@ti.com>
Date:   Thu, 8 Oct 2020 10:28:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB55292BB3A7BC0A46EE2F5124DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2020 07:18, Pawel Laszczak wrote:
> Hi Roger,
> 
>>
>> On 07/10/2020 06:35, Pawel Laszczak wrote:
>>> On failure, the platform_get_irq_byname prints an error message
>>> so, patch removes error message related to this function from
>>> core.c file.
>>>
>>> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>    drivers/usb/cdns3/core.c | 7 +------
>>>    1 file changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>> index a0f73d4711ae..4fd3c742d9d5 100644
>>> --- a/drivers/usb/cdns3/core.c
>>> +++ b/drivers/usb/cdns3/core.c
>>> @@ -469,9 +469,6 @@ static int cdns3_probe(struct platform_device *pdev)
>>>    	if (cdns->dev_irq == -EPROBE_DEFER)
>>
>> if (cdns->dev_irq < 0 && cdns->dev_irq == -EPROBE_DEFER)
> 
> It's the same - cdns->dev_irq == -EPROBE_DEFER < 0
> 
> 
>>>    		return cdns->dev_irq;
>>>
>>> -	if (cdns->dev_irq < 0)
>>> -		dev_err(dev, "couldn't get peripheral irq\n");
>>> -
>>>    	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
>>>    	if (IS_ERR(regs))
>>>    		return PTR_ERR(regs);
>>> @@ -481,10 +478,8 @@ static int cdns3_probe(struct platform_device *pdev)
>>>    	if (cdns->otg_irq == -EPROBE_DEFER)
>>
>> if (cdns->otg_irq < 0 && cdns->otg_irq == -EPROBE_DEFER)
> 
> It should be:
> if (cdns->dev_irq < 0 || cdns->dev_irq == -EPROBE_DEFER)
> or event
> if (cdns->dev_irq < 0)
> 
> Am I right ?

Yeah, at both places just

	if (cdns->dev_irq < 0)
		return cdns->dev_irq;

should be enough.

cheers,
-roger

> 
>>
>>>    		return cdns->otg_irq;
>>>
>>> -	if (cdns->otg_irq < 0) {
>>> -		dev_err(dev, "couldn't get otg irq\n");
>>> +	if (cdns->otg_irq < 0)
>>
>> you can then get rid of this if {}.
>>
>>>    		return cdns->otg_irq;
>>> -	}
>>>
>>>    	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>>>    	if (!res) {
>>>
> 
> Cheers,
> Pawell
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
