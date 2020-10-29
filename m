Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486A29F22E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgJ2QvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:51:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46160 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728095AbgJ2QvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:51:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TGh2EC008652;
        Thu, 29 Oct 2020 17:49:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Mob56LhM6sAkz2L2wk6dZEKkVhrLDQUMsyRzFNsv3XU=;
 b=Skm6nkKPBAs+smcvx0P8Tmd5pCuSHb1FmyROzy1YgE2+dk3dT5s9HOWvo8Txdo2xdXgo
 Nu4qmKN4hT4PwSmPfUcH4KtGQJzvHVHAX5qBwROuPsGI/avcmwiW5LUqk5I5+dFn8a9J
 xH4Oa7k1GAhiZ+oRdnxrRL1T++MrGg/9spMBop3xZCvgL/uxSO1DMkSWYnGSHpnseWPU
 Gd0ba3GoUjn4QKUAlSAcJZ8Q/Fbk89X152ai9FX11AYDGiEM/qhARf0VdRtxi99MW+Wk
 +sPrMRtRSghB4fnP1Hz2DfdqOyj3ZNDgUqSlLg6o3oFx/Hik4oKQzLyJJGlTNaYoJ2Wq Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccffthgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 17:49:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9CC4210002A;
        Thu, 29 Oct 2020 17:49:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F215F22AE30;
        Thu, 29 Oct 2020 17:49:34 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 17:49:33 +0100
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com>
 <20201029154016.GA1917373@bogus>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
Date:   Thu, 29 Oct 2020 17:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029154016.GA1917373@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_10:2020-10-29,2020-10-29 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/20 4:40 PM, Rob Herring wrote:
> On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
>> Power operation mode may depends on hardware design, so, add the optional
>> property power-opmode for usb-c connector to select the power operation
>> mode capability.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 728f82db073d..200d19c60fd5 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -93,6 +93,24 @@ properties:
>>         - device
>>         - dual
>>   
>> +  power-opmode:
> 
> I've acked this version:
> 
> https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
>

frs is used for Fast Role Swap defined in USB PD spec.
I understand it allows to get the same information but I'm wondering why 
the property name is limited to -frs- in this case. What about a 
non-power delivery USB-C connector ?

Moreover, power-opmode property support is already merged in typec class:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/typec/class.c?h=v5.10-rc1&id=12f3467b0d28369d3add7a0deb65fdac9b503c90
and stusb160x driver uses it :(

So, do I need to modify stusb160x driver (and bindings) to take into 
account this USB PD specific property?

Regards,
Amelie

> Please ack it if you are okay with it.
> 
> Rob
> 
> 
>> +    description: Determines the power operation mode that the Type C connector
>> +      will support and will advertise through CC pins when it has no power
>> +      delivery support.
>> +      - "default" corresponds to default USB voltage and current defined by the
>> +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
>> +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
>> +        operation respectively.
>> +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
>> +        Type-C Cable and Connector specification, when Power Delivery is not
>> +        supported.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#definitions/string
>> +    enum:
>> +      - default
>> +      - 1.5A
>> +      - 3.0A
>> +
>>     # The following are optional properties for "usb-c-connector" with power
>>     # delivery support.
>>     source-pdos:
>> -- 
>> 2.17.1
>>
