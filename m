Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC37C26DB40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIQMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726868AbgIQMMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600344769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYvTPsLZIKdZMubNPB/I8LO22UxKAq285lr5qRnl3cU=;
        b=JR60c0IIVJlrlPU3YILQmAjKtDXAY3BPFjXYgi9UoM3pASZTiQVvJy387qvPzyBvAZhYKk
        11Wk242ZJx+zj6UuXH4UYNrr+CYGYQqzIlt372HdMSekULEmmRNIbgKThbQACa6/O0pgrJ
        N+GtHRiyzEP/MoMTCXUywcegghiFqbg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-dss43w9eMp-S7x2-zG6dSA-1; Thu, 17 Sep 2020 08:12:47 -0400
X-MC-Unique: dss43w9eMp-S7x2-zG6dSA-1
Received: by mail-ej1-f70.google.com with SMTP id dc22so787245ejb.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYvTPsLZIKdZMubNPB/I8LO22UxKAq285lr5qRnl3cU=;
        b=l54jefM0Wb/HzKpp2/xWeP3siR35JKLvb0ohK3ooETApxa/C2oti4TCBSIXoZL5mkU
         JNpe2TKBirYp+7u2eNYxEkWPJyeNLxPwmTy1nbMfPHKZMWUX+WqspE2Cw8dpdkB/oeyE
         hrgS89VPpc8VwTY+BZi5UL0Wl/pKvduotcJ12uAkmwLmqiKC7zGLuEhmVTp93uova5Pq
         k20ctAoik+pVaa3wvJfBT0MvG5/GJPmlz4ww3SQY1t0RqhfjPc2A66QoXFVluxmgatxZ
         4hejmmY4NK+Q+iz1V0d4JEIX4qq0hsWvPRrqKWmUmsYZdNLnfGrRz5cjanszczzKTpFr
         g3vw==
X-Gm-Message-State: AOAM533QPB9S2F2K0AbSbuTh/hI38TEXMHE9OaANce2hCOimSnITZvMJ
        gP2OtVRRaoryxblq22jy16aISmLCB18Lxo8uXA6KzFattbD96efVXabnJKoQuhsy91/rtV32A3m
        PdTz8Z0lmXcUZ6DlBWZgaoFkV
X-Received: by 2002:aa7:c693:: with SMTP id n19mr33641089edq.101.1600344765666;
        Thu, 17 Sep 2020 05:12:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE4ptNVmI8xraihMa5eYcsFPfZXO3c5C/7JG6wlUkfe8Ipb7JhjNcDCH2O8NKon9JW6Lu0Hw==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr33641052edq.101.1600344765298;
        Thu, 17 Sep 2020 05:12:45 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id u18sm8384335ejm.115.2020.09.17.05.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:12:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com>
 <6e3738db-bfff-7fd2-65e6-bd0d126f9eaa@redhat.com>
 <CAKgT0UcxSwRseMBdMd0_HDUS=JGZDAZnAy-tkLkB-hMXLYtucw@mail.gmail.com>
 <CAKgT0UfM0534GZcKzgTeEa3nq2+FWHk4PfA593smGOLun4d97A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <67f5816a-1307-da81-ff71-cea1f907b58b@redhat.com>
