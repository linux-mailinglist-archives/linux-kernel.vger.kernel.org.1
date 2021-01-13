Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D12F4774
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbhAMJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:23:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbhAMJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610529702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsYQD4EZiuySMSd/M8ZpVbCS4y6dJ9pZywd0oobrbIo=;
        b=iCcm/NuRnBr0T8R4FfpoV1RKJA+FNGWuXQKY6SvVoD7HN7wYRDvH8ejn3vGOnVERFQnNAK
        I4WDS9tLwn/+hVQVigFIzdWB9Yiqqv5iF0bmGN+YsVZdLJ8qmfjUYD9SL2oiTcbl0aGDrZ
        XDcCYRYaFbqnUS+NI6mBFEIpz/B9H5o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-781zlhvSP5SqDNo4peMloA-1; Wed, 13 Jan 2021 04:21:39 -0500
X-MC-Unique: 781zlhvSP5SqDNo4peMloA-1
Received: by mail-ed1-f71.google.com with SMTP id g25so592254edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsYQD4EZiuySMSd/M8ZpVbCS4y6dJ9pZywd0oobrbIo=;
        b=AdQH8EtO5AZBHQgKZ4nrT/kpkgh/0UfeRDoTjmnhBIlGNIh0tZIAjt6BLxMLHi8pS/
         DyIe1InrxiCESkBms9LWezjFwOBLYv2daaX4ZC1KOu0ChvKtcrrZ4cW2UOkuFvLBieBG
         V6fF+FJDQaE6HX2GQ+GZR/Z3TSG30eDQ7NpQ9VofiqdqDwBGGhdnveKuArpRnmYaBUER
         YmJM/IX+7eYyDgKPiUCTF37qpNdYKMZ9hfGPoXSIv4t8NQKl7rFz/y8oYT+YyPW3aKWS
         r2dImRUU7ArNH9PG1Jky8QTugNHY1eGborbdsA6xbilUzI+v6eFx05CkOCNHwvejErfE
         NUfQ==
X-Gm-Message-State: AOAM531iB+PnlLbV9IAefGoeCw5s0vG0KLEOTUzQRMQrCutTtgnk/yWv
        NSpYxtw+R2SW8wYy3L2LVCGU7/w8d+NzFZ6F0/9PbeswaYWxs3yDDk1IeikroYuOZRIoGFFiE9z
        4Opqj6RhOZbcxuB9qfgzkzY8VideVXJ6EeCOLibgsu+h2wL8KrdHl2ZStz6C5Zd3xMnCqKDV+sl
        af
X-Received: by 2002:aa7:c5d6:: with SMTP id h22mr1011774eds.82.1610529697600;
        Wed, 13 Jan 2021 01:21:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySWVX0GLoYXHJ5wyBJmhxAMczpUJguAXOvkGoV/ve3GZ4Gkgqkk4q1rwalH7hznHzD/qavvw==
X-Received: by 2002:aa7:c5d6:: with SMTP id h22mr1011750eds.82.1610529697379;
        Wed, 13 Jan 2021 01:21:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j9sm553565eds.66.2021.01.13.01.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 01:21:36 -0800 (PST)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.11-1
From:   Hans de Goede <hdegoede@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
 <CAHk-=wiMs5Q9VwEP_gfGmUR3R+_xDRA5pprbgznaFuq48pY+wQ@mail.gmail.com>
 <c24d791c-1f2f-7f94-84cd-450cbdba6ce3@redhat.com>
Message-ID: <5c87fbd3-b4f1-2d1b-3058-0d2c57cc983a@redhat.com>
Date:   Wed, 13 Jan 2021 10:21:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c24d791c-1f2f-7f94-84cd-450cbdba6ce3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/16/20 10:21 AM, Hans de Goede wrote:
> Hi,
> 
> On 12/16/20 1:17 AM, Linus Torvalds wrote:
>> On Mon, Dec 14, 2020 at 4:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> - New Intel PMT telemetry and crashlog drivers
>>
>> These have _very_ annoying Kconfig setups.
>>
>> First it asks about INTEL_PMT support.
>>
>> If you say no, it then asks about INTEL_PMT_CLASS, INTEL_PMT_TELEMETRY
>> and INTEL_PMT_CRASHLOG support.
> 
> Yeah that is bad, sorry for not spotting that (I answer M/Y everywhere
> so that I at least compile test everything).
> 
>> I've pulled this,
> 
> Thanks.
> 
>> but I really wish the PMT support understood that
>> whole "No means no" thing.
> 
> Agreed. I will make sure to get a fix to you for this sometime
> during the 5.11 cycle.
> 
> Alexander and/or David I believe that the best solution for this
> would be to replace the:
> 
>         select INTEL_PMT_CLASS
> 
> In the INTEL_PMT_TELEMETRY and INTEL_PMT_CRASHLOG Kconfig entries
> with "depends on". Also as a general comment for the future, select
> should typically be used with non-user-selectable options. E.g.
> you could also have made INTEL_PMT_CLASS non-user-selectable by
> changing:
> 
> config INTEL_PMT_CLASS
>         tristate "Intel Platform Monitoring Technology (PMT) Class driver"
> 
> To:
> 
> config INTEL_PMT_CLASS
>         tristate
> 
> Having both INTEL_PMT_CLASS user-selectable and using select on
> it is bad. I believe that in this case changing the 2 "select"-s
> to "depend on"-s is best.

Alexander and/or David can you please write and submit a fix for this soon?

Thanks & Regards,

Hans

