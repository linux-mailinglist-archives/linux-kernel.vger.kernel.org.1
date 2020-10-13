Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4128CEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgJMNFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387472AbgJMNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602594294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Dh7ilDc5530PnisUfZBLPyxGmpAbSs0er4CH5lzyPo=;
        b=Hvy1mzBgE79qVMmz4jpC5H0fgtFSxuDtqFRSSxr3lf1nLnqzQ1KdfN4Oqf9lOP0W/iIt6p
        xN4U0EKthBmXbuL1AYTIDGtAyxx+Lw74TKK/6mMzqIkapgNxbGPToAcvzVFlZHl0n+FETE
        87h4TteaCWT/c5q9gdGLY8t6NWkafKY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-7o41PxEZOOqmJz4ovsryUA-1; Tue, 13 Oct 2020 09:04:53 -0400
X-MC-Unique: 7o41PxEZOOqmJz4ovsryUA-1
Received: by mail-ed1-f70.google.com with SMTP id 28so2331418edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Dh7ilDc5530PnisUfZBLPyxGmpAbSs0er4CH5lzyPo=;
        b=oHgTDxUfJ2hhvgDmWJUq7rWObo27h/rVnCVs6qQZQVAt4kK+t2czq6fJWC+jejbfYC
         Qng1thNBp2eyaNZbwbDq+R7sBM4kCXNe/hOoIm6LlyTmUbRqNqfQOotPlReTFuHDUoO1
         INQTijqVgdQBrsJ8iGuZ4oEUg4BzNuU3MNxt2rLwGtP9bgsv0NPfYIfgqTINdUJTRx8r
         MvAYvr+uu9wPC9DJbI/igiQvNCililioFmfDp5u+REPqhXPICV+FcQ4MJFat6yf+fIVO
         /VTWdTH9tap4zNN6lXYPGfX0dkU2iKXjztKmwr0EfXEAtCsxmvL+mJncFPZZxTOqwWNW
         wqew==
X-Gm-Message-State: AOAM533sNHWlui6Ly+g5RrhGsa40RByN/OPJI6+lWQTY3xWFx8HNN/R1
        bRcNnoB074Nho+ITdAnnbilsGzGNPcw3aGFZ0b6uXbsiPjCWj2LzCCakVsIKLtKah+8KCgF9yet
        11tmEwf5bvGvZijmuURs5iiNn
X-Received: by 2002:a17:907:2677:: with SMTP id ci23mr32309266ejc.270.1602594291918;
        Tue, 13 Oct 2020 06:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhpGqHtkNyN6pZYp22r7KkylKEMwBqudtBrJR99gARWQgoKnR0V/BLXSKguqa7eQwHNPsyhQ==
X-Received: by 2002:a17:907:2677:: with SMTP id ci23mr32309249ejc.270.1602594291609;
        Tue, 13 Oct 2020 06:04:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g4sm9496986ejf.78.2020.10.13.06.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:04:51 -0700 (PDT)
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <mpearson@lenovo.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
 <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
 <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com>
Date:   Tue, 13 Oct 2020 15:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 10/12/20 6:37 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 12, 2020 at 1:46 PM Hans de Goede <hdegoede@redhat.com> wrote:

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
>>      (might this be the rapl setting you mean? )
>>
>> 2. The X1C8 has such a setting for the embedded-controller, controlled
>>      through the ACPI interfaces which thinkpad-acpi used
>>
>> 3. The hp-wmi interface allows selecting a profile which in turn
>>      (through AML code) sets a bunch of variables which influence how
>>      the (dynamic, through mjg59's patches) DPTF code controls various
>>      things
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
> It doesn't need to work this way IMV.
> 
> It may also work by allowing drivers (or whatever kernel entities are
> interested in that) to subscribe to it, so that they get notified
> whenever a new value is written to it by user space (eg. each driver
> may be able to register a callback to be invoked when that happens).
> The information coming from user space will just be passed to the
> subscribers of that interface and they will do about it what they want
> (eg. it may be translated into a value to be written to a
> performance-vs-power interface provided by the platform or similar).
> 
> This really is similar to having a class interface with one file per
> "subscribed" device except that the aggregation is done in the kernel
> and not in user space and the subscribers need not be related to
> specific devices.  It still allows to avoid exposing the low-level
> interfaces to user space verbatim and it just passes the "policy"
> choice from user space down to the entities that can take it into
> account.

First of all thank you for your input, with your expertise in this
area your input is very much appreciated, after all we only get
one chance to get the userspace API for this right.

Your proposal to have a single sysfs file for userspace to talk
to and then use an in kernel subscription mechanism for drivers
to get notified of writes to this file is interesting.

But I see 2 issues with it:

1. How will userspace know which profiles are actually available ?

An obvious solution is to pick a set of standard names and let
subscribers map those as close to their own settings as possible,
the most often mentioned set of profile names in this case seems to be:

low_power
balanced_power
balanced
balanced_performance
performance

Which works fine for the thinkpad_acpi case, but not so much for
the hp-wmi case. In the HP case what happens is that a WMI call
is made which sets a bunch of ACPI variables which influence
the DPTF code (this assumes we have some sort of DPTF support
such as mjg59's reverse engineered support) but the profile-names
under Windows are: "Performance", "HP recommended", "Cool" and
"Quiet".  If you read the discussion from the
"[RFC] Documentation: Add documentation for new performance_profile sysfs class"
thread you will see this was brought up as an issue there.

The problem here is that both "cool" and "quiet" could be
interpreted as low-power. But it seems that they actually mean
what they say, cool focuses on keeping temps low, which can
also be done by making the fan-profile more aggressive. And quiet
is mostly about keeping fan speeds down, at the cost of possible
higher temperatures.  IOW we don't really have a 1 dimensional
axis. My class proposal fixes this by having a notion of both
standardized names (because anything else would suck) combined
with a way for drivers to advertise which standardized names
the support. So in my proposal I simply add quiet and cool
to the list of standard profile names, and then the HP-wmi
driver can list those as supported, while not listing
low_power as a supported profile.  This way we export the
hardware interface to userspace as is (as much as possible)
while still offering a standardized interface for userspace
to consume.  Granted if userspace now actually want to set
a low_power profile, we have just punted the problem to userspace
but I really do not see a better solution.


2. This only works assuming that all performance-profiles
are system wide. But given a big desktop case there might
be very well be separate cooling zones for e.g. the CPU
and the GPU and I can imagine both having separate
performance-profile settings and some users will doubtlessly
want to be able to control these separately ...

Regards,

Hans

