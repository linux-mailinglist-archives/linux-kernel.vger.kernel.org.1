Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641DC2C1E46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgKXGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:32:10 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:31677 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgKXGcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:32:10 -0500
IronPort-SDR: Y6Lk3kVRZ+5mBdV5OjMKOPZ+ZkCRc79fHYc8snNF0IckAyb682SDMXeatTJzya9AZKjLNK2Z6j
 HfKRJNPJAloS4xl2qSXq7u/SyNN3RoVZcDY/JCKRPVsRinWIm954UTHk9MEH3rScGZiLtzmz2D
 pMrFBbL35jHFm3anqVQCSNvNj/ZmZMnlG7l5wlz32FhM/vJzPeYJ/PmgXyAR9AvZCv4W/Bg6TD
 l8BIAK49A3xXb7m5/gy6pkZIrzQZq7f627OBhjJHkDN3AmpuFs72xAzQTN46FddRyF3s4hiT2F
 4l8=
X-IronPort-AV: E=Sophos;i="5.78,365,1599552000"; 
   d="scan'208";a="55401919"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 23 Nov 2020 22:32:08 -0800
IronPort-SDR: CHtWuG+lbav1jgNdVlG64wOibccGFuUHz8eX58XOUu5tgOrwKVQboutzdb0HEtddjeB30I/hlS
 GP3kw5vx9rq5L63KFfzow3Epc84Rjiu4FmM5vKu4/FGJoyXKjRRYqy5RPbYLhSG9WnJWW+AoMF
 y1DY7JuFxGZrBnCVmXFyMqrLztmJO7Z2024u+wmXhKBdtiSp+dRdpmX0R4cYdW2B7UWOaeHkXR
 7XOpB9qk18tEIa+3Mw8Wd2mv+AKm29jeT2iy1ErSBFtSBsEqX7p+n7+yDCdcvGcpUVvxAisxOz
 jNI=
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     Andre Muller <andre.muller@web.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        <linux-kernel@vger.kernel.org>
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
 <beae40be-4e84-ceea-ee00-351b18b26e06@mentor.com>
 <69305cdf-1ba7-a51a-302c-9b1b83e788aa@web.de>
 <e1d1c27e-3c02-d29c-7bf4-2b302a292e70@mentor.com>
 <fd717b9c-f363-d8e8-87e9-d967bd514cd4@web.de>
From:   "Wang, Jiada" <jiada_wang@mentor.com>
Message-ID: <67f8e922-941d-8538-15d7-5125356082d3@mentor.com>
Date:   Tue, 24 Nov 2020 15:32:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <fd717b9c-f363-d8e8-87e9-d967bd514cd4@web.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre

Thanks for the log,
Hmmm, from the log (also as you have observed)
Seems "data->use_retrigen_workaround" is true on your device
so workaround mxt_process_messages_until_invalid() is used.
which is as same as with the commit reverted,
I am not sure what caused IRQ get generated.

@dmitry
I would suggest to revert the commit until we find out the root cause

Thanks,
Jiada


