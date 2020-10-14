Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BD28E514
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgJNRIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgJNRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:08:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D111C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:08:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dt13so5841268ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pf99k+07m4mrIb1gS8zJR1G3mnh/ke8MCJBxtPKJpIg=;
        b=dskpwNai/nW+6CeBYPmy3qMPZMo/vdZqY2CzNKTpJDMw+izbww2lwD77LzFIC+KNfk
         0rp1P7Osvoc4QIlqEeoFL8qb1XTVON3oQoWoUXCAShqI3PGkWzSdlASaXl1wxW5GTMvP
         yGD6ZefqbnXLaz/t2w3ZcDTjANZDIMmoTsP44AOYRMkMZeu1o84vnYxDhQh+C4irRjN3
         5496sO0xYt15qh4AICwmX4BVCRYJeefCo541MfOZqdCALuSgC40IXhgwwuc6jU0Rj+2e
         TB8ChLj5cFDa99FToOwWF43JCMggB8RzxUo4NckMXOhfH50JE95OFJOEiiiAOncQP0wN
         7URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pf99k+07m4mrIb1gS8zJR1G3mnh/ke8MCJBxtPKJpIg=;
        b=oqbAWScSwEipUO/tJeYf7OsvFVrDIupmOPUMyT4DCWsWUFLupe8OVRPHXd3HfVVoVx
         FeAHaKtuBFycDMPWFt2dUUTcR6QS/lJTR9mfvav4zzsokMJxuM2oth3oFFPyYxWykf++
         hUFn/n44320EWQcP2re3XWTC/t5kCs1bVQgBI2OiZ/5Nv9IH4WJ7jP3JVe1bfL99Let0
         eclbBz8QtDbpMuiVSr3e5E5IWDgR++owwqhy9A7DVSZIwubqQKorubr5dnn6PHywRxg0
         IHRfci0GjLujNg1BMnC/e+OhMWrqWTDpHWDUwvDDXX1F10aGjOD1jQH63vqGQGzYyB5R
         3DGQ==
X-Gm-Message-State: AOAM530P22m7y38zUt/00TgB7j0jaJW8Br0qKosPvfu59b9/tRJMrAc2
        BOahTC7xY8V5dHH6/v6Ja4R0uaMcpXQ=
X-Google-Smtp-Source: ABdhPJzbDp0iY6SGfoqUIkn/ASnftk+Mjf+S/3ZviDzODph9KmrUqwtD9Fjb4MvgFMxqMLuSn08sbg==
X-Received: by 2002:a17:907:1010:: with SMTP id ox16mr6449080ejb.379.1602695316426;
        Wed, 14 Oct 2020 10:08:36 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p24sm78869edq.35.2020.10.14.10.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:08:35 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <872e84c9-ff49-c5a3-d07e-10a80b10ffa9@gmail.com>
Date:   Wed, 14 Oct 2020 10:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014091806.GB20315@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 2:18 AM, Sudeep Holla wrote:
> Hi Florian,
> 
> Thanks for the patch, it shows someone else is also using this and
> testing 😉.
> 
> On Tue, Oct 13, 2020 at 07:17:37PM -0700, Florian Fainelli wrote:
>> When more than a single SCMI device are present in the system, the
>> creation of the notification workqueue with the WQ_SYSFS flag will lead
>> to the following sysfs duplicate node warning:
>>
> 
> Please trim the calltrace next time without timestamp and register raw
> hex values.

Will do, thanks!

> 
> You using this on 32-bit platform ? If so, thanks for additional test
> coverage.

We have a mix of ARMv7/LPAE (Brahma-B15) and ARMv8 (Brahma-B53,
Cortex-A72) devices that we regularly test with 32-bit and 64-bit kernels.

