Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5E27ED4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbgI3Pg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731043AbgI3Pg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:36:56 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601480213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZQr4qo7MmVedHzODdP79d98Rq+MUgAemXQy2+EhAOk=;
        b=WrNskRJI/+hnZzsIjWszeG1+lNM0ooxDkzhfXcaKXrqJoIgrHoKdulpGfyT4w0TIpSH462
        nV8sjD2Y1a4U4tKBjvYNe6qPrEWamR0xBO4iyc9BRqEGAvzHZD6H4JcxMJluaidtBEJx1W
        +tJDlSMeInKf4XyyGaVn/eYVXCnNRmo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-qOHGZ754Nu-RWXgdda6njQ-1; Wed, 30 Sep 2020 11:36:49 -0400
X-MC-Unique: qOHGZ754Nu-RWXgdda6njQ-1
Received: by mail-ej1-f71.google.com with SMTP id w10so950850ejq.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZQr4qo7MmVedHzODdP79d98Rq+MUgAemXQy2+EhAOk=;
        b=R9n9QmqbcukifpNoCEATkzTKst2N0SmfYhkRF9TbEfkEoJ3Ax5PpLMmn9S9dxII8n1
         +lfdWAy+bsRwV+dyMcJS+obKLvIdqDELya7njUOkzeB8LeZWYLS6LxdZrQzNNN6M1CfL
         Aj4C115vjOZ6UuChh4LzVUhTMw0UgXLawXpjsHv/iBMnFMUnIDrml4wARdfQCbBqXdHs
         uEWiL7twUDYQq21hYW4cCW+Z9dRa14AoZI/qwboKZJqqnQWY2x26HiRw74N4jnKz28Il
         nMM4bAhyS++HzdwaKTEQFCWuefvtjtBwRim8DQLThmzlCJ+XPfutxJzd+bVCkVcGLToI
         fX+A==
X-Gm-Message-State: AOAM5335Agbq0U9IDrktfqlA5Z26ATI+Zdn9pCka0L9rXMlLa+E1uIkN
        f9woq1prr3Agu8G9G8HPBMx8ZpBZWfewbHeMEhkhcDR1qECulZPHtfPgMFJA161X0AC8BJgUdcF
        WL9+WvAwlSWWOlY3mTJTz5zfd
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr2864725ejb.450.1601480208573;
        Wed, 30 Sep 2020 08:36:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJXkVQYl8z3nQMVPZLyQL0iJ8D2tIaxu+miUaefTQilPL78sEVQFweTGZcq5JPebcDF4glTQ==
X-Received: by 2002:a17:907:2179:: with SMTP id rl25mr2864709ejb.450.1601480208374;
        Wed, 30 Sep 2020 08:36:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id oq8sm1840380ejb.32.2020.09.30.08.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 08:36:47 -0700 (PDT)
Subject: Re: Keyboard regression by intel-vbtn
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <DM6PR19MB2636BD25C7C828D28CF27CC8FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <fce9f346-5c02-0997-216a-14ab6c8b336d@redhat.com>
 <DM6PR19MB2636919AD0E9FD06F05AC8A8FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a5e05458-a61f-a523-a48b-5c5c821eb053@redhat.com>
