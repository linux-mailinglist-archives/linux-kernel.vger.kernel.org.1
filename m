Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5D2E785A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgL3MD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgL3MDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609329717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvjfJ+LFatFfbZe/Q9mQaV9ad4YgiDZqIK+OxZ/le3U=;
        b=ePIbyGpPxngsBEe7HeLxtJyhWFMl5a1VG9mhzUQ6tJWMrHxSLyc8ey7KNIeTMk6re1fd8j
        2UR1gPatxNucxAeIFplgL8jL5PHrOUFQi+Q484Z433OOYtDuS2hyxCmzlox9X0ZB7dM8eC
        q9BIA9s5doZHmIL+Yl0x8kpqxF9hlsg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-D8DS2KgmMIi_wuFS9-_yqw-1; Wed, 30 Dec 2020 07:01:55 -0500
X-MC-Unique: D8DS2KgmMIi_wuFS9-_yqw-1
Received: by mail-ed1-f70.google.com with SMTP id x13so4764196edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 04:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NvjfJ+LFatFfbZe/Q9mQaV9ad4YgiDZqIK+OxZ/le3U=;
        b=RX4X939gykobDMG99mIXqcXdwgHXNumMFHF96PU5a9Fb6/aYMt/6osAK2zv5DObNco
         vOaGzqId6FVbsCy1n3wsI24QKtLw2DW951McdvRtDY76zND9zlBOgbJcy6ar09/X/WLu
         8FNYdqtyMPMHn1/D4VelTUO8WBfNvEzTSNKMXCsm2fX8XJ8mudiK0Le41tusEMVTlO7o
         SdeA4cQyaHEAPrtKOpz06hHj9k8sHOp4MKTUuaB3V+fVsjP1+l/tNlCno6ER1WnkjV+q
         mI1CzIUd64UQxqZSchN2EQeJm/BvjqPoCG86/J9/JXo55/OCbTFzn2EVChMYdUrimPfU
         95CA==
X-Gm-Message-State: AOAM532Zq3cuclGayzjknT5aJX0nRpTmEkVuvWfqV1kYUrCDtDfArIvF
        RBXzPYWAvGEPvatpZp1TwCDk4jj5g335ZnGQD27X3oy7pjjAXLStMng0t8vQvLOWRTZs8RJSXe5
        XbAJGYYIx+JRELTW2+VNSmSQD
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr36819126edd.129.1609329713683;
        Wed, 30 Dec 2020 04:01:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjaRbE/am2+NboBmQCUgz+kg7SEgmdVf3ihW/4XjLdr0/9shWVpLDwEOOxXukbmncXQYENeg==
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr36819110edd.129.1609329713442;
        Wed, 30 Dec 2020 04:01:53 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d6sm18914733ejy.114.2020.12.30.04.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 04:01:52 -0800 (PST)
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150635.GP9673@ediswmail.ad.cirrus.com>
 <20201229151548.GG4786@sirena.org.uk>
 <1d982dd1-eb02-e7c7-357e-83cf5003c624@redhat.com>
 <21333e30-1e7a-2c95-9e7c-6325c7e78f9a@opensource.cirrus.com>
 <833781fc-efde-fe98-fded-f81855e54de8@redhat.com>
 <53504898-3062-fb9a-3e44-ac0a2ccc86e2@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f2c7d303-6137-4a02-a581-afd2ab6b1ca9@redhat.com>
Date:   Wed, 30 Dec 2020 13:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <53504898-3062-fb9a-3e44-ac0a2ccc86e2@opensource.cirrus.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/30/20 12:23 PM, Richard Fitzgerald wrote:
> On 30/12/2020 11:04, Hans de Goede wrote:
>> Hi,
>>
>> On 12/29/20 5:51 PM, Richard Fitzgerald wrote:
>>>
>>>
>>> On 29/12/2020 15:40, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 12/29/20 4:15 PM, Mark Brown wrote:
>>>>> On Tue, Dec 29, 2020 at 03:06:35PM +0000, Charles Keepax wrote:
>>>>>
>>>>>> There is maybe more argument for porting the Arizona code across
>>>>>> anyways, since for a long time Android didn't properly support extcon
>>>>>> either. It supported the earlier out of tree switch stuff, extcon
>>>>>
>>>>> Completely moving the driver doesn't cause the same problems as the
>>>>> current proposal (unless it drops functionality I guess, there were
>>>>> issues with adding new detection types into the input layer but I can't
>>>>> remember if this hardware was impacted by that or not).
>>>>
>>>> The input-layer supports the following switches:
>>>>
>>>> SW_HEADPHONE_INSERT
>>>> SW_MICROPHONE_INSERT
>>>> SW_LINEOUT_INSERT
>>>> SW_JACK_PHYSICAL_INSERT
>>>>
>>>> Which is a 1:1 mapping with the cable-types currently exported by
>>>> extcon-arizona.c .
>>>>
>>>> I'm fine with fully moving extcon-arizona.c over to only using
>>>> sound/core/jack.c functionality and it no longer exporting an
>>>> extcon device.
>>>>
>>>> I guess we should move it out of drivers/extcon then though.
>>>> I suggest using: sound/soc/cirrus/arizona-jack-detect.c
>>>> Note that sound/soc/cirrus is a new dir here. Would that work
>>>> for you ?
>>>
>>> Shouldn't it be sound/soc/codecs/arizona-jack.c so that it is with all
>>> the other code for those codecs?
>>
>> The arizona codecs use the MFD framework and there is a separate
>> platform-device instantiated for the jack-detect functionality, so this
> 
> That is because it is an extcon driver. It is a different subsystem to
> the other child drivers so has to be a separate child.
> 
>> (mostly) a standalone platform-driver which has very little interaction
>> with the rest of the codec code.
>>
>> It is not a codec driver, or code shared between the codec drivers,
>> so putting it under sound/soc/codecs would be a bit weird.
>>
> 
> In fact it is tied into the codec driver. The code in arizona.c that
> handles HP OUT has to synchronize  with the jack detection to avoid one
> driver trashing the state of the other. But because they are currently
> separate drivers they have to communicate through hp_ena and
> hp_clamp in the parent mfd data. See arizona_hp_ev().

So what you are suggesting is to do something along these lines ? :

1. Drop the MFD instantiated arizona-extcon device
2. Move the extcon code to something more like a library
3. Have the various codec drivers call into the library
   at various points
4. Have the library call snd_soc_card_jack_new,
   snd_soc_jack_report, etc. ?

That works for me, but I would like to make sure we are all on
the same page here before spending time on coding this solution.

Regards,

Hans