Date:   Thu, 17 Sep 2020 14:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfM0534GZcKzgTeEa3nq2+FWHk4PfA593smGOLun4d97A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 12:35 AM, Alexander Duyck wrote:
> On Mon, Sep 14, 2020 at 11:07 AM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>>
>> On Mon, Sep 14, 2020 at 6:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 9/11/20 9:45 PM, David E. Box wrote:
>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>
>>>> Add support for the Intel Platform Monitoring Technology crashlog
>>>> interface.  This interface provides a few sysfs values to allow for
>>>> controlling the crashlog telemetry interface as well as a character driver
>>>> to allow for mapping the crashlog memory region so that it can be accessed
>>>> after a crashlog has been recorded.
>>>>
>>>> This driver is meant to only support the server version of the crashlog
>>>> which is identified as crash_type 1 with a version of zero. Currently no
>>>> other types are supported.
>>>>
>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>>> ---
>>>>    .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
>>>>    drivers/platform/x86/Kconfig                  |  10 +
>>>>    drivers/platform/x86/Makefile                 |   1 +
>>>>    drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
>>>>    4 files changed, 665 insertions(+)
>>>>    create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>>    create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-class-pmt_crashlog b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>> new file mode 100644
>>>> index 000000000000..40fb4ff437a6
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>> @@ -0,0 +1,66 @@
>>>> +What:                /sys/class/pmt_crashlog/
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             The pmt_crashlog/ class directory contains information
>>>> +             for devices that expose crashlog capabilities using the Intel
>>>> +             Platform Monitoring Technology (PTM).
>>>> +
>>>> +What:                /sys/class/pmt_crashlog/crashlogX
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             The crashlogX directory contains files for configuring an
>>>> +             instance of a PMT crashlog device that can perform crash data
>>>> +             recoring. Each crashlogX device has an associated
>>>> +             /dev/crashlogX device node. This node can be opened and mapped
>>>> +             to access the resulting crashlog data. The register layout for
>>>> +             the log can be determined from an XML file of specified guid
>>>> +             for the parent device.
>>>> +
>>>> +What:                /sys/class/pmt_crashlog/crashlogX/guid
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             (RO) The guid for this crashlog device. The guid identifies the
>>>> +             version of the XML file for the parent device that should be
>>>> +             used to determine the register layout.
>>>> +
>>>> +What:                /sys/class/pmt_crashlog/crashlogX/size
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             (RO) The length of the result buffer in bytes that corresponds
>>>> +             to the mapping size for the /dev/crashlogX device node.
>>>> +
>>>> +What:                /sys/class/pmt_crashlog/crashlogX/offset
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             (RO) The offset of the buffer in bytes that corresponds
>>>> +             to the mapping for the /dev/crashlogX device node.
>>>> +
>>>> +What:                /sys/class/pmt_crashlog/crashlogX/enable
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             (RW) Boolean value controlling if the crashlog functionality
>>>> +             is enabled for the /dev/crashlogX device node.
>>>> +
>>>> +What:                /sys/class/pmt_crashlog/crashlogX/trigger
>>>> +Date:                September 2020
>>>> +KernelVersion:       5.10
>>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> +Description:
>>>> +             (RW) Boolean value controlling  the triggering of the
>>>> +             /dev/crashlogX device node. When read it provides data on if
>>>> +             the crashlog has been triggered. When written to it can be
>>>> +             used to either clear the current trigger by writing false, or
>>>> +             to trigger a new event if the trigger is not currently set.
>>>> +
>>>
>>> Both the pmt_crashlog and the attributes suggest that this is highly
>>> Intel PMT specific. /sys/class/foo interfaces are generally speaking
>>> meant to be generic interfaces.
>>>
>>> If this was defining a generic, vendor and implementation agnostic interface for
>>> configuring / accessing crashlogs, then using a class would be fine, but that
>>> is not the case, so I believe that this should not implement / register a class.
>>>
>>> Since the devices are instantiated through MFD there already is a
>>> static sysfs-path which can be used to find the device in sysfs:
>>> /sys/bus/platform/device/pmt_crashlog
>>>
>>> So you can register the sysfs attributes directly under the platform_device
>>> and then userspace can easily find them, so there really is no need to
>>> use a class here.
>>
>> I see. So we change the root directory from "/sys/class/pmt_crashlog/"
>> to "/sys/bus/platform/device/pmt_crashlog" while retaining the same
>> functionality. That should be workable.
> 
> So one issue as I see it is that if we were to change this then we
> probably need to to change the telemetry functionality that was
> recently accepted
> (https://lore.kernel.org/lkml/20200819180255.11770-1-david.e.box@linux.intel.com/)
> as well. The general idea with using the /sys/class/pmt_crashlog/
> approach was to keep things consistent with how the pmt_telemetry was
> being accessed. So if we change this then we end up with very
> different interfaces for the two very similar pieces of functionality.
> So ideally we would want to change both telemetry and crashlog to
> function the same way.

I agree that the telemetry interface should be changed in a similar way.

Luckily it seems that this is not in Linus' tree yet and I'm also not
seeing it in next yet, e.g. :
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/platform/x86/intel_pmt_telemetry.c
does not exist.

So we seem to still have time to also get the telemetry driver userspace API
fixed too.

I see that Andy gave his Reviewed-by for the intel_pmt_telemetry.c code.

Andy, I have some concerns about the userspace API choices made here,
see my earlier review of this patch. Do you agree with my suggestions,
or do you think it would be ok to move forward with the telemetry and
now also the crashlog API each registering their own private class
under /sys/class ?

AFAIK classes are supposed to be generic and not driver-private, so
that seems wrong to me.  Also PMC is Intel specific and vendor specific
stuff really does not belong under /sys/class AFAIK ?

> Do you have any good examples of anything that has done something
> similar? From what I can tell it looks like we need to clean up the
> naming to drop the ".%d.auto" for the bus directory names

Assuming there will only be one of each platform-device, then you
can just replace the PLATFORM_DEVID_AUTO param to devm_mfd_add_devices()
with PLATFORM_DEVID_NONE and the .%d.auto will go away.

> and then
> look at adding a folder to handle all of the instances of either
> telemetry or crashlog, assuming we follow the reg-dummy or serial8250
> model.

So there can be multiple instances, you mean like the multiple chardevs
you add now, or can there be multiple platform-devices of the same
time instantiated through the MFD code ?

If you mean like the multiple chardevs, then yes you could add a folder
for the binary sysfs attributes replacing those, or register them
with a dynamic name with a number appended to the name.

> Similarly the crashlog and telemetry both rely on similar mechanisms
> to display the MMIO region containing the data. I still need to spend
> some more time looking into what is involved in switching from a char
> device to a binary sysfs, but I think with the example I found earlier
> of the resourceN bit from the PCI sysfs I can probably make that work
> for both cases.

I'm not sure that the PCI sysfs io resources are the best example,
as mentioned those mmap to actual memory-mapped io, which is somewhat
special.

For a simpler example see drivers/platform/x86/wmi-bmof.c.

The way normal sysfs binary attributes work is that they
have a read method much like the read method on a block device
where an offset into the file gets passed. So you just copy_to_user
the requested amount of data starting at offset from the in-kernel
mapped buffer to the user buffer:

static ssize_t
read_bmof(struct file *filp, struct kobject *kobj,
          struct bin_attribute *attr,
          char *buf, loff_t off, size_t count)
{
         struct bmof_priv *priv =
                 container_of(attr, struct bmof_priv, bmof_bin_attr);

         if (off < 0)
                 return -EINVAL;

         if (off >= priv->bmofdata->buffer.length)
                 return 0;

         if (count > priv->bmofdata->buffer.length - off)
                 count = priv->bmofdata->buffer.length - off;

         memcpy(buf, priv->bmofdata->buffer.pointer + off, count);
         return count;
}

The wmi_bmof code also shows how you can dynamically create and
add binary sysfs attr which allows you to add a %d postfix to the
name. Note you should always dynamically create binary sysfs attr.

There are some old static initializers for these, but AFAIK those
lead to lockdep issues.

Regards,

Hans

