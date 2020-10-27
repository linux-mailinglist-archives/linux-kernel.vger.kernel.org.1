Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB329A5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508426AbgJ0Hyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508410AbgJ0Hyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603785289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeSYfPXFT/GwkLN448ESBfAmr44wtqoH1b84R4tdDjQ=;
        b=NsDbPu9UAFQwY7Trawv3K23ReWPgr+nfj9lWvWIsH15oZSKxFouTGw8rRZtoQhoC69nk70
        J/G16aIRnYvZBHqnVwvcK9rDfm6U91w5p6qKiC/HxB/OaUCdKMyyxcMcQBV2iJte5TvPMm
        2yBvkJqrnpbZ5gRihv8i0nsbyMkRxo0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-ofDJvpadMy6C6q8iFw8FPQ-1; Tue, 27 Oct 2020 03:54:47 -0400
X-MC-Unique: ofDJvpadMy6C6q8iFw8FPQ-1
Received: by mail-ed1-f72.google.com with SMTP id j6so355099edh.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PeSYfPXFT/GwkLN448ESBfAmr44wtqoH1b84R4tdDjQ=;
        b=O/eaDzWuLtY1oXlty5ZTFmKetAoyTc8paJCtABnsO0CLN5vKijRbe6EyEHv+DHc5dd
         T9LEpA8dXEHlxJsxpEPVYSviUHC4jInoAxWg7HW/m9XoPqsZuae5Vou4WCRtPbu+zj0h
         lUjbIPXn7x266bo23wTJKGq9RXnPfRd+hLzT7ll6vhPINP5t25YgBc4IFFt67j9qBalm
         gTA+BX/AmskqlWFgKq5JRZy/lKPUYZnB0NjRHWYQZdTd59RoO1fqdK7rgUdqyrbkAz6w
         XY7X1Y2TlcsHPIbyxxBG1cioY8W9t/usLpDIfiJyCQgRv9pZtL9sMkpMUJWjMtEfoPk4
         1lPg==
X-Gm-Message-State: AOAM532QFQkobiEGF80E40QGQQPMS+KNgkDKnEEVbJbcKsJ1JqS03EgR
        bfTYXi4qa6aOk28nKzKWQ9BbGnog05ObiTwWvZz549f/V7BfJXM0cVbkPoI40xefIuIrqqcx038
        h97+1TXfcgKW/M100tcjgFAyf
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr1111892ejb.296.1603785285691;
        Tue, 27 Oct 2020 00:54:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWdLnZu11HKciZEJcQYuAGzfsA8Hn7vTIzd+IsG3fBh8aDDnW+yAxAPylmRjqa0/o6a6JZyA==
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr1111872ejb.296.1603785285445;
        Tue, 27 Oct 2020 00:54:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p20sm477353ejd.78.2020.10.27.00.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 00:54:44 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] [RFC] Documentation: Add documentation for
 new platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com,
        hadess@hadess.net, bberg@redhat.com, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201026174444.866545-1-markpearson@lenovo.com>
 <3c850d5a-75e6-4238-74fe-610ed9860abc@redhat.com>
 <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1fbaf1fa-47c6-afe7-ca9e-41b3ad6a4556@redhat.com>
Date:   Tue, 27 Oct 2020 08:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/20 8:55 PM, Mark Pearson wrote:
> Thanks Hans
> 
> On 26/10/2020 14:33, Hans de Goede wrote:
>> Hi Mark,
>>
>> Thank you for this new version.
>>
>> On 10/26/20 6:44 PM, Mark Pearson wrote:
>>> From: Hans de Goede <hdegoede@redhat.com>
>>>
> <snip>
> 
>>> +
>>> +If for some reason there is no good match when mapping then a new profile-name
>>> +may be added. Drivers which wish to introduce new profile-names must:
>>> +1. Have very good reasons to do so.
>>> +2. Add the new profile-name to this document, so that future drivers which also
>>> +   have a similar problem can use the same new.
>>
>> s/same new/same name/
> I've read this document so many times...I'm not sure how I missed that one. Thanks.
>>
>>> + Usually new profile-names will
>>> +   be added to the "extra profile-names" section of this document. But in some
>>> +   cases the set of standard profile-names may be extended.
>>
>> With the change from a more generic API to this new one more targeted towards DPTF
>> I would drop this part.
> OK - I have some questions then related to this change, below
>>
>>
>>> +
>>> +What:        /sys/firmware/acpi/platform_profile_choices
>>> +Date:        October 2020
>>> +Contact:    Hans de Goede <hdegoede@redhat.com>
>>> +Description:
>>> +        Reading this file gives a space separated list of profiles
>>> +        supported for this device.
>>> +
>>> +        Drivers must use the following standard profile-names whenever
>>> +        possible:
>>> +
>>> +        low-power:        Emphasises low power consumption
>>> +        quiet:            Offers quieter operation (lower fan
>>> +                    speed but with higher performance and
>>> +                    temperatures then seen in low-power
>>
>> I think the description here is a bit too specific, this may cause userspace
>> to have expectations which are not necessary true. I would describe this as
>> just:
>>
>>         quiet:            Emphasises quieter operation
>>
> Agreed. I'll update
> 
>>> +        balanced:        Balance between low power consumption
>>> +                    and performance
>>> +        performance:        Emphasises performance (and may lead to
>>> +                    higher temperatures and fan speeds)
>>> +
>>> +        Userspace may expect drivers to offer at least several of these
>>> +        standard profile-names! If none of the above are a good match
>>> +        for some of the drivers profiles, then drivers may use one of
>>> +        these extra profile-names:
>>> +        <reserved for future use>
>>> +
> If we remove the extra profile-names section above then I think it should be removed here too. If someone wants to add a new 'mode' then it would be added to the list of 'standard names', and becomes a new option. Wanted to check I'm not missing something important.

You are completely right, any references to an extra profile-names section
should be removed here too. I did intend to add that it should be removed here
too, but I forgot.


>>> +What:        /sys/firmware/acpi/platform_profile
>>> +Date:        October 2020
>>> +Contact:    Hans de Goede <hdegoede@redhat.com>
>>> +Description:
>>> +        Reading this file gives the current selected profile for this
>>> +        device. Writing this file with one of the strings from
>>> +        available_profiles changes the profile to the new value.
>>
>> The part about custom profiles below may be dropped. That was intended for use
>> with e.g. GPUs but since this now strictly is a system-level profile API, the
>> part below can be dropped now.
> Agreed
>>
>>
>>> +
>>> +        Reading this file may also return "custom". This is intended for
>>> +        drivers which have and export multiple knobs. Such drivers may
>>> +        very well still want to offer a set of profiles for easy of use
>>> +        and to be able to offer a consistent standard API (this API) to
>>> +        userspace for configuring their performance. The "custom" value
>>> +        is intended for when ai user has directly configured the knobs
>>> +        (through e.g. some advanced control-panel for a GPU) and the
>>> +        knob values do not match any of the presets represented by the
>>> +        platform-profiles. In this case writing this file will
>>> +        override the modifications and restore the selected presets.
>>> +
>>>
>>
>> Regards,
>>
>> Hans
>>
> Thanks!
> mark

Regards,

Hans

