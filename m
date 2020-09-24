Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8029F276DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIXJvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:51:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:51:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O9pcbj001598;
        Thu, 24 Sep 2020 04:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600941098;
        bh=ABf1wJk9pN6HyOKvz8iubl9Rlb0wrsJB4GHUiChsgdk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oCbtcEYTdXSxUbWbDAJab5mozeA4FTR6HYpDRQslKLwWqiboj9AIZwvPfi7rBUQVj
         wBw8Xp3ORPi7eIOrc4lV/IPQ3KRKNddBaKbMmCPpCwczMcgfJ2gSEqCooj+t9RDSPK
         xZLm5Bk4nVdHbowKUErforyLkd7g2wKcVwN/gkF4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O9pcJa076302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 04:51:38 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 04:51:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 04:51:38 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O9pZUP085506;
        Thu, 24 Sep 2020 04:51:36 -0500
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: cdns,usb3: Add
 cdns,phyrst-a-enable property
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>, <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200915114543.2599-1-rogerq@ti.com>
 <20200915114543.2599-3-rogerq@ti.com>
 <1b45d695-0874-69c7-8398-5d14033f0788@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <20b1126a-d328-ab79-2624-7ddece6b56b0@ti.com>
Date:   Thu, 24 Sep 2020 12:51:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1b45d695-0874-69c7-8398-5d14033f0788@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On 15/09/2020 19:15, Sergei Shtylyov wrote:
> Hello!
> 
> On 9/15/20 2:45 PM, Roger Quadros wrote:
> 
>> Controller version 0x0002450D has USB2 PHY RX sensitivity issues
>> that needs to be worked around by enabling phyrst-a-enable bit
>> in PHYRST_CFG register.
>>
>> There is no way to know controller version before device controller
>> is started and the workaround needs to be applied for both host and
>> device modes, so we add this DT property.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>> index 9b14c8443d39..ac20b98e9910 100644
>> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>> @@ -61,6 +61,10 @@ properties:
>>         buffers expressed in KB
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>   
>> +  cdns,phyrst-a-enable:
>> +    description: Enable resetting of PHY if Rx fail is detected
> 
>     Failure?

Actually the IP manual says "Reset PHY if Rx fail is detected".

So let's leave it like that.
> 
> [...]
> 
> MBR, Sergei
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
