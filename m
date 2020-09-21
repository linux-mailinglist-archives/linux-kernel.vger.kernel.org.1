Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D4272662
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgIUN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIUN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:58:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CAC061755;
        Mon, 21 Sep 2020 06:58:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u6so15419144iow.9;
        Mon, 21 Sep 2020 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dI0gRctuUF3r2hKiRsVkAQlGlvj+vIL04U762NV6T6g=;
        b=aBunCYzYaq1I4AADqRdvlweP+hwcIUhSKIuEEf1zKiQG84jsve+Ac1NVUCWYzcyx0u
         +VeZte+aEnSjPn+F9rdPvZvZStxML9TNVi4YTOlPERpluWeogeR4KoixbAT4OHiOCv14
         IJOX7rTy4pVMPXeTCi0v6POk9GtPDOqkPoC6nGvWWfS87wDGJ+BFU/A9mtO4ZIsS5K7n
         eZpSjIr90Y7rwRgaPqzPNcb2DluXL1bxeO4cfuTZ7lz2oEOPS7XkAhFevWvDa9nFP3E/
         BIiRwWLbWz7byj4zoaFoelUhezn4Qg8Czw4IPhOG/1NAOH6ZBHWwzpIJysh9pJIPGa8o
         7swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dI0gRctuUF3r2hKiRsVkAQlGlvj+vIL04U762NV6T6g=;
        b=IsjypiIPVzI4SG2SKDSmeLfcFG74fwwuSSAL4rfyxzw3ijVoihEPJ6a5dYUFwwynSy
         GRyMi0GXgcwnmkU3X3/tcCmbpTNyV67bjdFlO5Hjgt0Gg5BqkO6v/01cXxvHONi92Wds
         HdPYy4nCbY8Y6kQHtnaaEAgPM0bFQuUc3QFeHLK0ySULJ+WJfW5rX4JPe0OxY1FCRlbq
         M2cByFrgoANefDFsSIvE3A2OcZd0ada0FOaUUyee6vDUv3vcWX1sTunNMICA9ydSBL0o
         2LVAMiK1sBB2TGz6gDdAmBAJJgex7fNkLBblruufjSBjua41WbjpM91UlOstLAle/9VN
         aPqg==
X-Gm-Message-State: AOAM5301dTV5XSuNSuZ6Mjxyj6qIMEUs/GumedLEAgWu/IZNokwA3jYF
        r//bUf5ZQj2qARN0JYhp9tdxNCafCl1ixxaKbQU=
X-Google-Smtp-Source: ABdhPJyJydztj2+aqPLBtWjXshYDZROcALoe8+eUeEaKvOdYFLPHoC7RuKRcmytcrIbTBcb4hGi26xJZlaEyFUO7+z4=
X-Received: by 2002:a05:6638:25cd:: with SMTP id u13mr84620jat.87.1600696689885;
 Mon, 21 Sep 2020 06:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com> <6e3738db-bfff-7fd2-65e6-bd0d126f9eaa@redhat.com>
 <CAKgT0UcxSwRseMBdMd0_HDUS=JGZDAZnAy-tkLkB-hMXLYtucw@mail.gmail.com>
 <CAKgT0UfM0534GZcKzgTeEa3nq2+FWHk4PfA593smGOLun4d97A@mail.gmail.com>
 <67f5816a-1307-da81-ff71-cea1f907b58b@redhat.com> <CAKgT0UdvuLuDRnE5nzOr6fWkC9TJVQNRa+kf1Pcb9mUxGMBXPw@mail.gmail.com>
 <9025435b-c25c-1b31-fcea-2bc27946c754@redhat.com>