> 
>> [    9.259990] sysfs: cannot create duplicate filename '/devices/virtual/workqueue/scmi_notify'
>> [    9.260024] CPU: 0 PID: 20 Comm: kworker/0:1 Not tainted 5.9.0-gdf4dd84a3f7d #29
>> [    9.260045] Hardware name: Broadcom STB (Flattened Device Tree)
>> [    9.260083] Workqueue: events deferred_probe_work_func
>> [    9.260099] Backtrace:
>> [    9.260127] [<c02120b4>] (dump_backtrace) from [<c02123d8>] (show_stack+0x20/0x24)
>> [    9.260155]  r9:ffffffff r8:00000000 r7:c298e3c0 r6:60000013 r5:00000000 r4:c298e3c0
>> [    9.260186] [<c02123b8>] (show_stack) from [<c08852a0>] (dump_stack+0xbc/0xe0)
>> [    9.260216] [<c08851e4>] (dump_stack) from [<c054442c>] (sysfs_warn_dup+0x70/0x80)
>> [    9.260243]  r10:e472d814 r9:ffffffef r8:e4614a50 r7:c2806d48 r6:e0e50f80 r5:e4614a50
>> [    9.260265]  r4:e0e82000 r3:c5b17c34
>> [    9.260285] [<c05443bc>] (sysfs_warn_dup) from [<c05445fc>] (sysfs_create_dir_ns+0x15c/0x1a4)
>> [    9.260310]  r7:c2806d48 r6:ffffffef r5:e0dff008 r4:bb8cd6e4
>> [    9.260335] [<c05444a0>] (sysfs_create_dir_ns) from [<c088ebac>] (kobject_add_internal+0x140/0x4d0)
>> [    9.260363]  r9:e451fa80 r8:e0dff01c r7:e0dff014 r6:e45b1400 r5:e0dff018 r4:e0dff008
>> [    9.260390] [<c088ea6c>] (kobject_add_internal) from [<c088f004>] (kobject_add+0xc8/0x138)
>> [    9.260416]  r10:e0dff030 r9:00000000 r8:e45b1400 r7:00000000 r6:c2806d48 r5:e0dff008
>> [    9.260436]  r4:bb8cd708
>> [    9.260455] [<c088ef3c>] (kobject_add) from [<c0a0bc70>] (device_add+0x1dc/0xc20)
>> [    9.260476]  r3:e0dff014 r2:00000000
>> [    9.260495]  r9:00000000 r8:e466b980 r7:e45b1400 r6:c2806d48 r5:bb8cd724 r4:e0dff008
>> [    9.260521] [<c0a0ba94>] (device_add) from [<c0a0c6d8>] (device_register+0x24/0x28)
>> [    9.260547]  r10:c2831340 r9:e0dfec08 r8:e0dff028 r7:e0dfecc0 r6:e0dfec00 r5:e0dff008
>> [    9.260567]  r4:e0dff008
>> [    9.260586] [<c0a0c6b4>] (device_register) from [<c025f2a8>] (workqueue_sysfs_register+0xe4/0x1f0)
>> [    9.260609]  r5:e0dff008 r4:e0dff000
>> [    9.260627] [<c025f1c4>] (workqueue_sysfs_register) from [<c025f7fc>] (alloc_workqueue+0x448/0x6ac)
>> [    9.260655]  r10:e0dfecc0 r9:e0dfec08 r8:e0dfec0c r7:e0dfec04 r6:e0dfecc0 r5:e0dfec00
>> [    9.260675]  r4:00000001
>> [    9.260698] [<c025f3b4>] (alloc_workqueue) from [<c0d8b58c>] (scmi_notification_init+0x78/0x1dc)
>> [    9.260720]  r3:c0a1b488 r2:00000000
>> [    9.260739]  r10:e0de1040 r9:00800004 r8:e0de10d8 r7:e0de10f4 r6:e0de1074 r5:e0e54740
>> [    9.260759]  r4:e0e50d00
>> [    9.260778] [<c0d8b514>] (scmi_notification_init) from [<c0d87c00>] (scmi_probe+0x268/0x4fc)
>> [    9.260805]  r9:00800004 r8:e0de10d8 r7:e0de10f4 r6:e0de1074 r5:e0de10f0 r4:e472d810
>> [    9.260833] [<c0d87998>] (scmi_probe) from [<c0a17d74>] (platform_drv_probe+0x70/0xc8)
>> [    9.260859]  r10:e472d844 r9:c2ab02b4 r8:c2b5e298 r7:00000000 r6:c2ab02b4 r5:00000000
>> [    9.260879]  r4:e472d810
>> [    9.260898] [<c0a17d04>] (platform_drv_probe) from [<c0a13e80>] (really_probe+0x184/0x728)
>> [    9.260922]  r7:00000000 r6:c2fc82a0 r5:c2fc8220 r4:e472d810
>> [    9.260946] [<c0a13cfc>] (really_probe) from [<c0a146b4>] (driver_probe_device+0xa4/0x278)
>> [    9.260973]  r10:e0cef438 r9:c0a14a04 r8:c2b771c0 r7:c2b5e298 r6:c2ab02b4 r5:e472d834
>> [    9.260993]  r4:e472d810
>> [    9.261014] [<c0a14610>] (driver_probe_device) from [<c0a14aec>] (__device_attach_driver+0xe8/0x148)
>> [    9.261042]  r10:e0cef438 r9:c0a14a04 r8:e466bdc0 r7:e472d810 r6:00000000 r5:c2ab02b4
>> [    9.261062]  r4:e466bdc0
>> [    9.261082] [<c0a14a04>] (__device_attach_driver) from [<c0a10f6c>] (bus_for_each_drv+0x108/0x158)
>> [    9.261107]  r7:c2806d48 r6:00000000 r5:bb8cd79c r4:e466bd00
>> [    9.261131] [<c0a10e64>] (bus_for_each_drv) from [<c0a13c38>] (__device_attach+0x190/0x234)
>> [    9.261158]  r10:e46fde00 r9:e472d848 r8:e472d854 r7:e466be00 r6:c2806d48 r5:bb8cd7b4
>> [    9.261178]  r4:e472d810
>> [    9.261199] [<c0a13aa8>] (__device_attach) from [<c0a14b68>] (device_initial_probe+0x1c/0x20)
>> [    9.261226]  r10:e46fde54 r9:c29d6380 r8:c29d7910 r7:e472d810 r6:c29d78c0 r5:c29d6340
>> [    9.261246]  r4:e44efe00
>> [    9.261266] [<c0a14b4c>] (device_initial_probe) from [<c0a125fc>] (bus_probe_device+0xdc/0xec)
>> [    9.261296] [<c0a12520>] (bus_probe_device) from [<c0a12e24>] (deferred_probe_work_func+0xd4/0x11c)
>> [    9.261324]  r9:c29d6380 r8:e4672e54 r7:c29d6380 r6:c29d6340 r5:c29d6340 r4:e472d810
>> [    9.261356] [<c0a12d50>] (deferred_probe_work_func) from [<c025a534>] (process_one_work+0x420/0x8f0)
>> [    9.261384]  r10:e452fd84 r9:c2b53750 r8:00000000 r7:e452ae0c r6:e8a1e240 r5:e452ae00
>> [    9.261404]  r4:c29d6440
>> [    9.261424] [<c025a114>] (process_one_work) from [<c025af00>] (worker_thread+0x4fc/0x91c)
>> [    9.261450]  r10:e8a1e258 r9:e452ae00 r8:e8a1e254 r7:e8a1e240 r6:e452fd84 r5:e8a1e254
>> [    9.261470]  r4:e452ae14
>> [    9.261492] [<c025aa04>] (worker_thread) from [<c026591c>] (kthread+0x21c/0x22c)
>> [    9.261517]  r10:e455bce0 r9:e45b8d80 r8:e452ae00 r7:c025aa04 r6:e45b8d80 r5:00000000
>> [    9.261537]  r4:e45c0400
>> [    9.261555] [<c0265700>] (kthread) from [<c0200114>] (ret_from_fork+0x14/0x20)
>> [    9.261575] Exception stack(0xe466bfb0 to 0xe466bff8)
>> [    9.261593] bfa0:                                     00000000 00000000 00000000 00000000
>> [    9.261618] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    9.261641] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [    9.261663]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0265700
>> [    9.261683]  r4:e4622080
>> [    9.261728] kobject_add_internal failed for scmi_notify with -EEXIST, don't try to register things with the same name in the same directory.
>> [    9.261805] arm-scmi brcm_scmi@1: SCMI Notifications - Initialization Failed.
>> [    9.261847] arm-scmi brcm_scmi@1: SCMI Notifications NOT available.
>> [    9.262026] arm-scmi brcm_scmi@1: SCMI Protocol v1.0 'brcm-scmi:' Firmware version 0x1
>>
>> Fix this by using dev_name(handle->dev) which guarantees that the name is
>> unique and this also helps correlate which notification workqueue corresponds
>> to which SCMI device instance.
>>
> 
> I am curious as how multiple SCMI instances are used. We know few limitations
> in the code to handle that yet, so interested to know if you are carrying
> more patches/fixes.

