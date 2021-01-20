Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA92FDD77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 00:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404825AbhATX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730391AbhATVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611178702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHm8nVKL9Fr4wu0oxgE+9L7CgPJ7wuqXCFrUdbbeNXo=;
        b=M2u400wVsNoMJZvd/czGSJYiKff0cki5LJRmrwjqup9ydWdBl42VGB73awNGLd9bmTG2Jy
        d5QqMZoZcXvwKJR4dTA6/g93r2UR4r+Fv97oW2cgHe7ytXMZABAhzTzhRL2gz2Y6eS8WPv
        ldV2juBpqF6UcAOMwyvVNvYYQq0DrSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-Z1F4ohL6MKu2iibntd3CHA-1; Wed, 20 Jan 2021 16:38:20 -0500
X-MC-Unique: Z1F4ohL6MKu2iibntd3CHA-1
Received: by mail-ed1-f69.google.com with SMTP id w4so30561edu.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHm8nVKL9Fr4wu0oxgE+9L7CgPJ7wuqXCFrUdbbeNXo=;
        b=XeB6c+8fSG4PTD5WUYOP1eT2wPLV9Mx9rlI7b0DICxOcbbT0l9UbH1OgQidfcKb/y6
         ZK9+Vp9ha7geMSUTu7R6EFn4H6wACFgY/85GdC3MZtQtrzCdRLf2mQNhxEqblORbQ7xc
         0PWcwrej3dtqYJrdLFcD0qY77DwZuQBGjqo7LPTh/B+KkIzp6JunxIYjmDflDK70KiK5
         HLal/YTEQ+qu+ojKP2ZczjBieDI0srMKdiwok7oPa+1ehoOFAgHoM/tyOO/RMyBbobog
         OKpAkPW3Ozz5cVoOoQRZL2zfoCCYx7VMFO5OQdXt0CGCY3T4BTlnwluMSuGXTomP15Z5
         cl+A==
X-Gm-Message-State: AOAM532qhc1lm7XqGAW8Df3cVqzSmFcjrYDByR/HeSfz9COwXm3JH4qP
        qjcw2SNXY8JEIpUNLFJjd4t1ZIDnj/dm/ejahmMs0mxGCMJ64YaLfXDibyWRsIe5Sogd9+GvUKH
        ziUH0WpQa/ue2aodhQ7VIJCq/
X-Received: by 2002:a05:6402:1c0b:: with SMTP id ck11mr8848945edb.35.1611178698931;
        Wed, 20 Jan 2021 13:38:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyC/ocWNIlZZBmymqhSrfoTNVxWmqEy5lrlXs0dgY1fwLV2Z2ltM1tFi4s7WBAkCG47K1QxnQ==
X-Received: by 2002:a05:6402:1c0b:: with SMTP id ck11mr8848941edb.35.1611178698798;
        Wed, 20 Jan 2021 13:38:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id z2sm1419474ejd.44.2021.01.20.13.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:38:18 -0800 (PST)
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Christian Hartmann <cornogle@googlemail.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk>
 <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
 <20210118133449.GL4455@sirena.org.uk>
 <a1ea81b6-8aff-274c-f1b2-a06a27650b25@redhat.com>
 <CAHp75VeCSOxJr1qMoXj04hnXnZiXdG4PAQ9oaKJNHWXaTqCrVQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b96ec08f-32e5-1c0b-df07-c5c47e5c4b81@redhat.com>
Date:   Wed, 20 Jan 2021 22:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeCSOxJr1qMoXj04hnXnZiXdG4PAQ9oaKJNHWXaTqCrVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/21 8:59 PM, Andy Shevchenko wrote:
> On Wed, Jan 20, 2021 at 9:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 1/18/21 2:34 PM, Mark Brown wrote:
>>> On Mon, Jan 18, 2021 at 02:13:50PM +0100, Hans de Goede wrote:
>>>
>>>> More in general I'm not aware of any (recent-ish) x86 GPIO controllers
>>>> not being able to do active low interrupts. In theory we could hit this
>>>> code path on ARM devices using ACPI enumeration, but I don't think it
>>>> is likely we will see a combination of ARM + ACPI enumeration +
>>>> WM5102 + GPIO controller not capable of active-low interrupts.
>>>
>>> I've not seen this issue on any ARM based systems.
>>>
>>>> This overriding of the flags definitely is necessary on the Lenovo
>>>> devices in question. I could add a
>>>> "if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
>>>> seems unnecessary.
>>>
>>> Possibly just an update to the comment to make it clear that some
>>> firmwares might legitimately set the flag?
>>
>> Ok, I've extended the comment above the override of the irq-flags with
>> the following paragraph for v4 of this patch-set:
>>
>>          * Note theoretically it is possible that some boards are not capable
>>          * of handling active low level interrupts. In that case setting the
>>          * flag to IRQF_TRIGGER_FALLING would not be a bug (and we would need
>>          * to work around this) but sofar all known usages of IRQF_TRIGGER_FALLING
> 
> so far
> 
>>          * are a bug in the boards DSDT.
> 
> board's
> 

Thank you for the quick review, I've fixed both spelling errors for the upcoming v4.

Regards,

Hans

