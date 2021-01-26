Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2F303BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405161AbhAZL3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:29:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21544 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731022AbhAZJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:50:29 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q9WvNK027767;
        Tue, 26 Jan 2021 10:49:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=jc22SqmdYibgtAaJq3omeHgrRDIC9ZnXdKisEe+EuSc=;
 b=EWr7NECmAp0pEZ7oHXJO+C8QvdWfHvPmVLkH3Og0PUxq69dszHgi9j8JctB84suqYLYL
 SDDL5PLSFiHvzz/C80My3uBiZ/MkGsmmYgdvAPzlMr7fNOKykVNnvguF78Daae1Zw/G1
 GggsRmb2V9sZMQc/7dSbLlqIthkTV4ZfYY/2DIgJmVpW5snbHUC42fF0qzGUT65B3gHF
 z4PXfeFnxNVByH8vjDplOoPZ70R5cQVYnOPNDSeJal8rtcZ61SmojYmgc3E1kdOJ4X2R
 aC3TaGDOzCSlZLgeCQ5us87ypr4sZD6S2t5ZHpQ4mBIwDKVyxe9rnciu3itCskmJhOcy YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3689tdrb4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:49:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1464910002A;
        Tue, 26 Jan 2021 10:49:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 012E3230361;
        Tue, 26 Jan 2021 10:49:33 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan
 2021 10:49:32 +0100
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: phy-stm32-usbphyc: add
 #clock-cells required property
To:     Rob Herring <robh@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210114171314.18946-1-amelie.delaunay@foss.st.com>
 <20210114171314.18946-2-amelie.delaunay@foss.st.com>
 <20210125214042.GA1049362@robh.at.kernel.org>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <be0f4e5f-3e7d-d178-160b-ea90e9e00147@foss.st.com>
Date:   Tue, 26 Jan 2021 10:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125214042.GA1049362@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/25/21 10:40 PM, Rob Herring wrote:
> On Thu, Jan 14, 2021 at 06:13:13PM +0100, Amelie Delaunay wrote:
>> usbphyc provides a unique clock called ck_usbo_48m.
>> STM32 USB OTG needs a 48Mhz clock (utmifs_clk48) for Full-Speed operation.
>> ck_usbo_48m is a possible parent clock for USB OTG 48Mhz clock.
>>
>> ck_usbo_48m is available as soon as the PLL is enabled.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>> No change in v2.
>> ---
>>   .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml          | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
>> index 46df6786727a..4e4da64b8e01 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
>> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
>> @@ -51,6 +51,10 @@ properties:
>>     vdda1v8-supply:
>>       description: regulator providing 1V8 power supply to the PLL block
>>   
>> +  '#clock-cells':
>> +    description: number of clock cells for ck_usbo_48m consumer
>> +    const: 0
>> +
>>   #Required child nodes:
>>   
>>   patternProperties:
>> @@ -102,6 +106,7 @@ required:
>>     - "#size-cells"
>>     - vdda1v1-supply
>>     - vdda1v8-supply
>> +  - '#clock-cells'
> 
> You can't really make new properties required as it's not backwards
> compatible. If things can never work without or the binding has never
> been used, then you can. You just need to spell this out in the commit
> msg.
> 

In fact things can work without this property. But I made this new 
property required because in clock-bindings, #clock-cells property is a 
required property for clock providers.

phy-stm32-usbphyc bindings are only used in stm32mp151.dtsi, which will 
be updated with this new property as soon as this bindings will be reviewed.

I can remove this new property from required ones, but is it okay as 
#clock-cells property is a required property for clock providers?

Regards,
Amelie

>>     - usb-phy@0
>>     - usb-phy@1
>>   
>> @@ -120,6 +125,7 @@ examples:
>>           vdda1v8-supply = <&reg18>;
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>> +        #clock-cells = <0>;
>>   
>>           usbphyc_port0: usb-phy@0 {
>>               reg = <0>;
>> -- 
>> 2.17.1
>>
