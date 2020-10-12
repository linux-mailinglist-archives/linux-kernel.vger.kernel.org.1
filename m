Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86FF28B3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbgJLLi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:38:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58886 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgJLLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:38:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CBcJPg040157;
        Mon, 12 Oct 2020 06:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602502699;
        bh=IC1jfenlq2VH0Nfofi/gmk0bHsF62afORY5btOBjxrM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HJLOwR2RDPKeFDsqOPw55RVVpgaSa4hGVczSu2Jc3Ppkd8XTZAJztUYV9T9FSm5yw
         D0opAW/Dy3nc1wtxf2E8U2WyP2J6v+QtzDuOIsOUdMn+HzBVNPpYDjf3JI+CrJnv8D
         dshZ735PZXc0CJhUaIIS6NelVEXQ4f4x7HvS92ZI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CBcIND127143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 06:38:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 06:38:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 06:38:18 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CBcGeT068432;
        Mon, 12 Oct 2020 06:38:17 -0500
Subject: Re: [PATCH v2] usb: cdns3: Rids of duplicate error message
To:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
References: <20201012064256.8344-1-pawell@cadence.com>
 <e5ab2110-6bb0-ce06-be4f-010a030e307f@ti.com>
 <DM6PR07MB5529E8B3EC059F7DA43EEC25DD070@DM6PR07MB5529.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <ab93c402-f721-d780-654b-7b74bc5b2ab1@ti.com>
Date:   Mon, 12 Oct 2020 14:38:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB5529E8B3EC059F7DA43EEC25DD070@DM6PR07MB5529.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 12/10/2020 14:12, Pawel Laszczak wrote:
> Hi Roger,
> 
> On 12/10/2020 09:42, Pawel Laszczak wrote:
>> On failure, the platform_get_irq_byname prints an error message
>> so, patch removes error message related to this function from
>> core.c file.
>>
>> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>> Changelog:
>> v2
>> - simplified code as sugested by Roger Quadros.
>>
>>    drivers/usb/cdns3/core.c | 10 +---------
>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index a0f73d4711ae..85ef3025b293 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -469,22 +469,14 @@ static int cdns3_probe(struct platform_device *pdev)
>>    	if (cdns->dev_irq == -EPROBE_DEFER)
> 
> Shouldn't this be
> 	if (cdns->dev_irq < 0)
> ?
> 
> No, such line will change the original behavior of driver.
> 
> Current patch allows to run driver when we support only host.
> In such case the dev_irq can be < 0 and we still can use host  side.

In that case should we check if we need dev_irq and if so then error out.
i.e. if mode is "peripheral" or "otg"

Also DT binding document says all 3 IRQs are mandatory. Do we need to update that?

cheers,
-roger

> 
> Regards,
> Pawel Laszczak
> 
>>    		return cdns->dev_irq;
>>    
>> -	if (cdns->dev_irq < 0)
>> -		dev_err(dev, "couldn't get peripheral irq\n");
>> -
>>    	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
>>    	if (IS_ERR(regs))
>>    		return PTR_ERR(regs);
>>    	cdns->dev_regs	= regs;
>>    
>>    	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
>> -	if (cdns->otg_irq == -EPROBE_DEFER)
>> -		return cdns->otg_irq;
>> -
>> -	if (cdns->otg_irq < 0) {
>> -		dev_err(dev, "couldn't get otg irq\n");
>> +	if (cdns->otg_irq < 0)
>>    		return cdns->otg_irq;
>> -	}
>>    
>>    	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>>    	if (!res) {
>>
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
