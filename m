Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCAF2AC04D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgKIPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:55:11 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:64288 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729445AbgKIPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:55:11 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Fkdt6032585;
        Mon, 9 Nov 2020 16:54:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=UBGo5D2wKRwZPFXsITIZTn6DFn/APPci5EP/rirzjqc=;
 b=J9K8BqLjt5FzSEbfXkVSs+P046W5I2QQZI+Utl1BTaCkgsaGBrV4VkyjNnNHyrCadrWp
 hKYCPrca47AIE4qRAHuPg/aFg+ve/12zC+zGaSW4m5zky3sHzV0TorCtxdLFjBVNBzNP
 Xfu4JDrxLsSM9F2t3oyXbuQUUG0Dim+ApvP/k9PjGxmYKkXGJNSg7KUaapwnOAlY+TCv
 iz9DBemlzLrai6E7KDPTfJCfPLmlWs6F8XhF73Nq/xdqtABINi9kidS6S8cMdTnjoLFe
 FkHaZbxnJraXF0QQT3VDiMqoHe1GOJI0cUS6ddS4NLFsRKAXhiDJ+BgpMFAHfiFnZ2RW HQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nj80jvyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 16:54:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4C4E10002A;
        Mon,  9 Nov 2020 16:54:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BBD1322D74A;
        Mon,  9 Nov 2020 16:54:44 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 16:54:43 +0100
Subject: Re: [PATCH v5 1/5] dt-bindings: connector: add typec-power-opmode
 property to usb-connector
To:     Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-2-amelie.delaunay@st.com>
 <CAL_Jsq+A=nixpdrT3Omq7Osat=_Egb5g6VGao=gY4CEssOe+xQ@mail.gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <a0e0bde1-5657-c0f9-9123-6b1dd5a1bd73@st.com>
Date:   Mon, 9 Nov 2020 16:54:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+A=nixpdrT3Omq7Osat=_Egb5g6VGao=gY4CEssOe+xQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_08:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 4:03 PM, Rob Herring wrote:
> On Fri, Nov 6, 2020 at 10:58 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
>>
>> Power operation mode may depends on hardware design, so, add the optional
>> property typec-power-opmode for usb-c connector to select the power
>> operation mode capability.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>> Hi Bahdri, Rob,
>>
>> I've added the exlusion with FRS property, but new FRS property name
>> should be use here so, be careful.
>>
>> ---
>>   .../bindings/connector/usb-connector.yaml     | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 62781518aefc..a84464b3e1f2 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -93,6 +93,24 @@ properties:
>>         - device
>>         - dual
>>
>> +  typec-power-opmode:
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
> 
> Use the enums here. Unless you want to define it as actual current as
> a numerical value.

If I understand your point correctly, I think I should remove allOf here 
and stick with what is done to describe power-role and data-role 
property. Right ?

Regards,
Amelie
> 
> Rob
> 
