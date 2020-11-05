Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0B2A8203
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgKEPSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:18:11 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730973AbgKEPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:18:11 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5FC054015665;
        Thu, 5 Nov 2020 16:17:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=6CQ7fh91CfjTVJ2jXisAjtxUWP6/xftaixySWIC6ubE=;
 b=hAP/dltXKJCmvCzKuf4+tbju0mz5azJADpxhctJs6A0HuSv2RJFDKZF7eO2irqeDeCpO
 pkh/dQXWtfiB1me8Iy7wKgOVb08TAuwcO6+pcpogcNnAZCDnjexlcHj6GI9Zv0rN8APJ
 lo5/g/Pl+Z5YCy6nRKYYN5ckMyyRAHG8eZMJZ/2XxArjWqH5ILFaIJEvdfx6RgZ1IC96
 ze1bWQpeOXM0CVkcDQ3TmOa/+rUABN5fFVElo72uv5cOnWB4OI5zvR0fYHaMe5tX5G5H
 DrT0Oc3MFQOaCn5JQfK5DsLAzIBPQnj8hlgD1vddQlaZHoZO7vHpqki6fw0GKzI65wby 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00epv8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 16:17:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4025510002A;
        Thu,  5 Nov 2020 16:17:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 238252ADA1B;
        Thu,  5 Nov 2020 16:17:44 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 16:17:42 +0100
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Jun Li <lijun.kernel@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com>
 <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
 <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
 <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com>
 <20201104210803.GA4115079@bogus>
 <2da804ff-3b3c-0ea9-14d5-a163b28ccc33@st.com>
 <CAKgpwJU_yTTYabeMYFBqNs_6=N7gaTAc1v-+fU-dshFUrL1qVA@mail.gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <05a69d4c-f78f-4f3f-ff8b-34e9dbe38519@st.com>
