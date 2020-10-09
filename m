Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7E2887B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbgJILP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732140AbgJILP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602242155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOx27e9wVhFSVHOPPW00xTwH7iIIer8HNd6UYJS5k/U=;
        b=O0hlO+naoXbBxP0P32kS+1fWhSGs/8wMwkNyLMMQ0rW+WPsnYv6VnYtRodnV9kPI+SeZ6j
        7UMvHNeU+d6akRggheOOzeQpbr67+ivgXvLThNcM3hI8Oa2EvZeAERp3uT0Ui8vsiqEnDT
        PY34Lp1m6ox9SxbhpS3ZJf9MpJCSZS4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-HcKiwy1eMBKoEPBK5_Ss2A-1; Fri, 09 Oct 2020 07:15:51 -0400
X-MC-Unique: HcKiwy1eMBKoEPBK5_Ss2A-1
Received: by mail-ej1-f72.google.com with SMTP id z8so3495203ejw.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 04:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOx27e9wVhFSVHOPPW00xTwH7iIIer8HNd6UYJS5k/U=;
        b=Jw20LetWIu4vJtAANC2SRznye2LVjcW9/3kqQ6a1MMcO+gr6AvFlxpUxb042AveM/+
         hnEp2Uq59ZcDF1OY5EloV97uX9Hr+Z8a1RxzpCvEcZQmmWZxLK2tSCc3u6J0CG8UviBo
         8TOjwwRh4gPzkIVeXyMglhOPnw5JdNAU8GPM5XD2x6t95MrYEl6NDMCvbakc+D27BILY
         OVoZEaGpH6Jn2zc6i1AAivfR/sylL1+D4LQ0CmjicmxILwhXFMjXAvCInrCDHP1+y4wa
         odL0yzun6ubBpo6sYerb/S8tHipW+iNFxvvzEkflg2iaoPAZiAljhOIeJrBmmEyQPOAH
         UePg==
X-Gm-Message-State: AOAM533trkvYz+svwXqUTWsDKMYLgOykcRFgQeCSd5k9/+oWfhDOk1J4
        0HILLrlVkmLZewy5Coy/3ca+S5gi/KREFDZI7DYNQgS5rlTK2lvXy9SEyjvdK2oWb1FtoXs/aPa
        YLoug2VqXbjUWhC1isyCc2fZ3
X-Received: by 2002:a17:906:1c0f:: with SMTP id k15mr13326650ejg.343.1602242150541;
        Fri, 09 Oct 2020 04:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzycqa7sZhno3JTiSgNP0vyp13nEUdVKQhdrfTioZ5Ad6OmiITn8VCxrCRTTkd1qkGFGC1nfg==
X-Received: by 2002:a17:906:1c0f:: with SMTP id k15mr13326626ejg.343.1602242150254;
        Fri, 09 Oct 2020 04:15:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id e5sm6350213ejb.26.2020.10.09.04.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 04:15:49 -0700 (PDT)
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
 <c464996fb3e0e23958c01196fe45f79cafce6cf4.camel@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb0593b7-d597-dc32-365c-1a30a77d6cf3@redhat.com>
