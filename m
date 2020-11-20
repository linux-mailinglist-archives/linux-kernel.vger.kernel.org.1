Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A402BA617
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKTJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgKTJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:26:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5663C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:26:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id s13so9164341wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeFjuFGeYCYUaAKQyjMkKInsaG2E8UkQCv+L8e6qaRM=;
        b=FViVQOB+4kPRotuMYoJNz12BqNGgO5A8FGRC0TVJJvZ72dvVbsWWqwWhdV9pCMk7mW
         yyZpsNG7JS2QYGMBIB2+lFw4V6ig0n2QAahhacASKrLMKO5B3gjdY7Hb3C079bRalirC
         /qhN8NsMIO3L1ZAHDZI4/+lSheCVUV2t+KedKlKTGuwXRZznmUh1GgXqlkj2E2pmVUAP
         vG5GxiPhh1LQCVsTrHOXeOWmjunXJ8WUJmKXJ4thKIgVmmBGBownrU0djwVPPOn18zII
         NMhXR/G1TK0Lcu504spx+pofzzQYFWb2L9fW6hPHo2yfNHvBETUFi8bpr1eNrPuhXID1
         JuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zeFjuFGeYCYUaAKQyjMkKInsaG2E8UkQCv+L8e6qaRM=;
        b=GkX68LoI2L4mz9BUzNPr2N0Qqq+OVlDMJOsxm8sRDQYACf1keZuo/Lk4/R9+W4HsH4
         Q4JOgIPo2c/4ZVq1+FHu+YTrbZh2QQpsv4IbCfDgjihKOq7onhE45M69hI2mO47AN9Nk
         WHtztdoFmcPT/ZTQD1FQ5+QMJv46SnGHupxwgfRa55dk4MwEJg3RBQwUg6YxMfa9kRlz
         RZo6rajMvACJA6l8ex3EBeHa6RtFziCZtsgx5JxXwSwQgR/ooYyW+rh/+jh7kiQVENbd
         66vG55TKInatHcWybQwjE2uI8TONUfiHbwGu4dLjOmZfjmAt9V9m9pZyMjiiobkuZ0bm
         g7aA==
X-Gm-Message-State: AOAM5318u5x15YHwTd0s7JFEmehdcpD4CtDgq2Rlji1sF5E8Ht5XUeaQ
        AyzU3nGMTOW0hkNGOcvuh6r5Wy04vohXJbHJ
X-Google-Smtp-Source: ABdhPJwT6EX04fltJ1c/P+yeHfvNo4GGo2vd/oODlWJKISvukVhe/TAnbsSuH5WC/OUhzU12Yjy0xg==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr8979275wmm.150.1605864413787;
        Fri, 20 Nov 2020 01:26:53 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7? ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id x63sm4049700wmb.48.2020.11.20.01.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 01:26:52 -0800 (PST)
Subject: Re: next/master bisection: baseline.dmesg.emerg on meson-gxbb-p200
To:     Marc Zyngier <maz@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io, Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <5fb5e094.1c69fb81.a2014.2e62@mx.google.com>
 <a0bec7c4-9bec-8858-4879-52f4688d9992@collabora.com>
 <630e00e83cdd07ee5a0eaba9d3479554@kernel.org>
 <3f54de27-0fef-c5a1-8991-0a0614c90667@baylibre.com>
 <c76273f5fe483766e6a7f509f82d928a@kernel.org>
 <f59922c6-69f5-c70e-b424-0659bf91a4fd@collabora.com>
 <1jr1op8bbc.fsf@starbuckisacylon.baylibre.com>
 <00a10c12a4eb2a9cdd9f50e88a293c3f@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <93dcf61a-be80-8870-48f5-30e215cc56ed@baylibre.com>
