Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD57300EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbhAVVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729530AbhAVVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611350239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDjPT9iPHhu8PUnABJf0D49/IjW21PMzqZx/2LRxvgE=;
        b=FeEACqAhFVEnGD8Mp5g4cVGBhFYk6nGmHsvhUuTWLXQnMIdOuVyl875Rqvof5e1GC653Ni
        7XM7EHoNcwNYz+2BRZ+Yigr3hMGmBaRywMmjaf4vIjLvXmbEm4I+v2V5bruw4ySYsY3Scz
        R4uf0JvWMN4B+/MczJgCOc7Ogx6JNs8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-C53lIlujP3Cz5pnGFw0mVg-1; Fri, 22 Jan 2021 16:17:18 -0500
X-MC-Unique: C53lIlujP3Cz5pnGFw0mVg-1
Received: by mail-ed1-f70.google.com with SMTP id m16so3516541edd.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BDjPT9iPHhu8PUnABJf0D49/IjW21PMzqZx/2LRxvgE=;
        b=e4DZmDgy4xfta8U/3VqSix9irR/6MRP0hn1EeNGHrWAmjvNLDfYZxuiiGbb5rzix3u
         KlDSqFSBgWrC9IMZ/PYKv9NuoZrS6ZYqmutu41JvTA/n1I2Envs8/QArW4P6Hg1oF8Du
         u3PNoWjCUJSG0OJ9pzRZewwHlqdbOkqQyOf5aXbafn6CwBGXjrgSvQzxPLPq+FysLfiP
         KqcVwdk24uME65WvhAvwozwHADJdKu9nYPLhq9AR3m7UKKGB7ZYEzlswOglzozVlfsKj
         xsKnSXbNt/hPsJFN0teDLWFe30ry9n/pF9f8xPTEpwpi9+aaYYEPnXbSRscuiAUC3l32
         8y9w==
X-Gm-Message-State: AOAM532shI96wXSkZol8efPGCUQxa+31pQGgktveb23PcajEBgvFeRF0
        njGBzcYnuJ/27GBz/l4gkmRtOzeL3FQVlVHMxlbllJn97H18eoWo3e+LlDeNciUTg5uNVe90Yiu
        A5ydCmSh/jTsdaTJ+nCgsgNV9
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr1002108edd.242.1611350236898;
        Fri, 22 Jan 2021 13:17:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0hFVgHmuGiHHbKAqBXsmd3goO6RuIwjF4vltR2iPF94lLbwxkEF9o448HxKNY3lQl4eALlA==
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr1002100edd.242.1611350236777;
        Fri, 22 Jan 2021 13:17:16 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id b26sm6380261eds.48.2021.01.22.13.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 13:17:15 -0800 (PST)
Subject: Re: [PATCH v3 06/13] ASoC/extcon: arizona: Move arizona jack code to
 sound/soc/codecs/arizona-jack.c
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210122164107.361939-1-hdegoede@redhat.com>
 <20210122164107.361939-7-hdegoede@redhat.com>
 <CAHp75VedGzihYi1Ndjj4K4326pMrLtk3V7gi_rxteu5HaqWfEA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <63f62136-8d19-c281-bbae-3e1e6b0fd4e3@redhat.com>
Date:   Fri, 22 Jan 2021 22:17:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VedGzihYi1Ndjj4K4326pMrLtk3V7gi_rxteu5HaqWfEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/22/21 9:40 PM, Andy Shevchenko wrote:
> On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The jack handling for arizona codecs is being refactored so that it is
>> done directly by the codec drivers, instead of having an extcon-driver
>> bind to a separate "arizona-extcon" child-device for this.
>>
>> drivers/mfd/arizona-core.c has already been updated to no longer
>> instantiate an "arizona-extcon" child-device for the arizona codecs.
>>
>> This means that the "arizona-extcon" driver is no longer useful
>> (there are no longer any devices for it to bind to).
>>
>> This commit drops the extcon Kconfig / Makefile bits and moves
>> drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c .
>>
>> This is a preparation patch for converting the arizona extcon-driver into
>> a helper library for letting the arizona codec-drivers directly report jack
>> state through the standard sound/soc/soc-jack.c functions.
> 
> ...
> 
>>  MAINTAINERS                                               | 1 -
> 
>> -F:     drivers/extcon/extcon-arizona.c
> 
> Commit message doesn't shed a light if we need to move this actually
> to another record in MAINTAINERS database.

Ah, good call, yes we should. I'll fix this for v4.

Regards,

Hans