Date:   Fri, 9 Oct 2020 13:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c464996fb3e0e23958c01196fe45f79cafce6cf4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/5/20 3:13 PM, Benjamin Berg wrote:
> Hi,
> 
> seems reasonable to me. Quite simple, but likely good enough as we are
> sticking to only use well known names.
> 
> Just found a small typo.
> 
> Benjamin
> 
> On Sat, 2020-10-03 at 15:19 +0200, Hans de Goede wrote:
>> On modern systems CPU/GPU/... performance is often dynamically configurable
>> in the form of e.g. variable clock-speeds and TPD. The performance is often
>> automatically adjusted to the load by some automatic-mechanism (which may
>> very well live outside the kernel).
>>
>> These auto performance-adjustment mechanisms often can be configured with
>> one of several performance-profiles, with either a bias towards low-power
>> consumption (and cool and quiet) or towards performance (and higher power
>> consumption and thermals).
>>
>> Introduce a new performance_profile class/sysfs API which offers a generic
>> API for selecting the performance-profile of these automatic-mechanisms.
>>
>> Cc: Mark Pearson <markpearson@lenovo.com>
>> Cc: Elia Devito <eliadevito@gmail.com>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Cc: Benjamin Berg <bberg@redhat.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-performance_profile
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile b/Documentation/ABI/testing/sysfs-class-performance_profile
>> new file mode 100644
>> index 000000000000..9c67cae39600
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
>> @@ -0,0 +1,104 @@
>> +Performance-profile selection (e.g. /sys/class/performance_profile/thinkpad_acpi/)
>> +
>> +On modern systems CPU/GPU/... performance is often dynamically configurable
>> +in the form of e.g. variable clock-speeds and TPD. The performance is often
>> +automatically adjusted to the load by some automatic-mechanism (which may
>> +very well live outside the kernel).
>> +
>> +These auto performance-adjustment mechanisms often can be configured with
>> +one of several performance-profiles, with either a bias towards low-power
>> +consumption (and cool and quiet) or towards performance (and higher power
>> +consumption and thermals).
>> +
>> +The purpose of the performance_profile class is to offer a generic sysfs
>> +API for selecting the performance-profile of these automatic-mechanisms.
>> +
>> +Note that this API is only for selecting the performance-profile, it is
>> +NOT a goal of this API to allow monitoring the resulting performance
>> +characteristics. Monitoring performance is best done with device/vendor
>> +specific tools such as e.g. turbostat.
>> +
>> +Specifically when selecting a high-performance profile the actual achieved
>> +performance may be limited by various factors such as: the heat generated by
>> +other components, room temperature, free air flow at the bottom of a laptop,
>> +etc. It is explicitly NOT a goal of this API to let userspace know about
>> +any sub-optimal conditions which are impeding reaching the requested
>> +performance level.
>> +
>> +Since numbers are a rather meaningless way to describe performance-profiles
>> +this API uses strings to describe the various profiles. To make sure that
>> +userspace gets a consistent experience when using this API this API document
>> +defines a fixed set of profile-names. Drivers *must* map their internal
>> +profile representation/names onto this fixed set.
>> +
>> +If for some reason there is no good match when mapping then a new profile-name
>> +may be added. Drivers which wish to introduce new profile-names must:
>> +1. Have very good reasons to do so.
>> +2. Add the new profile-name to this document, so that future drivers which also
>> +   have a similar problem can use the same new. Usually new profile-names will
> 
> Typo, "new" -> "name" I suppose.

Ack, fixed in my local tree.

Thx.

Regards,

Hans


> 
>> +   be added to the "extra profile-names" section of this document. But in some
>> +   cases the set of standard profile-names may be extended.
>> +
>> +What:		/sys/class/performance_profile/<device>/available_profiles
>> +Date:		October 2020
>> +Contact:	Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +		Reading this file gives a space separated list of profiles
>> +		supported for this device.
>> +
>> +		Drivers must use the following standard profile-names whenever
>> +		possible:
>> +
>> +		low-power:		Emphasises low power consumption
>> +					(and also cool and quiet)
>> +		balanced-low-power:	Balances between low power consumption
>> +					and performance with a slight bias
>> +					towards low power
>> +		balanced:		Balance between low power consumption
>> +					and performance
>> +		balanced-performance:	Balances between performance and low
>> +					power consumption with a slight bias
>> +					towards performance
>> +		performance:		Emphasises performance (and may lead to
>> +					higher temperatures and fan speeds)
>> +
>> +		Userspace may expect drivers to offer at least several of these
>> +		standard profile-names! If none of the above are a good match
>> +		for some of the drivers profiles, then drivers may use one of
>> +		these extra profile-names:
>> +		<reserved for future use>
>> +
>> +What:		/sys/class/performance_profile/<device>/current_profile
>> +Date:		October 2020
>> +Contact:	Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +		Reading this file gives the current selected profile for this
>> +		device. Writing this file with one of the strings from
>> +		available_profiles changes the profile to the new value.
>> +
>> +		Reading this file may also return "custom". This is intended for
>> +		drivers which have and export multiple knobs influencing
>> +		performance. Such drivers may very well still want to offer a
>> +		set of profiles for easy of use and to be able to offer a
>> +		consistent standard API (this API) to userspace for configuring
>> +		their performance. The "custom" value is intended for when a
>> +		user has directly configured the knobs (through e.g. some
>> +		advanced control-panel for a GPU) and the knob values do not
>> +		match any of the presets represented by the
>> +		performance-profiles. In this case writing this file will
>> +		override the modifications and restore the selected presets.
>> +
>> +What:		/sys/class/performance_profile/<device>/type
>> +Date:		October 2020
>> +Contact:	Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +		Performance-profiles may be system-wide, or for a specific
>> +		device (e.g. CPU / GPU). System-wide profiles are typically
>> +		used on devices where where a single cooling solution is
>> +		shared between all components, such as laptops and NUCs.
>> +
>> +		Reading this file indicates the type of the device for which
>> +		the thermal-profile is being configured.
>> +
>> +		Valid values: "system"
>> +		Reserved for future use values: "cpu", "gpu"

