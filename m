Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D32E9404
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhADLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbhADLVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:21:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B12C061798
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:20:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u19so26962750edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MZWKWB6DR6hNDrsfU5p9DwYo2p/txd/B82NQ7fAKCkU=;
        b=nl9r27QNZY4Nj976rgvuCPiFY8wmes/BZl9umicY7cdV5Fxo65af2BrZmdHzWXIobt
         oOIWzDwmZlzJ+VLUWsqIfQpqc6bGiZgUeqKQz+cSyvdruBb3tLxfz2mX5cjngPL00izA
         jKU+EP+gmt7AU7mKPsjiYsvEGXM4g6KcOpVKz5FfcnjWpqdCKjcXmU5XvQhBC59tGcVA
         sFXHAd1mGsSXug2gdh18mC7rN85u6D5jxHebdmrMg5cJ4ZQCom4WaIouYIyB+huraAHb
         mnknX2v4ZX85PGB6N3r8QKcP0KJItnyVdKr8S4V4Kf6GeqLKrYMRGdE+L8A9grpgXzQe
         qyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MZWKWB6DR6hNDrsfU5p9DwYo2p/txd/B82NQ7fAKCkU=;
        b=s78rygJ3iEOr2Mw9nihCDIMtP8k0ERRHpamp0kDkpd7rXrAoK1+D1CGviLwj9+9jyP
         kTfAqn3NApXZEC8S34TsnW1hS7t5ZtD/6gfVIfdQaMuVCYrBfOhSBwpuMfJnrDbxLVwW
         jf5CHoVTMvfgjmfwcMzuT48LHQ3S+mUHd12RWn0SSpRorXWmhiVRFhOVPgIXDni1Cm6w
         Qoh8a5/ZdaxMXDfFioC3vA2xy+Q8TsqrVGIC+6LfLF7sLDAUS6uNL9rW0aQ/Xgd7Wpms
         rRq3dftmQt4t+cXYrrkIG6WkziK4Gwl0CjMNK8OIoLIVoediZBO5hvzvg3h3LBxC12Xy
         1j4g==
X-Gm-Message-State: AOAM5309cLiOjnCizIZYr7Hdk33eArmLPK+lqsw+/C5a8iUulHWbUNnY
        nbEVGaa7uS2T8zMl951qEOoYH2HfB25qzA==
X-Google-Smtp-Source: ABdhPJwHI1lN3jR5DnkDpXruXetK/kDTL1pCTJK1usrE58eGVznR+xTruuuJBkNz+y3TDbBeob5Xaw==
X-Received: by 2002:a50:e84d:: with SMTP id k13mr68908071edn.154.1609759236390;
        Mon, 04 Jan 2021 03:20:36 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-129-8.adsl.proxad.net. [82.252.129.8])
        by smtp.googlemail.com with ESMTPSA id h16sm23360677eji.110.2021.01.04.03.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:20:35 -0800 (PST)
Subject: Re: [PATCH] powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod
 unresolved symbols
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>
References: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
 <20201230153744.15612-1-daniel.lezcano@linaro.org>
 <CAMuHMdXCn-tKcaeAHTgdJu0Lg=YrF7cFnW8-tD4ZBfVPUb53NA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f350a7a4-9305-5a75-8261-94f7e4760389@linaro.org>
Date:   Mon, 4 Jan 2021 12:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXCn-tKcaeAHTgdJu0Lg=YrF7cFnW8-tD4ZBfVPUb53NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Geert,


On 04/01/2021 09:18, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Wed, Dec 30, 2020 at 4:39 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> 32 bits architectures do not support u64 division, so the macro
>> DIV_ROUND_CLOSEST is not adequate as the compiler will replace the
>> call to an unexisting function for the platform, leading to an
>> unresolved symbols.
>>
>> Fix this by using the compatible macros:
>>
>> DIV64_U64_ROUND_CLOSEST and DIV_ROUND_CLOSEST_ULL.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/powercap/dtpm.c
>> +++ b/drivers/powercap/dtpm.c
>> @@ -99,8 +99,8 @@ static void __dtpm_rebalance_weight(struct dtpm *dtpm)
>>                 pr_debug("Setting weight '%d' for '%s'\n",
>>                          child->weight, child->zone.name);
>>
>> -               child->weight = DIV_ROUND_CLOSEST(child->power_max * 1024,
>> -                                                 dtpm->power_max);
>> +               child->weight = DIV64_U64_ROUND_CLOSEST(
>> +                       child->power_max * 1024, dtpm->power_max);
> 
> Note that 64-by-64 divisions are expensive on 32-bit platforms.
> 
> Does dtpm.power_max need to be u64?

The dtpm is based on the powercap framework which deals with microwatts
and the functions are expecting u64 values.

The division here happens when there is an update of the dtpm tree which
occurs rarely (at boot time or hotplug).

As the power model is in the vast majority on 64b platforms, the effort
to optimize to u32 sounds not worth, especially that the 32b platforms
supporting the energy model are now obsolete.

> The (lack of) documentation for the dtpm structure does not say what is
> being stored there.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
