Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F3319D507
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgDCK1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 06:27:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727940AbgDCK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585909668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHw9iwKjMkYshJ17dVhJvBCdJkzI/fYth3f2V7Qym+g=;
        b=JUE4TGZjLxLqGgClsn6C3WDuMApfa/nW7Z5VKtmYSmjiKYwXcQn5jA5rkJkg97Ae/AdkCR
        Tia0H3H7wWKgjwQqyAWtwKIqpCH+OX15wFjsRQW1TuIUiSnuTYVGO7DCmUZP8PNDOaBOuR
        x+onZ5yEX29lMWAdVHABoka/vunRlF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-YJb5m2soMFiXzw-OTdz3Nw-1; Fri, 03 Apr 2020 06:27:46 -0400
X-MC-Unique: YJb5m2soMFiXzw-OTdz3Nw-1
Received: by mail-wm1-f70.google.com with SMTP id l13so2594053wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 03:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHw9iwKjMkYshJ17dVhJvBCdJkzI/fYth3f2V7Qym+g=;
        b=Sjd/LIIb769WQpi1wZbwRJS9R3TL2cy9o0y6rlrhiF7iQ172qQDiJS8yXfbgJnkNfX
         81UUUCG8dfat+ZeNsgxJ4Yl6gmlO2lfNGWCrdnkHNju+J5b5MTY653ca1mmeog3sKB0U
         mS2TXepDd8tfadF6bNfmhtjc8Wxdbut0B4a3TipNI78a7fpMF4Q9PNsFEqsDxNiHoLXa
         vs3kg+2Pep/yE5VpuAr89TGhPkTMd+DXNi1Lhc/VzBsab4cUZlEjSeU6Zr+b9fkl8VNq
         miHRcjEyW73C/A6Eu1iLvnOQX85sem0FSvW6MQR1kAVTeHK+lwtOH+rL8h3r1FHSVWtt
         SeZw==
X-Gm-Message-State: AGi0PuZMLZwyZ2Rbkf+QTEr7H6kWgcIv0nXPLyQq+NLuNrv1MPexvswa
        v1Z6/LECTsT3+S4VaABTe9nTE4TG83ibAtjCgMSIzMX3UCYkTxd652U++d/dIBkUUUqOwMNZDvJ
        jm1hoXb0FfWk/BpTU8HZoF1T4
X-Received: by 2002:adf:c511:: with SMTP id q17mr8407030wrf.275.1585909664800;
        Fri, 03 Apr 2020 03:27:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZi/VsLHrdeSbE19NAsAkHnY1hIp/O/VL5ub1pnDBau5gM2LSnYAJ/BN5CBwd4fZ8tQ7B7Mw==
X-Received: by 2002:adf:c511:: with SMTP id q17mr8407001wrf.275.1585909664461;
        Fri, 03 Apr 2020 03:27:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r3sm11538153wrm.35.2020.04.03.03.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:27:43 -0700 (PDT)
Subject: Re: [PATCH 5.6 regression fix 1/2] ACPI: PM: Add
 acpi_s2idle_register_wake_callback()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200329223419.122796-1-hdegoede@redhat.com>
 <CAJZ5v0iapuqnfsQHhTQTWXdEtzX_MMTBUqdAzCej19AF9rtrNA@mail.gmail.com>
 <daea7dad-73ac-3f2a-75a1-58017988ec89@redhat.com>
 <4023796.rWsessMiv5@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <70f2747e-43b9-f191-5884-6f0fc4e48fe6@redhat.com>