Date:   Thu, 5 Nov 2020 16:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKgpwJU_yTTYabeMYFBqNs_6=N7gaTAc1v-+fU-dshFUrL1qVA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_09:2020-11-05,2020-11-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/20 1:23 PM, Jun Li wrote:
> Amelie DELAUNAY <amelie.delaunay@st.com> 于2020年11月5日周四 下午7:36写道：
>>
>> On 11/4/20 10:08 PM, Rob Herring wrote:
>>> On Fri, Oct 30, 2020 at 04:27:14PM +0100, Amelie DELAUNAY wrote:
>>>>
>>>>
>>>> On 10/30/20 3:29 PM, Rob Herring wrote:
>>>>> On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/29/20 4:40 PM, Rob Herring wrote:
>>>>>>> On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
>>>>>>>> Power operation mode may depends on hardware design, so, add the optional
>>>>>>>> property power-opmode for usb-c connector to select the power operation
>>>>>>>> mode capability.
>>>>>>>>
>>>>>>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>>>>>>> ---
>>>>>>>>      .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
>>>>>>>>      1 file changed, 18 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>>>>>> index 728f82db073d..200d19c60fd5 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>>>>>> @@ -93,6 +93,24 @@ properties:
>>>>>>>>            - device
>>>>>>>>            - dual
>>>>>>>>
>>>>>>>> +  power-opmode:
>>>>>>>
>>>>>>> I've acked this version:
>>>>>>>
>>>>>>> https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
>>>>>>>
>>>>>>
>>>>>> frs is used for Fast Role Swap defined in USB PD spec.
>>>>>> I understand it allows to get the same information but I'm wondering why
>>>>>> the property name is limited to -frs- in this case. What about a
>>>>>> non-power delivery USB-C connector ?
>>>>>
>>>>> I've got no idea. The folks that know USB-C and PD details need to get
>>>>> together and work all this out. To me, it looks like the same thing...
>>>>>
>>>>
>>>> It looks but...
>>>>
>>>> The purpose of power-opmode property is to configure the USB-C controllers,
>>>> especially the non-PD USB-C controllers to determine the power operation
>>>> mode that the Type C connector will support and will advertise through CC
>>>> pins when it has no power delivery support, whatever the power role: Sink,
>>>> Source or Dual
>>>> The management of the property is the same that data-role and power-role
>>>> properties, and done by USB Type-C Connector Class.
>>>>
>>>> new-source-frs-typec-current specifies initial current capability of the new
>>>> source when vSafe5V is applied during PD3.0 Fast Role Swap. So here, this
>>>> property is not applied at usb-c controller configuration level, but during
>>>> PD Fast Role Swap, so when the Sink become the Source.
>>>> Moreover, the related driver code says FRS can only be supported by DRP
>>>> ports. So new-source-frs-typec-current property, in addition to being
>>>> specific to PD, is also dedicated to DRP usb-c controller.
>>>> The property is managed by Type-C Port Controller Manager for PD.
>>>
>>> But it's the same set of possible values, right? So we can align the
>>> values at least.
>>>
>>
>> USB Power Delivery FRS values are defined in
>> include/dt-bindings/usb/pd.h
> 
> I think this can be changed if both can be aligned.
> 
>> to fit with drivers/usb/typec/tcpm/tcpm.c
>> frs_typec_current enum.
>>
>> USB-C power operation mode values are defined in
>> include/linux/usb/typec.h with typec_pwr_opmode enum and matching with
>> string values of typec_pwr_opmodes tab.
>>
>> USB PD requires USB-C.
>> USB-C doesn't requires USB PD.
>>
>> drivers/usb/typec/tcpm/tcpm.c already used typec_pwr_opmode values.
>>
>> USB PD specification Table 6-14 Fixed Supply PDO says:
>> Fast Role Swap required USB Type-C Current (see also [USB Type-C 2.0]):
>> Value | Description
>>    00b  | Fast Swap not supported (default)
>>    01b  | Default USB Power
>>    10b  | 1.5A @ 5V
>>    11b  | 3.0A @ 5V
> 
> This is the value in PDO of sink, the FRS property value(or after translated)
> actually is used to compare with above value.
> 
> So I think both properties can share the same "value", maybe string
> like below
> 
>    10 static const char * const typec_pwr_opmodes[] = {
>    11         [TYPEC_PWR_MODE_USB]    = "default",
>    12         [TYPEC_PWR_MODE_1_5A]   = "1.5A",
>    13         [TYPEC_PWR_MODE_3_0A]   = "3.0A",
> 
>>
>> Note the *see also USB Type-C 2.0*.
>>
>> USB Type-C specification 4.6.2.1 USB Type-C Current says:
>> The USB Type-C connector uses CC pins for configuration including an
>> ability for a Source to advertise to its port partner (Sink) the amount
>> of current it shall supply:
>> • Default is the as-configured for high-power operation current value as
>> defined by the USB Specification (500 mA for USB 2.0 ports; 900 mA or
>> 1,500 mA for USB 3.2 ports in single-lane or dual-lane operation,
>> respectively)
>> • 1.5 A
>> • 3.0 A
>>
>>> Can we align the names in some way? power-opmode and frs-source-opmode
>>> or ??
> 
> how about typec-power-opmode and frs-new-source-opmode
> 

I agree with typec-power-opmode. And with string values. This way, 
typec_find_pwr_opmode is still usable to translate into TYPEC defines.

>>>
>>
>> I let USB PD specialists answer.
>>
>> *frs* property fits with USB PD specification, so with USB PD protocol.
>> *power-opmode fits with USB Type-C specification, so with USB-C hardware
>> support.
>>
>>> Are these 2 properties mutually exclusive?
> 
> I think yes.
> 
> thanks
> Li Jun
>>> If so, that should be
>>> captured.
>>
>> FRS is specific to products with Power Delivery Support.
>>
>> power-opmode is dedicated to products with USB-C connector support.
>>
>> Regards,
>> Amelie
