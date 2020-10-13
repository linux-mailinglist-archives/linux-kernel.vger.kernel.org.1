Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2420328CEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgJMMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgJMMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602593269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diQ9Y+b1t01E3zZ97sns1AIbyqKC7Rn+2NhQYJUIcSc=;
        b=hxUvhsZrFz1lrZZs0gA5J9Ezf3vgB838auN6hP+m4HVpj5zk78eRr7Hbjc9q57J54keBQw
        8axxNUtx44iBVmNjLImD7AKwYzfcnaahTOqRA2FnTU0Ms2abAuRYpeoJiwS3kP9oOUOpQO
        Dqdh8fYbLmAnZ7CAs9MLIi/LmYMECoQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-NH8S7o93O3C2m35EsLWwiw-1; Tue, 13 Oct 2020 08:47:47 -0400
X-MC-Unique: NH8S7o93O3C2m35EsLWwiw-1
Received: by mail-ed1-f71.google.com with SMTP id s21so8019993edi.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=diQ9Y+b1t01E3zZ97sns1AIbyqKC7Rn+2NhQYJUIcSc=;
        b=rSda1mylHJgW6AM7ecqDH1qAaJ9rHWSoSsw4J/Klsk/D5kd9JnxE25JbvdhzXU5GhO
         UJZ34ncWShpl7aB3qPkfpOa+aeAvx+K1YxYMnBWqVs45TH0bim/MUdHiJi9X2vD87mkC
         wNCSf61rl5mwABq0+Il65aswusrR/Hz3BziUbMNJZ679TBdJEvy/jTms/jXkar2sLrSk
         wmfw6j8RJzISavGmHWniLi0feJvSmApSqFBssS+U7HMSCEffprE+IwTvdEQh4/rC5cMa
         COUUOQtv9ZHdduT3bKh4yFT7w3cJakGEHh4qBpc/2vVNmxYZPEMT2HOzwFmAfdpZad4Y
         murA==
X-Gm-Message-State: AOAM533pzLaJuenvaCNwDDR0SIvPn766kP4TVIRrPp3c7zwZhb5ZAjVz
        g5IUAeF/mbWdpz4/wXJWj/hQJc0KVqlZMHHof4FGHJUbFqpCbClZBWmVvp5jkiUbRrHhobayCvy
        eyGfMZiGvTdSAn+l2sm/XAObX
X-Received: by 2002:a50:fd83:: with SMTP id o3mr20342989edt.17.1602593266233;
        Tue, 13 Oct 2020 05:47:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYP45uUwLLzkXTHV9szVUHlTlurlG45v+ejbn3DPLvsWByhCTBQxZXHRj5XqIKX6HPCZGHJw==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr20342957edt.17.1602593265902;
        Tue, 13 Oct 2020 05:47:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g20sm12702761ejz.88.2020.10.13.05.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 05:47:45 -0700 (PDT)
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        Mark Pearson <mpearson@lenovo.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
 <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
 <bc1a0134-5242-65d7-a753-fbec0d3bb327@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <15da0ac7-c992-067c-f101-9775bce717e0@redhat.com>
Date:   Tue, 13 Oct 2020 14:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc1a0134-5242-65d7-a753-fbec0d3bb327@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/20 6:02 PM, Daniel Lezcano wrote:
> On 12/10/2020 13:46, Hans de Goede wrote:
>> Hi Daniel,
>>
>> On 10/12/20 12:30 PM, Daniel Lezcano wrote:

<snip>

>>> Here the proposed interface is already exported in userspace via the
>>> powercap framework which supports today the backend driver for the RAPL
>>> register.
>>
>> You say that some sort of power/ balanced power / balanced /
>> balanced performance / performance setting in is already exported
>> through the powercap interface today (if I understand you correctly)?
> 
> Sorry, I was unclear. I meant 'Here the proposed interface' referring to
> the powercap/dtpm. There is no profile interface in the powercap framework.

Ah, I see.

<snip>

>>> A side note, related to your proposal, not this patch. IMO it suits
>>> better to have /sys/power/profile.
>>>
>>> cat /sys/power/profile
>>>
>>> power
>>> balanced_power *
>>> balanced
>>> balanced_performance
>>> performance
>>>
>>> The (*) being the active profile.
>>
>> Interesting the same thing was brought up in the discussion surrounding
>> RFC which I posted.
>>
>> The downside against this approach is that it assumes that there
>> only is a single system-wide settings. AFAIK that is not always
>> the case, e.g. (AFAIK):
>>
>> 1. The intel pstate driver has something like this
>>     (might this be the rapl setting you mean? )
>>
>> 2. The X1C8 has such a setting for the embedded-controller, controlled
>>     through the ACPI interfaces which thinkpad-acpi used
>>
>> 3. The hp-wmi interface allows selecting a profile which in turn
>>     (through AML code) sets a bunch of variables which influence how
>>     the (dynamic, through mjg59's patches) DPTF code controls various
>>     things
>>
>> At least the pstate setting and the vendor specific settings can
>> co-exist. Also the powercap API has a notion of zones, I can see the
>> same thing here, with a desktop e.g. having separate performance-profile
>> selection for the CPU and a discrete GPU.
>>
>> So limiting the API to a single /sys/power/profile setting seems a
>> bit limited and I have the feeling we will regret making this
>> choice in the future.
>>
>> With that said your proposal would work well for the current
>> thinkpad_acpi / hp-wmi cases, so I'm not 100% against it.
>>
>> This would require adding some internal API to the code which
>> owns the /sys/power root-dir to allow registering a profile
>> provider I guess. But that would also immediately bring the
>> question, what if multiple drivers try to register themselves
>> as /sys/power/profile provider ?
> 
> Did you consider putting the profile on a per device basis ?
> 
> eg.
> 
> /sys/devices/system/cpu/cpu[0-9]/power/profile
> 
> May be make 'energy_performance_preference' obsolete in
> /sys/devices/system/cpu/cpufreq ?
> 
> When one device sets the profile, all children will have the same profile.
> 
> eg.
> 
> A change in /sys/devices/system/cpu/power/profile will impact all the
> underlying cpu[0-9]/power/profile
> 
> Or a change in /sys/devices/power/profile will change all profiles below
> /sys/devices.
> 
> Well that is a high level suggestion, I don't know how that can fit with
> the cyclic sysfs hierarchy.

A problem with I see with making this a per-device power setting is that
only a few devices will actually have this; and then the question becomes
how does userspace discover / find these devices ? Typically for these kinda
discovery problems we use a sysfs class as a solution to group devices
offering the same functionailty (through the same standardized sysfs API)
together. Which circles back to my original RFC proposal for this.

Regards,

Hans

