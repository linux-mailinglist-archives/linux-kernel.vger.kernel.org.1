Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB726DACA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIQLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgIQLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600343343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIOTnLJn3GvxUVqb33sUqtVuUK+v3BB7+6gGdZ/dnGU=;
        b=VY2YxXsOTv4pFWOvOHH9Nc0CVFwPN6xWA4HKcTrgH3U3v4/YrSDOmJEFjsUfg7x9BlwaiA
        C7ptnrpRX0r2guDL5n4g1Y0yaLj6ETwGoSBlTTlB69xLwqM/ZxrpfBVU8AHgjYzodicSXD
        rgmYV7zBK4hPJiPmDLDkRTkaJGfvWHU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-l9cKmQhgP4-O3oMtRPZmKQ-1; Thu, 17 Sep 2020 07:48:57 -0400
X-MC-Unique: l9cKmQhgP4-O3oMtRPZmKQ-1
Received: by mail-ej1-f69.google.com with SMTP id dc22so762609ejb.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fIOTnLJn3GvxUVqb33sUqtVuUK+v3BB7+6gGdZ/dnGU=;
        b=Z26pIj0hDbEckZLegvKd5muNh6wM8KMNWPcnbAOq0wECGlirL845idOJmMBeShBlbO
         11foeVSo1b3fZVBZk5ZNgQeb3CIC1JjgTDF/RLFv11OPry/1dSRwxT0D0EEFgAFfD2Rp
         XnFko0AjB1u4PVwM7qFIFpNUwLIKXTUzD0HUuSslwkC44YLHZ9TVJ70xA74eQk/vO4Ow
         DP2kdi0u603LZnGG1ThML/gXZP0UDAofMqIPiNQrerrYRsQTb/lWZG6lL7uginej9Ih4
         ZTtwoUK0QC36+vhQ8ub+ZeAua8wlmjxzsGQMrrIvB+11LKr3VzFmcH0xU6dQ4QLByY5Y
         W44A==
X-Gm-Message-State: AOAM533toyBSUUywELyZTQpueMzV0zOi4hnMO4akGHDkffOgYM+EDlar
        DeWSUL+95SEW2vmV4x1LB5e0FXI3h9kwp9eFwJRn/SiH86KeoLsg1XXCHxQFNpd1BJ2qv+PKTq3
        yvZWNTQ/oxUFcrTTzArptPVKe
X-Received: by 2002:a17:906:3bd8:: with SMTP id v24mr31228865ejf.509.1600343335556;
        Thu, 17 Sep 2020 04:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEoexmREwK9xyUcNyD26RuFAnhzMvgVtCvuk88tEd+9KWugKt6ecaIVr7zJg6VSqQxLcT6JA==
X-Received: by 2002:a17:906:3bd8:: with SMTP id v24mr31228838ejf.509.1600343335213;
        Thu, 17 Sep 2020 04:48:55 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id k19sm14765946ejo.40.2020.09.17.04.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 04:48:54 -0700 (PDT)
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com>
 <6e3738db-bfff-7fd2-65e6-bd0d126f9eaa@redhat.com>
 <CAKgT0UcxSwRseMBdMd0_HDUS=JGZDAZnAy-tkLkB-hMXLYtucw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f4b1fbb3-5d73-1214-8cd2-79432d4b23e4@redhat.com>