We currently have two SCMI device nodes in Device Tree:

- the first one is responsible for all of the base, performance, sensors
protocols and is present on all of the chips listed above

- the second one is responsible for a proprietary protocol through which
we encapsulate a variety of operations towards a secure agent in the
system, this is only present in a subset of devices.

The reason for that split was because the nature of the SCMI traffic was
different, the first one is comprised of small messages dealing with
power management, most messages can be completed synchronously (or
quasi, if you remember our mailbox implementation) whereas the second is
comprised of large and asynchronously completed messages. This is not
probably a common set-up, and we have since eliminated that second SCMI
interface and went with a direct Linux to agent interface that does not
"speak" SCMI.

We may still have multiple SCMI devices in the future since we are
trying to separate out the CPU performance domain which involves writing
to registers that are either ARM system control registers, or only on an
ARM CPU local bus. The other clock/performance controls can go directly
to the agent implementing SCMI.

> 
>> Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/firmware/arm_scmi/notify.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
>> index 4731daaacd19..24c9ef232f48 100644
>> --- a/drivers/firmware/arm_scmi/notify.c
>> +++ b/drivers/firmware/arm_scmi/notify.c
>> @@ -1468,7 +1468,7 @@ int scmi_notification_init(struct scmi_handle *handle)
>>  	ni->gid = gid;
>>  	ni->handle = handle;
>>  
>> -	ni->notify_wq = alloc_workqueue("scmi_notify",
>> +	ni->notify_wq = alloc_workqueue(dev_name(handle->dev),
> 
> Not sure if it makes sense to add "_notify" to clearly identify the workqueue.

I had intentionally not done it because:

- it would create a different name than "dev_name" and I liked having
the same name throughout the entire sysfs hierarchy to easily identify
the device

- it would require doing a sprintf() variant to format the name which
require a temporary buffer

No strong preference either way though.
-- 
Florian
