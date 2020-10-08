Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71324286F67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgJHH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:29:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46432 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:29:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0987ThGe055125;
        Thu, 8 Oct 2020 02:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602142183;
        bh=0fJP+PjiMjaHur0vYWV+WdV/MjQ3t6LWtmw89pujeog=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VjUejw/FNINArgmkrPMZaGBvN+Jr2FTp/BG0ltrftx4XDh6ULdu/E8VshoGzfpOZ5
         i5BJdhNeFV5DOKiCajZK1xvXEv50MOVMuolDx/GEJWYj28zM8bQD2yQ6DMrsAtZIWN
         VjaFuDkPiQFj2u0FII84rukeF/VxUg5jE4byemYU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0987ThLv126887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 02:29:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 02:29:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 02:29:43 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0987TfRt088630;
        Thu, 8 Oct 2020 02:29:41 -0500
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIHVzYjogY2RuczM6IFZhcmlhYmxlIOKAmGxl?=
 =?UTF-8?Q?ngth=e2=80=99_set_but_not_used?=
To:     Pawel Laszczak <pawell@cadence.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
References: <20201007033932.23050-1-pawell@cadence.com>
 <8994106d-2cc5-fa2c-bbcc-6526632ff80b@ti.com>
 <18bf46b7-d86a-fbf0-9ce7-c2d0765758f1@gmail.com>
 <DM6PR07MB552984371C356A6E31D8D116DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d88c92c7-acc6-df22-09e2-f5ddfba1d76b@ti.com>
Date:   Thu, 8 Oct 2020 10:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB552984371C356A6E31D8D116DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 08/10/2020 06:57, Pawel Laszczak wrote:
> Siergei,
> 
>>
>> On 10/7/20 11:15 AM, Roger Quadros wrote:
>>
>> [...]
>>>> Patch removes not used variable 'length' from
>>>> cdns3_wa2_descmiss_copy_data function.
>>>>
>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>
>>> Fixes: commit 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")
>>
>>    No "commit" is needed here.
> 
> Can you explain why?
> 
> I guess it's because commit 141e70fef4ee is quite new and it's not yet included in any stable kernel version,
> or because it's only warning - not error.
> 
> Am I right ?

Siergei meant that the word "commit" should not be used. So it should be

Fixes: 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")

cheers,
-roger

> 
>>
>>> Acked-by: Roger Quadros <rogerq@ti.com>
>> [...]
>>
> 
> Regards,
> Pawel
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
