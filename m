Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A592C21D1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgKXJjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:39:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60168 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgKXJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:39:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AO9dMKr102139;
        Tue, 24 Nov 2020 03:39:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606210762;
        bh=/UZqV0080zJ5hCt/MnjxSlJyTTwEADKbUBDSNEH9IAA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GK2Z1qn9A4QjTNtkh1EuMuIv9d1b40cJR8S9+R5ire2qR8swMI92C9nPqbEjSQftp
         3NHajRxYhNxQ06HK4nPKZrIbKaUjdnoGOzROo9fY8kermyKrbMmtyXbaSM0RGlf/ai
         jO6ZLRr7WZTGZAnn2fAjHf79cOF05340LRN2nsZs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AO9dLYL027179
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:39:21 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 24
 Nov 2020 03:39:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 24 Nov 2020 03:39:21 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AO9dJUE112679;
        Tue, 24 Nov 2020 03:39:20 -0600
Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
To:     Peter Chen <peter.chen@nxp.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
Date:   Tue, 24 Nov 2020 11:39:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201124064242.GA32310@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 24/11/2020 08:43, Peter Chen wrote:
> On 20-11-23 13:50:51, Roger Quadros wrote:
>> This reverts commit 50642709f6590fe40afa6d22c32f23f5b842aed5.
>>
>> This commit breaks hardware based role switching on TI platforms.
>> cdns->role_sw is always going to be non-zero as it is a pointer
>> to the usb_role_switch instance. Some other means needs to be used
>> if hardware based role switching is not required by the platform.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/cdns3/core.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index a0f73d4711ae..4c1445cf2ad0 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -280,10 +280,6 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
>>   	enum usb_role real_role, current_role;
>>   	int ret = 0;
>>   
>> -	/* Depends on role switch class */
>> -	if (cdns->role_sw)
>> -		return 0;
>> -
>>   	pm_runtime_get_sync(cdns->dev);
>>   
>>   	current_role = cdns->role;
>> -- 
> 
> Hi Roger,
> 
> I am sorry about that. Do you use role switch /sys entry, if you have
> used, I prefer using "usb-role-switch" property at dts to judge if
> SoC OTG signals or external signals for role switch. If you have not
> used it, I prefer only setting cdns->role_sw for role switch use cases.
> 

We use both hardware role switch and /sys entries for manually forcing
a certain role.

We do not set any "usb-role-switch" property at DTS.

Currently cdns->role_sw is being always set by driver irrespective of
any DT property, so this patch is clearly wrong and needs to be reverted.

What do you think?

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
