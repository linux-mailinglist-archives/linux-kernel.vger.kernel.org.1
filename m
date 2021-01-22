Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9432FF932
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAVAFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbhAVAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611273804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ND7fHh4Ed7bL6Z/DJqsvNrBqRdzbBP9LfTYlWL442E=;
        b=Mfbr/5TafemY9ogtQCSl1aNzpg9UpKOymYGtnEmsUPrVTZUuje+xulMw+lclvYT4kV4Kko
        YB7ggWhixSR/V7KA4MUg/m6q/DDF2JoKHxSxO2Ue7OVCm/XeZMhDZpN6w4BQ4ZTEXVreUD
        s6/Aod+XGLdNJanfkP3GBP+S02l+IcA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-C3h4KdgsPhq8fZYBsN_j4Q-1; Thu, 21 Jan 2021 19:03:20 -0500
X-MC-Unique: C3h4KdgsPhq8fZYBsN_j4Q-1
Received: by mail-ej1-f72.google.com with SMTP id ox17so1472541ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ND7fHh4Ed7bL6Z/DJqsvNrBqRdzbBP9LfTYlWL442E=;
        b=IW/rpNwNWJK1LhEUYoeiIF0kdmuZh6awnwRqfaK8SkQHVfhEDG4vFpTnc+ORemAoY8
         FRjBygIE8HxhYsrfXamv/FrgJtdG2q0pY7ZXI72W9WlJlEB8QQJAM7v0zTnZzv801SkX
         drX7wJvB+AXRNlW3VxhGwZWBgENO2CrQendqdElv2EyegzPQQPj4KlHX8dapXJwDQkUD
         4zHnExJXQtLa/I2n5r7Pag4zm54sjbmM0A9vkYoEzGA4qFpjrUt+Sof4N+g46YfiM2OR
         i2da5ARoIAuKiBDNMstsekHxC6AF9EvXOjaMpHfFZ1Jnqpfil1u0p/oef2x4Gdn0Y8YX
         C/Jg==
X-Gm-Message-State: AOAM532wb9RiB1sRoHC2Gii6QqhaX/WjAXbM5lSuWC4M3LEQHIo/jxh3
        diCy3fU6N9fKe45BHbzTeUZVDrnX1DIUSJnBAvMo8r0oV0t9l5uMq4GoFe7A7jYNARGg+6Sr2Ct
        sg8yV9vWCOsSzLz+qx4sNQMoE
X-Received: by 2002:aa7:d288:: with SMTP id w8mr1222371edq.241.1611273795995;
        Thu, 21 Jan 2021 16:03:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXi83FqJFHBssya6jEbrG5TNm97wngLlCaCrVjxAFonRfNhfjVMHSsm4DK+9BhS1HAhSolTg==
X-Received: by 2002:aa7:d288:: with SMTP id w8mr1222351edq.241.1611273795775;
        Thu, 21 Jan 2021 16:03:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id t21sm3745387edv.82.2021.01.21.16.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 16:03:15 -0800 (PST)
Subject: Re: [PATCH v2 07/12] ASoC: arizona-jack: Use arizona->dev for
 runtime-pm
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
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-8-hdegoede@redhat.com>
 <CAHp75Vc92WoJm5T1jbF7UUjCNrVZr2as8ccEWxCZ9aP7z+ZyLA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d0189116-d110-f91a-afd9-70f323833e32@redhat.com>
Date:   Fri, 22 Jan 2021 01:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc92WoJm5T1jbF7UUjCNrVZr2as8ccEWxCZ9aP7z+ZyLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 1:02 PM, Andy Shevchenko wrote:
> On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Use arizona->dev for runtime-pm as the main shared/libray code from
>> sound/soc/codecs/arizona.c does.
> 
> Can you elaborate switchings from get() to get_sync() in few places

Sorry, those 2 changes really should have been in a separate commit.
I've put the 2 get -> get_sync() changed in their own commit now
with the following commit-msg:

"""
extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake

Before this commit the extcon-arizona code was mixing pm_runtime_get()
and pm_runtime_get_sync() in different places. In all cases where
either function is called we make use of the device immediately
afterwards. This means that we should always use pm_runtime_get_sync().
"""

> along with moving disable()?
The enable / disable calls are not moved, they are removed.

Here is a new commit msg which hopefully explains this better
which I plan to use for v3:

"""
Drivers for MFD child-devices such as the arizona codec drivers
and the arizona-extcon driver can choose to either make
runtime_pm_get/_put calls on their own child-device, which will
then be propagated to their parent; or they can make them directly
on their MFD parent-device.

The arizona-extcon code was using runtime_pm_get/_put calls on
its own child-device where as the codec drivers are using
runtime_pm_get/_put calls on their parent.

The arizona-extcon MFD cell/child-device has been removed and this
commit is part of refactoring the arizona-extcon code into a library
to be used directly from the codec drivers.

Specifically this commit moves the code over to make
runtime_pm_get/_put calls on the parent device (on arizona->dev)
bringing the code inline with how the codec drivers do this.

Note this also removes the pm_runtime_enable/_disable calls
as pm_runtime support has already been enabled on the parent-device
by the arizona MFD driver.
"""

Regards,

Hans

