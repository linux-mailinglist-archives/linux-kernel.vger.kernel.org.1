Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB3275494
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:32:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53724 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726359AbgIWJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:32:04 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08N9RfZF025147;
        Wed, 23 Sep 2020 11:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=lzbFRFsz/R6jt9tD1gxmeXbe10XEpYjyF4q6GDF0eY8=;
 b=HKRLjl+N+kCvWIU+T8HEO7D2PQY4QJBEjKqWVe5uagmlRjLoAeZJSpJjvSdsU4rwHWEy
 UZCY02zB8HxV5loJRqnUzLBXK98D+Mk4uzbkMdfPJHLaQ0mVqhGmE2HsMgZzEgTgIMf5
 rhRB+OAXurla8GpssLSBR5Ag/2UURowVc5xjZiyiJ2V1Bm9lW88i97I3yveMvAft2O5q
 wam7e2SszUnMHl9olK7KowhNixT0PUDAR7v4sAw4Rm0bNc2HVvD1Sp+6EyrSouI3lRTf
 BJD1T0gyvI4vEU3FiOw3/Jl61qPenABA41LE0/rUrWPVu6fL8kx9I6tegp1IoD/zmots 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n8vewct2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 11:31:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C692910002A;
        Wed, 23 Sep 2020 11:31:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D01B22A5612;
        Wed, 23 Sep 2020 11:31:39 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 11:31:17 +0200
Subject: Re: [RESEND PATCH v2 1/6] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Jun Li <lijun.kernel@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200902075707.9052-1-amelie.delaunay@st.com>
 <20200902075707.9052-2-amelie.delaunay@st.com>
 <CAKgpwJWPWFF_yWC0N_7qPONpWCN8U8tKVJ5Ctr1DGqXd_FyWkA@mail.gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <31ee8d7c-00b0-0ae1-eea1-e245f215c586@st.com>
Date:   Wed, 23 Sep 2020 11:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKgpwJWPWFF_yWC0N_7qPONpWCN8U8tKVJ5Ctr1DGqXd_FyWkA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_03:2020-09-23,2020-09-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/20 11:08 AM, Jun Li wrote:
> Amelie Delaunay <amelie.delaunay@st.com> 于2020年9月2日周三 下午4:01写道：
>>
>> Power operation mode may depends on hardware design, so, add the optional
>> property power-opmode for usb-c connector to select the power operation
>> mode capability.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>> Changes in v2:
>> - Add description for possible operation current values
>> ---
>>   .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 9bd52e63c935..2fd85b9a7e1a 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -88,6 +88,26 @@ properties:
>>         - device
>>         - dual
>>
>> +  power-opmode:
>> +    description: Determines the power operation mode that the Type C connector
>> +      will support and will advertise through CC pins.
>> +      - "default" corresponds to default USB voltage and current defined by the
>> +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
>> +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
>> +        operation respectively.
>> +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
>> +        Type-C Cable and Connector specification, when Power Delivery is not
>> +        supported.
>> +      - "usb_power_delivery" when Power Delivery is supported, as defined in
>> +        USB Power Delivery specification.
> 
> Why need "usb_power_delivery"? isn't this information can be implied by
> existing properties like if "source-pdos" is present?
> 

power-opmode is an optional property.
usb_power_delivery, as 3.0A, 1.5A or default here, only reflect the 
possible power operation mode you can set and that are understood by 
typec class:
static const char * const typec_pwr_opmodes[] = {
	[TYPEC_PWR_MODE_USB]	= "default",
	[TYPEC_PWR_MODE_1_5A]	= "1.5A",
	[TYPEC_PWR_MODE_3_0A]	= "3.0A",
	[TYPEC_PWR_MODE_PD]	= "usb_power_delivery",
};

But I guess that a Type-C controller with usb power delivery support 
won't use power-opmode property but rather source/sink-pdos.

power-opmode shows what will be advertised through CC pins. I can remove 
usb_power_delivery from the possible values, but what about the user who 
will add power-opmode property to configure his Type-C controller with 
USB power delivery support (sink and/or source by the way) ?
Should I restrict the use of power-opmode to non-USB power delivery 
Type-C controllers ?
Please advise.

Regards,
Amelie


> Li Jun
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#definitions/string
>> +    enum:
>> +      - default
>> +      - 1.5A
>> +      - 3.0A
>> +      - usb_power_delivery
>> +
>>     # The following are optional properties for "usb-c-connector" with power
>>     # delivery support.
>>     source-pdos:
>> --
>> 2.17.1
>>