Date:   Thu, 17 Sep 2020 13:48:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcxSwRseMBdMd0_HDUS=JGZDAZnAy-tkLkB-hMXLYtucw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/20 8:07 PM, Alexander Duyck wrote:
> On Mon, Sep 14, 2020 at 6:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 9/11/20 9:45 PM, David E. Box wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> Add support for the Intel Platform Monitoring Technology crashlog
>>> interface.  This interface provides a few sysfs values to allow for
>>> controlling the crashlog telemetry interface as well as a character driver
>>> to allow for mapping the crashlog memory region so that it can be accessed
>>> after a crashlog has been recorded.
>>>
>>> This driver is meant to only support the server version of the crashlog
>>> which is identified as crash_type 1 with a version of zero. Currently no
>>> other types are supported.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>> ---
>>>    .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
>>>    drivers/platform/x86/Kconfig                  |  10 +
>>>    drivers/platform/x86/Makefile                 |   1 +
>>>    drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
>>>    4 files changed, 665 insertions(+)
>>>    create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>>    create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-pmt_crashlog b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>> new file mode 100644
>>> index 000000000000..40fb4ff437a6
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
>>> @@ -0,0 +1,66 @@
>>> +What:                /sys/class/pmt_crashlog/
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             The pmt_crashlog/ class directory contains information
>>> +             for devices that expose crashlog capabilities using the Intel
>>> +             Platform Monitoring Technology (PTM).
>>> +
>>> +What:                /sys/class/pmt_crashlog/crashlogX
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             The crashlogX directory contains files for configuring an
>>> +             instance of a PMT crashlog device that can perform crash data
>>> +             recoring. Each crashlogX device has an associated
>>> +             /dev/crashlogX device node. This node can be opened and mapped
>>> +             to access the resulting crashlog data. The register layout for
>>> +             the log can be determined from an XML file of specified guid
>>> +             for the parent device.
>>> +
>>> +What:                /sys/class/pmt_crashlog/crashlogX/guid
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             (RO) The guid for this crashlog device. The guid identifies the
>>> +             version of the XML file for the parent device that should be
>>> +             used to determine the register layout.
>>> +
>>> +What:                /sys/class/pmt_crashlog/crashlogX/size
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             (RO) The length of the result buffer in bytes that corresponds
>>> +             to the mapping size for the /dev/crashlogX device node.
>>> +
>>> +What:                /sys/class/pmt_crashlog/crashlogX/offset
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             (RO) The offset of the buffer in bytes that corresponds
>>> +             to the mapping for the /dev/crashlogX device node.
>>> +
>>> +What:                /sys/class/pmt_crashlog/crashlogX/enable
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             (RW) Boolean value controlling if the crashlog functionality
>>> +             is enabled for the /dev/crashlogX device node.
>>> +
>>> +What:                /sys/class/pmt_crashlog/crashlogX/trigger
>>> +Date:                September 2020
>>> +KernelVersion:       5.10
>>> +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> +Description:
>>> +             (RW) Boolean value controlling  the triggering of the
>>> +             /dev/crashlogX device node. When read it provides data on if
>>> +             the crashlog has been triggered. When written to it can be
>>> +             used to either clear the current trigger by writing false, or
>>> +             to trigger a new event if the trigger is not currently set.
>>> +
>>
>> Both the pmt_crashlog and the attributes suggest that this is highly
>> Intel PMT specific. /sys/class/foo interfaces are generally speaking
>> meant to be generic interfaces.
>>
>> If this was defining a generic, vendor and implementation agnostic interface for
>> configuring / accessing crashlogs, then using a class would be fine, but that
>> is not the case, so I believe that this should not implement / register a class.
>>
>> Since the devices are instantiated through MFD there already is a
>> static sysfs-path which can be used to find the device in sysfs:
>> /sys/bus/platform/device/pmt_crashlog
>>
>> So you can register the sysfs attributes directly under the platform_device
>> and then userspace can easily find them, so there really is no need to
>> use a class here.
> 
> I see. So we change the root directory from "/sys/class/pmt_crashlog/"
> to "/sys/bus/platform/device/pmt_crashlog" while retaining the same
> functionality. That should be workable.

Ack.

<snip>

>>> +static const struct file_operations pmt_crashlog_fops = {
>>> +     .owner =        THIS_MODULE,
>>> +     .open =         pmt_crashlog_open,
>>> +     .mmap =         pmt_crashlog_mmap,
>>
>> mmap but no read, I guess read may be emulated through mmap,
>> is that the case ?
>>
>> I can see sysadmins wanting to be able to do a simple cat
>> on this file to get the logs (including headers), so if
>> the kernel-core does not emulate read in this case, you
>> should really add read support I guess.
> 
> So first the contents of the crashlog are not really human readable,
> so it is not likely that they would "cat" the contents.

Sorry, I was not really clear there, what I meant is a sysadmin doing
something like this:

cat /sys/.../crashlog-file > /mnt/external-usb-disk/server-foo-bar-crashlog20200917

So that they can easily save the crashlog for later reference without
needing to install special tools.

> Also I don't
> believe it is a very common thing to provide read access if we don't
> know the memory layout of the region. If you take a look at the
> handling for resourceN in
> pci_create_attr(https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/pci/pci-sysfs.c#L1127)
> it looks like it does something similar where it only provides mmap
> for MMIO access.

That was meant as a way to allow doing hardware-drivers in userspace
(think old userspace modesetting Xorg/xfree86) without needing to
call iopl and on non-x86 platforms which don't have iopl.


> 
>> Also how big are these files ?  sysfs also supports binary
>> files, so unless these files are huge / this is really
>> performance critical it may make more sense to just add
>> a binary sysfs attr for this and get rid of the whole chardev
>> all together.
> 
> So for the file we are looking at the minimum of a page up to multiple
> pages of data. It largely depends on how much information is collected
> by the crashlog agent. I can take a look and see if we can do it. Odds
> are it shouldn't be too different from how resourceN is done for the
> PCI devices.

Ok, a few pages of data should not be an issue for a binary sysfs
file at all.

<snip>

>>> +     entry->devid = ida_simple_get(entry->ida, 0, 0, GFP_KERNEL);
>>> +     if (entry->devid < 0)
>>> +             return entry->devid;
>>> +
>>> +     ret = pmt_crashlog_make_dev(priv, entry);
>>> +     if (ret) {
>>> +             ida_simple_remove(entry->ida, entry->devid);
>>> +             return ret;
>>> +     }
>>
>> Hmm wait, you are making one chardev per log entry ? Then just using
>> binary sysfs attributes seems to make even more sense to me.
> 
> Yes we are required to create one per log entry as each one can be
> accessed independently.

That is fine, but then at least to me, using sysfs binary files, seems to make
a lot more sense then creating multiple char devices for this.

Regards,

Hans

