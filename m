Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11372C1F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgKXIG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:06:26 -0500
Received: from mout.web.de ([212.227.15.4]:38749 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbgKXIG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606205178;
        bh=Ay7zj2FqSEwv/TvPc35iyEKLrKGyrsWRwFCjurJRVIM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XhrC5dzeLdTaKFiAusf01XkOgYIFxr1QNQe6PAYSSxBlwRCWwfi82JP8BrfRvZDrj
         F3xUqjkkr3RS54s8vnzRLh3jsBKrhQkyBI90SLCQKnGDRAqrUe67ggJeLAR8Y8y9yc
         8a8EDVzLbR7/yCgL9bxgLLTj6SiY/OJyY2SP1X9A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.110] ([193.36.117.236]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M22Sh-1kOQ3F26W3-00tyWA; Tue, 24
 Nov 2020 09:06:18 +0100
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     "Wang, Jiada" <jiada_wang@mentor.com>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-kernel@vger.kernel.org
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
 <beae40be-4e84-ceea-ee00-351b18b26e06@mentor.com>
 <69305cdf-1ba7-a51a-302c-9b1b83e788aa@web.de>
 <e1d1c27e-3c02-d29c-7bf4-2b302a292e70@mentor.com>
 <fd717b9c-f363-d8e8-87e9-d967bd514cd4@web.de>
 <67f8e922-941d-8538-15d7-5125356082d3@mentor.com>
From:   Andre Muller <andre.muller@web.de>
Message-ID: <2ba73d1a-30d1-48a1-e2c3-89c4da28f88a@web.de>
Date:   Tue, 24 Nov 2020 09:07:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <67f8e922-941d-8538-15d7-5125356082d3@mentor.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKQpJrS+TpAgEvmOWHJzYD7W4F3+iFp/jF9YFIx0ldgeaRe9VQV
 ASuDZGkhxd7wZqdlqCxzXoxPz53m++txmnxtRdUPeG6fgWVh97UfMlF6iHCKIneOg0krDxW
 2DjawlAflGyWg2xCh/zBmFUU9pPK0EoLGu3PS8A7evo3VCTYMqE45br4IMu6iBrrvftYAYV
 3WvXXDJHI6bpGP4WNa0/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6VAilXwqygg=:v7tFkK0lup1Tu+PZS1Te8Y
 MsShpmFOjc1DCL3fHUF7T/R+2F0B6OeREfAlCtjiz3ud3wjeTUfA/9mcvAkrxrclNMGfU1g1N
 meJ3xwFIPJv4qm2ijcWZAL/JW6Qj97yvVwfw7+8ww4uVj2cnyTv1N/AWssgtW7UDSs/A5Jpz9
 zn61voaD7g7Yv6ZImzwzQu1BlnF5KC1VDX8XWDVsoYCqeCajTjt537Oa19AaMMoaGtXXa9q9r
 zYaYKaK+oyMtTJZo1bDsTAFFa7kXYqDaEsKByTJffgd9d47zinPIccxQPDRb1GAXqGx5le7fN
 +Xm6m7GFnqOaCWD0Q7k4iuCPuFinzc3P8Y888iHKdzNLDr+2SD6UsDNbnLK41eZa1UmwBQ34n
 b8p+WCxEGzHvNM2Xzp6xihccU46m1ehMuAJ3j+JoxW9+MQKpSUI6FcDYewjyPGvEyzM4g+FTY
 CJgUOAGzpxP6Y5MkC4XtLIy8v36vfxhPsB16dmypOm14mVvkpyPN+kAG5eDXc4CankEsqySJr
 XOU2VsQLeqcfARfj7LYDU1N2xIbMK42u2UMirKxoE4JNvgpoqMTPGsJ5roKdd8C/izt6KwJvi
 o2YApFdkUUmN1GgbsCtrxGDRZPuWUlumX9zLiOpiTwRScRBJnMASjBw3jZrKyL4m9oU2/fhk6
 GAqwJcPiZGyhGFS+Rrkfj2H4DmkLUtxHAKHs1zxUBZ7+wYBwBEsg4AeE7D9Maha+9E1bIUHe8
 BoUPO3w8NlizTYw7bOiVkI2zmUAVqJaZ65w+Tyq1nzaVt0xp+d1TCQH7VeymmQipxb6PboBz1
 YFDW1DvQDzmyQ0hmBqgCE5UIR/qW8xmUy70t8c3NNKi7t/rcIa7qKZsv6KMEOkU5eUh5wmn6i
 5ncwsO+qKR2UPPfvSZ6g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a shot in the dark:

I consulted my notes on the convoluted initial setup of a mainline kernel
for this hardware, and found the Atmel chip needed reprogramming
to start working. The settings are preserved, once set.

I ran "enable-atmel.sh", last in 2017,
from here: https://github.com/raphael/linux-samus/tree/master/scripts/setu=
p/touchpad

I don't see or think this is related to the issue at hand,
but my expertise on this hardware is limited, to put it kindly :)

Thanks,
Andre


