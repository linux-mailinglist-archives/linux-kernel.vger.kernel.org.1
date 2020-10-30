Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1E2A0204
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgJ3KBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgJ3KBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604052103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qh++YDjpLMr2T/NwgklzR0r6j7IRiLB3Ll291xVhXSE=;
        b=cYv5INW6oQgRMpCvQdAsaL4gR2Q3YTXbCRpfXFOvBYH38kj7lMaRPEHL52O7SDK+rDgbWB
        0d8sV+7A8I3T/dHpP9laTFfz3Nu9iBrJPBT33/60j07X8hCRcN7EHTBq6dS2AVzzz8xQHJ
        nFo26kbGB8OmzjHDy6Q8W/2kJx20bTU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-zZfwfJgNO8CPxDRVdxL8hw-1; Fri, 30 Oct 2020 06:01:42 -0400
X-MC-Unique: zZfwfJgNO8CPxDRVdxL8hw-1
Received: by mail-ej1-f70.google.com with SMTP id p19so2228868ejy.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qh++YDjpLMr2T/NwgklzR0r6j7IRiLB3Ll291xVhXSE=;
        b=LJIlXGbZeXjlyfrqM46FEhK8iSqhL1ZyY3LWjqwEU0gYUMYLE2E7MTqBOETip6e3l3
         om3c+EMuea5hMz9HcKyQbjBNpsGUPW/q39J10pcnaOlqEgTrEfSBjf4A/oZ6GNyn1GPB
         3IiQBH09sLjq6EroPA8bSHp4vSqYsEv9Q0jKA5voOo3frjXBV19EpMx9s/FzSOlFscFl
         xD2UZae5lrCVY2xJWJeLcu6a+F50GWFyaj10E+/IZw1ssK1/66MPsuciLdNQbGFpbD/1
         nHFKxV/unFUvutq9HznbpQkcRlENjMqzTLSXWiw/5EtqnfislKNKRqSXvE5c2tMEglkT
         xvgw==
X-Gm-Message-State: AOAM533WuLl53/8fO8iTAFwFJjy0Kldxih9zfpS3pjB0lpCWCOUxrBfE
        E6X035nrxUGfFiOryZoYqESlfK0HPMXAqsIvMxk82FjOKTOXrWHrrBZNQKL87IzlLsrfF7zya0g
        3bRiXL+jrEu0YayesU3cag2M/
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr1498843eju.364.1604052100628;
        Fri, 30 Oct 2020 03:01:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR/QgAeFT6uCvIRGJTtj36hLcVbl/CF9UaFP/+FfZZ2BEaFM1sGsXoSqK6Ey3ng9M8D0CyMw==
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr1498818eju.364.1604052100400;
        Fri, 30 Oct 2020 03:01:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id v21sm2788872edt.80.2020.10.30.03.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 03:01:39 -0700 (PDT)
Subject: Re: [PATCH] PM / reboot: Use S5 for reboot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201030070659.16948-1-kai.heng.feng@canonical.com>
 <45641823-1866-4FF5-9A1C-BFF61A66FCE3@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f8e03d98-1732-81f8-9557-a5da8f962368@redhat.com>
Date:   Fri, 30 Oct 2020 11:01:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <45641823-1866-4FF5-9A1C-BFF61A66FCE3@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/30/20 8:09 AM, Kai-Heng Feng wrote:
> Hi Hans,
> 
>> On Oct 30, 2020, at 15:06, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> After reboot, it's not possible to use hotkeys to enter BIOS setup and
>> boot menu on some HP laptops.
>>
>> BIOS folks identified the root cause is the missing _PTS call, and BIOS
>> is expecting _PTS to do proper reset.
>>
>> Using S5 for reboot is default behavior under Windows, "A full shutdown
>> (S5) occurs when a system restart is requested" [1], so let's do the
>> same here.
> 
> I wonder if this can also solve "HID: i2c-hid: Put ACPI enumerated devices in D3 on shutdown" fixed.

I just checked the _PTS of one of the devices with the SMO91D0 i2c-hid
sensor-hub and it does not appear to turn off the sensor-hub (or any
other devices for that matter). Specifically it does not touch the
GPIO used by the _PS0 / _PS3 methods of the SMO91D0.

Regards,

Hans




>> [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-states
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> kernel/reboot.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index e7b78d5ae1ab..7e5aa1f78693 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -244,6 +244,8 @@ void migrate_to_reboot_cpu(void)
>> void kernel_restart(char *cmd)
>> {
>> 	kernel_restart_prepare(cmd);
>> +	if (pm_power_off_prepare)
>> +		pm_power_off_prepare();
>> 	migrate_to_reboot_cpu();
>> 	syscore_shutdown();
>> 	if (!cmd)
>> -- 
>> 2.17.1
>>
> 

