Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4C2C230A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgKXKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:33:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43532 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgKXKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:33:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AOAXatm121466;
        Tue, 24 Nov 2020 04:33:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606214016;
        bh=9AEDAE4WyMCBvQI/H5/7oqzxWZDAmTCoLvPZoTUtAqE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lQVHPyZQkHQXDtfu+LwWjOPox7oT11le7tlm+OWIB/FSe4COMLNWkEoO2yr0vM6f/
         PivvWJjXj3PDFNcK1/VfOwVu1VOBELaqxSvdutUWACo7iVjDJN2gAay1zDJWQRtGpg
         xHZ4Luxu0j6mTwYiZHCKEdMQbA1u7NWRtpl8FROs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AOAXasU113484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 04:33:36 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 24
 Nov 2020 04:33:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 24 Nov 2020 04:33:36 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AOAXY9V027465;
        Tue, 24 Nov 2020 04:33:35 -0600
Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
To:     Peter Chen <peter.chen@nxp.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
 <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
 <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
Date:   Tue, 24 Nov 2020 12:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Heikki

Peter,

On 24/11/2020 11:57, Peter Chen wrote:
> 
> 
> 
> Best regards,
> Peter Chen
> 
>> -----Original Message-----
>> From: Roger Quadros <rogerq@ti.com>
>> Sent: 2020年11月24日 17:39
>> To: Peter Chen <peter.chen@nxp.com>
>> Cc: pawell@cadence.com; gregkh@linuxfoundation.org; balbi@kernel.org;
>> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch class"
>>
>> Peter,
>>
>> On 24/11/2020 08:43, Peter Chen wrote:
>>> On 20-11-23 13:50:51, Roger Quadros wrote:
>>>> This reverts commit 50642709f6590fe40afa6d22c32f23f5b842aed5.
>>>>
>>>> This commit breaks hardware based role switching on TI platforms.
>>>> cdns->role_sw is always going to be non-zero as it is a pointer
>>>> to the usb_role_switch instance. Some other means needs to be used if
>>>> hardware based role switching is not required by the platform.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>    drivers/usb/cdns3/core.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index a0f73d4711ae..4c1445cf2ad0 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -280,10 +280,6 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
>>>>    	enum usb_role real_role, current_role;
>>>>    	int ret = 0;
>>>>
>>>> -	/* Depends on role switch class */
>>>> -	if (cdns->role_sw)
>>>> -		return 0;
>>>> -
>>>>    	pm_runtime_get_sync(cdns->dev);
>>>>
>>>>    	current_role = cdns->role;
>>>> --
>>>
>>> Hi Roger,
>>>
>>> I am sorry about that. Do you use role switch /sys entry, if you have
>>> used, I prefer using "usb-role-switch" property at dts to judge if SoC
>>> OTG signals or external signals for role switch. If you have not used
>>> it, I prefer only setting cdns->role_sw for role switch use cases.
>>>
>>
>> We use both hardware role switch and /sys entries for manually forcing a
>> certain role.
>>
>> We do not set any "usb-role-switch" property at DTS.
>>
>> Currently cdns->role_sw is being always set by driver irrespective of any DT
>> property, so this patch is clearly wrong and needs to be reverted.
>>
>> What do you think?
>>
> 
> Could you accept below fix?
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 2e469139769f..fdd52e87a7b2 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -280,8 +280,8 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
>          enum usb_role real_role, current_role;
>          int ret = 0;
> 
> -       /* Depends on role switch class */
> -       if (cdns->role_sw)
> +       /* quit if switch role through external signals */
> +       if (device_property_read_bool(cdns->dev, "usb-role-switch"))
>                  return 0;
> 
>          pm_runtime_get_sync(cdns->dev);

Although this will fix the issue I don't think this is making the driver to behave
as expected with usb-role-switch property.

Now, even if usb-role-switch property is not present the driver will still register
the role switch driver.

I think we need to register the role switch driver only if usb-role-switch property
is present. We would also need to set the default role if role-switch-default-mode is present.

How about the following? It still doesn't handle role-switch-default-mode property though.


diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4c1445cf2ad0..986b56a9940c 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -532,11 +532,13 @@ static int cdns3_probe(struct platform_device *pdev)
  	if (device_property_read_bool(dev, "usb-role-switch"))
  		sw_desc.fwnode = dev->fwnode;
  
-	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
-	if (IS_ERR(cdns->role_sw)) {
-		ret = PTR_ERR(cdns->role_sw);
-		dev_warn(dev, "Unable to register Role Switch\n");
-		goto err3;
+	if (device_property_read_bool(cdns->dev, "usb-role-switch")) {
+		cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
+		if (IS_ERR(cdns->role_sw)) {
+			ret = PTR_ERR(cdns->role_sw);
+			dev_warn(dev, "Unable to register Role Switch\n");
+			goto err3;
+		}
  	}
  
  	if (cdns->wakeup_irq) {



cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