On 24/11/2020 07.32, Wang, Jiada wrote:
> Hi Andre
>
> Thanks for the log,
> Hmmm, from the log (also as you have observed)
> Seems "data->use_retrigen_workaround" is true on your device
> so workaround mxt_process_messages_until_invalid() is used.
> which is as same as with the commit reverted,
> I am not sure what caused IRQ get generated.
>
> @dmitry
> I would suggest to revert the commit until we find out the root cause
>
> Thanks,
> Jiada
>
>
> On 2020/11/24 15:15, Andre Muller wrote:
>> On 24/11/2020 04.02, Wang, Jiada wrote:
>>> Hello Andre
>>>
>>> Thanks for the log,
>>> can you add more debug information like following diff,
>>> and get full log?
>>
>> Hi Jiada,
>>
>> I added the warnings, but none of them triggers.
>> I double-checked the generated object file, it includes the debug strin=
gs.
>> (Also tested that touchscreen/touchpad don't work, as expected.)
>>
>> Please find the full log attached.
>>
>> Thank you,
>> Andre
>>
>>
>>>
>>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/=
touchscreen/atmel_mxt_ts.c
>>> index 98f17fa3a892..60bccd5c42f6 100644
>>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>>> @@ -1298,21 +1298,29 @@ static int mxt_check_retrigen(struct mxt_data =
*data)
>>> =A0=A0=A0=A0=A0=A0=A0=A0 data->use_retrigen_workaround =3D false;
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0 irqd =3D irq_get_irq_data(data->irq);
>>> -=A0=A0=A0=A0=A0=A0 if (!irqd)
>>> +=A0=A0=A0=A0=A0=A0 if (!irqd) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(&client->dev, "un=
able to get IRQ data\n");
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>> +=A0=A0=A0=A0=A0=A0 }
>>>
>>> -=A0=A0=A0=A0=A0=A0 if (irqd_is_level_type(irqd))
>>> +=A0=A0=A0=A0=A0=A0 if (irqd_is_level_type(irqd)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(&client->dev, "IR=
Q is level type\n");
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +=A0=A0=A0=A0=A0=A0 }
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0 if (data->T18_address) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D __mxt_read_=
reg(client,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->T18_address + MXT_C=
OMMS_CTRL,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1, &val);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (error)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (error) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 de=
v_warn(&client->dev, "failed to read reg: MXT_COMMS_CTRL\n");
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 return error;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val & MXT_COMMS_RETRIG=
EN)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val & MXT_COMMS_RETRIG=
EN) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 de=
v_warn(&client->dev, "RETRIGEN feature available\n");
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 return 0;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(&client->dev, "Enabling RETRIGEN wor=
karound\n");
>>>
>>>
>>> Thanks,
>>> Jiada
>>>
>>> On 2020/11/05 23:23, Andre Muller wrote:
>>>> On 05/11/2020 14.25, Wang, Jiada wrote:
>>>>> Hi Andre
>>>>>
>>>>> Thanks for your report,
>>>>> could you also please post the log when with this commit reverted?
>>>>>
>>>>> Thanks,
>>>>> Jiada
>>>>
>>>> Shure!
>>>> The full dmesg with the revert is attached.
>>>>
>>>> The atmel_mxt bits are:
>>>>
>>>> [=A0=A0=A0 0.195879] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Varian=
t: 17 Firmware V1.0.AA Objects: 32
>>>> [=A0=A0=A0 0.211712] atmel_mxt_ts i2c-ATML0000:01: Direct firmware lo=
ad for maxtouch.cfg failed with error -2
>>>> [=A0=A0=A0 0.212986] atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X=
960Y540
>>>> [=A0=A0=A0 0.213025] input: Atmel maXTouch Touchpad as /devices/pci00=
00:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>>>> [=A0=A0=A0 0.219208] atmel_mxt_ts i2c-ATML0001:01: Family: 164 Varian=
t: 13 Firmware V1.0.AA Objects: 41
>>>> [=A0=A0=A0 0.238825] atmel_mxt_ts i2c-ATML0001:01: Direct firmware lo=
ad for maxtouch.cfg failed with error -2
>>>> [=A0=A0=A0 0.238949] intel_rapl_common: Found RAPL domain package
>>>> [=A0=A0=A0 0.238955] intel_rapl_common: Found RAPL domain core
>>>> [=A0=A0=A0 0.238961] intel_rapl_common: Found RAPL domain uncore
>>>> [=A0=A0=A0 0.238966] intel_rapl_common: Found RAPL domain dram
>>>> [=A0=A0=A0 0.240121] atmel_mxt_ts i2c-ATML0001:01: Touchscreen size X=
2559Y1699
>>>> [=A0=A0=A0 0.240157] input: Atmel maXTouch Touchscreen as /devices/pc=
i0000:00/INT3433:00/i2c-1/i2c-ATML0001:01/input/input5
>>>>
>>>> Regards,
>>>> Andre
>>>>
>>>>>
>>>>> On 2020/11/04 17:13, Andre wrote:
>>>>>> Hi,
>>>>>>
>>>>>> commit 74d905d2: Input: atmel_mxt_ts - only read messages in
>>>>>> mxt_acquire_irq() when necessary
>>>>>>
>>>>>> breaks the touchpad and touchscreen of the 2015 Chromebook Pixel "S=
amus".
>>>>>>
>>>>>> Reverting the commit from the current git tree gets them to work ag=
ain.
>>>>>>
>>>>>> I am not at all shure what info to include, but I will happily prov=
ide
>>>>>> it on request.
>>>>>>
>>>>>> The dmesgs of a boot with commit 74d905d2 show "Enabling RETRIGEN
>>>>>> workaround", but otherwise looks the same as a boot without.
>>>>>>
>>>>>> Here is the relevant bit (with 74d905d2):
>>>>>>
>>>>>> atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0=
.AA
>>>>>> Objects: 32
>>>>>> atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
>>>>>> atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxtouch.cfg
>>>>>> failed with error -2
>>>>>> atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
>>>>>> input: Atmel maXTouch Touchpad as
>>>>>> /devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>>>>>> atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmware V1.0=
.AA
>>>>>> Objects: 41
>>>>>> atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
>>>>>> atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxtouch.cfg
>>>>>> failed with error -2
>>>>>>
>>>>>> Thank you,
>>>>>> Andre M=FCller
>>>>
>>

