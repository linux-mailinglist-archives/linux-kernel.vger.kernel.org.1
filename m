Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3F2B687E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbgKQPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgKQPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:17:54 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:17:54 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so6360698wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/gRT7DCZRAs7WkGjd79rZ+jaFHWSdQwkgcdc9HOkaGU=;
        b=jZ/ZpeqkBpBc9230T6VHfN1GV9J6RTOUYGwJ0rAkQTv/oaBJgTD4C/kH4bJh/z3XYn
         xUdkpcKyPPi3+Lopyw0E6KBexuivDeIHfPQuBQdyBhOqWrZLY54RZ+aA340ZQatHxDr9
         RGZe/I5RpyEergoZUVbjdbDkBzT0k4/bK+xlUER+k3b7lR/lb5+7cprJRHxSisGwz5YC
         b8SttCqEIP39iNOY5XeilFut8K4hBKyUDCUJLxqPd0C+SauHyM30lkWb9giwQEQRBl7E
         QLWcbzG0QC9qbvdBtCXmVSnX+qHIFys5/Pb0D3AzA7ZhmDHB1bHy7qa+X5WCiYLEOS+f
         k6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/gRT7DCZRAs7WkGjd79rZ+jaFHWSdQwkgcdc9HOkaGU=;
        b=W6iyMq7BlicloisXfX6HLiSGZXAni4NMt3dNg9WU0EQQ01aBc4UAaDVYJxBNZnvBTM
         rAAM37DDILckgRKKK34y15u4536O2flogM0nOgKz9u34fG0c+jFZ7d1bUYGHtafb+lCn
         h9KXvrYIK5vAwB0F2mhLGa5p+RGGEyeXXCXouQH4NGZBuKyJz/YgP0cI4eSh6wpl5fL5
         5tsCKcghYSKdN5JmutCzHH7/rlRmV2Bqa9Y/sLV+9EB8oq8/0dBEdrSog0QxMmsynInp
         a6XQRTSygXT7RZxiqSLpjtUF1SI0uyp6MmV/V2fYfmV35LMm2HaxzB4oOJGLSv0Orm54
         niMQ==
X-Gm-Message-State: AOAM531I64WppgZJHrCJS+2Ti9k2EWKGqop614wIJ8X2oRccgRkihKzu
        ncXUNAmwPmIwikxworRsH68=
X-Google-Smtp-Source: ABdhPJx90u7WQtKsYcDCE+7DdFXIMB7zJeaePcKNQZim/TM+MCwlt87fvc1kz272+oHkbgm7iudikg==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr26678420wrn.277.1605626273150;
        Tue, 17 Nov 2020 07:17:53 -0800 (PST)
Received: from ziggy.stardust ([213.195.112.112])
        by smtp.gmail.com with ESMTPSA id f16sm28505102wrp.66.2020.11.17.07.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 07:17:52 -0800 (PST)
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell>
 <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
 <20201117123741.GH1869941@dell>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d4424323-25a9-9f70-b2c8-ce464180f788@gmail.com>
Date:   Tue, 17 Nov 2020 16:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117123741.GH1869941@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2020 13:37, Lee Jones wrote:
> On Tue, 17 Nov 2020, Matthias Brugger wrote:
> 
>> Hi Lee,
>>
>> On 13/11/2020 11:19, Lee Jones wrote:
>>> On Tue, 10 Nov 2020, Enric Balletbo i Serra wrote:
>>>
>>>> This adds syscon_regmap_lookup_by_phandle_optional() function to get an
>>>> optional regmap.
>>>>
>>>> It behaves the same as syscon_regmap_lookup_by_phandle() except where
>>>> there is no regmap phandle. In this case, instead of returning -ENODEV,
>>>> the function returns NULL. This makes error checking simpler when the
>>>> regmap phandle is optional.
>>>>
>>>> Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Add Matthias r-b tag.
>>>> - Add the explanation from the patch description to the code.
>>>> - Return NULL instead of -ENOTSUPP when regmap helpers are not enabled.
>>>>
>>>>    drivers/mfd/syscon.c       | 18 ++++++++++++++++++
>>>>    include/linux/mfd/syscon.h | 11 +++++++++++
>>>>    2 files changed, 29 insertions(+)
>>>
>>> Applied, thanks.
>>>
>>
>> I've a series [1] that's based on this patch, could you provide a stable
>> branch for it, so that I can take the series.
> 
> Why can't you base it off of for-mfd-next?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
> 

I can do that, if you are willing to not overwrite the commit history. In my 
case it can happen that I drop a patch from my for-next branch as I realize that 
it e.g. breaks something. I think that's the reason why normally a stable branch 
get's created, as the commit ID won't change although you change the commit 
history of your for-mfd-next branch.

If you want to go the route for me rebasing my tree on top of for-mfd-next then 
I'd like to have at least a stable tag, so that it will be easier to provide the 
pull-request later on. Would that be a compromise?

Regards,
Matthias
