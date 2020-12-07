Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD552D1563
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgLGQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:00:06 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4641C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:59:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l9so4116001wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TsbR/ygYxyXFNxTWS+rlq87PYRq6NOfsyxwkN1nkloE=;
        b=Bsbi60AptI1vCJOxzvRvBbaEKPAazGs9IEdCxKhzFzQREOIMVOxK/5D4TcbhHl968t
         gmU7bHFSKllntii/SUXLSDINSRLe9zYtzjuqy8kMXaxCarhOunVii2BEwuBUbfpJLg3l
         ni/IaIbbbofOVXhCPSyK6RDKyoD5EZ/9n4nEtinLJE94xlg+0UCfpNoNJFHp+lSJJyrl
         mY0ptoOYtLWZzA8LjxvxeeshAPcGFcUggO9W9Vp+7tJruGyHafRFbxADiuh3FXS/ksyr
         jvzB1gi53Bk8J9U93Qb9S4JomZTrgXGsB0DKpkvQv+8yfcTXH822m7KMH9p8ByG/+aM1
         XoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TsbR/ygYxyXFNxTWS+rlq87PYRq6NOfsyxwkN1nkloE=;
        b=atdiFs9dUlf0DVbY3FU+NU9vuPTcDaQPUwY5MbLYSJOpuX15qj3rI4Nzc1QW9N4/pM
         4pELVTbttvjzKeIuMIVOSucLSo95EW5Qq3RipEjhlu1qlF5YDB/TzDuFctE++V1JlmLk
         W5dCsdtzEQzC1xJ2G3dyPGgrZTD3A6BRCL4Bt+rlbt67p31pHrLtIJjdxPfO99MeoQRE
         Uuy+aXjR9BZdMAH0kWxH7Gvku+vZ6FcsESQDpfte1VortSzJwBipvQeBEz+sNk0WXhHv
         1RBh2HPTd1bGgDA4P3er+ckFRuVRgxzlnpDmAjbwm3/PZGLuWoDhVY+MYMZAdQhzJ/Ix
         S4rg==
X-Gm-Message-State: AOAM53121ySzXCUYB1DsS5Xqq671nQhf1MMqfAqklQzfGzr6Kgjbikud
        VazzURrA4/jROvikJM5EUIUPvU5Dx5yZ1Q==
X-Google-Smtp-Source: ABdhPJzYlkkV9y15L7sZt8a7Aq3G0pyggpPyg/Q7eQW9JtvvXF7bANlqEB6ECjgdqyaNMQ8sIzIulg==
X-Received: by 2002:adf:f347:: with SMTP id e7mr20465446wrp.183.1607356764149;
        Mon, 07 Dec 2020 07:59:24 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:797d:a1c3:5539:208e? ([2a01:e34:ed2f:f020:797d:a1c3:5539:208e])
        by smtp.googlemail.com with ESMTPSA id s63sm7041541wms.18.2020.12.07.07.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:59:23 -0800 (PST)
Subject: Re: [PATCH v2 2/2] platform/x86/drivers/acerhdf: Check the interval
 value when it is set
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
 <20201203071738.2363701-1-daniel.lezcano@linaro.org>
 <92e330ff28a10b1fb92d91c083fa3cac@piie.net>
 <bf62927f-972b-b4c3-ff97-179af6d53882@linaro.org>
 <771a76da-bdd3-54b2-3661-e9db918ee00d@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b42f067e-aebf-4e6a-0adb-ccc1b8bfc8ba@linaro.org>
Date:   Mon, 7 Dec 2020 16:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <771a76da-bdd3-54b2-3661-e9db918ee00d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2020 15:54, Hans de Goede wrote:
> Hi,
> 
> On 12/4/20 12:43 PM, Daniel Lezcano wrote:
>> On 03/12/2020 22:22, Peter Kästle wrote:
>>> 3. Dezember 2020 08:17, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:
>>>
>>>> Currently the code checks the interval value when the temperature is
>>>> read which is bad for two reasons:
>>>>
>>>> - checking and setting the interval in the get_temp callback is
>>>> inaccurate and awful, that can be done when changing the value.
>>>>
>>>> - Changing the thermal zone structure internals is an abuse of the
>>>> exported structure, moreover no lock is taken here.
>>>>
>>>> The goal of this patch is to solve the first item by using the 'set'
>>>> function called when changing the interval. The check is done there
>>>> and removed from the get_temp function. If the thermal zone was not
>>>> initialized yet, the interval is not updated in this case as that will
>>>> happen in the init function when registering the thermal zone device.
>>>
>>> Thanks for your effort.  This improves the code, good finding.
>>>
>>>  
>>>> I don't have any hardware to test the changes.
>>>
>>> Tests successfully executed on my good old AOA110.
>>>
>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> Acked-by: Peter Kaestle <peter@piie.net>
>>
>> Thanks for testing the changes.
>>
>> Shall pick the patches through the thermal tree ?
> 
> I can take them through the drivers/platform/x86 (pdx86) tree,
> but if you prefer to take them upstream through the thermal tree,
> then that is fine too...
> 
> Here is my ack (as pdx86 maintainer) for taking them through
> the thermal tree:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks. I'll take them through the thermal tree.

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
