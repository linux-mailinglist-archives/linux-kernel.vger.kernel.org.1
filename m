Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF32D805A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgLKVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgLKVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:01:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DCC0613D3;
        Fri, 11 Dec 2020 13:00:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so8630278wmi.3;
        Fri, 11 Dec 2020 13:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLYiJ8CVCPtC2wb1C1lGxMhHOFkkPnpzN9R1KhxEacU=;
        b=uL26DPrE4Bxe9zYqM2aEoQA0fSoFierTOPDW0/Xzk+mcMZ4oZUAR6x0VtwQRC7v+wn
         IGLoO6ndyXwHi8DImKlM7wpgDsQtZVefohJyMYG09jKh9Hc9F3jTfU1NMajqsV70zYLQ
         Rz36KdhffQocudgAwDQDJ9iC0T7PgXGN/QfrsicE/F7vTitxh3bM7dsSxa3N9AfNmZpu
         2W3D0qIYzh1QJGCoElHik1VFXy7uO7VlFy/WkiVEjmiPFITX1mxVaPIrBnYQHM2jGDjB
         L6qrdk5aFsWeMTI9E/YGp50BDO/mqId6UhlbuXYkj1FaMEJtfy3tOsGk/m6BhGs+2gd1
         vkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLYiJ8CVCPtC2wb1C1lGxMhHOFkkPnpzN9R1KhxEacU=;
        b=DsHMnLurWv5zJXUGYENyofWdW6eL6JdeGtlkvn5GpO0r+iYD7PEGw/oXS+zETEt6JB
         K48FJtk8MVouOmUFWlHs6ChokcEBwCItzngDYFzAdrnZqr7/s/G1bGuLRHXkwiNl4W2W
         2WT9sTYr0S45l/HcRpHTgk3IlaLitHfb3l0vOgwIP5xZi1r3DEvz4N0DZxOBWA+5reY9
         D1fJQHZbYVEIqGfCBeC0WPYk5nQjXLsFCbPGYX42OsoW5djaOJnbfj0gR74NNhphu05g
         Tm+T4CXItqqLF44h/m5j9a3s92+TUVBTHHaU45zqhMjBR1OCAgxf0kddebQzpHozDnbb
         d8Yw==
X-Gm-Message-State: AOAM5312BnHmXzbEoi0qntvBLuS0fJo2IN4ubr65MrPDVhlEC5KCodpq
        fP4emm4sus7VHgJSQMpg+sGXO9+AEVA=
X-Google-Smtp-Source: ABdhPJwA/pO4eyTJY6uAV3UT1kfxlyMS6YjY/wSH5e3/1eBtPC7voTfQUj713yv6gTt84RFdKCkokg==
X-Received: by 2002:a1c:2203:: with SMTP id i3mr15089494wmi.6.1607720450981;
        Fri, 11 Dec 2020 13:00:50 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a2a8.dip0.t-ipconnect.de. [217.229.162.168])
        by smtp.gmail.com with ESMTPSA id r128sm17577305wma.5.2020.12.11.13.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 13:00:50 -0800 (PST)
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
References: <20201211190335.16501-1-rdunlap@infradead.org>
 <3705938f-6f82-88ef-455b-e0f7459989e3@gmail.com>
 <c9e708d4-f4c5-01e2-d003-7f5d92a533e9@infradead.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <4ed22944-c10b-221f-f7eb-52ca3e7f2d18@gmail.com>
Date:   Fri, 11 Dec 2020 22:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <c9e708d4-f4c5-01e2-d003-7f5d92a533e9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 9:41 PM, Randy Dunlap wrote:
> On 12/11/20 12:23 PM, Maximilian Luz wrote:
>> On 12/11/20 8:03 PM, Randy Dunlap wrote:
>>> Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
>>> functions are not used:
>>>
>>> ../drivers/platform/surface/surface_gpe.c:189:12: warning: ‘surface_gpe_resume’ defined but not used [-Wunused-function]
>>>    static int surface_gpe_resume(struct device *dev)
>>>               ^~~~~~~~~~~~~~~~~~
>>> ../drivers/platform/surface/surface_gpe.c:184:12: warning: ‘surface_gpe_suspend’ defined but not used [-Wunused-function]
>>>    static int surface_gpe_suspend(struct device *dev)
>>>               ^~~~~~~~~~~~~~~~~~~
>>>
>>> Fixes: 274335f1c557 ("platform/surface: Add Driver to set up lid GPEs on MS Surface device")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Maximilian Luz <luzmaximilian@gmail.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: platform-driver-x86@vger.kernel.org
>>> ---
>>>    drivers/platform/surface/surface_gpe.c |    2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> --- linux-next-20201210.orig/drivers/platform/surface/surface_gpe.c
>>> +++ linux-next-20201210/drivers/platform/surface/surface_gpe.c
>>> @@ -181,6 +181,7 @@ static int surface_lid_enable_wakeup(str
>>>        return 0;
>>>    }
>>>    +#ifdef CONFIG_PM_SLEEP
>>>    static int surface_gpe_suspend(struct device *dev)
>>>    {
>>>        return surface_lid_enable_wakeup(dev, true);
>>> @@ -190,6 +191,7 @@ static int surface_gpe_resume(struct dev
>>>    {
>>>        return surface_lid_enable_wakeup(dev, false);
>>>    }
>>> +#endif
>>>      static SIMPLE_DEV_PM_OPS(surface_gpe_pm, surface_gpe_suspend, surface_gpe_resume);
>>>   
>>
>> Right, thanks.
>>
>> I assume this covers all instances of this warning in platform/surface?
>> Otherwise, a "platform: surface: gpe: ..." subject would make more sense.
> 
> It should cover all of surface/. It was an allmodconfig and then I disabled
> CONFIG_PM and CONFIG_PM_SLEEP etc.

Perfect, thanks!

> As for prefixes, how many levels do we want to use?
> (that's mostly rhetorical, although I would read answers :)

Looking at platform/x86 and past commit messages, I'd prefer something
like

     platform/surface: <component>: <message>

This would be similar to the platform/x86 style. So two or three,
depending on how you count "platform/surface". I agree that this
probably tends to get a bit long, so I propose we drop the surface_
prefix on the component part to help with that. So, for example,
"surface_gpe" will become "gpe".

> 
>> As for the rest:
>>
>> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> thanks.
> 

Regards,
Max
