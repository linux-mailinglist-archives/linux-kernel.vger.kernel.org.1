Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D462C2F1E51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbhAKSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:55:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbhAKSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610391259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uN8LVAFq57erg1VZoogi4pvvwx0ELMzBGbyuGNoOJNQ=;
        b=ZPhnY6c1GiLyVD1X8GZSiDAqK6GrLJNib8kGLzCWmT5GLSDE6AbeGeJaK4Z8HtfQQNCSzV
        ZHZckDrk34j+gpNRpP1Q5Pyw/z9oVPVE3wNItgkq7HD24vpWn324b9co8Pvjq+GgvUlqpj
        a8ZZeKULXIM5SUfCA2S6P6wdAjWfHsA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-6bDCKNLwPrqHRzEVct_kkg-1; Mon, 11 Jan 2021 13:54:17 -0500
X-MC-Unique: 6bDCKNLwPrqHRzEVct_kkg-1
Received: by mail-ed1-f69.google.com with SMTP id n18so113663eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uN8LVAFq57erg1VZoogi4pvvwx0ELMzBGbyuGNoOJNQ=;
        b=d5GR79ZM6AXyzgGGIP89UjIZrjpcSRyOncFa6NzoKLlJ5R4tLHhzoZY/BH2E1b7Cfx
         mq3Dd8Aez846IBYryPAxFdhb+GJwfPEGxb6BhzmhcuUfHUEWIxHDoJnaMsJvtCBtK+DI
         QtX3iktJ+7XE0Cbs7FkmcS6+Zcg/Q8//5Sn4HvCuGcS7ouV0bC8JftCFNiblJbXPccxG
         anV+LFocR4JrtMPGG0dkTTHSe1aR81Z+MvGKfQJgGsE+IYUIGWpuWt8Uz5X7sj+jDWlk
         U34K5B0jyfZS9ScIF3G06Pq5ouzfeulZy2M1cDDRy+9PNxznuoPN1lw5Y7TUsmufSqoO
         /7UQ==
X-Gm-Message-State: AOAM533kJBPAy+vplH8tERwxK9Qx9fL0mmQ133m5EfQAgSb0grO/8Wnt
        WBn71wU6CRc3NSjF9K8Xyws1r0GSWBCpnZ2c+4YowTbgcOMDv1CT8N+gW7l2RQq8K0453pcJlRh
        v//1yyTgUUP8XeG0vYpRj7L0o
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr618250ejb.194.1610391255756;
        Mon, 11 Jan 2021 10:54:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVXqLUxJh5i0c1UI1w2DoRmg/BYR5TJnoaTSIEr6tFF0zm1S8TKTiTVqTLEmyXNS1iRoH3pA==
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr618229ejb.194.1610391255588;
        Mon, 11 Jan 2021 10:54:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id z10sm201661ejl.30.2021.01.11.10.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 10:54:15 -0800 (PST)
Subject: Re: [PATCH 00/14] MFD/extcon/ASoC: Add support for Intel Bay Trail
 boards with WM5102 codec
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <CAHp75VcMGjhuNWgVx6Jn6vGCN8pvPO5ePz7oprabhiW=Ffc_rg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ab291026-4e4e-7ab7-246a-f85001092a32@redhat.com>
Date:   Mon, 11 Jan 2021 19:54:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcMGjhuNWgVx6Jn6vGCN8pvPO5ePz7oprabhiW=Ffc_rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/28/20 3:19 PM, Andy Shevchenko wrote:
> On Sun, Dec 27, 2020 at 11:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> This patch series adds support for Intel Bay Trail based device which use
>> a WM5102 codec for audio output/input. This was developed and tested on a
>> Lenovo Yoga Tablet 1051L.
>>
>> This series consists of 3 parts:
>> 1. Arizona MFD drv patches for ACPI bindings, better jack-detect support
>>    and misc. fixes
>> 2. extcon-arizona driver fixes and improved jack reporting (this depends
>>    on the MFD changes)
>> 3. ASoC patches in the form of a quirk for BYTCR detecting, a new
>>    machine driver for BYT + WM5102 and jack-detect support for the new
>>    machine driver (which again depends on the MFD changes).
>>
>> Given that 2. and 3. depend on the MFD changes I believe that it is best
>> if all patches in this series are merged through the MFD tree (once
>> reviewed and acked) and then Lee can provide a immutable branch for
>> the ASoC and extcon maintainers to merge into their trees.
>>
>> I have a patch with matching UCM profile changes available here:
>> https://github.com/jwrdegoede/alsa-ucm-conf/commit/316109e7814926ba984322c1d9190575fab9021c
>>
>> This series + the UCM profile has been tested with both the SST and
>> SOF ASoC drivers for BYT devices.
> 
> Thanks for fixing this!
> I found the series pretty much in a good shape (only two patches I
> think need a bit of work), FWIW
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> after addressing comments.

Thank you, because of the jack-handling discussion I've extensively
reworked this series (and I'm going to split it into 2 series for v2).
I've kept your Reviewed-by: for the patches which are >= 99% unchanged
from v1. I've not added it to a whole bunch of new patches (and some
other patches were dropped).

>> BugLink: https://github.com/thesofproject/linux/issues/2485
> 
> Shouldn't this be somewhere in the "main" fix? (Yes, I understand that
> it may sound silly and should be copied to almost half of the series,
> but if there is a good place it would be nice to have in the Git
> history)

Ack. I've added this to the:
"ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102"
patches' commit msg now.

Regards,

Hans

