Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B531E2E77F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgL3LGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 06:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgL3LGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 06:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609326283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpgWKLH5J7D/Oa0vEFsu5sj48pEyZOyT3j58Gf22+Eo=;
        b=b0B4nZG2KrFWG691pkMKh3XKqFTPTuVl0wgtOCUtIaATPm6razWfIBXBjfjccatKAheqRP
        IRA5LWhud/CpLnmRKolBHx05Fl8WyfoYBBjFXDCTR+oasA8z62Jf7T33i61I4beVqoMj1U
        k7guvssxTegRQnvOh7dGTD40/89pHiw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-cQISeeXMNIqrIxKpHDQ57A-1; Wed, 30 Dec 2020 06:04:39 -0500
X-MC-Unique: cQISeeXMNIqrIxKpHDQ57A-1
Received: by mail-ed1-f72.google.com with SMTP id z20so5689012edl.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 03:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpgWKLH5J7D/Oa0vEFsu5sj48pEyZOyT3j58Gf22+Eo=;
        b=O1ZnfLdPjdBX4vDVDwbsaJLIEwj58Ic38N0GMODAPrWjiuwYHGTRlnNnw293d2t2TE
         YnnMm5HOnPW86fFcRUeCmPUAHoOQxhKcYzubjEN36mvgu6IEqw6euueq9jbCt6lJ/USp
         cCKeANC0ORAyYfhyD6MTksXhxPAtRVZHDlKzQhtQB6XhMWcFU2UWDkGg3W0IIRL0oj9Q
         q8thegqy2rLTnLKsqVjxHj6doyiiESnz3CbfkXrPxw5emBzuLRnSgOXZwgndXVIE6oPj
         Vlx8DU29dqbg94ZYMK9F/fvXtmq/2I3TalLj2S5jGTC3t5gGt1+VXyHjzZMLrXxQ9uyL
         MxJQ==
X-Gm-Message-State: AOAM5326bgwqInA8P1pgWWr/2dGrYJGCyFqtlJUyU3i8oOZYLVVfFjJl
        9CFrftZC0HE/1t4XNXcMzXG4LpNRtobETVJ0Q/F0uip76G2+57Iy5SXmXBoxdE/IpIW1j80SARy
        VTb79kyyyY666wsoSOEi7T2Sj
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr50627984ejc.178.1609326278642;
        Wed, 30 Dec 2020 03:04:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQoK2ErguTmqZhtInIPF5IxlgvA+O3IkrlZ4G4JnSsQc1SmFFfU76rlEsZKdix/bchzl6Hxw==
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr50627978ejc.178.1609326278480;
        Wed, 30 Dec 2020 03:04:38 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o10sm19041814eju.89.2020.12.30.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 03:04:37 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <833781fc-efde-fe98-fded-f81855e54de8@redhat.com>
Date:   Wed, 30 Dec 2020 12:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <21333e30-1e7a-2c95-9e7c-6325c7e78f9a@opensource.cirrus.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/20 5:51 PM, Richard Fitzgerald wrote:
> 
> 
> On 29/12/2020 15:40, Hans de Goede wrote:
>> Hi,
>>
>> On 12/29/20 4:15 PM, Mark Brown wrote:
>>> On Tue, Dec 29, 2020 at 03:06:35PM +0000, Charles Keepax wrote:
>>>
>>>> There is maybe more argument for porting the Arizona code across
>>>> anyways, since for a long time Android didn't properly support extcon
>>>> either. It supported the earlier out of tree switch stuff, extcon
>>>
>>> Completely moving the driver doesn't cause the same problems as the
>>> current proposal (unless it drops functionality I guess, there were
>>> issues with adding new detection types into the input layer but I can't
>>> remember if this hardware was impacted by that or not).
>>
>> The input-layer supports the following switches:
>>
>> SW_HEADPHONE_INSERT
>> SW_MICROPHONE_INSERT
>> SW_LINEOUT_INSERT
>> SW_JACK_PHYSICAL_INSERT
>>
>> Which is a 1:1 mapping with the cable-types currently exported by
>> extcon-arizona.c .
>>
>> I'm fine with fully moving extcon-arizona.c over to only using
>> sound/core/jack.c functionality and it no longer exporting an
>> extcon device.
>>
>> I guess we should move it out of drivers/extcon then though.
>> I suggest using: sound/soc/cirrus/arizona-jack-detect.c
>> Note that sound/soc/cirrus is a new dir here. Would that work
>> for you ?
> 
> Shouldn't it be sound/soc/codecs/arizona-jack.c so that it is with all
> the other code for those codecs?

The arizona codecs use the MFD framework and there is a separate
platform-device instantiated for the jack-detect functionality, so this
(mostly) a standalone platform-driver which has very little interaction
with the rest of the codec code.

It is not a codec driver, or code shared between the codec drivers,
so putting it under sound/soc/codecs would be a bit weird.

With that said I have no strong preference for putting it under
a new sound/soc/cirrus dir, if everyone is ok with putting it under
sound/soc/codecs then that works for me.

Regards,

Hans

