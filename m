Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCDD2D1423
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLGOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgLGOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607352853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZY9alcaJwbCVcJul/NI3QBrRiFsddnsGdax2/APiTVA=;
        b=Z9GZvlSPzSHEl+iNjE0h/baToJ4LhpnSiTAixwueWwKjBcxLJV7Ml+F0BX0glTjWY/63I6
        zrwx9gzl9g6fvLdBs1Et2DNPOBrbIlyjoyoM4uWayVvsm1rho85h5S2JbAKqvHxsyHoIr/
        CX/tjx0FEs9f5/co/GItmc7XFbttUx4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-L5A_i1ShM8-dkhK10UPW5A-1; Mon, 07 Dec 2020 09:54:11 -0500
X-MC-Unique: L5A_i1ShM8-dkhK10UPW5A-1
Received: by mail-ej1-f71.google.com with SMTP id ny19so3120002ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZY9alcaJwbCVcJul/NI3QBrRiFsddnsGdax2/APiTVA=;
        b=KLq0dwLqRHYBivjO6czY1i3d2gq9L11QahCb5vDUhm/PaJ20Qi44It1RqfphFiQ1+V
         xPC+PkGEQfn61NVE3+tPnexfKwIn5m33RqAebBKsjfp4H9p7kkF8qvfPWYqhXCe8cJ/v
         qNg2f6v+eXV8DlnAEqV1pWma4rThRk1T5YSORijPOh/ElPseB/8lID4rwCb2F81mCwVc
         yxGD/6WiiFgRrBkkqDieHZugBLKJhO5XyFe2sfX1jEKsuOObsEMpMatEYP+61J60WTRH
         Rj6pDQKjmsvgNXA5GQINuz5PtxUVNWbdGGpHHQ/CjTOlWkNjk2zwhlxKqbq+l0ebfGzi
         Vucg==
X-Gm-Message-State: AOAM53224xDIiNDwEAZv+/oEU1nA1l1StDQs2nT0y8U7kU3ciQ0wKSZd
        VxGREMAmikSKXypps71zfJA7kbODhe2yO3IaEMobsRdUtGBucVskg73AfE7w7zgkN6aR+bQeATb
        0xp1b9z3tHMUuYc4b+RA1FQ/AkRVV9PcxTl+G3AA+Z6kXG6l0B4lrjZKejm9z9wylUdZFI0FyIO
        d0
X-Received: by 2002:a50:998d:: with SMTP id m13mr19773437edb.119.1607352850565;
        Mon, 07 Dec 2020 06:54:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybvxtqBPfHFtpim+Hnhr9mhb51+yZcFZIaYdxT1fb4tmHWVW6GNTQRpZiN6fS1x3dyQf7Elw==
X-Received: by 2002:a50:998d:: with SMTP id m13mr19773417edb.119.1607352850355;
        Mon, 07 Dec 2020 06:54:10 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id rh2sm12520011ejb.68.2020.12.07.06.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 06:54:09 -0800 (PST)
Subject: Re: [PATCH v2 2/2] platform/x86/drivers/acerhdf: Check the interval
 value when it is set
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
 <20201203071738.2363701-1-daniel.lezcano@linaro.org>
 <92e330ff28a10b1fb92d91c083fa3cac@piie.net>
 <bf62927f-972b-b4c3-ff97-179af6d53882@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <771a76da-bdd3-54b2-3661-e9db918ee00d@redhat.com>
Date:   Mon, 7 Dec 2020 15:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <bf62927f-972b-b4c3-ff97-179af6d53882@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/20 12:43 PM, Daniel Lezcano wrote:
> On 03/12/2020 22:22, Peter Kästle wrote:
>> 3. Dezember 2020 08:17, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:
>>
>>> Currently the code checks the interval value when the temperature is
>>> read which is bad for two reasons:
>>>
>>> - checking and setting the interval in the get_temp callback is
>>> inaccurate and awful, that can be done when changing the value.
>>>
>>> - Changing the thermal zone structure internals is an abuse of the
>>> exported structure, moreover no lock is taken here.
>>>
>>> The goal of this patch is to solve the first item by using the 'set'
>>> function called when changing the interval. The check is done there
>>> and removed from the get_temp function. If the thermal zone was not
>>> initialized yet, the interval is not updated in this case as that will
>>> happen in the init function when registering the thermal zone device.
>>
>> Thanks for your effort.  This improves the code, good finding.
>>
>>  
>>> I don't have any hardware to test the changes.
>>
>> Tests successfully executed on my good old AOA110.
>>
>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Acked-by: Peter Kaestle <peter@piie.net>
> 
> Thanks for testing the changes.
> 
> Shall pick the patches through the thermal tree ?

I can take them through the drivers/platform/x86 (pdx86) tree,
but if you prefer to take them upstream through the thermal tree,
then that is fine too...

Here is my ack (as pdx86 maintainer) for taking them through
the thermal tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

