Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F022EE721
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbhAGUpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAGUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:45:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E004C0612F5;
        Thu,  7 Jan 2021 12:44:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x20so17674431lfe.12;
        Thu, 07 Jan 2021 12:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cDj24nQLqkfghbvcs4G0WvAJK+f5RlZi3A5SM53n9gk=;
        b=jO13V9gUn/zTIiGcWY0Rq1E/WIIrS6HDI09qtunmeFF8qh9v6+J0WLffkEUi8M/hDx
         +oo7yg0+7+UfZyQgq5IHDfnSuEwFEU8rekiRmjUYbSgmCvfgsGwYsyyIS8fs1UHskejl
         V3RDR878n34Viurn0LEnvbPHAs7G7wGqxYx8s+1avqfhDJ0ILImFNrjIvHHp4ybiVqcW
         EDTlNuMqwT3ndFr+fjhjQ6SjbtKZk0EAOm9DTjxEkQ3vyKLGKj5Unpny5f0eKy2DnWoP
         zpveR/UUJxXe+5PnqzGLismBK2ARBmDRBOginO4RfRjWFFpT8H4U8DiJ1dXgYaqaLQEW
         Wpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cDj24nQLqkfghbvcs4G0WvAJK+f5RlZi3A5SM53n9gk=;
        b=A0Qg61Pt0DMsSBrq5euMSqbzbt5IWZCftGULu1/CkfFjQjgZ4jmwwdVt5KEC4QZ+/S
         euRAkTgfEPv+Gq/ZtEDLqHtRfVSS26MB5GyfBXBdt9vqa63PrAMuzL3/y/S37PTBg7GT
         rufSjOprM4s0G4NIv68r1+GVdD2bbDVDCfQVW/rya8TDTJglmRfDNhN9Q1H3LbNz7uEU
         bPQgB/xNxqUTI8IR373a1+aPFmxRRljUga3t6YtN9x7TxDq0FJEPlzgCsbrU2lFQsJZn
         LkrM8tzCeMemw5LZ91M5+XD9fykHTyw00DWuL77gP3xxLFeEWzgEb+/qJYZwYBQmORXu
         tVUA==
X-Gm-Message-State: AOAM5320q2Lyy4zrl2zOT9lK631DR9bTqNHR9iyeQalUO2qN8qbI8Sgb
        Zt2C7B8LuMafwUx6nSk9iXoCeCUtsDg=
X-Google-Smtp-Source: ABdhPJw/stpc+/SEdV7S4l2iLI7Akpf6WUiTU7Egu41NgcOrWyCArp2jZEvXYK7ZQp4ynzVJOpyShA==
X-Received: by 2002:a19:cb45:: with SMTP id b66mr235839lfg.441.1610052278773;
        Thu, 07 Jan 2021 12:44:38 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id b11sm1394720lfi.174.2021.01.07.12.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 12:44:38 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: core: Replace devm_reset_control_array_get()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yejune Deng <yejune.deng@gmail.com>, balbi@kernel.org,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
 <11be44c1-0bd5-d09a-7820-f320a37a9da8@gmail.com> <X/dfxmkAThIsMIoO@kroah.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <86247ea3-7f34-3d8f-eed9-350012384083@gmail.com>
Date:   Thu, 7 Jan 2021 23:44:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <X/dfxmkAThIsMIoO@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.01.2021 22:23, Greg KH пишет:
> On Thu, Jan 07, 2021 at 10:16:50PM +0300, Dmitry Osipenko wrote:
>> 03.11.2020 06:57, Yejune Deng пишет:
>>> devm_reset_control_array_get_optional_shared() looks more readable
>>>
>>> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
>>> ---
>>>  drivers/usb/dwc3/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 841daec..b87acf0 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1490,7 +1490,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>>  
>>>  	dwc3_get_properties(dwc);
>>>  
>>> -	dwc->reset = devm_reset_control_array_get(dev, true, true);
>>> +	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>>>  	if (IS_ERR(dwc->reset))
>>>  		return PTR_ERR(dwc->reset);
>>>  
>>>
>>
>> Greg / Felipe, could you please pick up this patch?
>>
>> I want to add devm_reset_control_array_get_exclusive_released() for
>> NVIDIA Tegra drivers and we need to get rid of all the open-coded
>> devm_reset_control_array_get() users in order to extend the reset API
>> sanely.
> 
> Care to ack it or send a reviewed-by for it?

I sent r-b, thanks.