Date:   Fri, 20 Nov 2020 10:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00a10c12a4eb2a9cdd9f50e88a293c3f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2020 19:35, Marc Zyngier wrote:
> On 2020-11-19 18:13, Jerome Brunet wrote:
>> On Thu 19 Nov 2020 at 19:04, Guillaume Tucker
>> <guillaume.tucker@collabora.com> wrote:
>>
>>> Hi Marc,
>>>
>>> On 19/11/2020 11:58, Marc Zyngier wrote:
>>>> On 2020-11-19 10:26, Neil Armstrong wrote:
>>>>> On 19/11/2020 11:20, Marc Zyngier wrote:
>>>>>> On 2020-11-19 08:50, Guillaume Tucker wrote:
>>>>>>> Please see the automated bisection report below about some kernel
>>>>>>> errors on meson-gxbb-p200.
>>>>>>>
>>>>>>> Reports aren't automatically sent to the public while we're
>>>>>>> trialing new bisection features on kernelci.org, however this one
>>>>>>> looks valid.
>>>>>>>
>>>>>>> The bisection started with next-20201118 but the errors are still
>>>>>>> present in next-20201119.  Details for this regression:
>>>>>>>
>>>>>>>   https://kernelci.org/test/case/id/5fb6196bfd0127fd68d8d902/
>>>>>>>
>>>>>>> The first error is:
>>>>>>>
>>>>>>>   [   14.757489] Internal error: synchronous external abort: 96000210
>>>>>>> [#1] PREEMPT SMP
>>>>>>
>>>>>> Looks like yet another clock ordering setup. I guess different Amlogic
>>>>>> platforms have slightly different ordering requirements.
>>>>>>
>>>>>> Neil, do you have any idea of which platform requires which ordering?
>>>>>> The variability in DT and platforms is pretty difficult to follow (and
>>>>>> I don't think I have such board around).
>>>>>
>>>>> The requirements should be the same, here the init was done before calling
>>>>> dw_hdmi_probe to be sure the clocks and internals resets were deasserted.
>>>>> But since you boot from u-boot already enabling these, it's already active.
>>>>>
>>>>> The solution would be to revert and do some check in meson_dw_hdmi_init() to
>>>>> check if already enabled and do nothing.
>>>>
>>>> A better fix seems to be this, which makes it explicit that there is
>>>> a dependency between some of the registers accessed from meson_dw_hdmi_init()
>>>> and the iahb clock.
>>>>
>>>> Guillaume, can you give this a go on your failing box?
>>>
>>> I confirm it solves the problem.  Please add this to your fix
>>> patch if it's OK with you:
>>>
>>>   Reported-by: "kernelci.org bot" <bot@kernelci.org>
>>>   Tested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>>
>>>
>>> For the record, it passed all the tests when applied on top of
>>> the "bad" revision found by the bisection:
>>>
>>>   http://lava.baylibre.com:10080/scheduler/alljobs?search=v5.10-rc3-1021-gb8668a2e5ea1
>>>
>>> and the exact same test on the "bad" revision without the fix
>>> consistently showed the error:
>>>
>>>   http://lava.baylibre.com:10080/scheduler/job/374176
>>>
>>>
>>> Thanks,
>>> Guillaume
>>>
>>>
>>>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>>>> index 7f8eea494147..52af8ba94311 100644
>>>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>>>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>>>> @@ -146,6 +146,7 @@ struct meson_dw_hdmi {
>>>>      struct reset_control *hdmitx_ctrl;
>>>>      struct reset_control *hdmitx_phy;
>>>>      struct clk *hdmi_pclk;
>>>> +    struct clk *iahb_clk;
>>>>      struct clk *venci_clk;
>>>>      struct regulator *hdmi_supply;
>>>>      u32 irq_stat;
>>>> @@ -1033,6 +1034,13 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>>>>      }
>>>>      clk_prepare_enable(meson_dw_hdmi->hdmi_pclk);
>>>>
>>>> +    meson_dw_hdmi->iahb_clk = devm_clk_get(dev, "iahb");
>>>> +    if (IS_ERR(meson_dw_hdmi->iahb_clk)) {
>>>> +        dev_err(dev, "Unable to get iahb clk\n");
>>>> +        return PTR_ERR(meson_dw_hdmi->iahb_clk);
>>>> +    }
>>>> +    clk_prepare_enable(meson_dw_hdmi->iahb_clk);


On previous SoCs, iahb was directly the bus clock (clk81), and on recent socs
this clock is a gate.

The question is why is it disabled. Maybe a previous failed probe disabled it
in the dw-hdmi probe failure code and this clock is needed for meson_dw_hdmi_init(),
so yeah this is the right fix.

Thanks.

Could you send a revert of b33340e33acdfe5ca6a5aa1244709575ae1e0432 and then proper fix with clk_disable_unprepare added ?

>>
>> If you guys are going ahead with this fix, this call to
>> clk_prepare_enable() needs to be balanced with clk_disable_unprepare() somehow
> 
> Yup, good point.
> 
> Although this driver *never* disables any clock it enables, and leaves it
> to the main DW driver, which I guess makes it leak references.
> 
> So all 3 clocks need fixing.

Exact.

Thx Guillaume for testing,

Neil

> 
> Thanks,
> 
>         M.

