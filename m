Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B03204CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgFWIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgFWIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:47:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4288C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:47:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so1728618wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mK2XH2F62KC0dzjl6MoR3O0LMJboyHyTQgDKfSlJMR0=;
        b=HzuYPfh0bxtvG9mILlo8pgf/0+amN/m7osnMFTk4M2cn6/Zf0aWvF8lrkWI+yn0Ece
         y4n0TxF2qqrLi+Yndk4g0ChYfTzFzXyNFpJsVTB/8sU+1FEvBB43PsITSkGCLMq8Eo32
         3gGMGMlbSeQ1wHbXIlor8XVXnF6z2lR7c0mBG9ugk1GEn1JRyC2QJtwwc+zb29cOEYgO
         DqTkU/Zv8CHmldk06Ynxxvjrg7759ghXSn4xVF1EAARroaWxQj9RSB9/oSzR8FqE8lRW
         MwOjeByEJ9EW7JXV7kR7x8wXEQd4LIVcW4QQjFi9zYGLBJYUBYq/uQSppDRyH+r79gVl
         m/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mK2XH2F62KC0dzjl6MoR3O0LMJboyHyTQgDKfSlJMR0=;
        b=BOxu9ONGi8OMMt++jyXkx9Lp0ekyBxYhFRz86K4adyQkyM4d5jlpUnYhsvF2/gbXqJ
         aGnaRAWmFm6swT38OMdXi3gOIzHieXfaATLc/dAGTiiq8AD6Zzrio+3gUxChK9dON1ll
         iynby1iyUjN+BpFiVZDXGqH2ajL/zycUSwI0aO3SNtgArUPosvReiA0x6joPrizyuFBD
         wC0ut/hXTr+M5eT+DEqUgW4iFYNp4bOH37E0sZdyHY4BzNMHUPTW5+SRWQNCQRUVbWZM
         8mIlcL6z76ow5s2+UOyUE4Y2KhE6cuG6Zo8GkUc30jsLaY9fJ+wrYbnA8Of7jM+S7XDb
         Ludw==
X-Gm-Message-State: AOAM533R+3eBb6gg+rB2PVQG50o05ahayhfznhfXKzi7c52YFPWQ9Cn0
        stHYlPtb6fIXwpnqzrkpd6N07Q==
X-Google-Smtp-Source: ABdhPJztIXvAT7Qva2MC0fsZEora0Dp/33fevpZKOr7vKVxIw/QPlkAhOnIops+yzHGXRXyGvYOYyA==
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr24072590wms.40.1592902073099;
        Tue, 23 Jun 2020 01:47:53 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.googlemail.com with ESMTPSA id y6sm3074241wmy.0.2020.06.23.01.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 01:47:52 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20200618133818.15857-1-narmstrong@baylibre.com>
 <20200618133818.15857-2-narmstrong@baylibre.com>
 <53aa62a3-1d8e-bc91-1a2b-88c766276beb@linaro.org>
 <5f7154f6-c527-6665-4f7b-affd3cd62b70@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5fdd616f-812d-55fa-0c2f-301bd3c5edeb@linaro.org>
Date:   Tue, 23 Jun 2020 10:47:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5f7154f6-c527-6665-4f7b-affd3cd62b70@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Neil,

On 23/06/2020 10:25, Neil Armstrong wrote:
> Hi Daniel,
> 
> On 22/06/2020 21:46, Daniel Lezcano wrote:
>> On 18/06/2020 15:38, Neil Armstrong wrote:
>>> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
>>> on-board microcontroller.
>>>
>>> This implements the FAN control as thermal devices and as cell of the Khadas
>>> MCU MFD driver.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>> ---
>>> Hi Lee,
>>>
>>> Could you apply this patch via the MFD tree since it depends on
>>> the linux/mfd/khadas-mcu.h header ?
>>>
>>> This patch is unchanged from the v3 serie.
>>>

[ ... ]

>> Nitpicking : move the save section to suspend.
> 
> OK, but moving this makes khadas_mcu_fan_disable() useless.

It is fine. Seeing the shutdown calling the disable function which in
turn saves the state looks strange but it is not critical.

If you want to keep it as it is, I'm fine with that too.

>>> +	return 0;
>>> +}
>>> +
>>> +static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
>>> +{
>>> +	khadas_mcu_fan_disable(&pdev->dev);
>>> +}
>>> +
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int khadas_mcu_fan_suspend(struct device *dev)
>>> +{
>>> +	return khadas_mcu_fan_disable(dev);
>>> +}
>>> +
>>> +static int khadas_mcu_fan_resume(struct device *dev)
>>> +{
>>> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
>>> +
>>> +	return khadas_mcu_fan_set_level(ctx, ctx->level);
>>
>> Out of curiosity, did you check the fan is not continuously spinning
>> after a resume when the suspend happened during a mitigation phase?
> 
> No, but I took the logic from the hmwmon pwm-fan driver.
> 
> Not sure this is critical here.
No, logically you should the fan spinning at resume time even if the
board is not hot, until the post resume notification is called which
will update the thermal zone and set the cooling device state to zero again.

Thanks
  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
