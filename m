Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E432E713E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgL2N7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:59:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgL2N7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609250263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZ2YhHN3Hwjg2UbDRol1QpNQE1SnLZkkD3OZg+bxNoY=;
        b=PqJwJWf4QlsFNJ435n0j/ymL7myBFGnelFaOTL+OUqQsvi2Eat0lGBRnKrIXPNIZ5vNP+Q
        QFjURgxQyAFJg0y6sG+w7wfUhhggD19v00OTSB6LYqos5WiwLU8EGT6gn7PiDzL/qzDdJJ
        No2/n2k3O7GFXXn1cplEQ0dSvQP9Ko8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-cGaPxA11OwSCctlVARD5ow-1; Tue, 29 Dec 2020 08:57:41 -0500
X-MC-Unique: cGaPxA11OwSCctlVARD5ow-1
Received: by mail-ed1-f71.google.com with SMTP id u17so4517165edi.18
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 05:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZ2YhHN3Hwjg2UbDRol1QpNQE1SnLZkkD3OZg+bxNoY=;
        b=a+NaKBt3hZnV8LMxeYNyYK0EwCJXL6NRjm5jLTQ1jsJ53Uh9vIUWUvgfVjSaBJ7t/4
         RYUEgoi3M3HSfKCK57FTuxn47+AmtJjI7FfjTGSnAqemLp8/Y2re00tzM6wE7ORjCTjK
         zEIJR+eTpMXodXp1UnJT2APzOISQGa88Tqh+gKgws1p77WTsUUL0uBkU1r4jsM0zHiot
         QBaaYiaeE3bjUnv1PdSpxJUSK3Qopnv+1f4WFuiL8VcBtuGeTTiHuGrcWsIoW2h7g+2F
         C5wydAH9HxJYFTCcrSNqX1i0DaTYlpKK9eYY17IZscBssRaCNfhS1J+FSvoCy5aQtpgT
         HGYw==
X-Gm-Message-State: AOAM531y8zbjOhHay7Fau7f9zkzUidIiIxnxI3KzOIFG+0yP27NrM6V6
        23tgvUvIhSJS8YLUILQnJ/cPm6MWGc0wZBmwk7mX1yCDWgg3C7bnuhz0el0yzii1pRXZSWkxjLU
        1i4ZEVFIzUPPGvHFwVc+fU+Ql
X-Received: by 2002:a17:906:cc9c:: with SMTP id oq28mr45873013ejb.224.1609250260456;
        Tue, 29 Dec 2020 05:57:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuBE7wnJ/yXJ3rin6TYBmB4kU4OTVwnk0PDgy2e3mTu2jz5027n4FrjiiaK6btd5XfnkS2yg==
X-Received: by 2002:a17:906:cc9c:: with SMTP id oq28mr45873004ejb.224.1609250260286;
        Tue, 29 Dec 2020 05:57:40 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a13sm37319747edb.76.2020.12.29.05.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 05:57:39 -0800 (PST)
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
Date:   Tue, 29 Dec 2020 14:57:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201229130657.GN9673@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/20 2:06 PM, Charles Keepax wrote:
> On Mon, Dec 28, 2020 at 04:28:07PM +0000, Mark Brown wrote:
>> On Mon, Dec 28, 2020 at 02:16:04PM +0100, Hans de Goede wrote:
>>
>>> And more in general AFAIK extcon is sort of deprecated and it is
>>> not advised to use it for new code. I would esp. not expect it to
>>> be used for new jack-detection code since we already have standard
>>> uAPI support for that through sound/core/jack.c .
>>
>> Has Android been fixed to use the ALSA/input layer interfaces?  That's
>> why that code is there, long term the goal was to have ALSA generate
>> extcon events too so userspace could fall over to using that.  The basic
>> thing at the time was that nobody liked any of the existing interfaces
>> (the input layer thing is a total bodge stemming from it having been
>> easy to hack in a key for GPIO detection and using ALSA controls means
>> having to link against alsa-lib which is an awful faff for system level
>> UI stuff) and there were three separate userspace interfaces used by
>> different software stacks which needed to be joined together, extcon was
>> felt to be a bit more designed and is a superset so that was the
>> direction we were heading in.
> 
> Android has been updated to have the option to catch input events
> for jack detection now.
> 
> I have always been slightly confused between extcon and the ALSA
> jack reporting and have been unsure as to what is the longer term
> plan here. I vaguely thought there was a gentle plan to move to
> extcon, it is interesting to see Hans basically saying the
> opposite that extcon is intended to be paritially deprecated. I
> assume you just mean with respect to audio jacks, not other
> connector types?

No I mean that afaik extcon is being deprecated in general. Extcon
is mostly meant for kernel internal use, to allow things like
charger-type-detection done by e.g. a fsa micro-usb mux or a
Type-C PD controller to be hooked up to the actual charger chip
and set the input-current-limit based on this.

But there is no clean way to express these relation-ships
in extcon terms in devicetree. At least for new device with
Type-C functionality this is all being moved to OF graph bindings
combined with using the power_supply class to provide info like
negotiated voltage and current to the charger-IC.

Note this is mostly my 2 cents / my impression about where extcon
is heading. I have actually tried to use extcon for Type-C stuff
and this was frowned upon by both the devicetree bindings people and
the USB Type-C code controller people.

Also despite its age, the extcon code is still not really in good
shape. E.g. a driver can do extcon_get_extcon_dev, but that does
not return a device-reference, that just does a lookup and returns
the requested extcon-device, but there are 0 guarantees that the
extcon device will not go away and dereferencing the returned
pointer after doing a rmmod of the extcon-driver will result in
a nasty crash.

So all this suggests to me that extcon should not be used for
new code / projects.

> I would agree with Mark though that if extcon exists for external
> connectors it seems odd that audio jacks would have their own
> special way rather than just using the connector stuff.

Well as I said above in me experience the extcon code is (was) mostly
meant for kernel internal use. The sysfs API is more of a debugging
tool then anything else (IMHO).

Also the kernel has support for a lot of sound devices, including
many with jack-detection support. Yet a grep for EXTCON_JACK_HEADPHONE
over the entire mainline kernel tree shows that only extcon-arizona.c
is using it. So given that we have dozens of drivers providing jack
functionality through the sound/core/jack.c core and only 1 driver
using the extcon interface I believe that the ship on how to export
this to userspace has long sailed, since most userspace code will
clearly expect the sound/core/jack.c way of doing things to be used.

Arguably we should/could maybe even drop the extcon part of extcon-arizona.c
but I did not do that as I did not want to regress existing userspace
code which may depend on this (on specific embedded/android devices).

Regards,

Hans