Date:   Wed, 30 Sep 2020 17:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636919AD0E9FD06F05AC8A8FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/30/20 5:12 PM, Limonciello, Mario wrote:
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Wednesday, September 30, 2020 8:28
>> To: Limonciello, Mario; Barnabás Põcze; Andy Shevchenko
>> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Takashi
>> Iwai
>> Subject: Re: Keyboard regression by intel-vbtn
>>
>>
>> [EXTERNAL EMAIL]
>>
>> Hi,
>>
>> On 9/29/20 10:47 PM, Limonciello, Mario wrote:
>>>>
>>>> I requested on the Ubuntu bug for someone to provide these.
>>>>
>>>
>>> Joe Barnett was kind enough to share two ACPI dumps to compare.
>>> Not affected:
>>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/54153
>> 18/+files/1.2.0.acpidump
>>>
>>> Affected:
>>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/54154
>> 05/+files/1.13.0.acpidump
>>
>> Thank you, I took a look at these (before completing my allow-list fix),
>> but there is not really much which stands out. The only related thing which
>> stands out is that the 1.13.0 dsdt.dsl has this new bit:
>>
>>
>>                               Case (0x08)
>>                               {
>>                                   Return (^^PCI0.LPCB.H_EC.VGBI.VGBS ())
>>                               }
>>
>> Inside the _DSM of the HIDD / INT33D5 device.
>>
>>               Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>>               {
>>                   If ((Arg0 == ToUUID ("eeec56b3-4442-408f-a792-
>> 4edd4d758054")))
>>
>>
>> What is interesting here is that the PCI0.LPCB.H_EC.VGBI.VGBS object/method
>> does not actually exist the correct path is:
>>
>> ^^PCI0.LPCB.ECDV.VGBI.VGBS
>>
>> So this does suggest that something around the VGBS handling changed
>> (and since it points to a non existing ACPI object, possibly broke)
>> in the newer BIOS version. But what exactly is going on on this XPS 2-in-1
>> cannot really be derived from the acpidumps.
>>
>> Regards,
>>
>> Hans
> 
> Looking through some publicly found content I think I might have figured out what
> bight be the missing link.
> 
> https://software.intel.com/sites/default/files/detecting-slate-clamshell-mode-and-screen-orientation-in-convertible-pc-1.pdf
> 
> You can see that the device with CID PNP0C60 is supposed to indicate the presence
> of a convertible hinge.  We don't currently have anything that matches that _CID or _HID
> in intel-vbtn.
> 
> In the DSDT dump you can see that the status method for the INT33D3 device returns
> 0x0F on 2-in-1.s
> 
>          Device (CIND)
>          {
>              Name (_HID, "INT33D3" /* Intel GPIO Buttons */)  // _HID: Hardware ID
>              Name (_CID, "PNP0C60" /* Display Sensor Device */)  // _CID: Compatible ID
>              Method (_STA, 0, Serialized)  // _STA: Status
>              {
>                  If ((OSYS >= 0x07DC))
>                  {
>                      Return (0x0F)
>                  }
> 
>                  Return (Zero)
>              }
>          }
> 
> On a non 2-in-1 device I don't see this present.  So I think we should have intel-vbtn
> look for that INT33D3/PNP0C60 device to decide whether to offer the switch.
> 
> Similarly as mentioned in that document I think that we should not be showing the
> docking switch only when INT33D4/PNP0C70 is present and returns 0xF.

That is a good find, thank you for digging into this and finding this.

But it seems we have a typical case of the microsoft/intel example DSDT code being
blindly copied everywhere here too:

The chassis-type check was originally introduced by you in:
commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's")

     Some laptops such as the XPS 9360 support the intel-vbtn INT33D6
     interface but don't initialize the bit that intel-vbtn uses to
     represent switching tablet mode.

     By running this only on real 2-in-1's it shouldn't cause false
     positives.

     Fixes: 30323fb6d5 ("Support tablet mode switch")

I have a XPS 9360 (which is not 2-in-1) acpidump and that has:

         Device (CIND)
         {
             Name (_HID, "INT33D3" /* Intel GPIO Buttons */)  // _HID: Hardware ID
             Name (_CID, "PNP0C60" /* Display Sensor Device */)  // _CID: Compatible ID
             Method (_STA, 0, Serialized)  // _STA: Status
             {
                 If ((OSYS >= 0x07DC))
                 {
                     Return (0x0F)
                 }

                 Return (Zero)
             }
         }

And on an asus e200ha (also not a 2-in-1), where we were seeing
similar problems, but then using asus custom WMI interface for
getting SW_TABLET_MODE I see:

         Device (CIND)
         {
             Name (_HID, "INT33D3" /* Intel GPIO Buttons */)  // _HID: Hardware ID
             Name (_CID, "PNP0C60" /* Display Sensor Device */)  // _CID: Compatible ID
             Method (_STA, 0, Serialized)  // _STA: Status
             {
                 Return (0x0F)
             }
         }

I have quite a few DSDTs (mostly byt/cht tablets or 2-in-1s though) and
65 of them define a "PNP0C60" device and only 1 unconditionally
returns 0 from the _STA method for this device. Most others have
an OSYS check. Some also check for some other, presumably BIOS
configured variable, but by far most always return 0x0F, or do
so after an OSYS check which will be true in our case.

So I'm afraid that almost all devices which have the intel-vbtn (INT33D6)
ACPI device will also have a PNP0C60 device with the exact same
_STA method as found on the XPS 9360 and that this thus is not
helpful.

Regards,

Hans