In-Reply-To: <9025435b-c25c-1b31-fcea-2bc27946c754@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 21 Sep 2020 06:57:58 -0700
Message-ID: <CAKgT0Uf2Wo8bQPu6MeF+t91-+y2NOWiOg1i5bsG52tFQPBWjBg@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, dvhart@infradead.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 6:16 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/17/20 11:35 PM, Alexander Duyck wrote:
> > On Thu, Sep 17, 2020 at 5:12 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 9/15/20 12:35 AM, Alexander Duyck wrote:
> >>> On Mon, Sep 14, 2020 at 11:07 AM Alexander Duyck
> >>> <alexander.duyck@gmail.com> wrote:
> >>>>
> >>>> On Mon, Sep 14, 2020 at 6:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On 9/11/20 9:45 PM, David E. Box wrote:
> >>>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>>
> >>>>>> Add support for the Intel Platform Monitoring Technology crashlog
> >>>>>> interface.  This interface provides a few sysfs values to allow for
> >>>>>> controlling the crashlog telemetry interface as well as a character driver
> >>>>>> to allow for mapping the crashlog memory region so that it can be accessed
> >>>>>> after a crashlog has been recorded.
> >>>>>>
> >>>>>> This driver is meant to only support the server version of the crashlog
> >>>>>> which is identified as crash_type 1 with a version of zero. Currently no
> >>>>>> other types are supported.
> >>>>>>
> >>>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> >>>>>> ---
> >>>>>>     .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
> >>>>>>     drivers/platform/x86/Kconfig                  |  10 +
> >>>>>>     drivers/platform/x86/Makefile                 |   1 +
> >>>>>>     drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
> >>>>>>     4 files changed, 665 insertions(+)
> >>>>>>     create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
> >>>>>>     create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
> >>>>>>
> >>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-pmt_crashlog b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..40fb4ff437a6
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
> >>>>>> @@ -0,0 +1,66 @@
> >>>>>> +What:                /sys/class/pmt_crashlog/
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             The pmt_crashlog/ class directory contains information
> >>>>>> +             for devices that expose crashlog capabilities using the Intel
> >>>>>> +             Platform Monitoring Technology (PTM).
> >>>>>> +
> >>>>>> +What:                /sys/class/pmt_crashlog/crashlogX
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             The crashlogX directory contains files for configuring an
> >>>>>> +             instance of a PMT crashlog device that can perform crash data
> >>>>>> +             recoring. Each crashlogX device has an associated
> >>>>>> +             /dev/crashlogX device node. This node can be opened and mapped
> >>>>>> +             to access the resulting crashlog data. The register layout for
> >>>>>> +             the log can be determined from an XML file of specified guid
> >>>>>> +             for the parent device.
> >>>>>> +
> >>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/guid
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             (RO) The guid for this crashlog device. The guid identifies the
> >>>>>> +             version of the XML file for the parent device that should be
> >>>>>> +             used to determine the register layout.
> >>>>>> +
> >>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/size
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             (RO) The length of the result buffer in bytes that corresponds
> >>>>>> +             to the mapping size for the /dev/crashlogX device node.
> >>>>>> +
> >>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/offset
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             (RO) The offset of the buffer in bytes that corresponds
> >>>>>> +             to the mapping for the /dev/crashlogX device node.
> >>>>>> +
> >>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/enable
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             (RW) Boolean value controlling if the crashlog functionality
> >>>>>> +             is enabled for the /dev/crashlogX device node.
> >>>>>> +
> >>>>>> +What:                /sys/class/pmt_crashlog/crashlogX/trigger
> >>>>>> +Date:                September 2020
> >>>>>> +KernelVersion:       5.10
> >>>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>>>> +Description:
> >>>>>> +             (RW) Boolean value controlling  the triggering of the
> >>>>>> +             /dev/crashlogX device node. When read it provides data on if
> >>>>>> +             the crashlog has been triggered. When written to it can be
> >>>>>> +             used to either clear the current trigger by writing false, or
> >>>>>> +             to trigger a new event if the trigger is not currently set.
> >>>>>> +
> >>>>>
> >>>>> Both the pmt_crashlog and the attributes suggest that this is highly
> >>>>> Intel PMT specific. /sys/class/foo interfaces are generally speaking
> >>>>> meant to be generic interfaces.
> >>>>>
> >>>>> If this was defining a generic, vendor and implementation agnostic interface for
> >>>>> configuring / accessing crashlogs, then using a class would be fine, but that
> >>>>> is not the case, so I believe that this should not implement / register a class.
> >>>>>
> >>>>> Since the devices are instantiated through MFD there already is a
> >>>>> static sysfs-path which can be used to find the device in sysfs:
> >>>>> /sys/bus/platform/device/pmt_crashlog
> >>>>>
> >>>>> So you can register the sysfs attributes directly under the platform_device
> >>>>> and then userspace can easily find them, so there really is no need to
> >>>>> use a class here.
> >>>>
> >>>> I see. So we change the root directory from "/sys/class/pmt_crashlog/"
> >>>> to "/sys/bus/platform/device/pmt_crashlog" while retaining the same
> >>>> functionality. That should be workable.
> >>>
> >>> So one issue as I see it is that if we were to change this then we
> >>> probably need to to change the telemetry functionality that was
> >>> recently accepted
> >>> (https://lore.kernel.org/lkml/20200819180255.11770-1-david.e.box@linux.intel.com/)
>
> You say that this has been accepted, by I don't see any intel_pmt.c
> file here yet: ?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mfd/

Here is a link to the thread on the first patch set. The last notes I
saw were that it was going to be applied but it looks like that never
happened.
https://lore.kernel.org/lkml/20200819180255.11770-1-david.e.box@linux.intel.com/

> >>> as well. The general idea with using the /sys/class/pmt_crashlog/
> >>> approach was to keep things consistent with how the pmt_telemetry was
> >>> being accessed. So if we change this then we end up with very
> >>> different interfaces for the two very similar pieces of functionality.
> >>> So ideally we would want to change both telemetry and crashlog to
> >>> function the same way.
> >>
> >> I agree that the telemetry interface should be changed in a similar way.
> >>
> >> Luckily it seems that this is not in Linus' tree yet and I'm also not
> >> seeing it in next yet, e.g. :
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/platform/x86/intel_pmt_telemetry.c
> >> does not exist.
> >>
> >> So we seem to still have time to also get the telemetry driver userspace API
> >> fixed too.
> >>
> >> I see that Andy gave his Reviewed-by for the intel_pmt_telemetry.c code.
> >>
> >> Andy, I have some concerns about the userspace API choices made here,
> >> see my earlier review of this patch. Do you agree with my suggestions,
> >> or do you think it would be ok to move forward with the telemetry and
> >> now also the crashlog API each registering their own private class
> >> under /sys/class ?
> >>
> >> AFAIK classes are supposed to be generic and not driver-private, so
> >> that seems wrong to me.  Also PMC is Intel specific and vendor specific
> >> stuff really does not belong under /sys/class AFAIK ?
> >>
> >>> Do you have any good examples of anything that has done something
> >>> similar? From what I can tell it looks like we need to clean up the
> >>> naming to drop the ".%d.auto" for the bus directory names
> >>
> >> Assuming there will only be one of each platform-device, then you
> >> can just replace the PLATFORM_DEVID_AUTO param to devm_mfd_add_devices()
> >> with PLATFORM_DEVID_NONE and the .%d.auto will go away.
> >
> > We will have multiples of each platform device. So for example we can
> > have multiple OOBMSM in each system and each OOBMSM may have multiple
> > telemetry regions and maybe one crashlog.
>
> What is a OOBMSM ? Please don't make the person reviewing your patches
> do detective work. Only use acronyms if they are something of which
> you could reasonably expect any mailinglist reader to know what
> they are.

OOBMSM is an acronym for the Out-of-Band Management Services Module.
It is a PCIe function exposed by a device or CPU to provide in-band
telemetry.

> So looking at:
> https://lore.kernel.org/lkml/20200819180255.11770-3-david.e.box@linux.intel.com/
>
> What you are saying (I guess) is that both the pmt_pci_probe()
> function may run multiple times; and that for a single pmt_pci_probe()
> call, pmt_add_dev() may hit the DVSEC_INTEL_ID_TELEMETRY case more then
> once?
>
> If I understand either one correct, then indeed we need PLATFORM_DEVID_AUTO.
>
> Which I guess makes using a class for enumeration somewhat sensible.

Correct. In our case there will be multiple instances of each device
being potentially allocated.

> But I really do not think we need 2 separate classes, one for
> pmt_telemetry and one for pmt_crashlog. Also since this is rather
> Intel specific lets at least make that clear in the name.
>
> So how about intel_pmt as class and then register both the telemetry
> and the crashlog devs there? (the type can easily be deferred from
> the name part before the .%d.auto suffix) ?

Agreed. So we would set it up as an intel_pmt and then in the case of
crashlog we would be adding the binary sysfs for the memory access, a
trigger control, and the enable control. For the telemetry we would
just be adding the binary sysfs for the telemetry access. Do I have
all of that correct?

> >>> and then
> >>> look at adding a folder to handle all of the instances of either
> >>> telemetry or crashlog, assuming we follow the reg-dummy or serial8250
> >>> model.
> >>
> >> So there can be multiple instances, you mean like the multiple chardevs
> >> you add now, or can there be multiple platform-devices of the same
> >> time instantiated through the MFD code ?
> >>
> >> If you mean like the multiple chardevs, then yes you could add a folder
> >> for the binary sysfs attributes replacing those, or register them
> >> with a dynamic name with a number appended to the name.
> >
> > In addition to just the binary sysfs we need to expose several other
> > fields including the GUID, the size, and controls for enabling,
> > disabling, and either triggering or checking to see if the crashlog
> > has already been triggered. As such we would end up with a folder per
> > device and the binary sysfs would probably be living in the folder.
>
> Erm, in the Documentation/ABI/testing/sysfs-class-pmt_crashlog
> file from above you already put all that in sysfs ?
>
> So just add the binary sysfs file replacing the char-device next
> to (in the same dir as) the existing sysfs attributes for these.

Okay.

Thanks.

- Alex
