Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D725DB02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgIDOKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgIDOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:09:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C86C061245;
        Fri,  4 Sep 2020 07:08:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so4646582pfc.12;
        Fri, 04 Sep 2020 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kmxGZ73C5CsQLZZP/FDq6xz0n5ZrAH97GbPiW2F7114=;
        b=ByTisoq/16kDYd5Yn2o3w70Y2wvMGWpk4c/TIysLLJS9aUTI4bLLRXZvu4Hk6irbpK
         zYYt4V42kZP9Ki4YVK44FoAxux7Q9DgjgSFqox9/wylDUSm5oMholul7yQLY6uTEaf6v
         tdbNDDMepC58EdqrfTzHqiH3TC100tAXW0LHAgpyIW5gUcKrHe9lLY8nbXnAvO8vFX/8
         3LoCo3dHCGJB1ORRHnw9blZS/AKn9J/4JvwHQ99L1aFL8rPWc+Dr6RkI974IKryKkbmv
         axdPY/ttJYRvsJ19C5GJznC89PBUsMjE5ZeZPFjpQUZXBgMaqUsqlyzqboIhWJqE1Tn7
         OpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kmxGZ73C5CsQLZZP/FDq6xz0n5ZrAH97GbPiW2F7114=;
        b=STWupK12MIE2jmV8C/ZNB7W0A3UBdGOYgUv2Kc/brfE2cPF6KGEh/lOMGRwJaLTvt+
         1INmXaoAD8UWkQ4yF/O1YnB3Lng5JNiQF148pRVAtyFDYoqp9ulhdRA0ur2ep+W9/f2v
         IH/tqjvAcNUeHkHbLPRwrzwi5QTE2PtbT2ekd9yrWkvzRqsJQKSvBPDjYSJ3Zq/NUuKH
         ekwTKGlDo6+GiIOsT63gmpwDvM5ucMlZnSuOdYgCuwMVLkd7926gf1p9Tto0e3TZbn3i
         2QDJaD49n9KsAK4XMrDFIqDTHD8+sW0b4b6ndg/VAonxqyTr1uB68UQ3Rn6UGpQqDgOz
         8+vA==
X-Gm-Message-State: AOAM532YLErKXeufwlXm24UPjnPS12stqlHVglAtFvyJaWdyKpdWJO7V
        ZRfXGstWvNwoxdprFmu/w7U=
X-Google-Smtp-Source: ABdhPJxEhTornXLho7zTO/7GFT9MQHTSBLQwd9514+Ob3FA8E4YTqFfuHZ9cnqnlHyz9T8KzCkc5Kg==
X-Received: by 2002:a63:1262:: with SMTP id 34mr7425425pgs.37.1599228526267;
        Fri, 04 Sep 2020 07:08:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 19sm4398857pgz.42.2020.09.04.07.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 07:08:45 -0700 (PDT)
Subject: Re: [PATCH] hwmon: sparx5: Fix initial reading of temperature
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20200903134704.8949-1-lars.povlsen@microchip.com>
 <8ca270c9-5561-3176-61cf-7a9fbee10d1f@roeck-us.net>
 <87v9guvt4o.fsf@soft-dev15.microsemi.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <57a29906-7831-dbfa-8344-f464308fcbc8@roeck-us.net>
Date:   Fri, 4 Sep 2020 07:08:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87v9guvt4o.fsf@soft-dev15.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 1:33 AM, Lars Povlsen wrote:
> 
> Guenter Roeck writes:
> 
>> On 9/3/20 6:47 AM, Lars Povlsen wrote:
>>> If the temperature is read before the internal calibration is
>>> completed, the driver returns -EIO. Instead it should return -EAGAIN
>>> to encourage repeating the operation.
>>>
>>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>>> ---
>>>  drivers/hwmon/sparx5-temp.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
>>> index 1a2b1026b026..98be48e3a22a 100644
>>> --- a/drivers/hwmon/sparx5-temp.c
>>> +++ b/drivers/hwmon/sparx5-temp.c
>>> @@ -56,7 +56,7 @@ static int s5_read(struct device *dev, enum hwmon_sensor_types type,
>>>       case hwmon_temp_input:
>>>               stat = readl_relaxed(hwmon->base + TEMP_STAT);
>>>               if (!(stat & TEMP_STAT_VALID))
>>> -                     return -EIO;
>>> +                     return -EAGAIN;
>>
>> The problem is that this may result in a hard loop and effectively hang the system,
>> or at least the calling process. It may be better to return -ENODATA in this situation.
>>
> 
> Guenther,
> 
> Thank you for your response.
> 
> The motivation for the patch was as I tried to use thermal support to
> control a fan, and I noticed an initial quip from
> thermal_core.c:update_temperature() - it will throw a dev_warn() for
> anything else than an "EAGAIN". The EAGAIN also seems to be used by
> several other hwmon drivers in similar situations.
> 
> The bottom line is that I would like to get rid of the warning
> message. Changing the error code to ENODATA does not fix what I am
> trying to accomplish.
> 

Sigh. I know that -EAGAIN is used, but it has its own problems - userspace
is inclined to retry directly, causing hard loops.

Ok, lets go with -EAGAIN then. Can't be helped. I'll apply your patch.

Guenter

> Do you have any suggestions on how to achieve the objective?
> 
> Sincerely,
> 
> ---Lars
> 
>> Guenter
>>
>>>               value = stat & TEMP_STAT_TEMP;
>>>               /*
>>>                * From register documentation:
>>> --
>>> 2.27.0
>>>
> 

