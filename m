Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55F27268D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgIUOCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgIUOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600696935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfrESi9uXYW8SQ666Fqztu1uERk5SJMJ5POJpxZlCMY=;
        b=ia8pcQwihA5QDPdRkAgtZhqMsX1U6280JQa64IXJX47+lKNZLX9llCD69WRZhlEB9vksGe
        lqAWVSwO2Zj9x87tWu1kzidCLcnN1X8ujf9W7Hjv8U7QlfFGWjj2i26/ohs71F//Imx3Op
        jIC8/kCem18uy0hh2OzLu82lZ4UzdOs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-FRCW_l3JNJ-7ced39ATRxQ-1; Mon, 21 Sep 2020 10:02:12 -0400
X-MC-Unique: FRCW_l3JNJ-7ced39ATRxQ-1
Received: by mail-ed1-f69.google.com with SMTP id d13so4615249edz.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tfrESi9uXYW8SQ666Fqztu1uERk5SJMJ5POJpxZlCMY=;
        b=SASQlLKddUTFf/B1WgJhN/7Q9o6t126a4NzQyhwxdOaMWSq//O7QnHhENDXTimWqtW
         9/R48OhEbZ/pR14Bf9IrjrNBkkmt2nVbJJIfLH7ToyMuvK6oo/zoWD7ADfcRnx3W574f
         /J3/Ct/744j4wX4HfFwBNwzTR5k0dWlZRWTGKbYL3wrpuT75dm3O94E+lA6OuI1fq9DB
         uaS8nFYa1+pqTbOBZU051L9HZbCkhNSL16umvlP6Ke+fAf+/QBbudhQIRsieweT5A+Q0
         uegOPvijLbUUI+Su13CGQUkjCvcylTkFSjACa0IKYTe2rPoV7+AFDWQaMEN4YdD98Cg0
         QsiA==
X-Gm-Message-State: AOAM530LXoSjeG8sEob4CroPlUMvp0u2kvp1/nBUZM+TbDhGD/LS4t8v
        Vf1c65jcLdz1wBa6WfV51w3t5i2NxzBF0UBnZl0IDNHfgf1YNnW0z/ccGI229lkTGPa1MybFaIc
        sBftFRAX2MR2IlbcbmaXZ8fgh
X-Received: by 2002:a17:906:b88e:: with SMTP id hb14mr12690417ejb.543.1600696930477;
        Mon, 21 Sep 2020 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk7pCnq9E3v4eB9RqahW2OXbK/LNfaWYxz9/VHirCbv2qIN/Khs2Cl2zUe7WkNKnnNubnGBQ==
X-Received: by 2002:a17:906:b88e:: with SMTP id hb14mr12690382ejb.543.1600696930104;
        Mon, 21 Sep 2020 07:02:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id x25sm8566851edv.42.2020.09.21.07.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:02:08 -0700 (PDT)
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, dvhart@infradead.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com>
 <6e3738db-bfff-7fd2-65e6-bd0d126f9eaa@redhat.com>
 <CAKgT0UcxSwRseMBdMd0_HDUS=JGZDAZnAy-tkLkB-hMXLYtucw@mail.gmail.com>
 <CAKgT0UfM0534GZcKzgTeEa3nq2+FWHk4PfA593smGOLun4d97A@mail.gmail.com>
 <67f5816a-1307-da81-ff71-cea1f907b58b@redhat.com>
 <CAKgT0UdvuLuDRnE5nzOr6fWkC9TJVQNRa+kf1Pcb9mUxGMBXPw@mail.gmail.com>
 <9025435b-c25c-1b31-fcea-2bc27946c754@redhat.com>
 <CAKgT0Uf2Wo8bQPu6MeF+t91-+y2NOWiOg1i5bsG52tFQPBWjBg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <edbe14db-5046-e34b-046d-56673c9178c3@redhat.com>
