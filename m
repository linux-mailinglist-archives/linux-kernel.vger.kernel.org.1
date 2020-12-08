Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A162D2E08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgLHPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgLHPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:20:22 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8271C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 07:19:41 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id lt17so25157145ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tzsovbIcXxZbPQxa4va4cD/Nj2m9EEN+fh5YzE4Jzs8=;
        b=LIISehDJDsl6HTopwe/jucDF24nCTz1G8nlyh+9KRUuUtct7+FPmwGsXDHGyRLcPqA
         eIw8lkpOY8J+eZZxQmwNfaD/ZhW4CkThjQXbVuTXBgFYpbcso2UBE1vXiPPeL6DhUAOq
         wKcxqkm7Ht7yABSRkClc/mk9YfOaNxB7klZO+X0XURwWsZLoaYhQyCI9jT9Rd0xqnuIa
         YgWwhskPwHcu2QAfTBQfuhmxEbDG6r3TBmHRORywU0D2UnaZZUekwKDwlck1261pjW25
         dek3wZ/Hs1ikTl2tf4UoyaY2jzH7UNu7YkUNvuG9HwGeSuj5qlvNiyeutnlgYHi8X8KN
         33iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tzsovbIcXxZbPQxa4va4cD/Nj2m9EEN+fh5YzE4Jzs8=;
        b=EEGxiI4YYj16UvlZhINlJ2lNG19ct6nx74FGfAmQGmFRmFC+ifWOUFpDSodrdEtHFq
         VTQV+qB023+oHh/requEsjApKvIE9cJr7ue+ntajkXgeRE0i3vAqRzCGQrKZT/Wx+OG7
         4AVs+OH0uPZ/H9DvdXKHwHWl52RmlqviTcIR8NK/uhZxxx81o4QRMINUhY7Mx1qmekeq
         uw2VcYWTWBnH853I7LPq5XkOv8vw+0F+ggevEx/YOihtZlRaBy8mEQWtVToKLtm1749C
         WcPPKrqFzQp9PxKkIrutCpnbCOopIFMUjHeTjxlPCzKt/Rb+e/QasqusVBXDRxS0s/DY
         gF+w==
X-Gm-Message-State: AOAM533qtpvRzR7rKRaAFww2EBG1H7Ep2XBcllo7OLrFlNEKN0HeWm0i
        y6jwqiECHao4NpZ8uVaEbkPoa3UmWfBhUA==
X-Google-Smtp-Source: ABdhPJydZdkG3wGvgB36lJwRqm/woilf61nCHZ/fOBuVBoiFpKzGu3Kf8yD/KwpEy0Lnn7aCCVoITw==
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr8513471eja.409.1607440779779;
        Tue, 08 Dec 2020 07:19:39 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7b:3cd9:3112:fa1b? ([2a01:e34:ed2f:f020:7b:3cd9:3112:fa1b])
        by smtp.googlemail.com with ESMTPSA id v24sm17529631edw.23.2020.12.08.07.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:19:39 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Emit a warning if the thermal zone is
 updated without ops
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201207190530.30334-1-daniel.lezcano@linaro.org>
 <2b8ce280-cb91-fb23-d19a-00dcee2a3e5a@arm.com>
 <81e25f27-344e-f6c2-5f08-68068348f7ba@linaro.org>
 <dd5f9f97-ab30-5bb0-1211-66d211035968@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7dff767d-3089-584e-f77d-33018faa38ea@linaro.org>
Date:   Tue, 8 Dec 2020 16:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dd5f9f97-ab30-5bb0-1211-66d211035968@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2020 15:37, Lukasz Luba wrote:
> 
> 
> On 12/8/20 1:51 PM, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>> On 08/12/2020 10:36, Lukasz Luba wrote:
>>> Hi Daniel,
>>
>> [ ... ]
>>
>>>>      static void thermal_zone_device_init(struct thermal_zone_device
>>>> *tz)
>>>> @@ -553,11 +555,9 @@ void thermal_zone_device_update(struct
>>>> thermal_zone_device *tz,
>>>>        if (atomic_read(&in_suspend))
>>>>            return;
>>>>    -    if (!tz->ops->get_temp)
>>>> +    if (update_temperature(tz))
>>>>            return;
>>>>    -    update_temperature(tz);
>>>> -
>>>
>>> I think the patch does a bit more. Previously we continued running the
>>> code below even when the thermal_zone_get_temp() returned an error (due
>>> to various reasons). Now we stop and probably would not schedule next
>>> polling, not calling:
>>> handle_thermal_trip() and monitor_thermal_zone()
>>
>> I agree there is a change in the behavior.
>>
>>> I would left update_temperature(tz) as it was and not check the return.
>>> The function thermal_zone_get_temp() can protect itself from missing
>>> tz->ops->get_temp(), so we should be safe.
>>>
>>> What do you think?
>>
>> Does it make sense to handle the trip point if we are unable to read the
>> temperature?
>>
>> The lines following the update_temperature() are:
>>
>>   - thermal_zone_set_trips() which needs a correct tz->temperature
>>
>>   - handle_thermal_trip() which needs a correct tz->temperature to
>> compare with
>>
>>   - monitor_thermal_zone() which needs a consistent tz->passive. This one
>> is updated by the governor which is in an inconsistent state because the
>> temperature is not updated.
>>
>> The problem I see here is how the interrupt mode and the polling mode
>> are existing in the same code path.
>>
>> The interrupt mode can call thermal_notify_framework() for critical/hot
>> trip points without being followed by a monitoring. But for the other
>> trip points, the get_temp is needed.
> 
> Yes, I agree that we can bail out when there is no .get_temp() callback
> and even not schedule next polling in such case.
> But I am just not sure if we can bail out and not schedule the next
> polling, when there is .get_temp() populated and the driver returned
> an error only at that moment, e.g. indicating some internal temporary,
> issue like send queue full, so such as -EBUSY, or -EAGAIN, etc.
> The thermal_zone_get_temp() would pass the error to update_temperature()
> but we return, losing the next try. We would not check the temperature
> again.

Hmm, right. I agree with your point.

What about the following changes:

 - Add the new APIs:

   thermal_zone_device_critical(struct thermal_zone_device *tz);
     => emergency poweroff

   thermal_zone_device_hot(struct thermal_zone_device *tz);
     => userspace notification

 - Add a big fat WARN when thermal_zone_device_update is called with
.get_temp == NULL because that must not happen.

If the .get_temp is NULL it is because we only have a HOT/CRITICAL
thermal trip points where we don't care about the temperature and
governor decision, right ?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
