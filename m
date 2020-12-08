Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D952D2C39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgLHNw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgLHNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:52:25 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 05:51:45 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id i24so9777141edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WFdterntDuR+KrzKQaANmpOJdocC9x1BF8vZLJ6Mlww=;
        b=yRsoRQS+oTUiUz+ti79hPqmJTbh6rNlbzfFrTceVJtmt0QiGhUB9x6wzHYcBSVqf4W
         LhiHHhmkglXQiHpFJWe6ASLQZL4MdJR2WaP6y3hMI89eJ7FRBuclddzKJGJZE8RTH9FM
         n8pGXYqROVVuSrXmbzgPzZNir3r1y3wOmaN+KK9r6CZ17h99ORnjaFR4zPyTx9BWaMNc
         tpXwWr8W9logMvYAclp4LZRA2XZ0GRdwRMXcVqQB8xOb2sz2Uc3zrigbC6UuR8WxF+di
         W+/THYw09OphiVRE9xYaziUvZw4L1QoTd+L07WtWgHqz0o6HskCywqknRg7hSqESaiL7
         Y4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WFdterntDuR+KrzKQaANmpOJdocC9x1BF8vZLJ6Mlww=;
        b=fHJxQRl4It+vF9O0CYVf3m1PJGqMm5/qNj+aW/gf/TM/Qv5wE4WdeCRsV+c8w3RaZ1
         6HD784Cj+1u5DDJiYuyuYwt9FiYuyuVHUUN2jDoi3680uMq7haJqaqy0tkeqKfnOCIpo
         NS74RucJHQ1JrBit30O2U47APz/cs2lYf5lDFX30uWDaQ+vF7AOK3PksY/JFCDNb6ltN
         j4l2jbPDlm2aWDNXS4WmPc7fufdX72QM7aNuHO89fSoxujWPpntYNSPsdBKRQRd4rNAu
         R9FBQJ72eYRInKhHeoOIwqFsP/Db66Ztr2Yw6ccJsh9bsUqCO59lnTU2ogBZpDoFXBYC
         xWVw==
X-Gm-Message-State: AOAM530GLDF3+vZHJFGodJYFrS5LseYZ091KxUfdRTDSNrryMkSKX9+A
        ES1/bsKND2rV+M3knzD0SmiTv4JClrRU1Q==
X-Google-Smtp-Source: ABdhPJzyokLdbnGtB7Kpw9jmmw83E/WpRynBItAzSfK4Na+rPFVki0CJDK68hM6+wLmh6Y5UEeXspw==
X-Received: by 2002:a05:6402:3074:: with SMTP id bs20mr24816938edb.365.1607435503349;
        Tue, 08 Dec 2020 05:51:43 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7b:3cd9:3112:fa1b? ([2a01:e34:ed2f:f020:7b:3cd9:3112:fa1b])
        by smtp.googlemail.com with ESMTPSA id j2sm15565521eja.97.2020.12.08.05.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 05:51:42 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Emit a warning if the thermal zone is
 updated without ops
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201207190530.30334-1-daniel.lezcano@linaro.org>
 <2b8ce280-cb91-fb23-d19a-00dcee2a3e5a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81e25f27-344e-f6c2-5f08-68068348f7ba@linaro.org>
Date:   Tue, 8 Dec 2020 14:51:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2b8ce280-cb91-fb23-d19a-00dcee2a3e5a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

On 08/12/2020 10:36, Lukasz Luba wrote:
> Hi Daniel,

[ ... ]

>>     static void thermal_zone_device_init(struct thermal_zone_device *tz)
>> @@ -553,11 +555,9 @@ void thermal_zone_device_update(struct
>> thermal_zone_device *tz,
>>       if (atomic_read(&in_suspend))
>>           return;
>>   -    if (!tz->ops->get_temp)
>> +    if (update_temperature(tz))
>>           return;
>>   -    update_temperature(tz);
>> -
> 
> I think the patch does a bit more. Previously we continued running the
> code below even when the thermal_zone_get_temp() returned an error (due
> to various reasons). Now we stop and probably would not schedule next
> polling, not calling:
> handle_thermal_trip() and monitor_thermal_zone()

I agree there is a change in the behavior.

> I would left update_temperature(tz) as it was and not check the return.
> The function thermal_zone_get_temp() can protect itself from missing
> tz->ops->get_temp(), so we should be safe.
> 
> What do you think?

Does it make sense to handle the trip point if we are unable to read the
temperature?

The lines following the update_temperature() are:

 - thermal_zone_set_trips() which needs a correct tz->temperature

 - handle_thermal_trip() which needs a correct tz->temperature to
compare with

 - monitor_thermal_zone() which needs a consistent tz->passive. This one
is updated by the governor which is in an inconsistent state because the
temperature is not updated.

The problem I see here is how the interrupt mode and the polling mode
are existing in the same code path.

The interrupt mode can call thermal_notify_framework() for critical/hot
trip points without being followed by a monitoring. But for the other
trip points, the get_temp is needed.

IMHO, we should return if update_temperature() is failing.

Perhaps, it would make sense to simply prevent to register a thermal
zone if the get_temp ops is not defined.

AFAICS, if the interrupt mode without get_temp callback are for hot and
critical trip points which can be directly invoked from the sensor via a
specified callback, no thermal zone would be needed in this case.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