Date:   Mon, 21 Sep 2020 16:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf2Wo8bQPu6MeF+t91-+y2NOWiOg1i5bsG52tFQPBWjBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 3:57 PM, Alexander Duyck wrote:
> On Mon, Sep 21, 2020 at 6:16 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 9/17/20 11:35 PM, Alexander Duyck wrote:
>>> On Thu, Sep 17, 2020 at 5:12 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 9/15/20 12:35 AM, Alexander Duyck wrote:
>>>>> On Mon, Sep 14, 2020 at 11:07 AM Alexander Duyck
>>>>> <alexander.duyck@gmail.com> wrote:
>>>>>>
>>>>>> On Mon, Sep 14, 2020 at 6:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 9/11/20 9:45 PM, David E. Box wrote:
>>>>>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>>
>>>>>>>> Add support for the Intel Platform Monitoring Technology crashlog
>>>>>>>> interface.  This interface provides a few sysfs values to allow for
>>>>>>>> controlling the crashlog telemetry interface as well as a character driver
>>>>>>>> to allow for mapping the crashlog memory region so that it can be accessed
>>>>>>>> after a crashlog has been recorded.
>>>>>>>>
>>>>>>>> This driver is meant to only support the server version of the crashlog
>>>>>>>> which is identified as crash_type 1 with a version of zero. Currently no
>>>>>>>> other types are supported.
>>>>>>>>
>>>>>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>>>>>>> ---
>>>>>>>>      .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
>>>>>>>>      drivers/platform/x86/Kconfig                  |  10 +
>>>>>>>>      drivers/platform/x86/Makefile                 |   1 +
>>>>>>>>      drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
>>>>>>>>      4 files changed, 665 insertions(+)
>>>>>>>>      create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>>>>>>      create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
>>>>>>>>
>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-pmt_crashlog b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..40fb4ff437a6
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>>>>>> @@ -0,0 +1,66 @@
>>>>>>>> +What:                /sys/class/pmt_crashlog/
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             The pmt_crashlog/ class directory contains information
>>>>>>>> +             for devices that expose crashlog capabilities using the Intel
>>>>>>>> +             Platform Monitoring Technology (PTM).
>>>>>>>> +
>>>>>>>> +What:                /sys/class/pmt_crashlog/crashlogX
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             The crashlogX directory contains files for configuring an
>>>>>>>> +             instance of a PMT crashlog device that can perform crash data
>>>>>>>> +             recoring. Each crashlogX device has an associated
>>>>>>>> +             /dev/crashlogX device node. This node can be opened and mapped
>>>>>>>> +             to access the resulting crashlog data. The register layout for
>>>>>>>> +             the log can be determined from an XML file of specified guid
>>>>>>>> +             for the parent device.
>>>>>>>> +
>>>>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/guid
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             (RO) The guid for this crashlog device. The guid identifies the
>>>>>>>> +             version of the XML file for the parent device that should be
>>>>>>>> +             used to determine the register layout.
>>>>>>>> +
>>>>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/size
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             (RO) The length of the result buffer in bytes that corresponds
>>>>>>>> +             to the mapping size for the /dev/crashlogX device node.
>>>>>>>> +
>>>>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/offset
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             (RO) The offset of the buffer in bytes that corresponds
>>>>>>>> +             to the mapping for the /dev/crashlogX device node.
>>>>>>>> +
>>>>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/enable
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             (RW) Boolean value controlling if the crashlog functionality
>>>>>>>> +             is enabled for the /dev/crashlogX device node.
>>>>>>>> +
>>>>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/trigger
>>>>>>>> +Date:                September 2020
>>>>>>>> +KernelVersion:       5.10
>>>>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>>> +Description:
>>>>>>>> +             (RW) Boolean value controlling  the triggering of the
>>>>>>>> +             /dev/crashlogX device node. When read it provides data on if
>>>>>>>> +             the crashlog has been triggered. When written to it can be
>>>>>>>> +             used to either clear the current trigger by writing false, or
>>>>>>>> +             to trigger a new event if the trigger is not currently set.
>>>>>>>> +
>>>>>>>
>>>>>>> Both the pmt_crashlog and the attributes suggest that this is highly
>>>>>>> Intel PMT specific. /sys/class/foo interfaces are generally speaking
>>>>>>> meant to be generic interfaces.
>>>>>>>
>>>>>>> If this was defining a generic, vendor and implementation agnostic interface for
>>>>>>> configuring / accessing crashlogs, then using a class would be fine, but that
>>>>>>> is not the case, so I believe that this should not implement / register a class.
>>>>>>>
>>>>>>> Since the devices are instantiated through MFD there already is a
>>>>>>> static sysfs-path which can be used to find the device in sysfs:
>>>>>>> /sys/bus/platform/device/pmt_crashlog
>>>>>>>
>>>>>>> So you can register the sysfs attributes directly under the platform_device
>>>>>>> and then userspace can easily find them, so there really is no need to
>>>>>>> use a class here.
>>>>>>
>>>>>> I see. So we change the root directory from "/sys/class/pmt_crashlog/"
>>>>>> to "/sys/bus/platform/device/pmt_crashlog" while retaining the same
>>>>>> functionality. That should be workable.
>>>>>
>>>>> So one issue as I see it is that if we were to change this then we
>>>>> probably need to to change the telemetry functionality that was
>>>>> recently accepted
>>>>> (https://lore.kernel.org/lkml/20200819180255.11770-1-david.e.box@linux.intel.com/)
>>
>> You say that this has been accepted, by I don't see any intel_pmt.c
>> file here yet: ?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mfd/
> 
> Here is a link to the thread on the first patch set. The last notes I
> saw were that it was going to be applied but it looks like that never
> happened.
> https://lore.kernel.org/lkml/20200819180255.11770-1-david.e.box@linux.intel.com/
> 
>>>>> as well. The general idea with using the /sys/class/pmt_crashlog/
>>>>> approach was to keep things consistent with how the pmt_telemetry was
>>>>> being accessed. So if we change this then we end up with very
>>>>> different interfaces for the two very similar pieces of functionality.
>>>>> So ideally we would want to change both telemetry and crashlog to
>>>>> function the same way.
>>>>
>>>> I agree that the telemetry interface should be changed in a similar way.
>>>>
>>>> Luckily it seems that this is not in Linus' tree yet and I'm also not
>>>> seeing it in next yet, e.g. :
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/platform/x86/intel_pmt_telemetry.c
>>>> does not exist.
>>>>
>>>> So we seem to still have time to also get the telemetry driver userspace API
>>>> fixed too.
>>>>
>>>> I see that Andy gave his Reviewed-by for the intel_pmt_telemetry.c code.
>>>>
>>>> Andy, I have some concerns about the userspace API choices made here,
>>>> see my earlier review of this patch. Do you agree with my suggestions,
>>>> or do you think it would be ok to move forward with the telemetry and
>>>> now also the crashlog API each registering their own private class
>>>> under /sys/class ?
>>>>
>>>> AFAIK classes are supposed to be generic and not driver-private, so
>>>> that seems wrong to me.  Also PMC is Intel specific and vendor specific
>>>> stuff really does not belong under /sys/class AFAIK ?
>>>>
>>>>> Do you have any good examples of anything that has done something
>>>>> similar? From what I can tell it looks like we need to clean up the
>>>>> naming to drop the ".%d.auto" for the bus directory names
>>>>
>>>> Assuming there will only be one of each platform-device, then you
>>>> can just replace the PLATFORM_DEVID_AUTO param to devm_mfd_add_devices()
>>>> with PLATFORM_DEVID_NONE and the .%d.auto will go away.
>>>
>>> We will have multiples of each platform device. So for example we can
>>> have multiple OOBMSM in each system and each OOBMSM may have multiple
>>> telemetry regions and maybe one crashlog.
>>
>> What is a OOBMSM ? Please don't make the person reviewing your patches
>> do detective work. Only use acronyms if they are something of which
>> you could reasonably expect any mailinglist reader to know what
>> they are.
> 
> OOBMSM is an acronym for the Out-of-Band Management Services Module.
> It is a PCIe function exposed by a device or CPU to provide in-band
> telemetry.
> 
>> So looking at:
>> https://lore.kernel.org/lkml/20200819180255.11770-3-david.e.box@linux.intel.com/
>>
>> What you are saying (I guess) is that both the pmt_pci_probe()
>> function may run multiple times; and that for a single pmt_pci_probe()
>> call, pmt_add_dev() may hit the DVSEC_INTEL_ID_TELEMETRY case more then
>> once?
>>
>> If I understand either one correct, then indeed we need PLATFORM_DEVID_AUTO.
>>
>> Which I guess makes using a class for enumeration somewhat sensible.
> 
> Correct. In our case there will be multiple instances of each device
> being potentially allocated.
> 
>> But I really do not think we need 2 separate classes, one for
>> pmt_telemetry and one for pmt_crashlog. Also since this is rather
>> Intel specific lets at least make that clear in the name.
>>
>> So how about intel_pmt as class and then register both the telemetry
>> and the crashlog devs there? (the type can easily be deferred from
>> the name part before the .%d.auto suffix) ?
> 
> Agreed. So we would set it up as an intel_pmt and then in the case of
> crashlog we would be adding the binary sysfs for the memory access, a
> trigger control, and the enable control. For the telemetry we would
> just be adding the binary sysfs for the telemetry access. Do I have
> all of that correct?

Yes sounds good.

Regards,

Hans