On 2020/11/24 15:15, Andre Muller wrote:
> On 24/11/2020 04.02, Wang, Jiada wrote:
>> Hello Andre
>>
>> Thanks for the log,
>> can you add more debug information like following diff,
>> and get full log?
> 
> Hi Jiada,
> 
> I added the warnings, but none of them triggers.
> I double-checked the generated object file, it includes the debug strings.
> (Also tested that touchscreen/touchpad don't work, as expected.)
> 
> Please find the full log attached.
> 
> Thank you,
> Andre
> 
> 
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c 
>> b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 98f17fa3a892..60bccd5c42f6 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -1298,21 +1298,29 @@ static int mxt_check_retrigen(struct mxt_data 
>> *data)
>>          data->use_retrigen_workaround = false;
>>
>>          irqd = irq_get_irq_data(data->irq);
>> -       if (!irqd)
>> +       if (!irqd) {
>> +               dev_warn(&client->dev, "unable to get IRQ data\n");
>>                  return -EINVAL;
>> +       }
>>
>> -       if (irqd_is_level_type(irqd))
>> +       if (irqd_is_level_type(irqd)) {
>> +               dev_warn(&client->dev, "IRQ is level type\n");
>>                  return 0;
>> +       }
>>
>>          if (data->T18_address) {
>>                  error = __mxt_read_reg(client,
>>                                         data->T18_address + 
>> MXT_COMMS_CTRL,
>>                                         1, &val);
>> -               if (error)
>> +               if (error) {
>> +                       dev_warn(&client->dev, "failed to read reg: 
>> MXT_COMMS_CTRL\n");
>>                          return error;
>> +               }
>>
>> -               if (val & MXT_COMMS_RETRIGEN)
>> +               if (val & MXT_COMMS_RETRIGEN) {
>> +                       dev_warn(&client->dev, "RETRIGEN feature 
>> available\n");
>>                          return 0;
>> +               }
>>          }
>>
>>          dev_warn(&client->dev, "Enabling RETRIGEN workaround\n");
>>
>>
>> Thanks,
>> Jiada
>>
>> On 2020/11/05 23:23, Andre Muller wrote:
>>> On 05/11/2020 14.25, Wang, Jiada wrote:
>>>> Hi Andre
>>>>
>>>> Thanks for your report,
>>>> could you also please post the log when with this commit reverted?
>>>>
>>>> Thanks,
>>>> Jiada
>>>
>>> Shure!
>>> The full dmesg with the revert is attached.
>>>
>>> The atmel_mxt bits are:
>>>
>>> [    0.195879] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 
>>> Firmware V1.0.AA Objects: 32
>>> [    0.211712] atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for 
>>> maxtouch.cfg failed with error -2
>>> [    0.212986] atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
>>> [    0.213025] input: Atmel maXTouch Touchpad as 
>>> /devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>>> [    0.219208] atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 
>>> Firmware V1.0.AA Objects: 41
>>> [    0.238825] atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for 
>>> maxtouch.cfg failed with error -2
>>> [    0.238949] intel_rapl_common: Found RAPL domain package
>>> [    0.238955] intel_rapl_common: Found RAPL domain core
>>> [    0.238961] intel_rapl_common: Found RAPL domain uncore
>>> [    0.238966] intel_rapl_common: Found RAPL domain dram
>>> [    0.240121] atmel_mxt_ts i2c-ATML0001:01: Touchscreen size X2559Y1699
>>> [    0.240157] input: Atmel maXTouch Touchscreen as 
>>> /devices/pci0000:00/INT3433:00/i2c-1/i2c-ATML0001:01/input/input5
>>>
>>> Regards,
>>> Andre
>>>
>>>>
>>>> On 2020/11/04 17:13, Andre wrote:
>>>>> Hi,
>>>>>
>>>>> commit 74d905d2: Input: atmel_mxt_ts - only read messages in
>>>>> mxt_acquire_irq() when necessary
>>>>>
>>>>> breaks the touchpad and touchscreen of the 2015 Chromebook Pixel 
>>>>> "Samus".
>>>>>
>>>>> Reverting the commit from the current git tree gets them to work 
>>>>> again.
>>>>>
>>>>> I am not at all shure what info to include, but I will happily provide
>>>>> it on request.
>>>>>
>>>>> The dmesgs of a boot with commit 74d905d2 show "Enabling RETRIGEN
>>>>> workaround", but otherwise looks the same as a boot without.
>>>>>
>>>>> Here is the relevant bit (with 74d905d2):
>>>>>
>>>>> atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0.AA
>>>>> Objects: 32
>>>>> atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
>>>>> atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxtouch.cfg
>>>>> failed with error -2
>>>>> atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
>>>>> input: Atmel maXTouch Touchpad as
>>>>> /devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>>>>> atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmware V1.0.AA
>>>>> Objects: 41
>>>>> atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
>>>>> atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxtouch.cfg
>>>>> failed with error -2
>>>>>
>>>>> Thank you,
>>>>> Andre Müller
>>>
> 
