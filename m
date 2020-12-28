Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6084A2E3907
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgL1NR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731579AbgL1NRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609161369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BpGZqNqjl/EqgtMH0TEGlmSlmsvZxZ2+cVJLVuiye3o=;
        b=hlIOp88NkWMBrqaZi+T4Ov1F1QR7ZYLolExdHOzPJIamyhPpr857/VxBEXFQNENPelEObG
        QGY/jHjSaFmlAHlfSjOp3GDjCWeYkmSkXE1jLftCiuiA8pqNogKUmbZyOauY6gbeiKjqbt
        pREzI2cRxqsFvElOR/cX4CdRxa4X+kQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-HSDRE9GMPhe8H1VbWT7SkA-1; Mon, 28 Dec 2020 08:16:07 -0500
X-MC-Unique: HSDRE9GMPhe8H1VbWT7SkA-1
Received: by mail-ej1-f72.google.com with SMTP id u25so3995703ejf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 05:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpGZqNqjl/EqgtMH0TEGlmSlmsvZxZ2+cVJLVuiye3o=;
        b=cAMeNjyUD5JwsyJ3au8DFkzikbjoUXlibXlTQIYtIDTEuQx6ClIZuKb/yCOaZfg1OY
         4wsir4FJP+OnpdAd25hSxiXEjVmMAIftDuW/ic2gON5Je0ais2KzyLvFHoT16WPsjZB0
         Xe3SatJSNl/tZRPsN3+cwbUN3n9x7L7DXN6hf2Zwno6b7U58HEYjjPX07RtMTMbj0Vs9
         1+Qed/SqorHZ4paZiFn1zYEaZR6vf1ZwRO1+KXJQ/R9b7EzjYxCbpdOr4bb3MOO3P8dF
         aDXL3XdP7KBuRAL7rX6TDTeDXmu0gc4A+8eTHiPGk0Y7j+8adN+gNp4kvm+PqJx62gf6
         gR5A==
X-Gm-Message-State: AOAM533GRAJZtx91mhLZZvRt1hSy5Y0qP0EILKMSsxARf8AK9K/Rue8F
        ANcVWE7CuCQ55Vh8HlX7kyyM0+7JWsDMI9OMOuS8/wyxojUHn9hoc3yDRSIAdXtlsHp3WsFWKoq
        2uQK2zHJA5H2u9NQ0Nny/E4ic
X-Received: by 2002:a17:907:40f0:: with SMTP id nn24mr40959174ejb.233.1609161366032;
        Mon, 28 Dec 2020 05:16:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzrt1uKlVWXyK7ZFE9xUmRMZZXRSzEOAZI8gbA5K9cPIpgkRK+cinnSnJmQyqJNyCEoqnoxw==
X-Received: by 2002:a17:907:40f0:: with SMTP id nn24mr40959157ejb.233.1609161365830;
        Mon, 28 Dec 2020 05:16:05 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id e19sm36838102edr.61.2020.12.28.05.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 05:16:05 -0800 (PST)
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
To:     Mark Brown <broonie@kernel.org>
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
Date:   Mon, 28 Dec 2020 14:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201228122138.GA5352@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/28/20 1:21 PM, Mark Brown wrote:
> On Sun, Dec 27, 2020 at 10:12:19PM +0100, Hans de Goede wrote:
>> The Linux Arizona driver uses the MFD framework to create several
>> sub-devices for the Arizona codec and then uses a driver per function.
>>
>> The jack-detect support for the Arizona codec is handled by the
>> extcon-arizona driver. This driver exports info about the jack state
>> to userspace through the standard extcon sysfs class interface.
>>
>> But standard Linux userspace does not monitor/use the extcon sysfs
>> interface for jack-detection.
> 
> This seems like the wrong layer to fix this problem at, this issue will
> apply to all extcon devices that can detect audio.

Well, the problem really is that using extcon to report jack-state is
rather unusual to do, extcon-arizona.c is the only extcon driver which
deals with jack-state (typically extcon is used for things like determining
the type of charger connected to an USB charging port):

[hans@x1 linux]$ grep -lr EXTCON_JACK_HEADPHONE drivers/extcon/
drivers/extcon/extcon-arizona.c
drivers/extcon/extcon.c

And more in general AFAIK extcon is sort of deprecated and it is
not advised to use it for new code. I would esp. not expect it to
be used for new jack-detection code since we already have standard
uAPI support for that through sound/core/jack.c .

So extcon-arizona really is the odd duck here and writing some
generic extcon to sound/core/jack.c glue seems unnecessary since
we are just trying dealing with one special case here.

Also at first I tried to use extcon-glue like code in
sound/soc/intel/boards/bytcr_wm5102.c making it listen for
extcon events and have sound/soc/intel/boards/bytcr_wm5102.c
report jack events instead of sharing the jack with extcon-arizona.c
through the shared MFD data struct. But that did not work, because
the extcon-arizona.c probe function already (before this patch-set)
has this:

        if (!arizona->dapm || !arizona->dapm->card)
                return -EPROBE_DEFER;

Which means that the sound/soc/intel/boards/bytcr_wm5102.c machine
driver must first complete calling devm_snd_soc_register_card() before
the extcon driver will bind and register the extcon device.

But listening to extcon events requires the machine driver to do an:
extcon_get_extcon_dev("arizona-extcon") and as long as that returns
NULL, return -EPROBE_DEFER.

So now we have the machine-driver's probe returning with -EPROBE_DEFER
until the extcon driver shows up and the other-way around, so neither
ever binds.

I could have fixed this by making the machine driver bind without the
extcon driver being bound and then poll every second for the extcon device
to show up, and once it has shown up stop polling and register the jack,
once it has the extcon device.

But that seems quite ugly, so I did not even try to implement that
coming up with this solution instead which is much more KISS really.

Also note that sharing the jack is necessary to avoid creating 2
separate input_device-s for the headset, which also looks weird / ugly.

Besides being ugly, there also is another potential problem with
polling to wait for the extcon device to show up: the jack must be
registered before the card registration completes otherwise
snd_jack_dev_register will not run, since we are post registration.
But I guess that the sound core might be smart enough to call
the dev_register op immediately if the card has already been
registered ?

TL;DR: writing a generic solution for what is a special case used
in just driver seems like overkill and also writing such a
generic solution is not easily possible because of probe ordering
issues. So instead I've gone with this approach which is a much
simpler solution and as such seems a better way to deal with this
special case.

Regards,

Hans



