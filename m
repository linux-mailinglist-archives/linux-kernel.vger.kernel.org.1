Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4E2A09D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgJ3P1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:27:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8338 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgJ3P1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:27:43 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09UF8LL1003715;
        Fri, 30 Oct 2020 16:27:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=4QYEGEv6Dx43DkeQaT74KojLLBRyD+ORt/fhCMzqZTs=;
 b=iRE+Mcwq8+6u5wET2e5Rw2WxAMM2pJcHvtToopcqvUS1o63ME83HPr+7HCScDjg/MmRn
 oDz1b+FvQ6it4MNNkwAmMLl+zozfkufzi4UvSnWoD1QDQF2jgHm+EPHw5dJUn5/jDSGs
 mbffz9lPaLDR10C1y2/k0zUzFfPApKuZfctIej5UTLXe+ZaXf2xYRRwXEC1oDYch0n+T
 dfNE/SZ0BUbrHkYRPdgoCU0ogRajgN5NMdbkNtlotXRtbbdlboP/CocYT4UqcHVIxqdg
 +geGqafFj6b3KZN8TYAP9J7R6dtOaN6UBg+rl/qfd11PlFQp4HEKFnVHyCUHDKejdzYF XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccmrhjg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 16:27:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B09F100034;
        Fri, 30 Oct 2020 16:27:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F5D22257DC;
        Fri, 30 Oct 2020 16:27:16 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 16:27:15 +0100
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com>
Date:   Fri, 30 Oct 2020 16:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-30_07:2020-10-30,2020-10-30 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/20 3:29 PM, Rob Herring wrote:
> On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>>
>>
>>
>> On 10/29/20 4:40 PM, Rob Herring wrote:
>>> On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
>>>> Power operation mode may depends on hardware design, so, add the optional
>>>> property power-opmode for usb-c connector to select the power operation
>>>> mode capability.
>>>>
>>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>>> ---
>>>>    .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> index 728f82db073d..200d19c60fd5 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> @@ -93,6 +93,24 @@ properties:
>>>>          - device
>>>>          - dual
>>>>
>>>> +  power-opmode:
>>>
>>> I've acked this version:
>>>
>>> https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
>>>
>>
>> frs is used for Fast Role Swap defined in USB PD spec.
>> I understand it allows to get the same information but I'm wondering why
>> the property name is limited to -frs- in this case. What about a
>> non-power delivery USB-C connector ?
> 
> I've got no idea. The folks that know USB-C and PD details need to get
> together and work all this out. To me, it looks like the same thing...
> 

It looks but...

The purpose of power-opmode property is to configure the USB-C 
controllers, especially the non-PD USB-C controllers to determine the 
power operation mode that the Type C connector will support and will 
advertise through CC pins when it has no power delivery support, 
whatever the power role: Sink, Source or Dual
The management of the property is the same that data-role and power-role 
properties, and done by USB Type-C Connector Class.

new-source-frs-typec-current specifies initial current capability of the 
new source when vSafe5V is applied during PD3.0 Fast Role Swap. So here, 
this property is not applied at usb-c controller configuration level, 
but during PD Fast Role Swap, so when the Sink become the Source.
Moreover, the related driver code says FRS can only be supported by DRP 
ports. So new-source-frs-typec-current property, in addition to being 
specific to PD, is also dedicated to DRP usb-c controller.
The property is managed by Type-C Port Controller Manager for PD.

> And it's not just this, but the stream of USB-C additions that trickle in.
> 
>> Moreover, power-opmode property support is already merged in typec class:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/typec/class.c?h=v5.10-rc1&id=12f3467b0d28369d3add7a0deb65fdac9b503c90
>> and stusb160x driver uses it :(
>>
>> So, do I need to modify stusb160x driver (and bindings) to take into
>> account this USB PD specific property?
> 
> If not documented, then it's not an ABI, so yes.

I have tried to document it since months ago
v1: https://lkml.org/lkml/2020/6/15/927
v2: https://lkml.org/lkml/2020/7/23/445 integrating your remarks
v2 RESENT: https://lkml.org/lkml/2020/9/2/174
v3: https://lkml.org/lkml/2020/9/24/306 integrated Li Jun remarks

Regards,
Amelie
