Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E62AB5BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgKILDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:03:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31148 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727930AbgKILDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:03:12 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9AvmFh021010;
        Mon, 9 Nov 2020 12:03:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=SjBPRhky3qT+DJICgbZsSvGlruI9JMddOidNQycUyMU=;
 b=UYcd6mfjRPjCZtnnTa9UoHC/uvs1gJpkgHk17QldoBLQBd0EQGOFaXdi1mSMqMvS8IR7
 TDeJSKAJiQBCmP+0hnOqPZ/Ycw+Hchlhx6oSYFJAjm7wCg03lOIjhRrLbrMF9SNoHvAC
 kx6lfsKWcKQWgSWua9/29C56Pyl5VYsg5FBmnWb/EBmqG88/FNykSGCINBJf0kcB4qmG
 LyCvEambVzVjyGI7hvUqkvFBdWZbRlRAZmejvnTNKI4oBKs56a0+jIaHtFlH7S6ao0bd
 X9/SH72EDUzUKlEDIeYL6sfk0b3t6GCZdiFBjU/lnUJdhAg9h1dk4gZKBKJZE2KuI0r7 FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhkcj38n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Nov 2020 12:03:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F57610002A;
        Mon,  9 Nov 2020 12:03:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CC4024C7A0;
        Mon,  9 Nov 2020 12:03:01 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 12:03:00 +0100
Subject: Re: [Linux-stm32] [PATCH v7 10/12] ARM: dts: stm32: Fix schema
 warnings for pwm-leds
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Alexander Dahl <ada@thorsis.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20201005203451.9985-1-post@lespocky.de>
 <20201005203451.9985-11-post@lespocky.de>
 <b387bda8-3643-1d27-4996-2aa4dc94d69f@pengutronix.de>
 <20201027100536.cpfizc67gwrolp2z@falbala.internal.home.lespocky.de>
 <f6ed201d-51b6-f278-7a95-3e3e49dc19ee@pengutronix.de>
 <20201031135408.lgpiy5goa7l4cg2k@falbala.internal.home.lespocky.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <eef76d72-7467-eed7-ac65-93237bd2b3bb@st.com>
Date:   Mon, 9 Nov 2020 12:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201031135408.lgpiy5goa7l4cg2k@falbala.internal.home.lespocky.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_02:2020-11-05,2020-11-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex

On 10/31/20 2:54 PM, Alexander Dahl wrote:
> Hei hei,
> 
> On Tue, Oct 27, 2020 at 11:58:10AM +0100, Ahmad Fatoum wrote:
>> Hello,
>>
>> On 10/27/20 11:05 AM, Alexander Dahl wrote:
>>> Hello Ahmad,
>>>
>>> thanks for your feedback, comments below.
>>>
>>
>>>>> -	led-rgb {
>>>>> +	led-controller-2 {
>>>>
>>>> Is a single RGB LED really a controller?
>>>
>>> I just followed the recommendations by Rob here.
>>
>> Do you happen to know if the new multicolor LED support could be used here?
>>
>> I find it unfortunate that the device tree loses information relevant to humans
>> to adhere to a fixed nomenclature. Apparently led-controller isn't even codified
>> in the YAML binding (It's just in the examples). If you respin, please add a
>> comment that this is a single RGB led. I'd prefer to keep the information
>> in the DTB as well though.
> 
> Slightly off-topic, but while I was working on the patch based on your
> feedback I tried to find some information on that Linux Automation
> MC-1 board.  However I could not find any? Is there some website, some
> datasheet or maybe a schematic online?  The vendor prefix says "Linux
> Automation GmbH", but I find only that USB-SD-Mux on their page?
> 
> Greets
> Alex

I saw that Ahmad Acked this patch but regarding your discussion it seems 
there are opening questions. Are you going to send an update of it or 
can I take it ?

regards
alex



> 
>>
>>
>>
>>>
>>>>>   		compatible = "pwm-leds";
>>>>>   
>>>>> -		led-red {
>>>>> +		led-2 {
>>>>
>>>> Shouldn't this have been led-1 as well or is the numbering "global" ?
>>>
>>> Also good question. This numbering is for dts only, it usually does
>>> not correspond with LEDs on the board, so it could be numbered per
>>> led-controller as well?
>>
>> I'd prefer that it starts by 1. That way it's aligned with PWM channel
>> ID.
>>
>> Thanks for fixing the dtschema warnings by the way!
>>
>> Cheers,
>> Ahmad
>>
>>>
>>> Greets
>>> Alex
>>>
>>>>
>>>>>   			label = "mc1:red:rgb";
>>>>>   			pwms = <&leds_pwm 1 1000000 0>;
>>>>>   			max-brightness = <255>;
>>>>>   			active-low;
>>>>>   		};
>>>>>   
>>>>> -		led-green {
>>>>> +		led-3 {
>>>>>   			label = "mc1:green:rgb";
>>>>>   			pwms = <&leds_pwm 2 1000000 0>;
>>>>>   			max-brightness = <255>;
>>>>>   			active-low;
>>>>>   		};
>>>>>   
>>>>> -		led-blue {
>>>>> +		led-4 {
>>>>>   			label = "mc1:blue:rgb";
>>>>>   			pwms = <&leds_pwm 3 1000000 0>;
>>>>>   			max-brightness = <255>;
>>>>>
>>>>
>>>> -- 
>>>> Pengutronix e.K.                           |                             |
>>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>>
>>
>> -- 
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
> 