Date:   Fri, 3 Apr 2020 12:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4023796.rWsessMiv5@kreacher>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/20 9:09 PM, Rafael J. Wysocki wrote:
> On Wednesday, April 1, 2020 8:26:16 PM CEST Hans de Goede wrote:
>> Hi,
>>
>> On 4/1/20 6:32 PM, Rafael J. Wysocki wrote:
>>> On Mon, Mar 30, 2020 at 12:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Since commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
>>>> waking up the system") the SCI triggering without there being a wakeup
>>>> cause recognized by the ACPI sleep code will no longer wakeup the system.
>>>>
>>>> This works as intended, but this is a problem for devices where the SCI
>>>> is shared with another device which is also a wakeup source.
>>>>
>>>> In the past these, from the pov of the ACPI sleep code, spurious SCIs
>>>> would still cause a wakeup so the wakeup from the device sharing the
>>>> interrupt would actually wakeup the system. This now no longer works.
>>>>
>>>> This is a problem on e.g. Bay Trail-T and Cherry Trail devices where
>>>> some peripherals (typically the XHCI controller) can signal a
>>>> Power Management Event (PME) to the Power Management Controller (PMC)
>>>> to wakeup the system, this uses the same interrupt as the SCI.
>>>> These wakeups are handled through a special INT0002 ACPI device which
>>>> checks for events in the GPE0a_STS for this and takes care of acking
>>>> the PME so that the shared interrupt stops triggering.
>>>>
>>>> The change to the ACPI sleep code to ignore the spurious SCI, causes
>>>> the system to no longer wakeup on these PME events. To make things
>>>> worse this means that the INT0002 device driver interrupt handler will
>>>> no longer run, causing the PME to not get cleared and resulting in the
>>>> system hanging. Trying to wakeup the system after such a PME through e.g.
>>>> the power button no longer works.
>>>>
>>>> Add an acpi_s2idle_register_wake_callback() function which registers
>>>> a callback to be called from acpi_s2idle_wake() and when the callback
>>>> returns true, return true from acpi_s2idle_wake().
>>>>
>>>> The INT0002 driver will use this mechanism to check the GPE0a_STS
>>>> register from acpi_s2idle_wake() and to tell the system to wakeup
>>>> if a PME is signaled in the register.
>>>>
>>>> Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
>>>> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> I generally agree with the approach, but I would make some, mostly
>>> cosmetic, changes.
>>>
>>> First off, I'd put the new code into drivers/acpi/wakeup.c.
>>>
>>> I'd export one function from there to be called from
>>> acpi_s2idle_wake() and the install/uninstall routines for the users.
>>
>> Ok.
>>
>>>> ---
>>>>    drivers/acpi/sleep.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/acpi.h |  7 +++++
>>>>    2 files changed, 77 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>>>> index e5f95922bc21..e360e51afa8e 100644
>>>> --- a/drivers/acpi/sleep.c
>>>> +++ b/drivers/acpi/sleep.c
>>>> @@ -943,6 +943,65 @@ static struct acpi_scan_handler lps0_handler = {
>>>>           .attach = lps0_device_attach,
>>>>    };
>>>>
>>>> +struct s2idle_wake_callback {
>>>
>>> I'd call this acpi_wakeup_handler.
>>>
>>>> +       struct list_head list;
>>>
>>> list_node?
>>>
>>>> +       bool (*function)(void *data);
>>>
>>> bool (*wakeup)(void *context)?
>>>
>>>> +       void *user_data;
>>>
>>> context?
>>
>> Sure (for all of the above).
>>
>>>
>>>> +};
>>>> +
>>>> +static LIST_HEAD(s2idle_wake_callback_head);
>>>> +static DEFINE_MUTEX(s2idle_wake_callback_mutex);
>>>> +
>>>> +/*
>>>> + * Drivers which may share an IRQ with the SCI can use this to register
>>>> + * a callback which returns true when the device they are managing wants
>>>> + * to trigger a wakeup.
>>>> + */
>>>> +int acpi_s2idle_register_wake_callback(
>>>> +       int wake_irq, bool (*function)(void *data), void *user_data)
>>>> +{
>>>> +       struct s2idle_wake_callback *callback;
>>>> +
>>>> +       /*
>>>> +        * If the device is not sharing its IRQ with the SCI, there is no
>>>> +        * need to register the callback.
>>>> +        */
>>>> +       if (!acpi_sci_irq_valid() || wake_irq != acpi_sci_irq)
>>>> +               return 0;
>>>> +
>>>> +       callback = kmalloc(sizeof(*callback), GFP_KERNEL);
>>>> +       if (!callback)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       callback->function = function;
>>>> +       callback->user_data = user_data;
>>>> +
>>>> +       mutex_lock(&s2idle_wake_callback_mutex);
>>>> +       list_add(&callback->list, &s2idle_wake_callback_head);
>>>> +       mutex_unlock(&s2idle_wake_callback_mutex);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(acpi_s2idle_register_wake_callback);
>>>> +
>>>> +void acpi_s2idle_unregister_wake_callback(
>>>> +       bool (*function)(void *data), void *user_data)
>>>> +{
>>>> +       struct s2idle_wake_callback *cb;
>>>> +
>>>> +       mutex_lock(&s2idle_wake_callback_mutex);
>>>> +       list_for_each_entry(cb, &s2idle_wake_callback_head, list) {
>>>> +               if (cb->function == function &&
>>>> +                   cb->user_data == user_data) {
>>>> +                       list_del(&cb->list);
>>>> +                       kfree(cb);
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +       mutex_unlock(&s2idle_wake_callback_mutex);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(acpi_s2idle_unregister_wake_callback);
>>>> +
>>>>    static int acpi_s2idle_begin(void)
>>>>    {
>>>>           acpi_scan_lock_acquire();
>>>> @@ -992,6 +1051,8 @@ static void acpi_s2idle_sync(void)
>>>>
>>>>    static bool acpi_s2idle_wake(void)
>>>>    {
>>>> +       struct s2idle_wake_callback *cb;
>>>> +
>>>>           if (!acpi_sci_irq_valid())
>>>>                   return pm_wakeup_pending();
>>>>
>>>> @@ -1025,6 +1086,15 @@ static bool acpi_s2idle_wake(void)
>>>>                   if (acpi_any_gpe_status_set() && !acpi_ec_dispatch_gpe())
>>>>                           return true;
>>>>
>>>> +               /*
>>>> +                * Check callbacks registered by drivers sharing the SCI.
>>>> +                * Note no need to lock, nothing else is running.
>>>> +                */
>>>> +               list_for_each_entry(cb, &s2idle_wake_callback_head, list) {
>>>> +                       if (cb->function(cb->user_data))
>>>> +                               return true;
>>>> +               }
>>>
>>> AFAICS this needs to be done in acpi_s2idle_restore() too to clear the
>>> status bits in case one of these wakeup sources triggers along with a
>>> GPE or a fixed event and the other one wins the race.
>>
>> The "wakeup" callback does not actually clear the interrupt source, just like
>> for normal interrupts it relies on the actual interrupt handling (which at this
>> point is still suspended) to do this.
> 
> Of course, you are right, sorry for the confusion.
> 
> What I meant was that the interrupt handler needed to run in acpi_s2idle_restore(),
> but that should be taken care of the acpi_os_wait_events_complete() in there
> which synchronizes the SCI among other things.

Ok, I've prepared a v2 with the other discussed changes. I'll give it a
quick test and then send it out.

Regards,

Hans

